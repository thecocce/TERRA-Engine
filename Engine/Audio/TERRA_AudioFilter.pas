Unit TERRA_AudioFilter;

Interface
Uses TERRA_Utils, TERRA_AudioBuffer, TERRA_AudioPanning;

Const
  LOWPASSFREQREF  = 5000.0;
  HIGHPASSFREQREF  = 250.0;

  BUFFERSIZE  = 2048;

  GAIN_SILENCE_THRESHOLD  = 0.00001; // -100dB

  SPEEDOFSOUNDMETRESPERSEC = 343.3;
  AIRABSORBGAINHF          = 0.99426; // -0.05dB 

  // Listener properties.
  AL_METERS_PER_UNIT                       = $20004;

  // Source properties.
  AL_DIRECT_FILTER                         = $20005;
  AL_AUXILIARY_SEND_FILTER                 = $20006;
  AL_AIR_ABSORPTION_FACTOR                 = $20007;
  AL_ROOM_ROLLOFF_FACTOR                   = $20008;
  AL_CONE_OUTER_GAINHF                     = $20009;
  AL_DIRECT_FILTER_GAINHF_AUTO             = $2000A;
  AL_AUXILIARY_SEND_FILTER_GAIN_AUTO       = $2000B;
  AL_AUXILIARY_SEND_FILTER_GAINHF_AUTO     = $2000C;


// Effect properties.

  // Reverb effect parameters
  AL_EAXREVERB_DENSITY                     = $0001;
  AL_EAXREVERB_DIFFUSION                   = $0002;
  AL_EAXREVERB_GAIN                        = $0003;
  AL_EAXREVERB_GAINHF                      = $0004;
  AL_EAXREVERB_GAINLF                      = $0005;
  AL_EAXREVERB_DECAY_TIME                  = $0006;
  AL_EAXREVERB_DECAY_HFRATIO               = $0007;
  AL_EAXREVERB_DECAY_LFRATIO               = $0008;
  AL_EAXREVERB_REFLECTIONS_GAIN            = $0009;
  AL_EAXREVERB_REFLECTIONS_DELAY           = $000A;
  AL_EAXREVERB_REFLECTIONS_PAN             = $000B;
  AL_EAXREVERB_LATE_REVERB_GAIN            = $000C;
  AL_EAXREVERB_LATE_REVERB_DELAY           = $000D;
  AL_EAXREVERB_LATE_REVERB_PAN             = $000E;
  AL_EAXREVERB_ECHO_TIME                   = $000F;
  AL_EAXREVERB_ECHO_DEPTH                  = $0010;
  AL_EAXREVERB_MODULATION_TIME             = $0011;
  AL_EAXREVERB_MODULATION_DEPTH            = $0012;
  AL_EAXREVERB_AIR_ABSORPTION_GAINHF       = $0013;
  AL_EAXREVERB_HFREFERENCE                 = $0014;
  AL_EAXREVERB_LFREFERENCE                 = $0015;
  AL_EAXREVERB_ROOM_ROLLOFF_FACTOR         = $0016;
  AL_EAXREVERB_DECAY_HFLIMIT               = $0017;

  // Chorus effect parameters
  AL_CHORUS_WAVEFORM                       = $0001;
  AL_CHORUS_PHASE                          = $0002;
  AL_CHORUS_RATE                           = $0003;
  AL_CHORUS_DEPTH                          = $0004;
  AL_CHORUS_FEEDBACK                       = $0005;
  AL_CHORUS_DELAY                          = $0006;

  // Distortion effect parameters
  AL_DISTORTION_EDGE                       = $0001;
  AL_DISTORTION_GAIN                       = $0002;
  AL_DISTORTION_LOWPASS_CUTOFF             = $0003;
  AL_DISTORTION_EQCENTER                   = $0004;
  AL_DISTORTION_EQBANDWIDTH                = $0005;


  // Flanger effect parameters
  AL_FLANGER_WAVEFORM                      = $0001;
  AL_FLANGER_PHASE                         = $0002;
  AL_FLANGER_RATE                          = $0003;
  AL_FLANGER_DEPTH                         = $0004;
  AL_FLANGER_FEEDBACK                      = $0005;
  AL_FLANGER_DELAY                         = $0006;

  // Frequency shifter effect parameters
  AL_FREQUENCY_SHIFTER_FREQUENCY           = $0001;
  AL_FREQUENCY_SHIFTER_LEFT_DIRECTION      = $0002;
  AL_FREQUENCY_SHIFTER_RIGHT_DIRECTION     = $0003;

  // Vocal morpher effect parameters
  AL_VOCAL_MORPHER_PHONEMEA                = $0001;
  AL_VOCAL_MORPHER_PHONEMEA_COARSE_TUNING  = $0002;
  AL_VOCAL_MORPHER_PHONEMEB                = $0003;
  AL_VOCAL_MORPHER_PHONEMEB_COARSE_TUNING  = $0004;
  AL_VOCAL_MORPHER_WAVEFORM                = $0005;
  AL_VOCAL_MORPHER_RATE                    = $0006;

  // Pitchshifter effect parameters
  AL_PITCH_SHIFTER_COARSE_TUNE             = $0001;
  AL_PITCH_SHIFTER_FINE_TUNE               = $0002;

  // Ringmodulator effect parameters
  AL_RING_MODULATOR_FREQUENCY              = $0001;
  AL_RING_MODULATOR_HIGHPASS_CUTOFF        = $0002;
  AL_RING_MODULATOR_WAVEFORM               = $0003;

  // Autowah effect parameters
  AL_AUTOWAH_ATTACK_TIME                   = $0001;
  AL_AUTOWAH_RELEASE_TIME                  = $0002;
  AL_AUTOWAH_RESONANCE                     = $0003;
  AL_AUTOWAH_PEAK_GAIN                     = $0004;

  // Compressor effect parameters
  AL_COMPRESSOR_ONOFF                      = $0001;

  // Equalizer effect parameters
  AL_EQUALIZER_LOW_GAIN                    = $0001;
  AL_EQUALIZER_LOW_CUTOFF                  = $0002;
  AL_EQUALIZER_MID1_GAIN                   = $0003;
  AL_EQUALIZER_MID1_CENTER                 = $0004;
  AL_EQUALIZER_MID1_WIDTH                  = $0005;
  AL_EQUALIZER_MID2_GAIN                   = $0006;
  AL_EQUALIZER_MID2_CENTER                 = $0007;
  AL_EQUALIZER_MID2_WIDTH                  = $0008;
  AL_EQUALIZER_HIGH_GAIN                   = $0009;
  AL_EQUALIZER_HIGH_CUTOFF                 = $000A;

  // Effect type
  AL_EFFECT_FIRST_PARAMETER                = $0000;
  AL_EFFECT_LAST_PARAMETER                 = $8000;
  AL_EFFECT_TYPE                           = $8001;

  // Effect types, used with the AL_EFFECT_TYPE property
  AL_EFFECT_NULL                           = $0000;
  AL_EFFECT_REVERB                         = $0001;
  AL_EFFECT_CHORUS                         = $0002;
  AL_EFFECT_DISTORTION                     = $0003;
  AL_EFFECT_ECHO                           = $0004;
  AL_EFFECT_FLANGER                        = $0005;
  AL_EFFECT_FREQUENCY_SHIFTER              = $0006;
  AL_EFFECT_VOCAL_MORPHER                  = $0007;
  AL_EFFECT_PITCH_SHIFTER                  = $0008;
  AL_EFFECT_RING_MODULATOR                 = $0009;
  AL_EFFECT_AUTOWAH                        = $000A;
  AL_EFFECT_COMPRESSOR                     = $000B;
  AL_EFFECT_EQUALIZER                      = $000C;
  AL_EFFECT_EAXREVERB                      = $8000;

  // Auxiliary Effect Slot properties.
  AL_EFFECTSLOT_EFFECT                     = $0001;
  AL_EFFECTSLOT_GAIN                       = $0002;
  AL_EFFECTSLOT_AUXILIARY_SEND_AUTO        = $0003;

  // NULL Auxiliary Slot ID to disable a source send.
  AL_EFFECTSLOT_NULL                       = $0000;


  // Filter properties.
  // Lowpass filter parameters
  AL_LOWPASS_GAIN                          = $0001;
  AL_LOWPASS_GAINHF                        = $0002;

  // Highpass filter parameters
  AL_HIGHPASS_GAIN                         = $0001;
  AL_HIGHPASS_GAINLF                       = $0002;

  // Bandpass filter parameters
  AL_BANDPASS_GAIN                         = $0001;
  AL_BANDPASS_GAINLF                       = $0002;
  AL_BANDPASS_GAINHF                       = $0003;

  // Filter type
  AL_FILTER_FIRST_PARAMETER                = $0000;
  AL_FILTER_LAST_PARAMETER                 = $8000;
  AL_FILTER_TYPE                           = $8001;

  // Filter types, used with the AL_FILTER_TYPE property
  AL_FILTER_NULL                           = $0000;
  AL_FILTER_LOWPASS                        = $0001;
  AL_FILTER_HIGHPASS                       = $0002;
  AL_FILTER_BANDPASS                       = $0003;

