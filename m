Received: from eggs.gnu.org ([2001:4830:134:3::10]:37405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e0glP-0003qS-Kr
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 00:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e0glK-0004Bi-Un
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 00:30:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:56048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e0glK-0004AF-Nv
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 00:30:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e0glI-0003GJ-6p
	for <qemu-devel@nongnu.org>; Sat, 07 Oct 2017 04:30:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 327F52E80EC
	for <qemu-devel@nongnu.org>; Sat,  7 Oct 2017 04:30:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Oct 2017 04:17:30 -0000
From: Launchpad Bug Tracker <1050694@bugs.launchpad.net>
Reply-To: Bug 1050694 <1050694@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120914010448.8303.73336.malonedeb@gac.canonical.com>
Message-Id: <150734985057.28496.17457279081533299374.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1050694] Re: Interrupt 0xffffffff when debug is
 turned on
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
https://bugs.launchpad.net/bugs/1050694

Title:
  Interrupt 0xffffffff when debug is turned on

Status in QEMU:
  Expired

Bug description:
  Hi,

  I have been getting a GPF when I enable interrupts, working on
  implementing processes and a scheduler. When I comment out the
  scheduler code, I still get the GPF. I used the following QEMU command
  line to capture a log:

  qemu-system-i386 -smp 4 -monitor stdio -cpu core2duo -D
  /home/adam/century/util/qemu.log -d int,in_asm -s -hda
  "$harddisk_image" -m 3.5G

  Rather than posting the entire log, I need some help interpreting the fol=
lowing section (notice "INT=3D0xffffffff" on the top line):
  Servicing hardware INT=3D0xffffffff
  1: v=3Dffffffff e=3D0000 i=3D0 cpl=3D0 IP=3D0008:0010b63f pc=3D0010b63f S=
P=3D0010:0012b768 EAX=3D00000000
  EAX=3D00000000 EBX=3D00002000 ECX=3D00000018 EDX=3D05a00780
  ESI=3D00112faa EDI=3D000b8fa0 EBP=3D0012b780 ESP=3D0012b768
  EIP=3D0010b63f EFL=3D00207202 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HL=
T=3D0
  ES =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS [-WA]
  CS =3D0008 00000000 ffffffff 00cf9a00 DPL=3D0 CS32 [-R-]
  SS =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS [-WA]
  DS =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS [-WA]
  FS =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS [-WA]
  GS =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS [-WA]
  LDT=3D0000 00000000 00000000 00008200 DPL=3D0 LDT
  TR =3D0008 00000580 00000067 00008900 DPL=3D0 TSS32-avl
  GDT=3D 00127760 00000027
  IDT=3D 00122f40 000007ff
  CR0=3D80000011 CR2=3D00000000 CR3=3D0014a000 CR4=3D00000000
  DR0=3D00000000 DR1=3D00000000 DR2=3D00000000 DR3=3D00000000
  DR6=3Dffff0ff0 DR7=3D00000400
  CCS=3D00000024 CCD=3D0012b75c CCO=3DADDL
  EFER=3D0000000000000000
  check_exception old: 0xffffffff new 0xd
  2: v=3D0d e=3Dfffffffa i=3D0 cpl=3D0 IP=3D0008:0010b63f pc=3D0010b63f SP=
=3D0010:0012b768 EAX=3D00000000
  EAX=3D00000000 EBX=3D00002000 ECX=3D00000018 EDX=3D05a00780
  ESI=3D00112faa EDI=3D000b8fa0 EBP=3D0012b780 ESP=3D0012b768
  EIP=3D0010b63f EFL=3D00207202 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HL=
T=3D0
  ES =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS [-WA]
  CS =3D0008 00000000 ffffffff 00cf9a00 DPL=3D0 CS32 [-R-]
  SS =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS [-WA]
  DS =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS [-WA]
  FS =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS [-WA]
  GS =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS [-WA]
  LDT=3D0000 00000000 00000000 00008200 DPL=3D0 LDT
  TR =3D0008 00000580 00000067 00008900 DPL=3D0 TSS32-avl
  GDT=3D 00127760 00000027
  IDT=3D 00122f40 000007ff
  CR0=3D80000011 CR2=3D00000000 CR3=3D0014a000 CR4=3D00000000
  DR0=3D00000000 DR1=3D00000000 DR2=3D00000000 DR3=3D00000000
  DR6=3Dffff0ff0 DR7=3D00000400
  CCS=3D00000024 CCD=3D0012b75c CCO=3DADDL
  EFER=3D0000000000000000

  To the best of my ability to interpret, I an getting an undefined
  interrupt, which is then triggering a GPF, which is caught. However,
  do not know where it might be coming from.

  Some additional information:

  This command works:

  qemu-system-i386 -smp 4 -monitor stdio -cpu core2duo -s -hda
  "$harddisk_image" -m 3.5G

  This command works:

  qemu-system-i386 -monitor stdio -cpu core2duo -D
  /home/adam/century/util/qemu.log -d int,in_asm -s -hda
  "$harddisk_image" -m 3.5G

  And, as above, this does not:

  qemu-system-i386 -smp 4 -monitor stdio -cpu core2duo -D
  /home/adam/century/util/qemu.log -d int,in_asm -s -hda
  "$harddisk_image" -m 3.5G

  [adam@os-development ~]$ qemu-system-i386 -version
  QEMU emulator version 1.2.0, Copyright (c) 2003-2008 Fabrice Bellard

  Attached is an image as a test case.  Please let me know if you need
  any additional information.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1050694/+subscriptions
