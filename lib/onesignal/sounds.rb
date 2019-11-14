# frozen_string_literal: true

module OneSignal
  class Sounds
    attr_reader :ios, :android, :amazon, :windows, :small_icon

    def initialize ios: nil, android: nil, amazon: nil, windows: nil, small_icon: nil, large_icon: nil
      validate ios: ios, windows: windows

      @ios = ios
      @android = android
      @amazon = amazon
      @windows = windows
      @small_icon = small_icon
      @large_icon = large_icon
    end

    def as_json options = nil
      {
        'ios_sound'     => @ios.as_json(options),
        'android_sound' => @android.as_json(options),
        'adm_sound'     => @amazon.as_json(options),
        'wp_wns_sound'  => @windows.as_json(options),
        'small_icon'    => @small_icon.as_json(options),
        'large_icon'    => @large_icon.as_json(options)
      }
    end

    private

    REGEX = /.*.\.\w*/.freeze

    def validate ios: nil, windows: nil
      ios_valid = !ios.nil? && (REGEX =~ ios).nil?
      windows_valid = !windows.nil? && (REGEX =~ windows).nil?
      raise InvalidError, "provide file extension for iOS: #{ios}" if ios_valid
      raise InvalidError, "provide file extension for windows: #{ios}" if windows_valid
    end
  end

  class InvalidError < StandardError
  end
end