// Filter ranges and defaults.

// Lowpass filter
  AL_LOWPASS_MIN_GAIN                    =  0.0;
  AL_LOWPASS_MAX_GAIN                    =  1.0;
  AL_LOWPASS_DEFAULT_GAIN                =  1.0;

  AL_LOWPASS_MIN_GAINHF                    = 0.0;
  AL_LOWPASS_MAX_GAINHF                    = 1.0;
  AL_LOWPASS_DEFAULT_GAINHF                = 1.0;

// Highpass filter */
AL_HIGHPASS_MIN_GAIN                     = 0.0;
AL_HIGHPASS_MAX_GAIN                     = 1.0;
AL_HIGHPASS_DEFAULT_GAIN                 = 1.0;

AL_HIGHPASS_MIN_GAINLF                   = 0.0;
AL_HIGHPASS_MAX_GAINLF                   = 1.0;
AL_HIGHPASS_DEFAULT_GAINLF               = 1.0;

// Bandpass filter */
AL_BANDPASS_MIN_GAIN                     = 0.0;
AL_BANDPASS_MAX_GAIN                     = 1.0;
AL_BANDPASS_DEFAULT_GAIN                 = 1.0;

AL_BANDPASS_MIN_GAINHF                   = 0.0;
AL_BANDPASS_MAX_GAINHF                   = 1.0;
AL_BANDPASS_DEFAULT_GAINHF               = 1.0;

AL_BANDPASS_MIN_GAINLF                   = 0.0;
AL_BANDPASS_MAX_GAINLF                   = 1.0;
AL_BANDPASS_DEFAULT_GAINLF               = 1.0;


// Effect parameter ranges and defaults. */

// Standard reverb effect */
AL_REVERB_MIN_DENSITY                    = 0.0;
AL_REVERB_MAX_DENSITY                    = 1.0;
AL_REVERB_DEFAULT_DENSITY                = 1.0;

AL_REVERB_MIN_DIFFUSION                  = 0.0;
AL_REVERB_MAX_DIFFUSION                  = 1.0;
AL_REVERB_DEFAULT_DIFFUSION              = 1.0;

AL_REVERB_MIN_GAIN                       = 0.0;
AL_REVERB_MAX_GAIN                       = 1.0;
AL_REVERB_DEFAULT_GAIN                   = 0.32;

AL_REVERB_MIN_GAINHF                     = 0.0;
AL_REVERB_MAX_GAINHF                     = 1.0;
AL_REVERB_DEFAULT_GAINHF                 = 0.89;

AL_REVERB_MIN_DECAY_TIME                 = 0.1;
AL_REVERB_MAX_DECAY_TIME                 = 20.0;
AL_REVERB_DEFAULT_DECAY_TIME             = 1.49;

AL_REVERB_MIN_DECAY_HFRATIO              = 0.1;
AL_REVERB_MAX_DECAY_HFRATIO              = 2.0;
AL_REVERB_DEFAULT_DECAY_HFRATIO          = 0.83;

