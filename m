Received: from eggs.gnu.org ([2001:4830:134:3::10]:40582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cjHSs-0001AE-12
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 22:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cjHSo-0006B9-Se
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 22:31:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:47435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cjHSo-0006Ar-NZ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 22:31:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cjHSm-0003JI-Ns
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 03:31:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A2B092E80C4
	for <qemu-devel@nongnu.org>; Thu,  2 Mar 2017 03:31:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Mar 2017 03:16:45 -0000
From: Javier <1617114@bugs.launchpad.net>
Reply-To: Bug 1617114 <1617114@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160826013950.26404.19900.malonedeb@gac.canonical.com>
Message-Id: <20170302031645.21468.70335.malone@soybean.canonical.com>
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

More narrowed now, :-)

With 2.8.0 qemu keeps freezing bad, when used with "-display sdl".
However when used with "-display gtk" or "-display none", then it
doesn't freeze.

So it seems "-display sdl" is the one totally breaking windows guest on
qemu.

Notice that if I don't try other displays, then I wouldn't even notice
it was just the SDL display.

If there's no intention on fixing SDL, given other alternatives are
available, in particular a GTK one for displaying the graphics output,
then I'm OK with a "no fix" for this.

As a bonus, it seems no display (-display none), with current qxl-dod
windows driver from Fedora project, seems to be working fine with spice.
That was not working before...  So getting away from SDL display now.
But no sure if this means SDL never again?  :-)

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
