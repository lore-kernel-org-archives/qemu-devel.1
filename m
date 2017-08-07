Received: from eggs.gnu.org ([2001:4830:134:3::10]:44287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1deln4-0005SE-NT
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1delmz-0003Jr-Gf
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:26:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:49836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1delmz-0003IW-B7
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:26:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1delmx-0003v4-3h
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 17:25:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 18FA12E80CC
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 17:25:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Aug 2017 17:10:28 -0000
From: Thomas Huth <1050694@bugs.launchpad.net>
Reply-To: Bug 1050694 <1050694@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120914010448.8303.73336.malonedeb@gac.canonical.com>
Message-Id: <150212582843.17284.9668708203577146298.malone@gac.canonical.com>
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

Triaging old bug tickets ... is there still something left to do here,
or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1050694

Title:
  Interrupt 0xffffffff when debug is turned on

Status in QEMU:
  Incomplete

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