AL_REVERB_MIN_REFLECTIONS_GAIN           = 0.0;
AL_REVERB_MAX_REFLECTIONS_GAIN           = 3.16;
AL_REVERB_DEFAULT_REFLECTIONS_GAIN       = 0.05;

AL_REVERB_MIN_REFLECTIONS_DELAY          = 0.0;
AL_REVERB_MAX_REFLECTIONS_DELAY          = 0.3;
AL_REVERB_DEFAULT_REFLECTIONS_DELAY      = 0.007;

AL_REVERB_MIN_LATE_REVERB_GAIN           = 0.0;
AL_REVERB_MAX_LATE_REVERB_GAIN           = 10.0;
AL_REVERB_DEFAULT_LATE_REVERB_GAIN       = 1.26;

AL_REVERB_MIN_LATE_REVERB_DELAY          = 0.0;
AL_REVERB_MAX_LATE_REVERB_DELAY          = 0.1;
AL_REVERB_DEFAULT_LATE_REVERB_DELAY      = 0.011;

AL_REVERB_MIN_AIR_ABSORPTION_GAINHF      = 0.892;
AL_REVERB_MAX_AIR_ABSORPTION_GAINHF      = 1.0;
AL_REVERB_DEFAULT_AIR_ABSORPTION_GAINHF  = 0.994;

AL_REVERB_MIN_ROOM_ROLLOFF_FACTOR        = 0.0;
AL_REVERB_MAX_ROOM_ROLLOFF_FACTOR        = 10.0;
AL_REVERB_DEFAULT_ROOM_ROLLOFF_FACTOR    = 0.0;

AL_REVERB_MIN_DECAY_HFLIMIT              = False;
AL_REVERB_MAX_DECAY_HFLIMIT              = True;
AL_REVERB_DEFAULT_DECAY_HFLIMIT          = True;

// EAX reverb effect */
AL_EAXREVERB_MIN_DENSITY                 = 0.0;
AL_EAXREVERB_MAX_DENSITY                 = 1.0;
AL_EAXREVERB_DEFAULT_DENSITY             = 1.0;

AL_EAXREVERB_MIN_DIFFUSION               = 0.0;
AL_EAXREVERB_MAX_DIFFUSION               = 1.0;
AL_EAXREVERB_DEFAULT_DIFFUSION           = 1.0;

AL_EAXREVERB_MIN_GAIN                    = 0.0;
AL_EAXREVERB_MAX_GAIN                    = 1.0;
AL_EAXREVERB_DEFAULT_GAIN                = 0.32;

AL_EAXREVERB_MIN_GAINHF                  = 0.0;
AL_EAXREVERB_MAX_GAINHF                  = 1.0;
AL_EAXREVERB_DEFAULT_GAINHF              = 0.89;

AL_EAXREVERB_MIN_GAINLF                  = 0.0;
AL_EAXREVERB_MAX_GAINLF                  = 1.0;
AL_EAXREVERB_DEFAULT_GAINLF              = 1.0;

AL_EAXREVERB_MIN_DECAY_TIME              = 0.1;
AL_EAXREVERB_MAX_DECAY_TIME              = 20.0;
AL_EAXREVERB_DEFAULT_DECAY_TIME          = 1.49;

AL_EAXREVERB_MIN_DECAY_HFRATIO           = 0.1;
AL_EAXREVERB_MAX_DECAY_HFRATIO           = 2.0;
AL_EAXREVERB_DEFAULT_DECAY_HFRATIO       = 0.83;

AL_EAXREVERB_MIN_DECAY_LFRATIO           = 0.1;
AL_EAXREVERB_MAX_DECAY_LFRATIO           = 2.0;
AL_EAXREVERB_DEFAULT_DECAY_LFRATIO       = 1.0;

AL_EAXREVERB_MIN_REFLECTIONS_GAIN        = 0.0;
AL_EAXREVERB_MAX_REFLECTIONS_GAIN        = 3.16;
AL_EAXREVERB_DEFAULT_REFLECTIONS_GAIN    = 0.05;

AL_EAXREVERB_MIN_REFLECTIONS_DELAY       = 0.0;
AL_EAXREVERB_MAX_REFLECTIONS_DELAY       = 0.3;
AL_EAXREVERB_DEFAULT_REFLECTIONS_DELAY   = 0.007;

AL_EAXREVERB_DEFAULT_REFLECTIONS_PAN_XYZ = 0.0;

AL_EAXREVERB_MIN_LATE_REVERB_GAIN        = 0.0;
AL_EAXREVERB_MAX_LATE_REVERB_GAIN        = 10.0;
AL_EAXREVERB_DEFAULT_LATE_REVERB_GAIN    = 1.26;

AL_EAXREVERB_MIN_LATE_REVERB_DELAY       = 0.0;
AL_EAXREVERB_MAX_LATE_REVERB_DELAY       = 0.1;
AL_EAXREVERB_DEFAULT_LATE_REVERB_DELAY   = 0.011;

AL_EAXREVERB_DEFAULT_LATE_REVERB_PAN_XYZ = 0.0;

AL_EAXREVERB_MIN_ECHO_TIME               = 0.075;
AL_EAXREVERB_MAX_ECHO_TIME               = 0.25;
AL_EAXREVERB_DEFAULT_ECHO_TIME           = 0.25;

AL_EAXREVERB_MIN_ECHO_DEPTH              = 0.0;
AL_EAXREVERB_MAX_ECHO_DEPTH              = 1.0;
AL_EAXREVERB_DEFAULT_ECHO_DEPTH          = 0.0;

AL_EAXREVERB_MIN_MODULATION_TIME         = 0.04;
AL_EAXREVERB_MAX_MODULATION_TIME         = 4.0;
AL_EAXREVERB_DEFAULT_MODULATION_TIME     = 0.25;

AL_EAXREVERB_MIN_MODULATION_DEPTH        = 0.0;
AL_EAXREVERB_MAX_MODULATION_DEPTH        = 1.0;
AL_EAXREVERB_DEFAULT_MODULATION_DEPTH    = 0.0;

