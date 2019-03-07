Received: from eggs.gnu.org ([209.51.188.92]:59665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h1k3h-0005UM-3F
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h1k3c-0003zT-Md
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:51:01 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:32867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1h1k3c-0003xT-17
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:50:56 -0500
Received: by mail-pg1-x544.google.com with SMTP id h11so10157703pgl.0
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 19:50:49 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Thu, 7 Mar 2019 06:47:13 +0300
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BRJgcDI5WyCkB8A"
Message-Id: <201903070647.13740.randrianasulu@gmail.com>
Subject: [Qemu-devel]  [PATCH v5-resend 0/2] Basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: balaton@eik.bme.hu, qemu-devel@nongnu.org

--Boundary-00=_BRJgcDI5WyCkB8A
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Tried this with mac99 machine and lubuntu 16.04 ppc.

After upgrading r128 driver to -hwe part to get past this bug
https://bugs.freedesktop.org/show_bug.cgi?id=91622

and disabling accel I can see some image and cursor!

qemu command:

ppc64-softmmu/qemu-system-ppc64 -M mac99 -device ati-vga \
-cdrom /mnt/sdb1/ISO/lubuntu-16.04-desktop-powerpc.iso -m 1G -boot d -cpu g4 -device usb-mouse -smp 1

model rv100 doesn't recognized by openfirmware, so no output from it.

Menus in wondows still at wrong place (not shown, even), but generally speaking some image is on screen.

--Boundary-00=_BRJgcDI5WyCkB8A
Content-Type: text/x-log;
  charset="iso 8859-1";
  name="Xorg.1.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Xorg.1.log"

[  6238.260] 
X.Org X Server 1.19.6
Release Date: 2017-12-20
[  6238.275] X Protocol Version 11, Revision 0
[  6238.280] Build Operating System: Linux 4.4.0-138-powerpc64-smp ppc Ubuntu
[  6238.283] Current Operating System: Linux lubuntu 4.4.0-21-powerpc-smp #37-Ubuntu SMP Mon Apr 18 18:33:34 UTC 2016 ppc
[  6238.284] Kernel command line: ro ramdisk_size=1048576 file=/cdrom/preseed/lubuntu.seed boot=casper quiet splash --- 
[  6238.302] Build Date: 25 October 2018  04:10:08PM
[  6238.306] xorg-server 2:1.19.6-1ubuntu4.1~16.04.2 (For technical support please see http://www.ubuntu.com/support) 
[  6238.313] Current version of pixman: 0.33.6
[  6238.325] 	Before reporting problems, check http://wiki.x.org
	to make sure that you have the latest version.
[  6238.326] Markers: (--) probed, (**) from config file, (==) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
[  6238.364] (==) Log file: "/var/log/Xorg.1.log", Time: Thu Mar  7 03:12:54 2019
[  6238.381] (==) Using config file: "/etc/X11/xorg.conf"
[  6238.387] (==) Using system config directory "/usr/share/X11/xorg.conf.d"
[  6238.437] (==) ServerLayout "X.org Configured"
[  6238.439] (**) |-->Screen "Screen0" (0)
[  6238.440] (**) |   |-->Monitor "Monitor0"
[  6238.449] (**) |   |-->Device "Card0"
[  6238.451] (**) |-->Input Device "Mouse0"
[  6238.451] (**) |-->Input Device "Keyboard0"
[  6238.452] (==) Automatically adding devices
[  6238.452] (==) Automatically enabling devices
[  6238.452] (==) Automatically adding GPU devices
[  6238.452] (==) Automatically binding GPU devices
[  6238.454] (==) Max clients allowed: 256, resource mask: 0x1fffff
[  6238.456] (WW) The directory "/usr/share/fonts/X11/cyrillic" does not exist.
[  6238.456] 	Entry deleted from font path.
[  6238.456] (WW) The directory "/usr/share/fonts/X11/100dpi/" does not exist.
[  6238.456] 	Entry deleted from font path.
[  6238.456] (WW) The directory "/usr/share/fonts/X11/75dpi/" does not exist.
[  6238.456] 	Entry deleted from font path.
[  6238.456] (WW) The directory "/usr/share/fonts/X11/Type1" does not exist.
[  6238.457] 	Entry deleted from font path.
[  6238.457] (WW) The directory "/usr/share/fonts/X11/100dpi" does not exist.
[  6238.457] 	Entry deleted from font path.
[  6238.457] (WW) The directory "/usr/share/fonts/X11/75dpi" does not exist.
[  6238.457] 	Entry deleted from font path.
[  6238.457] (WW) The directory "/usr/share/fonts/X11/cyrillic" does not exist.
[  6238.457] 	Entry deleted from font path.
[  6238.457] (WW) The directory "/usr/share/fonts/X11/100dpi/" does not exist.
[  6238.457] 	Entry deleted from font path.
[  6238.457] (WW) The directory "/usr/share/fonts/X11/75dpi/" does not exist.
[  6238.458] 	Entry deleted from font path.
[  6238.458] (WW) The directory "/usr/share/fonts/X11/Type1" does not exist.
[  6238.458] 	Entry deleted from font path.
[  6238.458] (WW) The directory "/usr/share/fonts/X11/100dpi" does not exist.
[  6238.458] 	Entry deleted from font path.
[  6238.458] (WW) The directory "/usr/share/fonts/X11/75dpi" does not exist.
[  6238.458] 	Entry deleted from font path.
[  6238.458] (**) FontPath set to:
	/usr/share/fonts/X11/misc,
	built-ins,
	/usr/share/fonts/X11/misc,
	built-ins
[  6238.458] (**) ModulePath set to "/usr/lib/xorg/modules"
[  6238.459] (WW) Hotplugging is on, devices using drivers 'kbd', 'mouse' or 'vmmouse' will be disabled.
[  6238.459] (WW) Disabling Mouse0
[  6238.460] (WW) Disabling Keyboard0
[  6238.460] (II) Loader magic: 0x202ee710
[  6238.461] (II) Module ABI versions:
[  6238.461] 	X.Org ANSI C Emulation: 0.4
[  6238.461] 	X.Org Video Driver: 23.0
[  6238.461] 	X.Org XInput driver : 24.1
[  6238.461] 	X.Org Server Extension : 10.0
[  6238.669] (++) using VT number 2

[  6238.915] (II) systemd-logind: took control of session /org/freedesktop/login1/session/_31
[  6239.091] (II) xfree86: Adding drm device (/dev/dri/card0)
[  6239.229] (II) systemd-logind: got fd for /dev/dri/card0 226:0 fd 11 paused 0
[  6239.328] (--) PCI:*(0:0:15:0) 1002:5046:1af4:1100 rev 0, Mem @ 0x81000000/16777216, 0x82000000/16384, I/O @ 0x00001000/256, BIOS @ 0x????????/65536
[  6239.341] (II) "glx" will be loaded. This was enabled by default and also specified in the config file.
[  6239.342] (II) LoadModule: "glx"
[  6239.389] (II) Loading /usr/lib/xorg/modules/extensions/libglx.so
[  6239.444] (II) Module glx: vendor="X.Org Foundation"
[  6239.445] 	compiled for 1.19.6, module version = 1.0.0
[  6239.446] 	ABI class: X.Org Server Extension, version 10.0
[  6239.451] (II) LoadModule: "r128"
[  6239.459] (II) Loading /usr/lib/xorg/modules/drivers/r128_drv.so
[  6239.465] (II) Module r128: vendor="X.Org Foundation"
[  6239.475] 	compiled for 1.19.3, module version = 6.10.2
[  6239.475] 	Module class: X.Org Video Driver
[  6239.476] 	ABI class: X.Org Video Driver, version 23.0
[  6239.477] (II) R128: Driver for ATI Rage 128 chipsets:
	ATI Rage 128 Mobility M3 LE (PCI), ATI Rage 128 Mobility M3 LF (AGP),
	ATI Rage 128 Mobility M4 MF (AGP), ATI Rage 128 Mobility M4 ML (AGP),
	ATI Rage 128 Pro GL PA (PCI/AGP), ATI Rage 128 Pro GL PB (PCI/AGP),
	ATI Rage 128 Pro GL PC (PCI/AGP), ATI Rage 128 Pro GL PD (PCI),
	ATI Rage 128 Pro GL PE (PCI/AGP), ATI Rage 128 Pro GL PF (AGP),
	ATI Rage 128 Pro VR PG (PCI/AGP), ATI Rage 128 Pro VR PH (PCI/AGP),
	ATI Rage 128 Pro VR PI (PCI/AGP), ATI Rage 128 Pro VR PJ (PCI/AGP),
	ATI Rage 128 Pro VR PK (PCI/AGP), ATI Rage 128 Pro VR PL (PCI/AGP),
	ATI Rage 128 Pro VR PM (PCI/AGP), ATI Rage 128 Pro VR PN (PCI/AGP),
	ATI Rage 128 Pro VR PO (PCI/AGP), ATI Rage 128 Pro VR PP (PCI),
	ATI Rage 128 Pro VR PQ (PCI/AGP), ATI Rage 128 Pro VR PR (PCI),
	ATI Rage 128 Pro VR PS (PCI/AGP), ATI Rage 128 Pro VR PT (PCI/AGP),
	ATI Rage 128 Pro VR PU (PCI/AGP), ATI Rage 128 Pro VR PV (PCI/AGP),
	ATI Rage 128 Pro VR PW (PCI/AGP), ATI Rage 128 Pro VR PX (PCI/AGP),
	ATI Rage 128 GL RE (PCI), ATI Rage 128 GL RF (AGP),
	ATI Rage 128 RG (AGP), ATI Rage 128 VR RK (PCI),
	ATI Rage 128 VR RL (AGP), ATI Rage 128 4X SE (PCI/AGP),
	ATI Rage 128 4X SF (PCI/AGP), ATI Rage 128 4X SG (PCI/AGP),
	ATI Rage 128 4X SH (PCI/AGP), ATI Rage 128 4X SK (PCI/AGP),
	ATI Rage 128 4X SL (PCI/AGP), ATI Rage 128 4X SM (AGP),
	ATI Rage 128 4X SN (PCI/AGP), ATI Rage 128 Pro ULTRA TF (AGP),
	ATI Rage 128 Pro ULTRA TL (AGP), ATI Rage 128 Pro ULTRA TR (AGP),
	ATI Rage 128 Pro ULTRA TS (AGP?), ATI Rage 128 Pro ULTRA TT (AGP?),
	ATI Rage 128 Pro ULTRA TU (AGP?)
[  6239.503] (II) R128(0): PCI bus 0 card 15 func 0
[  6239.505] (==) R128(0): Depth 24, (--) framebuffer bpp 32
[  6239.506] (II) R128(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
[  6239.507] (==) R128(0): Default visual is TrueColor
[  6239.508] (**) R128(0): Option "NoAccel" "1"
[  6239.508] (**) R128(0): Option "PanelWidth" "1024"
[  6239.509] (**) R128(0): Option "PanelHeight" "768"
[  6239.509] (II) R128(0): VGAAccess option set to FALSE, VGA module load skipped
[  6239.509] (==) R128(0): RGB weight 888
[  6239.510] (II) R128(0): Using 8 bits per RGB (8 bit DAC)
[  6239.510] (**) R128(0): Using framebuffer device
[  6239.510] (II) Loading sub module "fbdevhw"
[  6239.510] (II) LoadModule: "fbdevhw"
[  6239.511] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
[  6239.516] (II) Module fbdevhw: vendor="X.Org Foundation"
[  6239.518] 	compiled for 1.19.6, module version = 0.0.2
[  6239.519] 	ABI class: X.Org Video Driver, version 23.0
[  6239.523] (--) R128(0): Chipset: "ATI Rage 128 Pro GL PF (AGP)" (ChipID = 0x5046)
[  6239.523] (--) R128(0): Linear framebuffer at 0x80000000
[  6239.523] (--) R128(0): MMIO registers at 0x82000000
[  6239.525] (--) R128(0): VideoRAM: 16384 kByte (64-bit SDR SGRAM 1:1)
[  6239.526] (II) Loading sub module "ddc"
[  6239.526] (II) LoadModule: "ddc"
[  6239.526] (II) Module "ddc" already built-in
[  6239.526] (II) Loading sub module "i2c"
[  6239.526] (II) LoadModule: "i2c"
[  6239.526] (II) Module "i2c" already built-in
[  6239.541] (II) R128(0): PLL parameters: rf=2950 rd=0 min=12500 max=25000; xclk=0
[  6239.545] (II) R128(0): Output DVI-0 using monitor section Monitor0
[  6239.546] (II) R128(0): I2C bus "DVI-0" initialized.
[  6239.547] (**) R128(0): Option "NoDDC" "1"
[  6239.549] (II) R128(0): EDID for output DVI-0
[  6239.558] (II) R128(0): Not using default mode "1024x768i" (hsync out of range)
[  6239.558] (II) R128(0): Not using default mode "1024x768" (vrefresh out of range)
[  6239.558] (II) R128(0): Not using default mode "1024x768" (vrefresh out of range)
[  6239.558] (II) R128(0): Not using default mode "1024x768" (hsync out of range)
[  6239.559] (II) R128(0): Not using default mode "1024x768" (vrefresh out of range)
[  6239.559] (II) R128(0): Not using default mode "1024x768" (hsync out of range)
[  6239.559] (II) R128(0): Not using default mode "1024x768" (hsync out of range)
[  6239.559] (II) R128(0): Printing probed modes for output DVI-0
[  6239.561] (II) R128(0): Modeline "1024x768"x72.3   78.75  1024 1044 1140 1328  768 781 784 820 +hsync +vsync (59.3 kHz UP)
[  6239.561] (II) R128(0): Modeline "1024x768"x75.0   78.75  1024 1040 1136 1312  768 769 772 800 +hsync +vsync (60.0 kHz d)
[  6239.562] (II) R128(0): Output DVI-0 connected
[  6239.563] (II) R128(0): Using user preference for initial modes
[  6239.563] (II) R128(0): Output DVI-0 using initial mode 1024x768 +0+0
[  6239.566] (==) R128(0): DPI set to (96, 96)
[  6239.566] (II) Loading sub module "fb"
[  6239.566] (II) LoadModule: "fb"
[  6239.568] (II) Loading /usr/lib/xorg/modules/libfb.so
[  6239.571] (II) Module fb: vendor="X.Org Foundation"
[  6239.573] 	compiled for 1.19.6, module version = 1.0.0
[  6239.573] 	ABI class: X.Org ANSI C Emulation, version 0.4
[  6239.574] (==) R128(0): Using gamma correction (1.0, 1.0, 1.0)
[  6239.574] (II) Loading sub module "ramdac"
[  6239.574] (II) LoadModule: "ramdac"
[  6239.575] (II) Module "ramdac" already built-in
[  6239.575] (II) Loading sub module "shadowfb"
[  6239.575] (II) LoadModule: "shadowfb"
[  6239.577] (II) Loading /usr/lib/xorg/modules/libshadowfb.so
[  6239.578] (II) Module shadowfb: vendor="X.Org Foundation"
[  6239.579] 	compiled for 1.19.6, module version = 1.0.0
[  6239.579] 	ABI class: X.Org ANSI C Emulation, version 0.4
[  6239.580] (II) R128(0): Page flipping disabled
[  6239.582] (--) Depth 24 pixmap format is 32 bpp
[  6239.585] (II) R128(0): Acceleration of RENDER operations will be enabled upon successful loading of DRI and EXA
[  6239.589] (WW) R128(0): Acceleration disabled, not initializing the DRI
[  6239.604] (II) R128(0): Memory manager initialized to (0,0) (1024,4096)
[  6239.607] (II) R128(0): Reserved area from (0,768) to (1024,770)
[  6239.608] (II) R128(0): Largest offscreen area available: 1024 x 3326
[  6239.608] (II) R128(0): Acceleration disabled
[  6239.618] (==) R128(0): Backing store enabled
[  6239.619] (==) R128(0): Silken mouse enabled
[  6239.623] (II) R128(0): Will use 2 kb for hardware cursor 0 at offset 0x00302000
[  6239.624] (II) R128(0): Largest offscreen area available: 1024 x 3325
[  6239.627] (==) R128(0): DPMS enabled
[  6239.632] (WW) R128(0): Option "PreferredMode" is not used
[  6239.633] (WW) R128(0): Option "DefaultModes" is not used
[  6239.633] (WW) R128(0): Direct rendering disabled
[  6239.633] (II) R128(0): RandR 1.2 enabled, ignore the following RandR disabled message.
[  6239.652] (--) RandR disabled
[  6239.771] (II) SELinux: Disabled on system
[  6239.784] (II) AIGLX: Screen 0 is not DRI2 capable
[  6239.785] (EE) AIGLX: reverting to software rendering
[  6239.898] (II) IGLX: enabled GLX_MESA_copy_sub_buffer
[  6239.907] (II) IGLX: Loaded and initialized swrast
[  6239.907] (II) GLX: Initialized DRISWRAST GL provider for screen 0
[  6241.395] (II) config/udev: Adding input device QEMU QEMU USB Mouse (/dev/input/event2)
[  6241.399] (**) QEMU QEMU USB Mouse: Applying InputClass "evdev pointer catchall"
[  6241.401] (II) LoadModule: "evdev"
[  6241.402] (II) Loading /usr/lib/xorg/modules/input/evdev_drv.so
[  6241.411] (II) Module evdev: vendor="X.Org Foundation"
[  6241.411] 	compiled for 1.19.3, module version = 2.10.5
[  6241.412] 	Module class: X.Org XInput Driver
[  6241.412] 	ABI class: X.Org XInput driver, version 24.1
[  6241.413] (II) Using input driver 'evdev' for 'QEMU QEMU USB Mouse'
[  6241.493] (II) systemd-logind: got fd for /dev/input/event2 13:66 fd 20 paused 0
[  6241.500] (**) QEMU QEMU USB Mouse: always reports core events
[  6241.502] (**) evdev: QEMU QEMU USB Mouse: Device: "/dev/input/event2"
[  6241.508] (--) evdev: QEMU QEMU USB Mouse: Vendor 0x627 Product 0x1
[  6241.509] (--) evdev: QEMU QEMU USB Mouse: Found 3 mouse buttons
[  6241.509] (--) evdev: QEMU QEMU USB Mouse: Found scroll wheel(s)
[  6241.509] (--) evdev: QEMU QEMU USB Mouse: Found relative axes
[  6241.510] (--) evdev: QEMU QEMU USB Mouse: Found x and y relative axes
[  6241.511] (II) evdev: QEMU QEMU USB Mouse: Configuring as mouse
[  6241.511] (II) evdev: QEMU QEMU USB Mouse: Adding scrollwheel support
[  6241.513] (**) evdev: QEMU QEMU USB Mouse: YAxisMapping: buttons 4 and 5
[  6241.514] (**) evdev: QEMU QEMU USB Mouse: EmulateWheelButton: 4, EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[  6241.515] (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000:00:0d.0/usb1/1-1/1-1:1.0/0003:0627:0001.0001/input/input2/event2"
[  6241.515] (II) XINPUT: Adding extended input device "QEMU QEMU USB Mouse" (type: MOUSE, id 6)
[  6241.526] (II) evdev: QEMU QEMU USB Mouse: initialized for relative axes.
[  6241.541] (**) QEMU QEMU USB Mouse: (accel) keeping acceleration scheme 1
[  6241.543] (**) QEMU QEMU USB Mouse: (accel) acceleration profile 0
[  6241.554] (**) QEMU QEMU USB Mouse: (accel) acceleration factor: 2.000
[  6241.555] (**) QEMU QEMU USB Mouse: (accel) acceleration threshold: 4
[  6241.580] (II) config/udev: Adding input device QEMU QEMU USB Mouse (/dev/input/mouse1)
[  6241.583] (II) No input driver specified, ignoring this device.
[  6241.583] (II) This device may have been added with another device file.
[  6241.639] (II) config/udev: Adding input device ADB keyboard (/dev/input/event0)
[  6241.641] (**) ADB keyboard: Applying InputClass "evdev keyboard catchall"
[  6241.642] (II) Using input driver 'evdev' for 'ADB keyboard'
[  6241.654] (II) systemd-logind: got fd for /dev/input/event0 13:64 fd 21 paused 0
[  6241.657] (**) ADB keyboard: always reports core events
[  6241.658] (**) evdev: ADB keyboard: Device: "/dev/input/event0"
[  6241.659] (--) evdev: ADB keyboard: Vendor 0x1 Product 0x2202
[  6241.660] (--) evdev: ADB keyboard: Found keys
[  6241.660] (II) evdev: ADB keyboard: Configuring as keyboard
[  6241.661] (**) Option "config_info" "udev:/sys/devices/virtual/input/input0/event0"
[  6241.662] (II) XINPUT: Adding extended input device "ADB keyboard" (type: KEYBOARD, id 7)
[  6241.663] (**) Option "xkb_rules" "evdev"
[  6241.663] (**) Option "xkb_model" "pc105"
[  6241.664] (**) Option "xkb_layout" "us"
[  6241.677] (II) config/udev: Adding input device ADB mouse (/dev/input/event1)
[  6241.678] (**) ADB mouse: Applying InputClass "evdev pointer catchall"
[  6241.679] (II) Using input driver 'evdev' for 'ADB mouse'
[  6241.690] (II) systemd-logind: got fd for /dev/input/event1 13:65 fd 22 paused 0
[  6241.691] (**) ADB mouse: always reports core events
[  6241.693] (**) evdev: ADB mouse: Device: "/dev/input/event1"
[  6241.694] (--) evdev: ADB mouse: Vendor 0x1 Product 0x3303
[  6241.694] (--) evdev: ADB mouse: Found 3 mouse buttons
[  6241.694] (--) evdev: ADB mouse: Found relative axes
[  6241.695] (--) evdev: ADB mouse: Found x and y relative axes
[  6241.695] (II) evdev: ADB mouse: Configuring as mouse
[  6241.697] (**) evdev: ADB mouse: YAxisMapping: buttons 4 and 5
[  6241.697] (**) evdev: ADB mouse: EmulateWheelButton: 4, EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[  6241.698] (**) Option "config_info" "udev:/sys/devices/virtual/input/input1/event1"
[  6241.700] (II) XINPUT: Adding extended input device "ADB mouse" (type: MOUSE, id 8)
[  6241.701] (II) evdev: ADB mouse: initialized for relative axes.
[  6241.705] (**) ADB mouse: (accel) keeping acceleration scheme 1
[  6241.706] (**) ADB mouse: (accel) acceleration profile 0
[  6241.707] (**) ADB mouse: (accel) acceleration factor: 2.000
[  6241.707] (**) ADB mouse: (accel) acceleration threshold: 4
[  6241.715] (II) config/udev: Adding input device ADB mouse (/dev/input/mouse0)
[  6241.716] (II) No input driver specified, ignoring this device.
[  6241.717] (II) This device may have been added with another device file.
[  6322.823] (II) systemd-logind: got pause for 13:64
[  6322.847] (II) systemd-logind: got pause for 226:0
[  6322.861] (II) systemd-logind: got pause for 13:66
[  6322.868] (II) systemd-logind: got pause for 13:65
[  6465.826] (II) systemd-logind: got resume for 13:64
[  6466.059] (II) systemd-logind: got resume for 226:0
[  6466.419] (II) systemd-logind: got resume for 13:66
[  6466.447] (II) systemd-logind: got resume for 13:65
[  6511.689] (II) systemd-logind: got pause for 13:64
[  6511.731] (II) systemd-logind: got pause for 226:0
[  6511.772] (II) systemd-logind: got pause for 13:66
[  6511.808] (II) systemd-logind: got pause for 13:65
[  6818.848] (II) systemd-logind: got resume for 13:64
[  6819.130] (II) systemd-logind: got resume for 226:0
[  6820.039] (II) systemd-logind: got resume for 13:66
[  6820.134] (II) systemd-logind: got resume for 13:65
[  6823.719] (II) systemd-logind: got pause for 13:64
[  6823.726] (II) systemd-logind: got pause for 226:0
[  6823.728] (II) systemd-logind: got pause for 13:66
[  6823.731] (II) systemd-logind: got pause for 13:65

--Boundary-00=_BRJgcDI5WyCkB8A
Content-Type: text/plain;
  charset="iso 8859-1";
  name="dmesg_ati_r128"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg_ati_r128"

[    0.000000] Using PowerMac machine description
[    0.000000] Total memory = 1024MB; using 2048kB for hash table (at cfe00000)
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.4.0-21-powerpc-smp (buildd@denneed04) (gcc version 5.3.1 20160413 (Ubuntu 5.3.1-14ubuntu2) ) #37-Ubuntu SMP Mon Apr 18 18:33:34 UTC 2016 (Ubuntu 4.4.0-21.37-powerpc-smp 4.4.6)
[    0.000000] Found initrd at 0xc1b00000:0xc30f9ad3
[    0.000000] Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0x07
[    0.000000] Mapped at 0xff7c0000
[    0.000000] Found a Keylargo mac-io controller, rev: 0, mapped at 0xff740000
[    0.000000] Processor NAP mode on idle enabled.
[    0.000000] PowerMac motherboard: PowerMac G4 AGP Graphics
[    0.000000] CPU maps initialized for 1 thread per core
[    0.000000]  (thread shift is 0)
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f2000000. Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f2000000 (primary) ranges:
[    0.000000]   IO 0x00000000f2000000..0x00000000f27fffff -> 0x0000000000000000
[    0.000000]  MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000 
[    0.000000] nvram: Checking bank 0...
[    0.000000] Invalid signature
[    0.000000] Invalid checksum
[    0.000000] nvram: gen0=0, gen1=0
[    0.000000] nvram: Active bank is: 0
[    0.000000] nvram: OF partition at 0xffffffff
[    0.000000] nvram: XP partition at 0xffffffff
[    0.000000] nvram: NR partition at 0xffffffff
[    0.000000] Top of RAM: 0x40000000, Total RAM: 0x40000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x0000000030000000-0x000000003fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000] On node 0 totalpages: 262144
[    0.000000] free_area_init_node: node 0, pgdat c0bb0920, node_mem_map ef6ee000
[    0.000000]   DMA zone: 1728 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 196608 pages, LIFO batch:31
[    0.000000]   HighMem zone: 65536 pages, LIFO batch:15
[    0.000000] PERCPU: Embedded 13 pages/cpu @ef6db000 s22188 r8192 d22868 u53248
[    0.000000] pcpu-alloc: s22188 r8192 d22868 u53248 alloc=13*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260416
[    0.000000] Kernel command line: ro ramdisk_size=1048576 file=/cdrom/preseed/lubuntu.seed boot=casper quiet splash --- 
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] allocated 1048576 bytes of page_ext
[    0.000000] Memory: 932896K/1048576K available (8204K kernel code, 564K rwdata, 2784K rodata, 536K init, 1743K bss, 115680K reserved, 0K cma-reserved, 262144K highmem)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfff9f000..0xfffff000  : fixmap
[    0.000000]   * 0xff800000..0xffc00000  : highmem PTEs
[    0.000000]   * 0xfef37000..0xff800000  : early ioremap
[    0.000000]   * 0xf1000000..0xfef37000  : vmalloc & ioremap
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] mpic: Resetting
[    0.000000] mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 1 CPUs
[    0.000000] mpic: ISU size: 64, shift: 6, mask: 3f
[    0.000000] mpic: Initializing for 64 sources
[    0.000000] GMT Delta read from XPRAM: 0 minutes, DST: on
[    0.000000] time_init: decrementer frequency = 100.000000 MHz
[    0.000000] time_init: processor frequency   = 900.000000 MHz
[    0.001095] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
[    0.001390] clocksource: timebase mult[a000000] shift[24] registered
[    0.001845] clockevent: decrementer mult[1999999a] shift[32] cpu[0]
[    0.017324] Console: colour dummy device 80x25
[    0.017578] console [tty0] enabled
[    0.017734] bootconsole [udbg0] disabled
[    0.025361] pid_max: default: 32768 minimum: 301
[    0.027534] Security Framework initialized
[    0.027651] Yama: becoming mindful.
[    0.032695] AppArmor: AppArmor initialized
[    0.036428] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.036486] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.079970] Initializing cgroup subsys io
[    0.080500] Initializing cgroup subsys memory
[    0.080983] Initializing cgroup subsys devices
[    0.081164] Initializing cgroup subsys freezer
[    0.081325] Initializing cgroup subsys net_cls
[    0.081478] Initializing cgroup subsys perf_event
[    0.081664] Initializing cgroup subsys net_prio
[    0.081829] Initializing cgroup subsys pids
[    0.082751] ftrace: allocating 26562 entries in 78 pages
[    0.210111] PowerMac SMP probe found 1 cpus
[    0.238820] Brought up 1 CPUs
[    0.262742] devtmpfs: initialized
[    0.283110] evm: security.selinux
[    0.283173] evm: security.SMACK64
[    0.283192] evm: security.SMACK64EXEC
[    0.283211] evm: security.SMACK64TRANSMUTE
[    0.283229] evm: security.SMACK64MMAP
[    0.283247] evm: security.ima
[    0.283271] evm: security.capability
[    0.288323] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.314539] NET: Registered protocol family 16
[    0.324119] cpuidle: using governor ladder
[    0.324414] cpuidle: using governor menu
[    0.358339] PCI: Probing PCI hardware
[    0.363973] PCI host bridge to bus 0000:00
[    0.364863] pci_bus 0000:00: root bus resource [io  0x0000-0x7fffff]
[    0.365058] pci_bus 0000:00: root bus resource [mem 0x80000000-0x8fffffff]
[    0.365507] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.365987] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
[    0.368097] pci 0000:00:0b.0: [106b:001f] type 00 class 0x060000
[    0.373345] pci 0000:00:0c.0: [106b:0022] type 00 class 0xff0000
[    0.374833] pci 0000:00:0c.0: reg 0x10: [mem 0x80000000-0x8007ffff]
[    0.394986] pci 0000:00:0d.0: [106b:003f] type 00 class 0x0c0310
[    0.395999] pci 0000:00:0d.0: reg 0x10: [mem 0x80080000-0x800800ff]
[    0.402045] pci 0000:00:0e.0: [106b:0021] type 00 class 0x020000
[    0.402828] pci 0000:00:0e.0: reg 0x10: [mem 0x80200000-0x803fffff]
[    0.407388] pci 0000:00:0f.0: [1002:5046] type 00 class 0x030000
[    0.409097] pci 0000:00:0f.0: reg 0x10: [mem 0x81000000-0x81ffffff pref]
[    0.411205] pci 0000:00:0f.0: reg 0x14: [io  0x1000-0x10ff]
[    0.412979] pci 0000:00:0f.0: reg 0x18: [mem 0x82000000-0x82003fff]
[    0.423850] pci 0000:00:0f.0: reg 0x30: [mem 0x82010000-0x8201ffff pref]
[    0.428042] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    0.436557] pci_bus 0000:00: resource 4 [io  0x0000-0x7fffff]
[    0.436676] pci_bus 0000:00: resource 5 [mem 0x80000000-0x8fffffff]
[    0.484909] vgaarb: setting as boot device: PCI:0000:00:0f.0
[    0.485313] vgaarb: device added: PCI:0000:00:0f.0,decodes=io+mem,owns=io+mem,locks=none
[    0.485428] vgaarb: loaded
[    0.485518] vgaarb: bridge control possible 0000:00:0f.0
[    0.491977] SCSI subsystem initialized
[    0.493404] libata version 3.00 loaded.
[    0.495327] usbcore: registered new interface driver usbfs
[    0.495999] usbcore: registered new interface driver hub
[    0.496618] usbcore: registered new device driver usb
[    0.518840] NetLabel: Initializing
[    0.519021] NetLabel:  domain hash size = 128
[    0.519066] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.522113] NetLabel:  unlabeled traffic allowed by default
[    0.528433] clocksource: Switched to clocksource timebase
[    0.719689] AppArmor: AppArmor Filesystem Enabled
[    0.758307] NET: Registered protocol family 2
[    0.770664] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.771112] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.771941] TCP: Hash tables configured (established 8192 bind 8192)
[    0.774338] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.774663] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.777937] NET: Registered protocol family 1
[    0.782506] PCI: CLS 0 bytes, default 32
[    0.795575] Trying to unpack rootfs image as initramfs...
[   42.521883] Freeing initrd memory: 22500K (c1b00000 - c30f9000)
[   42.524139] Thermal assist unit using timers, shrink_timer: 500 jiffies
[   42.537487] futex hash table entries: 256 (order: 1, 8192 bytes)
[   42.538917] audit: initializing netlink subsys (disabled)
[   42.541071] audit: type=2000 audit(1551921969.428:1): initialized
[   42.546535] Initialise system trusted keyring
[   42.587959] zbud: loaded
[   42.591517] VFS: Disk quotas dquot_6.6.0
[   42.592323] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   42.603778] fuse init (API version 7.23)
[   42.607406] Key type big_key registered
[   42.620971] Key type asymmetric registered
[   42.621102] Asymmetric key parser 'x509' registered
[   42.621458] bounce: pool size: 64 pages
[   42.621850] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[   42.623004] io scheduler noop registered
[   42.623139] io scheduler deadline registered (default)
[   42.623980] io scheduler cfq registered
[   42.628539] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   42.628917] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[   42.633997] aty128fb: Found Intel x86 BIOS ROM Image
[   42.634043] aty128fb: Rage128 BIOS located
[   42.637754] aty128fb: Rage128 PF PRO AGP [chip rev 0x0] 16M 128-bit SDR SGRAM (1:1)
[   42.663788] Console: switching to colour frame buffer device 128x48
[   42.670174] fb0: ATY Rage128 frame buffer device on Rage128 PF PRO AGP
[   42.697145] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[   42.736786] pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
[   42.739112] Generic non-volatile memory driver v1.1
[   42.740560] Linux agpgart interface v0.103
[   42.849029] brd: module loaded
[   42.872708] loop: module loaded
[   42.877820] MacIO PCI driver attached to Keylargo chipset
[   42.885911] 0.00013020:ch-a: ttyPZ0 at MMIO 0x80013020 (irq = 37, base_baud = 230400) is a Z85c30 ESCC - Serial port
[   42.888183] 0.00013000:ch-b: ttyPZ1 at MMIO 0x80013000 (irq = 36, base_baud = 230400) is a Z85c30 ESCC - Serial port
[   42.894233] Macintosh CUDA driver v0.5 for Unified ADB.
[   42.902662] adb: starting probe task...
[   42.928854] adb devices: [2]: 2 2 [3]: 3 3
[   42.934108] ADB keyboard at 2, handler 1
[   42.934745] Detected ADB keyboard, type ANSI.
[   42.937991] input: ADB keyboard as /devices/virtual/input/input0
[   42.947964] ADB mouse at 3, handler set to 3 (Mouse Systems A3 Mouse, or compatible)
[   42.951599] input: ADB mouse as /devices/virtual/input/input1
[   42.952024] adb: finished probe task...
[   43.920429] pata-macio 0.00020000:ata-3: Activating pata-macio chipset KeyLargo ATA-3, Apple bus ID 0
[   43.936878] scsi host0: pata_macio
[   43.939870] ata1: PATA max MWDMA2 irq 16
[   44.967714] pata-macio 0.00021000:ata-3: Activating pata-macio chipset KeyLargo ATA-3, Apple bus ID 1
[   44.974119] scsi host1: pata_macio
[   44.975918] ata2: PATA max MWDMA2 irq 18
[   44.982042] libphy: Fixed MDIO Bus: probed
[   44.982313] tun: Universal TUN/TAP device driver, 1.6
[   44.982388] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   44.984418] PPP generic driver version 2.4.2
[   44.986191] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   44.986883] ehci-pci: EHCI PCI platform driver
[   44.987676] ehci-platform: EHCI generic platform driver
[   44.987893] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   44.988241] ohci-pci: OHCI PCI platform driver
[   44.990632] ohci-pci 0000:00:0d.0: OHCI PCI host controller
[   44.991910] ohci-pci 0000:00:0d.0: new USB bus registered, assigned bus number 1
[   44.994302] ohci-pci 0000:00:0d.0: irq 28, io mem 0x80080000
[   45.062034] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[   45.062100] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   45.062157] usb usb1: Product: OHCI PCI host controller
[   45.062214] usb usb1: Manufacturer: Linux 4.4.0-21-powerpc-smp ohci_hcd
[   45.062269] usb usb1: SerialNumber: 0000:00:0d.0
[   45.069026] hub 1-0:1.0: USB hub found
[   45.070228] hub 1-0:1.0: 3 ports detected
[   45.080545] ohci-platform: OHCI generic platform driver
[   45.080879] uhci_hcd: USB Universal Host Controller Interface driver
[   45.084880] mousedev: PS/2 mouse device common for all mice
[   45.087380] i2c /dev entries driver
[   45.089166] device-mapper: uevent: version 1.0.3
[   45.090879] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel@redhat.com
[   45.092715] ledtrig-cpu: registered to indicate activity on CPUs
[   45.097725] NET: Registered protocol family 10
[   45.111039] NET: Registered protocol family 17
[   45.111983] Key type dns_resolver registered
[   45.116374] registered taskstats version 1
[   45.116826] Loading compiled-in X.509 certificates
[   45.147038] ata2.01: NODEV after polling detection
[   45.149977] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[   45.153267] ata2.00: configured for MWDMA2
[   45.160487] Loaded X.509 cert 'Build time autogenerated kernel key: 4be2596f661edc589a661416cf2887229e4b74d6'
[   45.162645] zswap: loaded using pool lzo/zbud
[   45.201636] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[   45.224538] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[   45.224946] cdrom: Uniform CD-ROM driver Revision: 3.20
[   45.234943] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   45.236677] sr 1:0:0:0: Attached scsi generic sg0 type 5
[   45.467727] usb 1-1: new full-speed USB device number 2 using ohci-pci
[   45.542304] Key type trusted registered
[   45.707529] usb 1-1: New USB device found, idVendor=0627, idProduct=0001
[   45.707610] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=9
[   45.707660] usb 1-1: Product: QEMU USB Mouse
[   45.707707] usb 1-1: Manufacturer: QEMU
[   45.707754] usb 1-1: SerialNumber: 89126-pci.2:0d.0-1
[   46.057491] Key type encrypted registered
[   46.057694] AppArmor: AppArmor sha1 policy hashing enabled
[   46.058240] ima: No TPM chip found, activating TPM-bypass!
[   46.061838] evm: HMAC attrs: 0x1
[   46.065722] hctosys: unable to open rtc device (rtc0)
[   46.067749] PM: Hibernation image not present or could not be loaded.
[   46.246599] Freeing unused kernel memory: 536K (c0abf000 - c0b45000)
[   47.721106] random: systemd-udevd urandom read with 6 bits of entropy available
[   49.482532] sungem.c:v1.0 David S. Miller <davem@redhat.com>
[   49.533848] hidraw: raw HID events driver (C) Jiri Kosina
[   49.550636] gem 0000:00:0e.0 eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 52:54:00:12:34:56
[   49.683529] usbcore: registered new interface driver usbhid
[   49.683618] usbhid: USB HID core driver
[   51.146412] gem 0000:00:0e.0 enp0s14: renamed from eth0
[   51.203558] input: QEMU QEMU USB Mouse as /devices/pci0000:00/0000:00:0d.0/usb1/1-1/1-1:1.0/0003:0627:0001.0001/input/input2
[   51.212432] hid-generic 0003:0627:0001.0001: input,hidraw0: USB HID v0.01 Mouse [QEMU QEMU USB Mouse] on usb-0000:00:0d.0-1/input0
[   59.567766] ISO 9660 Extensions: RRIP_1991A
[   61.508333] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   62.578497] random: nonblocking pool is initialized
[  185.166818] systemd[1]: systemd 229 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
[  185.174700] systemd[1]: Detected architecture ppc.
[  185.177665] systemd[1]: Set hostname to <lubuntu>.
[  185.180941] systemd[1]: Initializing machine ID from random generator.
[  188.513416] systemd[1]: Listening on Journal Socket (/dev/log).
[  188.523606] systemd[1]: Created slice User and Session Slice.
[  188.532621] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[  188.533578] systemd[1]: Listening on Syslog Socket.
[  188.534075] systemd[1]: Reached target Remote File Systems (Pre).
[  188.534369] systemd[1]: Reached target Remote File Systems.
[  188.536739] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[  188.537923] systemd[1]: Listening on Journal Socket.
[  188.539844] systemd[1]: Listening on LVM2 metadata daemon socket.
[  188.540169] systemd[1]: Reached target User and Group Name Lookups.
[  188.540770] systemd[1]: Listening on LVM2 poll daemon socket.
[  188.543828] systemd[1]: Listening on udev Kernel Socket.
[  188.548038] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[  188.548596] systemd[1]: Reached target Encrypted Volumes.
[  188.549781] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[  188.555361] systemd[1]: Listening on Journal Audit Socket.
[  188.556406] systemd[1]: Listening on udev Control Socket.
[  188.556614] systemd[1]: Reached target Swap.
[  188.558477] systemd[1]: Created slice System Slice.
[  188.609199] systemd[1]: Starting Nameserver information manager...
[  188.626458] systemd[1]: Created slice system-serial\x2dgetty.slice.
[  188.753461] systemd[1]: Mounting POSIX Message Queue File System...
[  189.119604] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[  189.456628] systemd[1]: Starting LSB: controls configuration of serial ports...
[  190.385372] systemd[1]: Started Read required files in advance.
[  190.966494] systemd[1]: Starting Journal Service...
[  191.392684] systemd[1]: Mounting Debug File System...
[  191.393574] systemd[1]: Reached target Slices.
[  191.917737] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[  192.874564] systemd[1]: Starting Uncomplicated firewall...
[  193.535007] systemd[1]: Starting Load Kernel Modules...
[  194.189287] systemd[1]: Starting Remount Root and Kernel File Systems...
[  195.402615] systemd[1]: Mounted Debug File System.
[  195.460432] systemd[1]: Mounted POSIX Message Queue File System.
[  195.975801] systemd[1]: Started Create list of required static device nodes for the current kernel.
[  196.063460] systemd[1]: Started Uncomplicated firewall.
[  196.199635] systemd[1]: Started Load Kernel Modules.
[  197.889482] systemd[1]: Started Nameserver information manager.
[  198.315375] systemd[1]: Started Remount Root and Kernel File Systems.
[  198.856837] systemd[1]: Started Journal Service.
[  211.834600] systemd-journald[817]: Received request to flush runtime journal from PID 1
[  230.830117] rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0
[  255.138657] zram: Added device: zram0
[  259.324679] zram0: detected capacity change from 0 to 523661312
[  262.272144] Adding 511384k swap on /dev/zram0.  Priority:5 extents:1 across:511384k SSFS
[  295.870013] IPv6: ADDRCONF(NETDEV_UP): enp0s14: link is not ready
[  296.012316] sungem_phy: PHY ID: 406210, addr: 0
[  296.013285] gem 0000:00:0e.0 enp0s14: Found BCM5201 PHY
[  296.015056] IPv6: ADDRCONF(NETDEV_UP): enp0s14: link is not ready
[  297.216561] gem 0000:00:0e.0 enp0s14: Link is up at 100 Mbps, full-duplex
[  297.217522] gem 0000:00:0e.0 enp0s14: Pause is disabled
[  297.221530] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s14: link becomes ready
[ 6065.191742] [drm] Initialized drm 1.1.0 20060810
[ 6065.459140] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[ 6065.459224] [drm] No driver support for vblank timestamp query.
[ 6065.459442] [drm] Initialized r128 2.5.0 20030725 for 0000:00:0f.0 on minor 0
[ 6671.391221] pcmanfm[5032]: unhandled signal 11 at 00000004 nip 1fba3bf0 lr 20539d40 code 30001
[ 6749.450215] pcmanfm[5103]: unhandled signal 11 at 00000004 nip 1fcdfbf0 lr 20675d40 code 30001
[ 6769.840585] pcmanfm[5132]: unhandled signal 11 at 00000004 nip 1f946bf0 lr 202dcd40 code 30001
[ 6783.255989] pcmanfm[5140]: unhandled signal 11 at 00000004 nip 1fd9bbf0 lr 20731d40 code 30001
[ 6794.223292] pcmanfm[5148]: unhandled signal 11 at 00000004 nip 1f88cbf0 lr 20222d40 code 30001
[ 6804.903538] pcmanfm[5156]: unhandled signal 11 at 00000004 nip 1f9afbf0 lr 20345d40 code 30001

--Boundary-00=_BRJgcDI5WyCkB8A--
