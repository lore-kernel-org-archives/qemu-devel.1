Received: from eggs.gnu.org ([2001:4830:134:3::10]:59917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cFulj-0005Qu-Os
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 22:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cFulg-0005sB-JA
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 22:25:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:55183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cFulg-0005qQ-Aj
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 22:25:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cFule-0000er-EB
	for <qemu-devel@nongnu.org>; Sun, 11 Dec 2016 03:25:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4E8B72E80C6
	for <qemu-devel@nongnu.org>; Sun, 11 Dec 2016 03:25:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Dec 2016 03:15:31 -0000
From: LPNow <77777@tutanota.de>
Reply-To: Bug 1649040 <1649040@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20161211031531.25603.88090.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1649040] [NEW] Ubuntu 16.04.1 Grub Splash Doesn't
 Appear
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

My Specs:

Slackware 14.2 x86_64 > Host
QEMU 2.7.0

Ubuntu 16.04.1 x86_64 > Guest

Start options for Ubuntu:

qemu-system-x86_64 -drive format=3Draw,file=3Dubuntu.img \
-cpu host \
--enable-kvm \
-smp 2 \
-m 4096 \
-vga vmware \
-soundhw ac97 \
-usbdevice tablet \
-rtc base=3Dlocaltime \
-usbdevice host:0781:5575

I've started Ubuntu around 6-8 times, and I have only see the Grub Boot
Splash appear twice, so pretty much without fail it typically boots past
the grub splash and automatically boots...

These are the /etc/default/grub settings; (I only changed these options
GRUB_TIMEOUT=3D15 and GRUB_GFXMODE=3D1440x900)

# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.
# For full documentation of the options in this file, see:
#   info -f grub -n 'Simple configuration'

GRUB_DEFAULT=3D0
GRUB_HIDDEN_TIMEOUT=3D0
GRUB_HIDDEN_TIMEOUT_QUIET=3Dtrue
GRUB_TIMEOUT=3D15
GRUB_DISTRIBUTOR=3D`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT=3D"quiet splash"
GRUB_CMDLINE_LINUX=3D""

# Uncomment to enable BadRAM filtering, modify to suit your needs
# This works with Linux (no patch required) and with any kernel that obtains
# the memory map information from GRUB (GNU Mach, kernel of FreeBSD ...)
#GRUB_BADRAM=3D"0x01234567,0xfefefefe,0x89abcdef,0xefefefef"

# Uncomment to disable graphical terminal (grub-pc only)
#GRUB_TERMINAL=3Dconsole

# The resolution used on graphical terminal
# note that you can use only modes which your graphic card supports via VBE
# you can see them in real GRUB with the command `vbeinfo'
GRUB_GFXMODE=3D1440x900

# Uncomment if you don't want GRUB to pass "root=3DUUID=3Dxxx" parameter to=
 Linux
#GRUB_DISABLE_LINUX_UUID=3Dtrue

# Uncomment to disable generation of recovery mode menu entries
#GRUB_DISABLE_RECOVERY=3D"true"

# Uncomment to get a beep at grub start
#GRUB_INIT_TUNE=3D"480 440 1"

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  My Specs:
  =

  Slackware 14.2 x86_64 > Host
- QEMU 2.7.0 =

+ QEMU 2.7.0
  =

- Ubuntu 16.04.1 > Guest
+ Ubuntu 16.04.1 x86_64 > Guest
  =

  Start options for Ubuntu:
  =

  qemu-system-x86_64 -drive format=3Draw,file=3Dubuntu.img \
  -cpu host \
  --enable-kvm \
  -smp 2 \
  -m 4096 \
  -vga vmware \
  -soundhw ac97 \
  -usbdevice tablet \
  -rtc base=3Dlocaltime \
  -usbdevice host:0781:5575
  =

- =

  I've started Ubuntu around 6-8 times, and I have only see the Grub Boot
  Splash appear twice, so pretty much without fail it typically boots past
  the grub splash and automatically boots...
  =

- =

- These are the /etc/default/grub settings; (I only changed these options G=
RUB_TIMEOUT=3D15 and GRUB_GFXMODE=3D1440x900)
- =