AL_EAXREVERB_MIN_AIR_ABSORPTION_GAINHF   = 0.892;
AL_EAXREVERB_MAX_AIR_ABSORPTION_GAINHF   = 1.0;
AL_EAXREVERB_DEFAULT_AIR_ABSORPTION_GAINHF = 0.994;

AL_EAXREVERB_MIN_HFREFERENCE             = 1000.0;
AL_EAXREVERB_MAX_HFREFERENCE             = 20000.0;
AL_EAXREVERB_DEFAULT_HFREFERENCE         = 5000.0;

AL_EAXREVERB_MIN_LFREFERENCE             = 20.0;
AL_EAXREVERB_MAX_LFREFERENCE             = 1000.0;
AL_EAXREVERB_DEFAULT_LFREFERENCE         = 250.0;

AL_EAXREVERB_MIN_ROOM_ROLLOFF_FACTOR     = 0.0;
AL_EAXREVERB_MAX_ROOM_ROLLOFF_FACTOR     = 10.0;
AL_EAXREVERB_DEFAULT_ROOM_ROLLOFF_FACTOR = 0.0;

AL_EAXREVERB_MIN_DECAY_HFLIMIT           = False;
AL_EAXREVERB_MAX_DECAY_HFLIMIT           = True;
AL_EAXREVERB_DEFAULT_DECAY_HFLIMIT       = True;

// Chorus effect */
AL_CHORUS_WAVEFORM_SINUSOID              = 0;
AL_CHORUS_WAVEFORM_TRIANGLE              = 1;

AL_CHORUS_MIN_WAVEFORM                   = 0;
AL_CHORUS_MAX_WAVEFORM                   = 1;
AL_CHORUS_DEFAULT_WAVEFORM               = 1;

AL_CHORUS_MIN_PHASE                      = -180;
AL_CHORUS_MAX_PHASE                      = 180;
AL_CHORUS_DEFAULT_PHASE                  = 90;

AL_CHORUS_MIN_RATE                       = 0.0;
AL_CHORUS_MAX_RATE                       = 10.0;
AL_CHORUS_DEFAULT_RATE                   = 1.1;

AL_CHORUS_MIN_DEPTH                      = 0.0;
AL_CHORUS_MAX_DEPTH                      = 1.0;
AL_CHORUS_DEFAULT_DEPTH                  = 0.1;

AL_CHORUS_MIN_FEEDBACK                   = -1.0;
AL_CHORUS_MAX_FEEDBACK                   = 1.0;
AL_CHORUS_DEFAULT_FEEDBACK               = 0.25;

AL_CHORUS_MIN_DELAY                      = 0.0;
AL_CHORUS_MAX_DELAY                      = 0.016;
AL_CHORUS_DEFAULT_DELAY                  = 0.016;

// Distortion effect */
AL_DISTORTION_MIN_EDGE                   = 0.0;
AL_DISTORTION_MAX_EDGE                   = 1.0;
AL_DISTORTION_DEFAULT_EDGE               = 0.2;

AL_DISTORTION_MIN_GAIN                   = 0.01;
AL_DISTORTION_MAX_GAIN                   = 1.0;
AL_DISTORTION_DEFAULT_GAIN               = 0.05;

AL_DISTORTION_MIN_LOWPASS_CUTOFF         = 80.0;
AL_DISTORTION_MAX_LOWPASS_CUTOFF         = 24000.0;
AL_DISTORTION_DEFAULT_LOWPASS_CUTOFF     = 8000.0;

AL_DISTORTION_MIN_EQCENTER               = 80.0;
AL_DISTORTION_MAX_EQCENTER               = 24000.0;
AL_DISTORTION_DEFAULT_EQCENTER           = 3600.0;

AL_DISTORTION_MIN_EQBANDWIDTH            = 80.0;
AL_DISTORTION_MAX_EQBANDWIDTH            = 24000.0;
AL_DISTORTION_DEFAULT_EQBANDWIDTH        = 3600.0;


// Flanger effect */
AL_FLANGER_WAVEFORM_SINUSOID             = 0;
AL_FLANGER_WAVEFORM_TRIANGLE             = 1;

AL_FLANGER_MIN_WAVEFORM                  = 0;
AL_FLANGER_MAX_WAVEFORM                  = 1;
AL_FLANGER_DEFAULT_WAVEFORM              = 1;

AL_FLANGER_MIN_PHASE                     = -180;
AL_FLANGER_MAX_PHASE                     = 180;
AL_FLANGER_DEFAULT_PHASE                 = 0;

AL_FLANGER_MIN_RATE                      = 0.0;
AL_FLANGER_MAX_RATE                      = 10.0;
AL_FLANGER_DEFAULT_RATE                  = 0.27;

AL_FLANGER_MIN_DEPTH                     = 0.0;
AL_FLANGER_MAX_DEPTH                     = 1.0;
AL_FLANGER_DEFAULT_DEPTH                 = 1.0;

AL_FLANGER_MIN_FEEDBACK                  = -1.0;
AL_FLANGER_MAX_FEEDBACK                  = 1.0;
AL_FLANGER_DEFAULT_FEEDBACK              = -0.5;

AL_FLANGER_MIN_DELAY                     = 0.0;
AL_FLANGER_MAX_DELAY                     = 0.004;
AL_FLANGER_DEFAULT_DELAY                 = 0.002;

// Frequency shifter effect */
AL_FREQUENCY_SHIFTER_MIN_FREQUENCY       = 0.0;
AL_FREQUENCY_SHIFTER_MAX_FREQUENCY       = 24000.0;
AL_FREQUENCY_SHIFTER_DEFAULT_FREQUENCY   = 0.0;

AL_FREQUENCY_SHIFTER_MIN_LEFT_DIRECTION  = 0;
AL_FREQUENCY_SHIFTER_MAX_LEFT_DIRECTION  = 2;
AL_FREQUENCY_SHIFTER_DEFAULT_LEFT_DIRECTION = 0;

