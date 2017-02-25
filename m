Received: from eggs.gnu.org ([2001:4830:134:3::10]:46877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1chaOF-0006ZH-LP
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 06:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1chaO9-0004qE-SX
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 06:19:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:38123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1chaO9-0004pv-Ni
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 06:19:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1chaO7-0000HJ-P7
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 11:19:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AD8FC2E80CA
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 11:19:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Feb 2017 11:04:01 -0000
From: yanman <1580459@bugs.launchpad.net>
Reply-To: Bug 1580459 <1580459@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160511061916.21125.98809.malonedeb@wampee.canonical.com>
Message-Id: <20170225110402.12388.33183.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1580459] Re: Windows (10?) guest freezes entire
 host on shutdown if using PCI passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi guys, not sure if I'm on the right track here but I think I'm
experiencing the same issue. My install might be a bit of a mess
combining bits from the VFIO Tips site and Ubuntu guides on GPU
passthrough, but I *did* have it all working for a few hours at a
stretch before I got this lock up.

The trouble with this is that after the host lockup, the Windows VM
seems to corrupt the EFI config or something like that as I can never
get it to boot again properly, even though the main partition seems fine
when tested in a bootable WinPE distro.

I'd be happy to supply versions and configs to help if it's related
however.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1580459

Title:
  Windows (10?) guest freezes entire host on shutdown if using PCI
  passthrough

Status in libvirt:
  New
Status in QEMU:
  New
Status in Arch Linux:
  New
Status in Debian:
  New
Status in Fedora:
  New

Bug description:
  Problem: after leaving a Windows VM that uses PCI passthrough (as we
  do for gaming graphics cards, sound cards, and in my case, a USB card)
  running for some amount of time between 1 and 2 hours (it's not
  consistent with exactly how long), and for any amount of time longer
  than that, shutting down that guest will, right as it finishes
  shutting down, freeze the host computer, making it require a hard
  reboot. Unbinding (or in the other user's case, unbinding and THEN
  binding) any PCI device in sysfs, even one that has nothing to do with
  the VM, also has the same effect as shutting down the VM (if the VM
  has been running long enough). So, it's probably an issue related to
  unbinding and binding PCI devices.

  There's a lot of info on this problem over at https://bbs.archlinux.org/v=
iewtopic.php?id=3D206050
  Here's a better-organized list of main details:
  -at least 2 confirmed victims of this bug; 2 (including me) have provided=
 lots of info in the link
  -I'm on Arch Linux and the other one is on Gentoo (distro-nonspecific)
  -issue affects my Windows 10 guest and others' Windows guests, but not my=
 Arch Linux guest (the others don't have non-Windows guests to test)
  -I'm using libvirt but the other user is not, so it's not an issue with l=
ibvirt
  -It seems to be version non-specific, too. I first noticed it at, or when=
 testing versions still had the issue at (whichever version is lower), Linu=
x 4.1 and qemu 2.4.0. It still persists in all releases of both since, incl=
uding the newest ones.
  -I can't track down exactly what package downgrade can fix it, as downgra=
ding further than Linux 4.1 and qemu 2.4.0 requires Herculean and system-de=
stroying changes such as downgrading ncurses, meaning I don't know whether =
it's a bug in QEMU, the Linux kernel, or some weird seemingly unrelated thi=
ng.
  -According to the other user, "graphics intensive gameplay (GTA V) can ca=
use the crash to happen sooner," as soon as "15 minutes"
  -Also, "bringing up a second passthrough VM with separate hardware will c=
ause the same crash," and "bringing up another VM before the two-hour mark =
will not result in a crash," further cementing that it's triggered by the u=
n/binding of PCI devices.
  -This is NOT related to the very similar bug that can be worked around by=
 not passing through the HDMI device or sound card. Even when we removed al=
l traces of any sort of sound card from the VM, it still had the same behav=
ior.

To manage notifications about this bug go to:
https://bugs.launchpad.net/libvirt/+bug/1580459/+subscriptions
