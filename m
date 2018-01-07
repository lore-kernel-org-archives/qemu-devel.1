Received: from eggs.gnu.org ([2001:4830:134:3::10]:44458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eY8No-0000ox-7w
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 05:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eY8Nk-00048N-Vj
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 05:40:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:55592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eY8Nk-00047U-Ls
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 05:40:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eY8Nj-0001jY-Kc
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 10:40:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9B1A42E8059
	for <qemu-devel@nongnu.org>; Sun,  7 Jan 2018 10:40:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jan 2018 10:30:43 -0000
From: Michal Nowak <mnowak@startmail.com>
Reply-To: Bug 1741718 <1741718@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151532104339.3110.15836914058272965717.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1741718] [NEW] qemu-system-sparc64:
 "panic[cpu0]/thread=180e000: lgrp_traverse: No memory blocks found" with
 tribblix-sparc-0m16.iso
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

qemu-system-sparc64 Niagara VM running Tribblix crashes with
"panic[cpu0]/thread=3D180e000: lgrp_traverse: No memory blocks found" on
QEMU 2.11.0. Happens also with 1 GB, 4 GB, and 8 GB of RAM.

$=C2=A0qemu-system-sparc64 -nographic -M niagara -L /home/newman/Downloads/=
OpenSPARCT1_Arch.1.5/S10image/ -drive if=3Dpflash,readonly=3Don,file=3D/hom=
e/newman/Downloads/tribblix-sparc-0m16.iso -m 2048
=11cpu Probing I/O buses