AL_FREQUENCY_SHIFTER_DIRECTION_DOWN      = 0;
AL_FREQUENCY_SHIFTER_DIRECTION_UP        = 1;
AL_FREQUENCY_SHIFTER_DIRECTION_OFF       = 2;

AL_FREQUENCY_SHIFTER_MIN_RIGHT_DIRECTION = 0;
AL_FREQUENCY_SHIFTER_MAX_RIGHT_DIRECTION = 2;
AL_FREQUENCY_SHIFTER_DEFAULT_RIGHT_DIRECTION = 0;

// Vocal morpher effect */
AL_VOCAL_MORPHER_MIN_PHONEMEA            = 0;
AL_VOCAL_MORPHER_MAX_PHONEMEA            = 29;
AL_VOCAL_MORPHER_DEFAULT_PHONEMEA        = 0;

AL_VOCAL_MORPHER_MIN_PHONEMEA_COARSE_TUNING = -24;
AL_VOCAL_MORPHER_MAX_PHONEMEA_COARSE_TUNING = 24;
AL_VOCAL_MORPHER_DEFAULT_PHONEMEA_COARSE_TUNING = 0;

AL_VOCAL_MORPHER_MIN_PHONEMEB            = 0;
AL_VOCAL_MORPHER_MAX_PHONEMEB            = 29;
AL_VOCAL_MORPHER_DEFAULT_PHONEMEB        = 10;

AL_VOCAL_MORPHER_MIN_PHONEMEB_COARSE_TUNING = -24;
AL_VOCAL_MORPHER_MAX_PHONEMEB_COARSE_TUNING = 24;
AL_VOCAL_MORPHER_DEFAULT_PHONEMEB_COARSE_TUNING = 0;

AL_VOCAL_MORPHER_PHONEME_A               = 0;
AL_VOCAL_MORPHER_PHONEME_E               = 1;
AL_VOCAL_MORPHER_PHONEME_I               = 2;
AL_VOCAL_MORPHER_PHONEME_O               = 3;
AL_VOCAL_MORPHER_PHONEME_U               = 4;
AL_VOCAL_MORPHER_PHONEME_AA              = 5;
AL_VOCAL_MORPHER_PHONEME_AE              = 6;
AL_VOCAL_MORPHER_PHONEME_AH              = 7;
AL_VOCAL_MORPHER_PHONEME_AO              = 8;
AL_VOCAL_MORPHER_PHONEME_EH              = 9;
AL_VOCAL_MORPHER_PHONEME_ER              = 10;
AL_VOCAL_MORPHER_PHONEME_IH              = 11;
AL_VOCAL_MORPHER_PHONEME_IY              = 12;
AL_VOCAL_MORPHER_PHONEME_UH              = 13;
AL_VOCAL_MORPHER_PHONEME_UW              = 14;
AL_VOCAL_MORPHER_PHONEME_B               = 15;
AL_VOCAL_MORPHER_PHONEME_D               = 16;
AL_VOCAL_MORPHER_PHONEME_F               = 17;
AL_VOCAL_MORPHER_PHONEME_G               = 18;
AL_VOCAL_MORPHER_PHONEME_J               = 19;
AL_VOCAL_MORPHER_PHONEME_K               = 20;
AL_VOCAL_MORPHER_PHONEME_L               = 21;
AL_VOCAL_MORPHER_PHONEME_M               = 22;
AL_VOCAL_MORPHER_PHONEME_N               = 23;
AL_VOCAL_MORPHER_PHONEME_P               = 24;
AL_VOCAL_MORPHER_PHONEME_R               = 25;
AL_VOCAL_MORPHER_PHONEME_S               = 26;
AL_VOCAL_MORPHER_PHONEME_T               = 27;
AL_VOCAL_MORPHER_PHONEME_V               = 28;
AL_VOCAL_MORPHER_PHONEME_Z               = 29;

AL_VOCAL_MORPHER_WAVEFORM_SINUSOID       = 0;
AL_VOCAL_MORPHER_WAVEFORM_TRIANGLE       = 1;
AL_VOCAL_MORPHER_WAVEFORM_SAWTOOTH       = 2;

AL_VOCAL_MORPHER_MIN_WAVEFORM            = 0;
AL_VOCAL_MORPHER_MAX_WAVEFORM            = 2;
AL_VOCAL_MORPHER_DEFAULT_WAVEFORM        = 0;

AL_VOCAL_MORPHER_MIN_RATE                = 0.0;
AL_VOCAL_MORPHER_MAX_RATE                = 10.0;
AL_VOCAL_MORPHER_DEFAULT_RATE            = 1.41;

// Pitch shifter effect */
AL_PITCH_SHIFTER_MIN_COARSE_TUNE         = -12;
AL_PITCH_SHIFTER_MAX_COARSE_TUNE         = 12;
AL_PITCH_SHIFTER_DEFAULT_COARSE_TUNE     = 12;

AL_PITCH_SHIFTER_MIN_FINE_TUNE           = -50;
AL_PITCH_SHIFTER_MAX_FINE_TUNE           = 50;
AL_PITCH_SHIFTER_DEFAULT_FINE_TUNE       = 0;

// Ring modulator effect */
AL_RING_MODULATOR_MIN_FREQUENCY          = 0.0;
AL_RING_MODULATOR_MAX_FREQUENCY          = 8000.0;
AL_RING_MODULATOR_DEFAULT_FREQUENCY      = 440.0;

AL_RING_MODULATOR_MIN_HIGHPASS_CUTOFF    = 0.0;
AL_RING_MODULATOR_MAX_HIGHPASS_CUTOFF    = 24000.0;
AL_RING_MODULATOR_DEFAULT_HIGHPASS_CUTOFF = 800.0;

AL_RING_MODULATOR_SINUSOID               = 0;
AL_RING_MODULATOR_SAWTOOTH               = 1;
AL_RING_MODULATOR_SQUARE                 = 2;

AL_RING_MODULATOR_MIN_WAVEFORM           = 0;
AL_RING_MODULATOR_MAX_WAVEFORM           = 2;
AL_RING_MODULATOR_DEFAULT_WAVEFORM       = 0;

