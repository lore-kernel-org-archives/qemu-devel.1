Received: from eggs.gnu.org ([209.51.188.92]:58919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBLy-0004TS-ET
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJBLw-0005Zt-IF
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:25:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:45080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJBLu-0005Tt-K4
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:25:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJBLp-0008MH-T3
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:25:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DA37E2E80CC
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:25:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 06:14:18 -0000
From: Thomas Huth <1579327@bugs.launchpad.net>
Reply-To: Bug 1579327 <1579327@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160507080857.903.95152.malonedeb@chaenomeles.canonical.com>
Message-Id: <155608645902.14412.2273974404058060574.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1579327] Re: emulation of vexpress-a9
 vexpress-a15 in multicore mode seems to be broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Sounds like a U-Boot bug. Closing according to comment #11.

** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1579327

Title:
  emulation of vexpress-a9 vexpress-a15 in multicore mode seems to be
  broken

Status in QEMU:
  Won't Fix

Bug description:
  Report based on:
  https://stackoverflow.com/questions/37068688/have-you-got-issues-with-run=
ning-u-boot-for-versatile-express-a9-platform-under

  I don't see any bug reports about vexpress boards emulation here, so I
  decided to let you know:

  version tested: qemu 2.0.0 on 32 bit Debian GNU/Linux

  There are issues with running u-boot on qemu vexpress-a9 ( it was reporte=
d to work ok at physical multicore board )  and vexpress-a15 with parameter=
s -smp cores=3D2 r 3 or 4.
  So far those are two tested. I dont know ATM if any other board emulation=
 works in multiprocessor mode

  Original post at stackoverflow:
  -------------------------------------------------------------------------=
--------------------------
  I have tried numerous releases of u-boot since vexpress-a9 was introduced=
 in u-bot stable release. Under qemu with multicore emulation its behaving =
unstable - mostly crashes instantly after loading. Sometimes it loads witho=
ut issues but its rare. My version of qemu is 2.0.0 on x86 32bit Debian. I =
would be interested to hear if you succeeded in runing it under qemu with m=
ulticore emulation ( if yes which version of qemu and u-boot ) or physical =
versatile express board with multiple cores.

  Example outputs are

  $ qemu-system-arm -M vexpress-a9 -nographic -kernel u-boot -smp cores=3D2
  U-Boot 2013.01.01-dirty (May 05 2016 - 08:27:19)

  DRAM:  128 MiB
  WARNING: Caches not enabled
  undefined instruction
  pc : [<00000000>]      lr : [<00000000>]
  sp : 60000ef0  ip : 67eedfd8     fp : 00000000
  r10: 00000000  r9 : 00000000     r8 : 60000f00
  r7 : 00000000  r6 : 608146ac     r5 : 60828365  r4 : 0000004d
  r3 : 00000000  r2 : 00000000     r1 : 60000f80  r0 : 47cc9e10
  Flags: nzcv  IRQs on  FIQs on  Mode USER_26
  Resetting CPU ...
  resetting ...
  Flash: 256 MiB
  MMC:   MMC: 0
  *** Warning - bad CRC, using default environment

  In:    serial
  Out:   serial
  Err:   serial
  Net:   smc911x-0
  Warning: smc911x-0 using MAC address from net device

  Hit any key to stop autoboot:  0 =

  Wrong Image Format for bootm command
  ERROR: can't get kernel image!
  VExpress# =


  This time it was loaded

  Other time it was not...

  $ qemu-system-arm -M vexpress-a9 -nographic -kernel u-boot -smp
  cores=3D2

  =

  U-Boot 2013.01.01-dirty (May 05 2016 - 08:27:19)

  DRAM:  128 MiB
  WARNING: Caches not enabled

  =

  U-Boot 2013.01.01-dirty (May 05 2016 - 08:27:19)

  DRAM:  128 MiB
  WARNING: Caches not enabled
  Flash: 256 MiB
  MMC:   MMC: 0
  *** Warning - bad CRC, using default environment

  In:    serial
  Out:   serial
  Err:   serial
  Net:   smc911x-0
  Warning: smc911x-0 using MAC address from net device

  Hit any key to stop autoboot:  2 qemu: fatal: Trying to execute code
  outside RAM or ROM at 0x6f71c004

  R00=3D00418937 R01=3D000003e8 R02=3D00418937 R03=3D00000000
  R04=3D00000000 R05=3D67eedf58 R06=3D67f8e000 R07=3D00000002
  R08=3D00418937 R09=3D0778e000 R10=3D6082f688 R11=3D00000000
  R12=3D67eedfd8 R13=3D00000000 R14=3D67fb82c0 R15=3D6f71c004
  PSR=3D200001db --C- A und32
  s00=3D00000000 s01=3D00000000 d00=3D0000000000000000
  s02=3D00000000 s03=3D00000000 d01=3D0000000000000000
  s04=3D00000000 s05=3D00000000 d02=3D0000000000000000
  s06=3D00000000 s07=3D00000000 d03=3D0000000000000000
  s08=3D00000000 s09=3D00000000 d04=3D0000000000000000
  s10=3D00000000 s11=3D00000000 d05=3D0000000000000000
  vs12=3D00000000 s13=3D00000000 d06=3D0000000000000000
  s14=3D00000000 s15=3D00000000 d07=3D0000000000000000
  s16=3D00000000 s17=3D00000000 d08=3D0000000000000000
  s18=3D00000000 s19=3D00000000 d09=3D0000000000000000
  s20=3D00000000 s21=3D00000000 d10=3D0000000000000000
  s22=3D00000000 s23=3D00000000 d11=3D0000000000000000
  s24=3D00000000 s25=3D00000000 d12=3D0000000000000000
  s26=3D00000000 s27=3D00000000 d13=3D0000000000000000
  s28=3D00000000 s29=3D00000000 d14=3D0000000000000000
  s30=3D00000000 s31=3D00000000 d15=3D0000000000000000
  s32=3D00000000 s33=3D00000000 d16=3D0000000000000000
  s34=3D00000000 s35=3D00000000 d17=3D0000000000000000
  s36=3D00000000 s37=3D00000000 d18=3D0000000000000000
  s38=3D00000000 s39=3D00000000 d19=3D0000000000000000
  s40=3D00000000 s41=3D00000000 d20=3D0000000000000000
  s42=3D00000000 s43=3D00000000 d21=3D0000000000000000
  s44=3D00000000 s45=3D00000000 d22=3D0000000000000000
  s46=3D00000000 s47=3D00000000 d23=3D0000000000000000
  s48=3D00000000 s49=3D00000000 d24=3D0000000000000000
  s50=3D00000000 s51=3D00000000 d25=3D0000000000000000
  s52=3D00000000 s53=3D00000000 d26=3D0000000000000000
  s54=3D00000000 s55=3D00000000 d27=3D0000000000000000
  s56=3D00000000 s57=3D00000000 d28=3D0000000000000000
  s58=3D00000000 s59=3D00000000 d29=3D0000000000000000
  s60=3D00000000 s61=3D00000000 d30=3D0000000000000000
  s62=3D00000000 s63=3D00000000 d31=3D0000000000000000
  FPSCR: 00000000
  -------------------------------------------------------------------------=
------------------------
  end of post

  Original discussion at ( includes comments of head custodian of Das U-boo=
t about u-boot working on physical board versatile express a9 and him havin=
g issues with runing Linux distro at qemu vexpress-a9 board emulation ):
  https://stackoverflow.com/questions/37068688/have-you-got-issues-with-run=
ning-u-boot-for-versatile-express-a9-platform-under

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1579327/+subscriptions
