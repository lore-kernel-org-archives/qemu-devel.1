Received: from eggs.gnu.org ([2001:4830:134:3::10]:59991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fbQaV-0003B4-60
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fbQaR-0003BA-Ur
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:15:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:38310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fbQaR-0003Ad-Nh
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:15:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fbQaQ-0003K9-6D
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 13:15:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EAA302E819C
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 13:15:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Jul 2018 13:00:55 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1774677 <1774677@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152787131775.31828.3557775502793493947.malonedeb@soybean.canonical.com>
Message-Id: <153088205589.18601.9516177847127082266.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1774677] Re: -icount increases boot time by >10x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Yes, I can reproduce this. Also, interestingly, with the -icount version
when I typed 'exit' to quit the guest I got this abort:

qemu: fatal: cpu_io_recompile: could not find TB for pc=3D0x7fcd0aae636e
EAX=3Dc88053a4 EBX=3D00000069 ECX=3Dc00211a4 EDX=3D00000000
ESI=3Dc7812180 EDI=3Dc78126f0 EBP=3D0000000f ESP=3Dc7a0de44
EIP=3Dc11ada30 EFL=3D00000287 [--S--PC] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HLT=
=3D0
ES =3D007b 00000000 ffffffff 00cff300 DPL=3D3 DS   [-WA]
CS =3D0060 00000000 ffffffff 00cf9a00 DPL=3D0 CS32 [-R-]
SS =3D0068 00000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
DS =3D007b 00000000 ffffffff 00cff300 DPL=3D3 DS   [-WA]
FS =3D0000 00000000 00000000 00000000
GS =3D0033 080a130c ffffffff 00dff300 DPL=3D3 DS   [-WA]
LDT=3D0000 00000000 00000000 00008200 DPL=3D0 LDT
TR =3D0080 c12fbe60 0000206b 00008900 DPL=3D0 TSS32-avl
GDT=3D     c12f6000 000000ff
IDT=3D     ffffc000 000007ff
CR0=3D8005003b CR2=3D09d40ffc CR3=3D07a08000 CR4=3D00000690
DR0=3D00000000 DR1=3D00000000 DR2=3D00000000 DR3=3D00000000 =

DR6=3Dffff0ff0 DR7=3D00000400
CCS=3Dc8800000 CCD=3Dc8805200 CCO=3DSUBL    =

EFER=3D0000000000000000
FCW=3D037f FSW=3D0000 [ST=3D0] FTW=3D00 MXCSR=3D00001f80
FPR0=3D0000000000000000 0000 FPR1=3D0000000000000000 0000
FPR2=3D0000000000000000 0000 FPR3=3D0000000000000000 0000
FPR4=3D0000000000000000 0000 FPR5=3D0000000000000000 0000
FPR6=3D0000000000000000 0000 FPR7=3Dec00000000000000 4006
XMM00=3D00000000000000000000000000000000 XMM01=3D00000000000000000000000000=
000000
XMM02=3D00000000000000000000000000000000 XMM03=3D00000000000000000000000000=
000000
XMM04=3D00000000000000000000000000000000 XMM05=3D00000000000000000000000000=
000000
XMM06=3D00000000000000000000000000000000 XMM07=3D00000000000000000000000000=
000000
Aborted (core dumped)


** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1774677

Title:
  -icount increases boot time by >10x

Status in QEMU:
  Confirmed

Bug description:
  When I specify the -icount option, some guest operations such as
  booting a Linux kernel take more than 10 times longer than otherwise.
  For example, the following will boot Aboriginal Linux to the login
  prompt about 6 seconds on my system (using TCG, not KVM):

  wget http://landley.net/aboriginal/downloads/old/binaries/1.4.5/system-im=
age-i686.tar.gz
  gunzip <system-image-i686.tar.gz | tar xfv -
  cd system-image-i686
  sh run-emulator.sh

  If I replace the last line with

  QEMU_EXTRA=3D"-icount shift=3Dauto" sh run-emulator.sh

  booting to the login prompt takes about 1 minute 20 seconds.

  I have tried different values for "shift" other than the "auto" used
  above, but have not been able to find one that gives reasonable
  performance.  Specifying "sleep=3Doff" also did not help.

  During the slow boots, qemu appears to spend most of its time
  sleeping, not using the host CPU.

  I see this with multiple versions of qemu, including current git
  sources (c181ddaa176856b3cd2dfd12bbcf25fa9c884a97), and on multiple
  host OSes, including Debian 9 on x86_64.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1774677/+subscriptions
