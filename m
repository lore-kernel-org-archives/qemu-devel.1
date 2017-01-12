Received: from eggs.gnu.org ([2001:4830:134:3::10]:58911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRmiL-00040o-TF
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRmiI-00079L-Pa
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:15:17 -0500
Received: from indium.canonical.com ([91.189.90.7]:60239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRmiI-00078X-JS
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:15:14 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRmiH-0003hi-EM
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 21:15:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 46D422E80AF
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 21:15:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Jan 2017 21:04:08 -0000
From: Javier <1617114@bugs.launchpad.net>
Reply-To: Bug 1617114 <1617114@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160826013950.26404.19900.malonedeb@gac.canonical.com>
Message-Id: <20170112210408.21384.3049.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1617114] Re: Qemu 2.6.0 freezes with windows
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Qemu 2.8.0 is no better.  Actually now win-10 can even boot, getting the
light blue window with sad face saying:  "Your PC ran into a problem and
needs to restart...".  Moreover, the qemu monitor mode (alt-2) pops up a
frozen useless window, so no way to try reseting...

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1617114

Title:
  Qemu 2.6.0 freezes with windows guests

Status in QEMU:
  New

Bug description:
  When launching qemu with the same command line as before 2.6.0, with
  SDL display, with virtio, for a win-10 guest:

  qemu-system-x86_64 -enable-kvm -name win-10 -machine type=3Dpc,accel=3Dkvm
  -cpu host -smp cores=3D1,threads=3D2,sockets=3D1 -m 2.7G -balloon virtio
  -drive
  file=3D/home/<username>/.qemu/imgs/win10-coe.qcow2,index=3D0,media=3Ddisk=
,if=3Dvirtio
  -drive file=3D/usr/share/virtio/virtio-win.iso,index=3D1,media=3Dcdrom
  -drive file=3D/usr/share/spice-guest-tools/spice-guest-
  tools.iso,index=3D2,media=3Dcdrom -net nic,model=3Dvirtio -net
  tap,ifname=3Dtap0,script=3Dno,downscript=3Dno,vhost=3Don -usbdevice tablet
  -usb -display sdl -vga qxl -soundhw ac97 -rtc base=3Dlocaltime
  -usbdevice host:0b0e:0032 -usbdevice host:0b0e:0348 -usbdevice
  host:0b0e:0410

  Qemu at some point just freezes with no error message at all with
  newer version 2.6.0-1.

  Reverting to prior version 2.5.1-1, things go back to normal.

  A simple way to accelerate the freeze is to have qemu launch in a
  workspace/desktop, and then move to a different workspace/desktop, and
  then move back to the qemu workspace/desktop, and you'll find out it's
  frozen.

  BTW, there's no way to get into qemu monitor mode terminal at all once
  frozen. The monitor terminal shows up, but does nothing...

  Perhaps it's useful to notice that I have up to date win-10 virtio
  drivers for ethernet, scsi/storage, qxl-dod, balloon, and serial
  interface drivers. The ISO version used is 0.1.118.1 (virtio-win AUR
  package).

  Using the standard (std) qemu video driver, rather than the qxl-dod
  one makes no difference BTW.

  Just in case, running on up to date x86-64 Arch, plain qemu command
  line.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1617114/+subscriptions
