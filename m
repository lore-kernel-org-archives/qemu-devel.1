Received: from eggs.gnu.org ([2001:4830:134:3::10]:60474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqKf5-0005Qx-SP
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqKf1-0005S5-TC
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:21:23 -0400
Received: from indium.canonical.com ([91.189.90.7]:49348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cqKf1-0005RI-N0
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:21:19 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cqKey-0003fL-2r
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 14:21:16 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 415EE2E82B8
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 14:21:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Mar 2017 14:11:56 -0000
From: Michal Nowak <michal.nowak@resist.ca>
Reply-To: Bug 1670170 <1670170@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170305181803.7371.53021.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170321141156.19872.93132.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1670170] Re: `qemu-system-sparc64 -M Niagara`
 Aborted (core dumped)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fixed in version 2.8.90.

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1670170

Title:
  `qemu-system-sparc64 -M Niagara` Aborted (core dumped)

Status in QEMU:
  Fix Committed

Bug description:
  > qemu-system-sparc64 -M Niagara
  qemu: fatal: Trap 0x0064 while trap level (6) >=3D MAXTL (6), Error state
  pc: 0000000000004c80  npc: 0000000000004c84
  %g0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %g4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %o0-3: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0 =

  %o4-7: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0 =

  %l0-3: 0000000007f00000 000001ff00000000 000001fff0080000 000000000000000=
0 =

  %l4-7: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0 =

  %i0-3: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0 =

  %i4-7: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0 =

  %f00:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f08:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f16:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f24:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f32:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f40:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f48:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f56:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  pstate: 00000414 ccr: 44 (icc: -Z-- xcc: -Z--) asi: 00 tl: 6 pil: 0
  cansave: 6 canrestore: 0 otherwin: 0 wstate: 0 cleanwin: 6 cwp: 7
  fsr: 0000000000000000 y: 0000000000000000 fprs: 0000000000000000

  Aborted (core dumped)

  > qemu-system-sparc64 -M help
  Supported machines are:
  Niagara              Sun4v platform, Niagara
  none                 empty machine
  sun4u                Sun4u platform (default)
  sun4v                Sun4v platform

  > qemu-system-sparc64 -version
  QEMU emulator version 2.8.0(Virtualization:Staging / SLE_12_SP2)

  from
  https://build.opensuse.org/package/show/Virtualization:Staging/qemu on
  openSUSE Leap 42.2.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1670170/+subscriptions