// Autowah effect */
AL_AUTOWAH_MIN_ATTACK_TIME               = 0.0001;
AL_AUTOWAH_MAX_ATTACK_TIME               = 1.0;
AL_AUTOWAH_DEFAULT_ATTACK_TIME           = 0.06;

AL_AUTOWAH_MIN_RELEASE_TIME              = 0.0001;
AL_AUTOWAH_MAX_RELEASE_TIME              = 1.0;
AL_AUTOWAH_DEFAULT_RELEASE_TIME          = 0.06;

AL_AUTOWAH_MIN_RESONANCE                 = 2.0;
AL_AUTOWAH_MAX_RESONANCE                 = 1000.0;
AL_AUTOWAH_DEFAULT_RESONANCE             = 1000.0;

AL_AUTOWAH_MIN_PEAK_GAIN                 = 0.00003;
AL_AUTOWAH_MAX_PEAK_GAIN                 = 31621.0;
AL_AUTOWAH_DEFAULT_PEAK_GAIN             = 11.22;

// Compressor effect */
AL_COMPRESSOR_MIN_ONOFF                  = 0;
AL_COMPRESSOR_MAX_ONOFF                  = 1;
AL_COMPRESSOR_DEFAULT_ONOFF              = 1;

// Equalizer effect */
AL_EQUALIZER_MIN_LOW_GAIN                = 0.126;
AL_EQUALIZER_MAX_LOW_GAIN                = 7.943;
AL_EQUALIZER_DEFAULT_LOW_GAIN            = 1.0;

AL_EQUALIZER_MIN_LOW_CUTOFF              = 50.0;
AL_EQUALIZER_MAX_LOW_CUTOFF              = 800.0;
AL_EQUALIZER_DEFAULT_LOW_CUTOFF          = 200.0;

AL_EQUALIZER_MIN_MID1_GAIN               = 0.126;
AL_EQUALIZER_MAX_MID1_GAIN               = 7.943;
AL_EQUALIZER_DEFAULT_MID1_GAIN           = 1.0;

AL_EQUALIZER_MIN_MID1_CENTER             = 200.0;
AL_EQUALIZER_MAX_MID1_CENTER             = 3000.0;
AL_EQUALIZER_DEFAULT_MID1_CENTER         = 500.0;

AL_EQUALIZER_MIN_MID1_WIDTH              = 0.01;
AL_EQUALIZER_MAX_MID1_WIDTH              = 1.0;
AL_EQUALIZER_DEFAULT_MID1_WIDTH          = 1.0;

AL_EQUALIZER_MIN_MID2_GAIN               = 0.126;
AL_EQUALIZER_MAX_MID2_GAIN               = 7.943;
AL_EQUALIZER_DEFAULT_MID2_GAIN           = 1.0;

AL_EQUALIZER_MIN_MID2_CENTER             = 1000.0;
AL_EQUALIZER_MAX_MID2_CENTER             = 8000.0;
AL_EQUALIZER_DEFAULT_MID2_CENTER         = 3000.0;

AL_EQUALIZER_MIN_MID2_WIDTH              = 0.01;
AL_EQUALIZER_MAX_MID2_WIDTH              = 1.0;
AL_EQUALIZER_DEFAULT_MID2_WIDTH          = 1.0;

AL_EQUALIZER_MIN_HIGH_GAIN               = 0.126;
AL_EQUALIZER_MAX_HIGH_GAIN               = 7.943;
AL_EQUALIZER_DEFAULT_HIGH_GAIN           = 1.0;

AL_EQUALIZER_MIN_HIGH_CUTOFF             = 4000.0;
AL_EQUALIZER_MAX_HIGH_CUTOFF             = 16000.0;
AL_EQUALIZER_DEFAULT_HIGH_CUTOFF         = 6000.0;


// Source parameter value ranges and defaults. */
AL_MIN_AIR_ABSORPTION_FACTOR             = 0.0;
AL_MAX_AIR_ABSORPTION_FACTOR             = 10.0;
AL_DEFAULT_AIR_ABSORPTION_FACTOR         = 0.0;

AL_MIN_ROOM_ROLLOFF_FACTOR               = 0.0;
AL_MAX_ROOM_ROLLOFF_FACTOR               = 10.0;
AL_DEFAULT_ROOM_ROLLOFF_FACTOR           = 0.0;

AL_MIN_CONE_OUTER_GAINHF                 = 0.0;
AL_MAX_CONE_OUTER_GAINHF                 = 1.0;
AL_DEFAULT_CONE_OUTER_GAINHF             = 1.0;

AL_MIN_DIRECT_FILTER_GAINHF_AUTO         = False;
AL_MAX_DIRECT_FILTER_GAINHF_AUTO         = True;
AL_DEFAULT_DIRECT_FILTER_GAINHF_AUTO     = True;

AL_MIN_AUXILIARY_SEND_FILTER_GAIN_AUTO   = False;
AL_MAX_AUXILIARY_SEND_FILTER_GAIN_AUTO   = True;
AL_DEFAULT_AUXILIARY_SEND_FILTER_GAIN_AUTO = True;

AL_MIN_AUXILIARY_SEND_FILTER_GAINHF_AUTO = False;
AL_MAX_AUXILIARY_SEND_FILTER_GAINHF_AUTO = True;
AL_DEFAULT_AUXILIARY_SEND_FILTER_GAINHF_AUTO = True;


// Listener parameter value ranges and defaults. */
//AL_MIN_METERS_PER_UNIT                   FLT_MIN
//AL_MAX_METERS_PER_UNIT                   FLT_MAX
AL_DEFAULT_METERS_PER_UNIT               = 1.0;

