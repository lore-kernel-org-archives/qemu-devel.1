Received: from eggs.gnu.org ([2001:4830:134:3::10]:35698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYZ1D-0008FZ-CO
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYZ1A-0003Zg-1H
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:35:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:50351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dYZ19-0003ZK-Rd
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:34:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dYZ18-0005xJ-RW
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 14:34:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BAC682E806D
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 14:34:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Jul 2017 14:20:59 -0000
From: Thomas Huth <1622547@bugs.launchpad.net>
Reply-To: Bug 1622547 <1622547@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160912101319.11954.40146.malonedeb@gac.canonical.com>
Message-Id: <150064685914.26794.5223905009918561244.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1622547] Re: qemu-system-sparc fatal error Trap
 0x29 on Solaris 2.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit 3db010c3398d03646 has been released with 2.9.0, so setting the
status to "Fix released"

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1622547

Title:
  qemu-system-sparc fatal error Trap 0x29 on Solaris 2.6

Status in QEMU:
  Fix Released

Bug description:
  When trying to install Solaris 2.6 from original CDROM, qemu fail with
  the following error :

  qemu: fatal: Trap 0x29 while interrupts disabled, Error state
  pc: f0041280  npc: f0041284
  %g0-7: 00000000 f0281800 08000000 ffffffff 00000000 f0243b88 00000001 f02=
44020
  %o0-7: 40400ce2 40400ce2 00000000 404000e2 f0243b88 00000000 f023ffd8 f00=
57914 =

  %l0-7: 40000cc2 f009645c f0096460 00000002 00000209 00000004 00000007 f02=
3ff90 =

  %i0-7: 00000042 404000e3 00000000 404000e3 e0000000 f028192a f0240038 f00=
96448 =

  %f00:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f08:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f16:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  %f24:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
  psr: 40400cc2 (icc: -Z-- SPE: SP-) wim: 00000002
  fsr: 00000000 y: 00000000

  The command line was :

  qemu-system-sparc -nographic -bios ./openbios-sparc32 -M SS-20 -hda
  ./36G.disk -m 512 -cdrom Solaris_2.6_Software_05_98.img -boot d
  -serial telnet:0.0.0.0:3000,server -smp 2,cores=3D2 -monitor null

  It fails with a similar output when using bios ss20_v2.25_rom.

  =E2=96=B6 qemu-system-sparc --version
  QEMU emulator version 2.7.0, Copyright (c) 2003-2016 Fabrice Bellard and =
the QEMU Project developers

  =E2=96=B6 uname -a
  Linux xxx 4.7.1-1-ARCH #1 SMP PREEMPT Wed Aug 17 08:13:35 CEST 2016 x86_6=
4 GNU/Linux

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1622547/+subscriptions