+ These are the /etc/default/grub settings; (I only changed these options
+ GRUB_TIMEOUT=3D15 and GRUB_GFXMODE=3D1440x900)
  =

  # If you change this file, run 'update-grub' afterwards to update
  # /boot/grub/grub.cfg.
  # For full documentation of the options in this file, see:
  #   info -f grub -n 'Simple configuration'
  =

  GRUB_DEFAULT=3D0
  GRUB_HIDDEN_TIMEOUT=3D0
  GRUB_HIDDEN_TIMEOUT_QUIET=3Dtrue
  GRUB_TIMEOUT=3D15
  GRUB_DISTRIBUTOR=3D`lsb_release -i -s 2> /dev/null || echo Debian`
  GRUB_CMDLINE_LINUX_DEFAULT=3D"quiet splash"
  GRUB_CMDLINE_LINUX=3D""
  =

  # Uncomment to enable BadRAM filtering, modify to suit your needs
  # This works with Linux (no patch required) and with any kernel that obta=
ins
  # the memory map information from GRUB (GNU Mach, kernel of FreeBSD ...)
  #GRUB_BADRAM=3D"0x01234567,0xfefefefe,0x89abcdef,0xefefefef"
  =

  # Uncomment to disable graphical terminal (grub-pc only)
  #GRUB_TERMINAL=3Dconsole
  =

  # The resolution used on graphical terminal
  # note that you can use only modes which your graphic card supports via V=
BE
  # you can see them in real GRUB with the command `vbeinfo'
  GRUB_GFXMODE=3D1440x900
  =

  # Uncomment if you don't want GRUB to pass "root=3DUUID=3Dxxx" parameter =
to Linux
  #GRUB_DISABLE_LINUX_UUID=3Dtrue
  =

  # Uncomment to disable generation of recovery mode menu entries
  #GRUB_DISABLE_RECOVERY=3D"true"
  =

  # Uncomment to get a beep at grub start
  #GRUB_INIT_TUNE=3D"480 440 1"

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1649040

Title:
  Ubuntu 16.04.1 Grub Splash Doesn't Appear

Status in QEMU:
  New

Bug description:
  My Specs:

  Slackware 14.2 x86_64 > Host
  QEMU 2.7.0

  Ubuntu 16.04.1 x86_64 > Guest

  Start options for Ubuntu:

  qemu-system-x86_64 -drive format=3Draw,file=3Dubuntu.img \
  -cpu host \
  --enable-kvm \
  -smp 2 \
  -m 4096 \
  -vga vmware \
  -soundhw ac97 \
  -usbdevice tablet \
  -rtc base=3Dlocaltime \
  -usbdevice host:0781:5575

  I've started Ubuntu around 6-8 times, and I have only see the Grub
  Boot Splash appear twice, so pretty much without fail it typically
  boots past the grub splash and automatically boots...

  These are the /etc/default/grub settings; (I only changed these
  options GRUB_TIMEOUT=3D15 and GRUB_GFXMODE=3D1440x900)

  # If you change this file, run 'update-grub' afterwards to update
  # /boot/grub/grub.cfg.
  # For full documentation of the options in this file, see:
  #   info -f grub -n 'Simple configuration'

  GRUB_DEFAULT=3D0
  GRUB_HIDDEN_TIMEOUT=3D0
  GRUB_HIDDEN_TIMEOUT_QUIET=3Dtrue
  GRUB_TIMEOUT=3D15
  GRUB_DISTRIBUTOR=3D`lsb_release -i -s 2> /dev/null || echo Debian`
  GRUB_CMDLINE_LINUX_DEFAULT=3D"quiet splash"
  GRUB_CMDLINE_LINUX=3D""

  # Uncomment to enable BadRAM filtering, modify to suit your needs
  # This works with Linux (no patch required) and with any kernel that obta=
ins
  # the memory map information from GRUB (GNU Mach, kernel of FreeBSD ...)
  #GRUB_BADRAM=3D"0x01234567,0xfefefefe,0x89abcdef,0xefefefef"

  # Uncomment to disable graphical terminal (grub-pc only)
  #GRUB_TERMINAL=3Dconsole

  # The resolution used on graphical terminal
  # note that you can use only modes which your graphic card supports via V=
BE
  # you can see them in real GRUB with the command `vbeinfo'
  GRUB_GFXMODE=3D1440x900

  # Uncomment if you don't want GRUB to pass "root=3DUUID=3Dxxx" parameter =
to Linux
  #GRUB_DISABLE_LINUX_UUID=3Dtrue

  # Uncomment to disable generation of recovery mode menu entries
  #GRUB_DISABLE_RECOVERY=3D"true"

  # Uncomment to get a beep at grub start
  #GRUB_INIT_TUNE=3D"480 440 1"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1649040/+subscriptions