(* Filters implementation is based on the "Cookbook formulae for audio
   EQ biquad filter coefficients" by Robert Bristow-Johnson
    http://www.musicdsp.org/files/Audio-EQ-Cookbook.txt                   *)

Type
  ALEffectType = (
    AudioEffect_REVERB,
    AudioEffect_AUTOWAH,
    AudioEffect_CHORUS,
    AudioEffect_COMPRESSOR,
    AudioEffect_DISTORTION,
    AudioEffect_ECHO,
    AudioEffect_EQUALIZER,
    AudioEffect_FLANGER,
    AudioEffect_MODULATOR,
    AudioEffect_DEDICATED
  );

  FloatAudioSampleArray = Array Of FloatAudioSample;
  AudioEffectBuffer = Record
    Samples:Array[0..Pred(MAX_OUTPUT_CHANNELS)] Of FloatAudioSampleArray;
  End;

(*
typedef union ALeffectProps {
    struct {
        // Shared Reverb Properties
        ALfloat Density;
        ALfloat Diffusion;
        ALfloat Gain;
        ALfloat GainHF;
        ALfloat DecayTime;
        ALfloat DecayHFRatio;
        ALfloat ReflectionsGain;
        ALfloat ReflectionsDelay;
        ALfloat LateReverbGain;
        ALfloat LateReverbDelay;
        ALfloat AirAbsorptionGainHF;
        ALfloat RoomRolloffFactor;
        ALboolean DecayHFLimit;

        // Additional EAX Reverb Properties
        ALfloat GainLF;
        ALfloat DecayLFRatio;
        ALfloat ReflectionsPan[3];
        ALfloat LateReverbPan[3];
        ALfloat EchoTime;
        ALfloat EchoDepth;
        ALfloat ModulationTime;
        ALfloat ModulationDepth;
        ALfloat HFReference;
        ALfloat LFReference;
    } Reverb;

    struct {
        ALfloat AttackTime;
        ALfloat ReleaseTime;
        ALfloat PeakGain;
        ALfloat Resonance;
    } Autowah;

    struct {
        ALint Waveform;
        ALint Phase;
        ALfloat Rate;
        ALfloat Depth;
        ALfloat Feedback;
        ALfloat Delay;
    } Chorus;

    struct {
        ALboolean OnOff;
    } Compressor;

    struct {
        ALfloat Edge;
        ALfloat Gain;
        ALfloat LowpassCutoff;
        ALfloat EQCenter;
        ALfloat EQBandwidth;
    } Distortion;

    struct {
        ALfloat Delay;
        ALfloat LowCutoff;
        ALfloat LowGain;
        ALfloat Mid1Center;
        ALfloat Mid1Gain;
        ALfloat Mid1Width;
        ALfloat Mid2Center;
        ALfloat Mid2Gain;
        ALfloat Mid2Width;
        ALfloat HighCutoff;
        ALfloat HighGain;
    } Equalizer;

    struct {
        ALint Waveform;
        ALint Phase;
        ALfloat Rate;
        ALfloat Depth;
        ALfloat Feedback;
        ALfloat Delay;
    } Flanger;

    struct {
        ALfloat Frequency;
        ALfloat HighPassCutoff;
        ALint Waveform;
    } Modulator;

    struct {
        ALfloat Gain;
    } Dedicated;
} ALeffectProps;

*)

(*  ALfilterType = (
    // EFX-style low-pass filter, specifying a gain and reference frequency.
    ALfilterType_HighShelf,
    // EFX-style high-pass filter, specifying a gain and reference frequency.
    ALfilterType_LowShelf,
    // Peaking filter, specifying a gain, reference frequency, and bandwidth.
    ALfilterType_Peaking,

    // Low-pass cut-off filter, specifying a cut-off frequency and bandwidth.
    ALfilterType_LowPass,
    // High-pass cut-off filter, specifying a cut-off frequency and bandwidth.
    ALfilterType_HighPass,
    // Band-pass filter, specifying a center frequency and bandwidth.
    ALfilterType_BandPass
  );*)


  AudioFilter = Class(TERRAObject)
    Protected
      _id:Cardinal;

      _TargetFrequency:Cardinal;

      _EffectType:ALEffectType;
      //EffectProps:ALeffectProps;

      _Gain:Single;
      _AuxSendAuto:Boolean;

      _NeedsUpdate:Boolean;

      _WetBuffer:Array[0..Pred(BUFFERSIZE)] Of Single;
      ID:Integer;

      _GainHF:Single;
      _HFReference:Single;
      _GainLF:Single;
      _LFReference:Single;

      _x:Array[0..1] Of Single; // History of two last input samples
      _y:Array[0..1] Of Single; // History of two last output samples
      _a:Array[0..2] Of Single; // Transfer function coefficients "a"
      _b:Array[0..2] Of Single; // Transfer function coefficients "b"

      Procedure ProcessState(dst, src:PSingleArray; numsamples:Cardinal); Virtual; Abstract;

      Procedure Clear(); Virtual; Abstract;

      Function processSingle(Const sample:Single):Single;

      Procedure UpdateParams(Const gain, bandwidth, w0:Single); Virtual; Abstract;
      Procedure SetParams(gain:Single; Const freq_mult, bandwidth:Single);

    Public
      Function Initialize(Frequency:Cardinal): Boolean; Virtual;

      Procedure Update(); Virtual; Abstract;
      Procedure Process(samplesToDo:Integer; samplesIn:PSingleArray; Var samplesOut:AudioEffectBuffer); Virtual; Abstract;

      Property Gain:Single Read _Gain;
  End;

  AudioHighShelfFilter = Class(AudioFilter)
    Protected
      Procedure UpdateParams(Const gain, bandwidth, w0:Single); Override;

    Public
      Function Initialize(Frequency:Cardinal): Boolean; Override;
  End;


Implementation
Uses TERRA_Math;

//void ALfilterState_processC(ALfilterState *filter, ALfloat *restrict dst, const ALfloat *src, ALuint numsamples);


{struct ALfilter *LookupFilter(ALCdevice *device, ALuint id)
 return (struct ALfilter*)LookupUIntMapKey(&device->FilterMap, id);

inline struct ALfilter *RemoveFilter(ALCdevice *device, ALuint id)
 return (struct ALfilter*)RemoveUIntMapKey(&device->FilterMap, id);

}

{ AudioFilter }
Function AudioFilter.Initialize(Frequency:Cardinal): Boolean;
Begin
  _TargetFrequency := Frequency;
  Result := True;
End;

Function AudioFilter.processSingle(Const sample:Single):Single;
Begin
  Result := _b[0] * sample + _b[1] * _x[0] + _b[2] * _x[1] -  _a[1] * _y[0] - _a[2] * _y[1];
  _x[1] := _x[0];
  _x[0] := Sample;
  _y[1] := _y[0];
  _y[0] := Result;
End;


(*Procedure AudioFilter.SetParams(FilterType:ALfilterType; Const gain, freq_mult, bandwidth:Single);
Begin
  // Calculate filter coefficients depending on filter type
  Case FilterType Of
  ALfilterType_HighShelf:
    Begin
    End;

    ALfilterType_LowShelf:
      Begin
        alpha := Sin(w0)/2.0*Sqrt((gain + 1.0/gain)*(1.0/0.75 - 1.0) + 2.0);
        _b[0] :=       gain*((gain+1.0) - (gain-1.0)*Cos(w0) + 2.0*Sqrt(gain)*alpha);
        _b[1] :=  2.0*gain*((gain-1.0) - (gain+1.0)*Cos(w0)                         );
        _b[2] :=       gain*((gain+1.0) - (gain-1.0)*Cos(w0) - 2.0*Sqrt(gain)*alpha);
        _a[0] :=             (gain+1.0) + (gain-1.0)*Cos(w0) + 2.0*Sqrt(gain)*alpha;
        _a[1] := -2.0*     ((gain-1.0) + (gain+1.0)*Cos(w0)                         );
        _a[2] :=             (gain+1.0) + (gain-1.0)*Cos(w0) - 2.0*Sqrt(gain)*alpha;
      End;

    ALfilterType_Peaking:
      Begin
        alpha := Sin(w0) * Sinh(Log2(2.0) / 2.0 * bandwidth * w0 / Sin(w0));
        _b[0] :=  1.0 + alpha * gain;
        _b[1] := -2.0 * Cos(w0);
        _b[2] :=  1.0 - alpha * gain;
        _a[0] :=  1.0 + alpha / gain;
        _a[1] := -2.0 * Cos(w0);
        _a[2] :=  1.0 - alpha / gain;
      End;

      ALfilterType_LowPass:
        Begin
            alpha := Sin(w0) * sinh(Log2(2.0) / 2.0 * bandwidth * w0 / Sin(w0));
            _b[0] := (1.0 - Cos(w0)) / 2.0;
            _b[1] :=  1.0 - Cos(w0);
            _b[2] := (1.0 - Cos(w0)) / 2.0;
            _a[0] :=  1.0 + alpha;
            _a[1] := -2.0 * Cos(w0);
            _a[2] :=  1.0 - alpha;
        End;

      ALfilterType_HighPass:
        Begin
            alpha := Sin(w0) * sinh(Log2(2.0) / 2.0 * bandwidth * w0 / Sin(w0));
            _b[0] :=  (1.0 + Cos(w0)) / 2.0;
            _b[1] := -(1.0 + Cos(w0));
            _b[2] :=  (1.0 + Cos(w0)) / 2.0;
            _a[0] :=   1.0 + alpha;
            _a[1] :=  -2.0 * Cos(w0);
            _a[2] :=   1.0 - alpha;
        End;

      ALfilterType_BandPass:
        Begin
            alpha := Sin(w0) * sinh(Log2(2.0) / 2.0 * bandwidth * w0 / Sin(w0));
            _b[0] :=  alpha;
            _b[1] :=  0;
            _b[2] := -alpha;
            _a[0] :=  1.0 + alpha;
            _a[1] := -2.0 * Cos(w0);
            _a[2] :=  1.0 - alpha;
        End;
    End;

  Self.NormalizeFilter();
//  _process := ALfilterState_processC;
End;*)

Procedure AudioFilter.SetParams(gain:Single; const freq_mult, bandwidth: Single);
Var
  w0:Single;
Begin
  // Limit gain to -100dB
  gain := FloatMax(gain, 0.00001);
  w0 := PI * 2 * freq_mult;

  Self.UpdateParams(gain, bandwidth, w0);
  
  _b[2] := _b[2] / _a[0];
  _b[1] := _b[1]/ _a[0];
  _b[0] := _b[0] / _a[0];
  _a[2] :=  _a[2] / _a[0];
  _a[1] :=  _a[1] / _a[0];
  _a[0] :=  _a[0] / _a[0];
End;

{ AudioHighShelfFilter }
Function AudioHighShelfFilter.Initialize(Frequency: Cardinal): Boolean;
Begin
  Inherited Initialize(Frequency);

  Self._Gain := AL_HIGHPASS_DEFAULT_GAIN;
  Self._GainHF := 1.0;
  Self._HFReference := LOWPASSFREQREF;
  Self._GainLF := AL_HIGHPASS_DEFAULT_GAINLF;

  Self._LFReference := HIGHPASSFREQREF;
End;

Procedure AudioHighShelfFilter.UpdateParams(Const gain, bandwidth, w0:Single);
Var
  Alpha:Single;
Begin
  alpha := Sin(w0)/2.0 * Sqrt((gain + 1.0/gain)*(1.0/0.75 - 1.0) + 2.0);

  _b[0] :=       gain*((gain+1.0) + (gain-1.0)*Cos(w0) + 2.0*Sqrt(gain)*alpha);
  _b[1] := -2.0*gain*((gain-1.0) + (gain+1.0)*Cos(w0)                         );
  _b[2] :=       gain*((gain+1.0) + (gain-1.0)*Cos(w0) - 2.0*Sqrt(gain)*alpha);
  _a[0] :=             (gain+1.0) - (gain-1.0)*Cos(w0) + 2.0*Sqrt(gain)*alpha;
  _a[1] :=  2.0*     ((gain-1.0) - (gain+1.0)*Cos(w0)                         );
  _a[2] :=             (gain+1.0) - (gain-1.0)*Cos(w0) - 2.0*Sqrt(gain)*alpha;
End;

End.
