Received: from eggs.gnu.org ([2001:4830:134:3::10]:60984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eld0m-0003EA-2j
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:00:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eld0h-00037N-9f
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:00:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:44266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eld0h-00036m-3U
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:00:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eld0g-0003Om-6i
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 16:00:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2C4BA2E802D
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 16:00:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Feb 2018 15:48:29 -0000
From: zlice <1749223@bugs.launchpad.net>
Reply-To: Bug 1749223 <1749223@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151853690975.29423.7587323391423810191.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1749223] [NEW] mouse offset or invisible wall
 2.11.0-3
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

(There was another post, I'm not sure if it is related though. Also not
sure if it's Arch related, I wouldn't be surprised as I normally use
Gentoo and have less problems with Gentoo.)


qemu-system-x86_64 -enable-kvm -M q35 -cpu host -m 8192 -vga vmware -smp 4,=
sockets=3D1,cores=3D4,threads=3D1 -drive file=3D/path/to/my.img,if=3Dvirtio=
 -soundhw ac97 -usb -monitor unix:/tmp/qemu-mon,server,nowait -usb --usbdev=
ice host:0000:ffff -device vfio-pci,host=3D00:00.0 -alt-grab &


When I grab the mouse in/out of the VM I tend to get an "invisible wall" ha=
lf of the time.
I can push past if I fling the mouse through it but not if I slowly keep mo=
ving down.

The direction always seems to be down when I hit a wall (so a Y offset? may=
be?)
This has been happening since at least version 2.10.

Not sure if "-alt-grab" has anything to do with it, that'd be my first
guess.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1749223

Title:
  mouse offset or invisible wall 2.11.0-3

Status in QEMU:
  New

Bug description:
  (There was another post, I'm not sure if it is related though. Also
  not sure if it's Arch related, I wouldn't be surprised as I normally
  use Gentoo and have less problems with Gentoo.)

  =

  qemu-system-x86_64 -enable-kvm -M q35 -cpu host -m 8192 -vga vmware -smp =
4,sockets=3D1,cores=3D4,threads=3D1 -drive file=3D/path/to/my.img,if=3Dvirt=
io -soundhw ac97 -usb -monitor unix:/tmp/qemu-mon,server,nowait -usb --usbd=
evice host:0000:ffff -device vfio-pci,host=3D00:00.0 -alt-grab &


  When I grab the mouse in/out of the VM I tend to get an "invisible wall" =
half of the time.
  I can push past if I fling the mouse through it but not if I slowly keep =
moving down.

  The direction always seems to be down when I hit a wall (so a Y offset? m=
aybe?)
  This has been happening since at least version 2.10.

  Not sure if "-alt-grab" has anything to do with it, that'd be my first
  guess.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1749223/+subscriptions
