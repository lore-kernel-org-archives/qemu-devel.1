Received: from eggs.gnu.org ([2001:4830:134:3::10]:60457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dRA8R-0003at-Dy
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 00:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dRA8M-0005Ka-Hr
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 00:35:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:53058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dRA8M-0005Jt-BF
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 00:35:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dRA8L-0006Fy-5j
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 04:35:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DB28F2E819D
	for <qemu-devel@nongnu.org>; Sat,  1 Jul 2017 04:35:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Jul 2017 04:17:19 -0000
From: Launchpad Bug Tracker <965133@bugs.launchpad.net>
Reply-To: Bug 965133 <965133@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120326102736.18275.22299.malonedeb@wampee.canonical.com>
Message-Id: <149888264109.11072.139612811028444457.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 965133] Re: Sparc64 crash on start
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
https://bugs.launchpad.net/bugs/965133

Title:
  Sparc64 crash on start

Status in QEMU:
  Expired

Bug description:
  qemu version 1.0.1 compiled on a Ubuntu live on a HP laptop win a x64
  architecture.

  With more than 4G of memory sparc64 machine crash on start.

  command line: qemu-system-sparc64 -m 4G

  output:
  VNC server running on `127.0.0.1:5900'
  qemu: fatal: Trap 0x0064 while trap level (5) >=3D MAXTL (5), Error state
  pc: 00000000ffd04c80  npc: 00000000ffd04c84
  General Registers:
  %g0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %g4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000

  Current Register Window:
  %o0-3: 00000000ffd00000 0000000000080000 0000000000080000 000000000000000=
0 =

  %o4-7: 0000000000000000 0000000000000000 00000000fff754e1 00000000ffd144d=
4 =

  %l0-3: 0000000100000000 00000000fff75c4d 0000000000000000 000000000000000=
0 =

  %l4-7: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0 =

  %i0-3: 0000000000000000 0000000000000000 0000000100000000 000000000000003=
6 =

  %i4-7: 00000000ffe87418 00000000ffe87648 00000000fff75591 00000000ffd0bf5=
4 =


  Floating Point Registers:
  %f00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f32: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f40: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f48: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f56: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  pstate: 00000414 ccr: 99 (icc: N--C xcc: N--C) asi: 00 tl: 5 pil: 0
  cansave: 5 canrestore: 1 otherwin: 0 wstate: 0 cleanwin: 6 cwp: 3
  fsr: 0000000000000000 y: 0000000000000000 fprs: 0000000000000000
  Aborted (core dumped)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/965133/+subscriptions
