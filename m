Received: from eggs.gnu.org ([2001:4830:134:3::10]:45326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVjJ5-00088G-8k
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVjIz-0007X2-ER
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:25:31 -0500
Received: from indium.canonical.com ([91.189.90.7]:59652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cVjIz-0007Wp-7v
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:25:25 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cVjIy-00060m-6A
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 18:25:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 081DA2E80C2
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 18:25:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Jan 2017 18:06:52 -0000
From: "mike@papersolve.com" <mike@papersolve.com>
Reply-To: Bug 1622547 <1622547@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160912101319.11954.40146.malonedeb@gac.canonical.com>
Message-Id: <20170123180652.26859.44055.malone@chaenomeles.canonical.com>
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

This still fails for me even when using that CPU option.  But it only
fails with my just-compiled QEMU 2.8.0, NOT my distribution-provided
QEMU 2.6.1.

mike@ossy ~/qemu> sudo /usr/local/bin/qemu-system-sparc -bios ./ss20_v2.25_=
rom -M SS-20 -nographic -boot d -hda ./sol26_36G.disk -m 512 -cdrom /mymedi=
a/Disk\ Sets/Solaris_2.6_SPARC/Solaris_2.6_Software_05_98.iso -serial telne=
t:0.0.0.0:3000,server -smp 2,cores=3D2 -cpu "TI SuperSparc 60" -net nic -ne=
t bridge,br=3Dbr0
QEMU 2.8.0 monitor - type 'help' for more information
(qemu) QEMU waiting for connection on: disconnected:telnet:0.0.0.0:3000,ser=
ver
qemu: fatal: Trap 0x29 while interrupts disabled, Error state
pc: 0000e754  npc: 0000e758
%g0-7: 00000000 00010d88 00000000 00000000 00000000 00000000 00000000 00000=
000
%o0-7: f1201e20 ffffffff 00000000 ffffffff ffffffff ffffffff ffffffff 00011=
a38 =

%l0-7: f1201e20 0000e754 0000e758 00000029 00000300 00003c1c 00000000 fffff=
fff =

%i0-7: 00013848 00000029 00000099 00000000 0edfe200 ffffffff ffffff40 00011=
a38 =

%f00:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f08:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f16:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f24:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
psr: 404010c5 (icc: -Z-- SPE: SP-) wim: 00000000
fsr: 00000000 y: 00000000

fish: =E2=80=9Csudo /usr/local/bin/qemu-system=E2=80=A6=E2=80=9D terminated=
 by signal SIGABRT
(Abort)


In the other window:
mike@ossy ~/qemu> telnet localhost 3000
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.

Power-ON Reset
Connection closed by foreign host.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1622547

Title:
  qemu-system-sparc fatal error Trap 0x29 on Solaris 2.6

Status in QEMU:
  Invalid

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
