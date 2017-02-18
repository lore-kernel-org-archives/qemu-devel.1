Received: from eggs.gnu.org ([2001:4830:134:3::10]:34640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cewfq-0006gR-4t
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 23:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cewfn-0005mf-EZ
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 23:31:06 -0500
Received: from indium.canonical.com ([91.189.90.7]:44649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cewfn-0005mN-8X
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 23:31:03 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cewfm-0006YR-BN
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 04:31:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4F5072E80C2
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 04:31:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Feb 2017 04:17:28 -0000
From: Launchpad Bug Tracker <682360@bugs.launchpad.net>
Reply-To: Bug 682360 <682360@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20101128141117.27491.10254.malonedeb@palladium.canonical.com>
Message-Id: <20170218041728.19951.32888.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 682360] Re: Unaccessible memory
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
https://bugs.launchpad.net/bugs/682360

Title:
  Unaccessible memory

Status in QEMU:
  Expired

Bug description:
  Hello,

  I'm trying to develop a OS over L4/X2 microkernel and I use Linux
  debian and qemu 0.13 in 64 bits mode. When I start qemu with qemu-
  system-x86_64 -hdc freevms.img -smp 1 -serial stdio -m 128M -k fr, my
  kernel boots fine. If I modify this command line with -m 384M (for
  example), my kernel is loaded but enter in a deadlock. I have found a
  bug in my code until I have tried to use the _same_ disk image under
  virtualbox and it works without any trouble. I runs fine on a real PC
  also.

  I have bissected my code and qemu stops (maybe in a deadlock) when I try =
to access to memory :
  %MEM-I-VM_ALLOC, adding $0000000000045000 - $0000000000108FFF to VM alloc=
ator
  %MEM-I-VM_ALLOC, adding $000000000010B000 - $00000000003F2FFF to VM alloc=
ator
  %MEM-I-VM_ALLOC, adding $000000000040C000 - $0000000000FFFFFF to VM alloc=
ator
  %MEM-I-VM_ALLOC, adding $000000000100F000 - $FFFFFEFFFFFFFFFF to VM alloc=
ator
  %MEM-I-ACCMAP, accepting mapping
  %MEM-I-ACCMAP, virtual  $FFFF000000000000 - $FFFF000000000FFF
  %MEM-I-ACCMAP, physical $000000000009E000 - $000000000009EFFF

  Note that qemu doesn't crash. It only stops. My virtual memory
  subsystem maps $FFFF000000000000 in physical memory ($9E000). And when
  I try to initialize this memory, qemu enters in deadlock.

  A disk image to reproduce this bug is available at
  http://www.systella.fr/~bertrand/freevms.img.bz2

  Regards,

  JKB

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/682360/+subscriptions
