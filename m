Received: from eggs.gnu.org ([2001:4830:134:3::10]:51938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fZqTV-0002EU-Ma
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 00:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fZqTS-0004j2-Jl
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 00:30:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:42898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fZqTS-0004iK-DG
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 00:30:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fZqTQ-0001LQ-FY
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 04:30:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5EF432E81A2
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 04:30:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Jul 2018 04:17:29 -0000
From: Launchpad Bug Tracker <1315257@bugs.launchpad.net>
Reply-To: Bug 1315257 <1315257@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140502062449.18994.92954.malonedeb@chaenomeles.canonical.com>
Message-Id: <153050504969.6988.4548131263071633170.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1315257] Re: QEMU get black screen when adjust
 resolution in full screen mode.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1315257

Title:
  QEMU get black screen when adjust resolution in full screen mode.

Status in QEMU:
  Expired

Bug description:
  Description:
  QEMU cause X11 error when adjust resolution in full screen mode or start =
QEMU with "-full-screen".

  Additional info:
  * host OS infomation
      Archlinux 64bit
  * gest OS infomation
      Windows XP SP3 32bit
  * Archlinux package version(s)
  qemu 1.7.1-1
  cinnamon 2.2.3-3
  sdl 1.2.15-5
  xf86-video-ati 1:7.3.0-1
  xf86-video-fbdev 0.4.4-2
  xf86-video-modesetting 0.8.1-2
  xf86-video-vesa 2.3.2-4
  xorg-server 1.15.1-1

  * error output in Xterm
  X Error of failed request:  BadValue (integer parameter out of range for =
operation)
    Major opcode of failed request:  153 (XFree86-VidModeExtension)
    Minor opcode of failed request:  10 (XF86VidModeSwitchToMode)
    Value in failed request:  0x2c2
    Serial number of failed request:  412
    Current serial number in output stream:  414

  * Xorg log output
      *with the command "grep EE /var/log/Xorg.0.log"
          (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
  [  7726.317] Initializing built-in extension MIT-SCREEN-SAVER
      *with the command "grep WW /var/log/Xorg.0.log"
          (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
  [  7726.314] (WW) `fonts.dir' not found (or not valid) in "/usr/share/fon=
ts/misc/".
  [  7726.314] (WW) `fonts.dir' not found (or not valid) in "/usr/share/fon=
ts/100dpi/".
  [  7726.314] (WW) `fonts.dir' not found (or not valid) in "/usr/share/fon=
ts/75dpi/".
  [  7726.316] (WW) Open ACPI failed (/var/run/acpid.socket) (No such file =
or directory)
  [  7726.334] (WW) Falling back to old probe method for modesetting
  [  7726.334] (WW) Falling back to old probe method for fbdev
  [  7726.335] (WW) Falling back to old probe method for vesa

  Steps to reproduce:
  1.Start QEMU with the command:
      qemu-system-i386 -enable-kvm -machine type=3Dpc,accel=3Dkvm -rtc base=
=3Dlocaltime -nodefaults -no-quit -usbdevice tablet -cpu host -smp 2 -m 1G =
-vga std -soundhw ac97 -net nic,model=3Dvirtio -net bridge,br=3Dvirbr0 -dri=
ve if=3Dvirtio,index=3D0,media=3Ddisk,format=3Draw,cache=3Dnone,file=3D/hom=
e/user/VM/WinXP.img
  2.Press ctl + alt + f to full screen.
  3.Adjust resolution in guest OS.
  or
  1.Make sure the guest OS resolution is not the same as host OS.
  2.Start QEMU with parameter "-full-screen".

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1315257/+subscriptions
