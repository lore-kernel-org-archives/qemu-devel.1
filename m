Received: from eggs.gnu.org ([2001:4830:134:3::10]:38227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC7vz-0007iT-TK
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:45:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC7vv-0008Li-Tg
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:45:11 -0500
Received: from indium.canonical.com ([91.189.90.7]:48184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC7vv-0008LK-Mk
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:45:07 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC7vu-0002ta-QA
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 17:45:06 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C16EC2E802D
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 17:45:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 17:35:38 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1400768 <1400768@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141209153744.25096.3299.malonedeb@wampee.canonical.com>
Message-Id: <151007613825.8833.15926547568424182180.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1400768] Re: Fatal error when running with
 '-machine isapc' on 2.1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Testing this with QEMU 2.5 (and also with today's head-of-git) "qemu-
system_x86-64 -machine isapc" works for me (it boots the guest bios). So
I'm going to close this bug as fixed; please open a fresh bug if you
still have problems with a more recent QEMU version.


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1400768

Title:
  Fatal error when running with '-machine isapc' on 2.1.2

Status in QEMU:
  Fix Released

Bug description:
  all I have are the traces, should hopefully be easy to reproduce.

  # qemu-system-i386 -machine isapc
  VNC server running on `::1:5900'
  qemu: fatal: Trying to execute code outside RAM or ROM at 0x1a0dff44

  EAX=3D000f0f88 EBX=3D00100000 ECX=3D07fc0000 EDX=3D0000002c
  ESI=3D00006f5c EDI=3D08000000 EBP=3D07fc0000 ESP=3Dfffe0014
  EIP=3D1a0dff44 EFL=3D00000046 [---Z-P-] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HL=
T=3D0
  ES =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS   [-WA]
  CS =3D0008 00000000 ffffffff 00cf9b00 DPL=3D0 CS32 [-RA]
  SS =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS   [-WA]
  DS =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS   [-WA]
  FS =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS   [-WA]
  GS =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS   [-WA]
  LDT=3D0000 00000000 0000ffff 00008200 DPL=3D0 LDT
  TR =3D0000 00000000 0000ffff 00008b00 DPL=3D0 TSS32-busy
  GDT=3D     000f6be8 00000037
  IDT=3D     000f6c26 00000000
  CR0=3D60000011 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
  DR0=3D00000000 DR1=3D00000000 DR2=3D00000000 DR3=3D00000000 =

  DR6=3Dffff0ff0 DR7=3D00000400
  CCS=3D00000000 CCD=3D00000000 CCO=3DADDB    =

  EFER=3D0000000000000000
  FCW=3D037f FSW=3D0000 [ST=3D0] FTW=3D00 MXCSR=3D00001f80
  FPR0=3D0000000000000000 0000 FPR1=3D0000000000000000 0000
  FPR2=3D0000000000000000 0000 FPR3=3D0000000000000000 0000
  FPR4=3D0000000000000000 0000 FPR5=3D0000000000000000 0000
  FPR6=3D0000000000000000 0000 FPR7=3D0000000000000000 0000
  XMM00=3D00000000000000000000000000000000 XMM01=3D000000000000000000000000=
00000000
  XMM02=3D00000000000000000000000000000000 XMM03=3D000000000000000000000000=
00000000
  XMM04=3D00000000000000000000000000000000 XMM05=3D000000000000000000000000=
00000000
  XMM06=3D00000000000000000000000000000000 XMM07=3D000000000000000000000000=
00000000
  Aborted

  =

  # qemu-system-x86_64 -machine isapc
  VNC server running on `::1:5900'
  qemu: fatal: Trying to execute code outside RAM or ROM at 0x000000001a0df=
f44

  EAX=3D000f0f88 EBX=3D00100000 ECX=3D07fc0000 EDX=3D0000002c
  ESI=3D00006f5c EDI=3D08000000 EBP=3D07fc0000 ESP=3Dfffe0014
  EIP=3D1a0dff44 EFL=3D00000046 [---Z-P-] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HL=
T=3D0
  ES =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS   [-WA]
  CS =3D0008 00000000 ffffffff 00cf9b00 DPL=3D0 CS32 [-RA]
  SS =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS   [-WA]
  DS =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS   [-WA]
  FS =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS   [-WA]
  GS =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS   [-WA]
  LDT=3D0000 00000000 0000ffff 00008200 DPL=3D0 LDT
  TR =3D0000 00000000 0000ffff 00008b00 DPL=3D0 TSS32-busy
  GDT=3D     000f6be8 00000037
  IDT=3D     000f6c26 00000000
  CR0=3D60000011 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
  DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=
=3D0000000000000000 =

  DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
  CCS=3D00000000 CCD=3D00000000 CCO=3DADDB    =

  EFER=3D0000000000000000
  FCW=3D037f FSW=3D0000 [ST=3D0] FTW=3D00 MXCSR=3D00001f80
  FPR0=3D0000000000000000 0000 FPR1=3D0000000000000000 0000
  FPR2=3D0000000000000000 0000 FPR3=3D0000000000000000 0000
  FPR4=3D0000000000000000 0000 FPR5=3D0000000000000000 0000
  FPR6=3D0000000000000000 0000 FPR7=3D0000000000000000 0000
  XMM00=3D00000000000000000000000000000000 XMM01=3D000000000000000000000000=
00000000
  XMM02=3D00000000000000000000000000000000 XMM03=3D000000000000000000000000=
00000000
  XMM04=3D00000000000000000000000000000000 XMM05=3D000000000000000000000000=
00000000
  XMM06=3D00000000000000000000000000000000 XMM07=3D000000000000000000000000=
00000000
  Aborted

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1400768/+subscriptions
