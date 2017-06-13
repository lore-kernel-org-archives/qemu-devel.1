Received: from eggs.gnu.org ([2001:4830:134:3::10]:48084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKsvE-0006QN-2W
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 17:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKsv8-0006Oj-77
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 17:00:20 -0400
Received: from indium.canonical.com ([91.189.90.7]:37488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dKsv7-0006Nf-Te
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 17:00:14 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dKsv5-0005eD-MQ
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 21:00:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7339C2E81AC
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 21:00:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jun 2017 20:45:03 -0000
From: Lucas Meneghel Rodrigues <lookkas@gmail.com>
Reply-To: Bug 1047576 <1047576@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120907191638.8105.79748.malonedeb@chaenomeles.canonical.com>
Message-Id: <149738670372.405.13253162826247608773.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1047576] Re: qemu unittest emulator failure on
 latest git master
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This doesn't reproduce with the latest version of QEMU, you may close
it.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1047576

Title:
  qemu unittest emulator failure on latest git master

Status in QEMU:
  Incomplete

Bug description:
  Running the emulator unittest, using the cmdline:

  16:01:30 INFO | Running emulator
  16:01:30 INFO | Running qemu command (reformatted):
  16:01:30 INFO | /home/lmr/Code/autotest.git/autotest/client/tests/virt/kv=
m/qemu =

  16:01:30 INFO |     -S =

  16:01:30 INFO |     -name 'unittest_vm' =

  16:01:30 INFO |     -nodefaults =

  16:01:30 INFO |     -chardev socket,id=3Dhmp_id_humanmonitor1,path=3D/tmp=
/monitor-humanmonitor1-20120907-155940-WomlFZY3,server,nowait =

  16:01:30 INFO |     -mon chardev=3Dhmp_id_humanmonitor1,mode=3Dreadline =

  16:01:30 INFO |     -chardev socket,id=3Dserial_id_20120907-155940-WomlFZ=
Y3,path=3D/tmp/serial-20120907-155940-WomlFZY3,server,nowait =

  16:01:30 INFO |     -device isa-serial,chardev=3Dserial_id_20120907-15594=
0-WomlFZY3 =

  16:01:30 INFO |     -chardev socket,id=3Dseabioslog_id_20120907-155940-Wo=
mlFZY3,path=3D/tmp/seabios-20120907-155940-WomlFZY3,server,nowait =

  16:01:30 INFO |     -device isa-debugcon,chardev=3Dseabioslog_id_20120907=
-155940-WomlFZY3,iobase=3D0x402 =

  16:01:30 INFO |     -m 512 =

  16:01:30 INFO |     -smp 2,cores=3D1,threads=3D1,sockets=3D2 =

  16:01:30 INFO |     -kernel '/home/lmr/Code/autotest.git/autotest/client/=
tests/virt/kvm/unittests/emulator.flat' =

  16:01:30 INFO |     -vnc :0 =

  16:01:30 INFO |     -chardev file,id=3Dtestlog,path=3D/tmp/testlog-201209=
07-155940-WomlFZY3 =

  16:01:30 INFO |     -device testdev,chardev=3Dtestlog =

  16:01:30 INFO |     -rtc base=3Dutc,clock=3Dhost,driftfix=3Dnone  =

  16:01:30 INFO |     -boot order=3Dcdn,once=3Dc,menu=3Doff   =

  16:01:30 INFO |     -S =

  16:01:30 INFO |     -enable-kvm

  We get

  16:01:32 INFO | Waiting for unittest emulator to complete, timeout 600, o=
utput in /tmp/testlog-20120907-155940-WomlFZY3
  16:01:32 INFO | [qemu output] KVM internal error. Suberror: 1
  16:01:32 INFO | [qemu output] emulation failure
  16:01:32 INFO | [qemu output] RAX=3Dffffffffffffeff8 RBX=3Dffffffffffffe0=
00 RCX=3Dfffffffffffff000 RDX=3D000000000044d2b0
  16:01:32 INFO | [qemu output] RSI=3D000000000044c9fa RDI=3D000000000044e3=
70 RBP=3Dffffffffffffeff8 RSP=3D000000000044d2b0
  16:01:32 INFO | [qemu output] R8 =3D000000000000000a R9 =3D00000000000003=
f8 R10=3D0000000000000000 R11=3D0000000000000000
  16:01:32 INFO | [qemu output] R12=3Dffffffffffffe000 R13=3D000000001fff60=
00 R14=3D000000001fff5000 R15=3D0000000000000000
  16:01:32 INFO | [qemu output] RIP=3D0000000000400a89 RFL=3D00010002 [----=
---] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HLT=3D0
  16:01:32 INFO | [qemu output] ES =3D0010 0000000000000000 ffffffff 00c093=
00 DPL=3D0 DS   [-WA]
  16:01:32 INFO | [qemu output] CS =3D0008 0000000000000000 ffffffff 00a09b=
00 DPL=3D0 CS64 [-RA]
  16:01:32 INFO | [qemu output] SS =3D0000 0000000000000000 ffffffff 000000=
00
  16:01:32 INFO | [qemu output] DS =3D0010 0000000000000000 ffffffff 00c093=
00 DPL=3D0 DS   [-WA]
  16:01:32 INFO | [qemu output] FS =3D0010 0000000000000000 ffffffff 00c093=
00 DPL=3D0 DS   [-WA]
  16:01:32 INFO | [qemu output] GS =3D0010 000000000044c370 ffffffff 00c093=
00 DPL=3D0 DS   [-WA]
  16:01:32 INFO | [qemu output] LDT=3D0000 0000000000000000 0000ffff 000082=
00 DPL=3D0 LDT
  16:01:32 INFO | [qemu output] TR =3D0048 000000000040a452 0000ffff 00008b=
00 DPL=3D0 TSS64-busy
  16:01:32 INFO | [qemu output] GDT=3D     000000000040a00a 00000447
  16:01:32 INFO | [qemu output] IDT=3D     0000000000000000 00000fff
  16:01:32 INFO | [qemu output] CR0=3D80010011 CR2=3D0000000000000000 CR3=
=3D000000001ffff000 CR4=3D00000020
  16:01:32 INFO | [qemu output] DR0=3D0000000000000000 DR1=3D00000000000000=
00 DR2=3D0000000000000000 DR3=3D0000000000000000
  16:01:32 INFO | [qemu output] DR6=3D00000000ffff0ff0 DR7=3D00000000000004=
00
  16:01:32 INFO | [qemu output] EFER=3D0000000000000500
  16:01:32 INFO | [qemu output] Code=3D88 77 00 49 8d 84 24 f8 0f 00 00 48 =
89 e2 48 89 e9 48 89 c5 <c9> 48 87 e2 48 87 e9 48 81 f9 99 88 77 00 0f 94 c=
0 48 39 d5 40 0f 94 c6 40 0f b6 f6 21 c6

  More logs will be attached to this bug report.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1047576/+subscriptions