Sun Fire T2000, No Keyboard
Copyright 2005 Sun Microsystems, Inc.  All rights reserved.
OpenBoot 4.20.0, 256 MB memory available, Serial #1122867.
[mo23723 obp4.20.0 #0]
Ethernet address 0:80:3:de:ad:3, Host ID: 80112233.


ok boot
Boot device: vdisk  File and args: =

hsfs-file-system =

Loading: /platform/sun4v/boot_archive
ramdisk-root ufs-file-system =

Loading: /platform/sun4v/kernel/sparcv9/unix
\
panic[cpu0]/thread=3D180e000: lgrp_traverse: No memory blocks found

Warning - stack not written to the dumpbuf
000000000180b710 unix:lgrp_traverse+120 (fff32000, 10d5f30, 2000, 7efefeff,=
 81010100, ff00)
  %l0-3: 0000000001876c00 ffffffffffffffff 00000000010d6c00 0000000000000000
  %l4-7: 800000008f000740 800000008fc54750 00000000f0254cc4 00000000010dedd0
000000000180b800 unix:plat_lgrp_init+14 (4, 180e000, 4, 0, 180b950, 1)
  %l0-3: 00000000fff32000 00000000fff340e0 00000000fff34590 00000000010d5f28
  %l4-7: 0000000000000016 0000000000000000 0000000000000016 0000000000000011
000000000180b8b0 unix:lgrp_plat_init+74 (0, 0, 0, 180ba08, 180ba00, 91)
  %l0-3: 0000000000002000 00000000fff34000 0000000001874c00 0000000001874c00
  %l4-7: 0000000000000000 0000000001874c00 000000000180b950 00000000010de048
000000000180b960 unix:lgrp_init+4 (0, 2000, 70002000, 0, 180c0e8, 0)
  %l0-3: 000000000180e380 000000000183c678 000000000180ba08 00000000010d4f90
  %l4-7: 00000000010d4fa0 00000000010d1c00 0000000000004000 0000000080001070
000000000180ba10 unix:mlsetup+2f4 (180bb80, 180bec0, 0, 0, f025496c, 0)
  %l0-3: 00000000018ee000 0000000070002000 0000000070002000 000000000180bad0
  %l4-7: 000000000190c4d8 00000001001f56e0 0000000000000000 0000000080001070


ERROR: Last Trap: Level 14 Interrupt
[Exception handlers interrupted, please file a bug]
[type 'resume' to attempt a normal recovery]


Without "if=3Dpflash" VM hangs:

$ qemu-system-sparc64 -nographic -M niagara -L /home/newman/Downloads/OpenS=
PARCT1_Arch.1.5/S10image/ -drive readonly=3Don,file=3D/home/newman/Download=
s/tribblix-sparc-0m16.iso -m 4096
=11cpu Probing I/O buses


Sun Fire T2000, No Keyboard
Copyright 2005 Sun Microsystems, Inc.  All rights reserved.
OpenBoot 4.20.0, 256 MB memory available, Serial #1122867.
[mo23723 obp4.20.0 #0]
Ethernet address 0:80:3:de:ad:3, Host ID: 80112233.


ok boot
Boot device: vdisk  File and args: =

qemu: fatal: Trap 0x0032 while trap level (6) >=3D MAXTL (6), Error state
pc: 000000000040f01c  npc: 000000000040f020
%g0-3: 0000000000000000 0000000000000000 0000000000000000 0000009700000280
%g4-7: 0000000000001000 0000000000000000 0000000000000000 0000000000000000
%o0-3: 0000000000000000 000000008ffd6000 0000000000008000 0000000000000000 =

%o4-7: 0000000000000000 00000000000000f0 00000000fff55701 00000000f020d78c =

%l0-3: 000000000002fd10 7ffffffffffffffe 8000000000000000 0000000000000000 =

%l4-7: 000000000000000b 800000008fffa750 00000000f026fbf0 00000000f022a0d8 =

%i0-3: 0000000080000000 0000000010000000 0000000000000000 0000000000000000 =

%i4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 =

%f00:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f08:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f16:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f24:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f32:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f40:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f48:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
%f56:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
pstate: 00000014 ccr: 11 (icc: ---C xcc: ---C) asi: 20 tl: 6 pil: d gl: 6
tbr: 00000000f0200000 hpstate: 0000000000000004 htba: 0000000000400000
cansave: 6 canrestore: 0 otherwin: 0 wstate: 0 cleanwin: 7 cwp: 0
fsr: 0000000000000000 y: 0000000000000000 fprs: 0000000000000004

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1741718

Title:
  qemu-system-sparc64: "panic[cpu0]/thread=3D180e000: lgrp_traverse: No
  memory blocks found" with tribblix-sparc-0m16.iso

Status in QEMU:
  New

Bug description:
  qemu-system-sparc64 Niagara VM running Tribblix crashes with
  "panic[cpu0]/thread=3D180e000: lgrp_traverse: No memory blocks found" on
  QEMU 2.11.0. Happens also with 1 GB, 4 GB, and 8 GB of RAM.

  $=C2=A0qemu-system-sparc64 -nographic -M niagara -L /home/newman/Download=
s/OpenSPARCT1_Arch.1.5/S10image/ -drive if=3Dpflash,readonly=3Don,file=3D/h=
ome/newman/Downloads/tribblix-sparc-0m16.iso -m 2048
  =11cpu Probing I/O buses

  =

  Sun Fire T2000, No Keyboard
  Copyright 2005 Sun Microsystems, Inc.  All rights reserved.
  OpenBoot 4.20.0, 256 MB memory available, Serial #1122867.
  [mo23723 obp4.20.0 #0]
  Ethernet address 0:80:3:de:ad:3, Host ID: 80112233.


  ok boot
  Boot device: vdisk  File and args: =

  hsfs-file-system =

  Loading: /platform/sun4v/boot_archive
  ramdisk-root ufs-file-system =

  Loading: /platform/sun4v/kernel/sparcv9/unix
  \
  panic[cpu0]/thread=3D180e000: lgrp_traverse: No memory blocks found

  Warning - stack not written to the dumpbuf
  000000000180b710 unix:lgrp_traverse+120 (fff32000, 10d5f30, 2000, 7efefef=
f, 81010100, ff00)
    %l0-3: 0000000001876c00 ffffffffffffffff 00000000010d6c00 0000000000000=
000
    %l4-7: 800000008f000740 800000008fc54750 00000000f0254cc4 00000000010de=
dd0
  000000000180b800 unix:plat_lgrp_init+14 (4, 180e000, 4, 0, 180b950, 1)
    %l0-3: 00000000fff32000 00000000fff340e0 00000000fff34590 00000000010d5=
f28
    %l4-7: 0000000000000016 0000000000000000 0000000000000016 0000000000000=
011
  000000000180b8b0 unix:lgrp_plat_init+74 (0, 0, 0, 180ba08, 180ba00, 91)
    %l0-3: 0000000000002000 00000000fff34000 0000000001874c00 0000000001874=
c00
    %l4-7: 0000000000000000 0000000001874c00 000000000180b950 00000000010de=
048
  000000000180b960 unix:lgrp_init+4 (0, 2000, 70002000, 0, 180c0e8, 0)
    %l0-3: 000000000180e380 000000000183c678 000000000180ba08 00000000010d4=
f90
    %l4-7: 00000000010d4fa0 00000000010d1c00 0000000000004000 0000000080001=
070
  000000000180ba10 unix:mlsetup+2f4 (180bb80, 180bec0, 0, 0, f025496c, 0)
    %l0-3: 00000000018ee000 0000000070002000 0000000070002000 000000000180b=
ad0
    %l4-7: 000000000190c4d8 00000001001f56e0 0000000000000000 0000000080001=
070

  =

  ERROR: Last Trap: Level 14 Interrupt
  [Exception handlers interrupted, please file a bug]
  [type 'resume' to attempt a normal recovery]

  =

  Without "if=3Dpflash" VM hangs:

  $ qemu-system-sparc64 -nographic -M niagara -L /home/newman/Downloads/Ope=
nSPARCT1_Arch.1.5/S10image/ -drive readonly=3Don,file=3D/home/newman/Downlo=
ads/tribblix-sparc-0m16.iso -m 4096
  =11cpu Probing I/O buses

  =

  Sun Fire T2000, No Keyboard
  Copyright 2005 Sun Microsystems, Inc.  All rights reserved.
  OpenBoot 4.20.0, 256 MB memory available, Serial #1122867.
  [mo23723 obp4.20.0 #0]
  Ethernet address 0:80:3:de:ad:3, Host ID: 80112233.


  ok boot
  Boot device: vdisk  File and args: =

  qemu: fatal: Trap 0x0032 while trap level (6) >=3D MAXTL (6), Error state
  pc: 000000000040f01c  npc: 000000000040f020
  %g0-3: 0000000000000000 0000000000000000 0000000000000000 0000009700000280
  %g4-7: 0000000000001000 0000000000000000 0000000000000000 0000000000000000
  %o0-3: 0000000000000000 000000008ffd6000 0000000000008000 000000000000000=
0 =

  %o4-7: 0000000000000000 00000000000000f0 00000000fff55701 00000000f020d78=
c =

  %l0-3: 000000000002fd10 7ffffffffffffffe 8000000000000000 000000000000000=
0 =

  %l4-7: 000000000000000b 800000008fffa750 00000000f026fbf0 00000000f022a0d=
8 =

  %i0-3: 0000000080000000 0000000010000000 0000000000000000 000000000000000=
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
  pstate: 00000014 ccr: 11 (icc: ---C xcc: ---C) asi: 20 tl: 6 pil: d gl: 6
  tbr: 00000000f0200000 hpstate: 0000000000000004 htba: 0000000000400000
  cansave: 6 canrestore: 0 otherwin: 0 wstate: 0 cleanwin: 7 cwp: 0
  fsr: 0000000000000000 y: 0000000000000000 fprs: 0000000000000004

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1741718/+subscriptions
