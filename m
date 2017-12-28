Received: from eggs.gnu.org ([2001:4830:134:3::10]:58282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eUPpx-0001Gm-MQ
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eUPpw-0001lc-ME
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:30:33 -0500
Received: from indium.canonical.com ([91.189.90.7]:59470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eUPpw-0001kE-GI
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:30:32 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eUPpv-0007kH-Nt
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 04:30:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AFA5C2E80C3
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 04:30:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Dec 2017 04:17:26 -0000
From: Launchpad Bug Tracker <1272796@bugs.launchpad.net>
Reply-To: Bug 1272796 <1272796@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140126002617.15783.73817.malonedeb@gac.canonical.com>
Message-Id: <151443464653.28609.4601707169718073074.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1272796] Re: Windows 98 First Edition emulation
 problems
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
https://bugs.launchpad.net/bugs/1272796

Title:
  Windows 98 First Edition emulation problems

Status in QEMU:
  Expired

Bug description:
  System: Debian SID x86 with latest updates

  1) QEMU compiled from latest main GIT branch(at the time of writing, 1.7.=
50) (and 1.7 stable version)
  ./configure options: ./configure --enable-sdl --target-list=3Di386-softmm=
u --cpu=3Di686 --audio-drv-list=3Dalsa

  When you try to boot Windows 98 First Edition (Italian), it does not simp=
ly boot. It stays on booting screen.
  If you try to install, the installation goes flawless, but when it boots =
it freeze.

  I am launching VM with this: qemu-system-i386 -hda main.img -cpu
  pentium -m 256 -fda floppy1.img -boot c -soundhw gus -vga cirrus

  I have tried with -M option "pc-i440fx-1.6" since 1.6 have no problems
  with the booting of Win98, but nothing. No fix found.

  2) QEMU 1.6.2 (same compile and launching options)
  gus soundboard seems not recognized even with real dos drivers (tried to =
install theme into real dos mode).
  with SoundBlaster 16 i have following error: WARNING: I/O thread spun for=
 1000 iterations, making the emulation impossible (too slow, and sound is s=
tuttering) . Tried to compile with oss and sdl option on audio-drv-list but=
 no fix found.

  Any ideas? thank you

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1272796/+subscriptions
