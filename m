Received: from eggs.gnu.org ([2001:4830:134:3::10]:49582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCHze-0004c9-1L
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 23:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCHzb-0006WT-Bt
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 23:29:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:57176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eCHzb-0006Vu-1z
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 23:29:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eCHzZ-0007wL-VE
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 04:29:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CDC3E2E80C9
	for <qemu-devel@nongnu.org>; Wed,  8 Nov 2017 04:29:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Nov 2017 04:17:26 -0000
From: Launchpad Bug Tracker <1060928@bugs.launchpad.net>
Reply-To: Bug 1060928 <1060928@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121003125732.14751.4991.malonedeb@gac.canonical.com>
Message-Id: <151011464657.16570.3293379114195826636.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1060928] Re: Error in launch virtual server port
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
https://bugs.launchpad.net/bugs/1060928

Title:
  Error in launch virtual server port

Status in QEMU:
  Expired

Bug description:
  .- configure
  .- uname -a
  .- script bash launcher
  .- Error
  .- output serial.c in statusRUN

  -----------------------------------

  .- configure

  ./configure --target-list=3Di386-softmmu,x86_64-softmmu,\
  i386-linux-user,x86_64-linux-user --enable-vde --disable-vnc --enable-sdl=
 \
  --audio-drv-list=3Doss,alsa,sdl,esd,pa \
  --audio-card-list=3Dac97,es1370,sb16,cs4231a,adlib,gus,hda &>status

  -----------------------------------

  .- uname -a
  Linux Aspire5250 3.2.0-23-generic #36-Ubuntu SMP Tue Apr 10 20:39:51 UTC =
2012 x86_64 x86_64 x86_64 GNU/Linux

  -----------------------------------

  .- script bash launcher

  #!/bin/bash

  qemu-system-i386 -m 128 -display sdl -cpu pentium \
  -k es \
  -net nic,vlan=3D0,macaddr=3D52:54:00:12:02:04,model=3Dpcnet \
  -net vde,vlan=3D0,sock=3D/var/run/vde2/tap0.ctl \
  -serial unix:/tmp/com1,server,nowait \
  -vga cirrus \
  -boot c -hda "/home/VirtualMachines/Discos/Hispa70_1.vmdk" \
  -cdrom "/home/VirtualMachines/CDROM/hf-7.0a.iso" 2>statusRUN

  echo -n "Pulsa enter para continuar . . . " && read REPLY

  -----------------------------------

  .- Error

  *** buffer overflow detected ***: qemu-system-i386 terminated
  =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
  /lib/x86_64-linux-gnu/libc.so.6(__fortify_fail+0x37)[0x7f2759892007]
  /lib/x86_64-linux-gnu/libc.so.6(+0x107f00)[0x7f2759890f00]
  /lib/x86_64-linux-gnu/libc.so.6(+0x108fbe)[0x7f2759891fbe]
  qemu-system-i386(+0xe5153)[0x7f275bfd8153]
  qemu-system-i386(+0x1744f6)[0x7f275c0674f6]
  qemu-system-i386(main+0xe77)[0x7f275bf5ef37]
  /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xed)[0x7f27597aa76d]
  qemu-system-i386(+0x70229)[0x7f275bf63229]
  =3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
  41912000-43912000 rwxp 00000000 00:00 0 =

  7f2730000000-7f2730054000 rw-p 00000000 00:00 0 =

  7f2730054000-7f2734000000 ---p 00000000 00:00 0 =

  7f2736539000-7f273bdff000 r--p 00000000 08:05 1978631                    =
/usr/lib/locale/locale-archive
  7f273bdff000-7f273be00000 rw-p 00000000 00:00 0 =

  7f273be00000-7f2743e00000 rw-p 00000000 00:00 0 =

  7f2743e00000-7f2744000000 rw-p 00000000 00:00 0 =

  7f2744000000-7f2744021000 rw-p 00000000 00:00 0 =

  7f2744021000-7f2748000000 ---p 00000000 00:00 0 =

  7f274c000000-7f274c021000 rw-p 00000000 00:00 0 =

  7f274c021000-7f2750000000 ---p 00000000 00:00 0 =

  7f27500c5000-7f27500ca000 r-xp 00000000 08:05 1979531                    =
/usr/lib/x86_64-linux-gnu/libXfixes.so.3.1.0
  7f27500ca000-7f27502c9000 ---p 00005000 08:05 1979531                    =
/usr/lib/x86_64-linux-gnu/libXfixes.so.3.1.0
  7f27502c9000-7f27502ca000 r--p 00004000 08:05 1979531                    =
/usr/lib/x86_64-linux-gnu/libXfixes.so.3.1.0
  7f27502ca000-7f27502cb000 rw-p 00005000 08:05 1979531                    =
/usr/lib/x86_64-linux-gnu/libXfixes.so.3.1.0
  7f27502cb000-7f27502d4000 r-xp 00000000 08:05 1979549                    =
/usr/lib/x86_64-linux-gnu/libXrender.so.1.3.0
  7f27502d4000-7f27504d3000 ---p 00009000 08:05 1979549                    =
/usr/lib/x86_64-linux-gnu/libXrender.so.1.3.0
  7f27504d3000-7f27504d4000 r--p 00008000 08:05 1979549                    =
/usr/lib/x86_64-linux-gnu/libXrender.so.1.3.0
  7f27504d4000-7f27504d5000 rw-p 00009000 08:05 1979549                    =
/usr/lib/x86_64-linux-gnu/libXrender.so.1.3.0
  7f27504d5000-7f27504de000 r-xp 00000000 08:05 1979523                    =
/usr/lib/x86_64-linux-gnu/libXcursor.so.1.0.2
  7f27504de000-7f27506dd000 ---p 00009000 08:05 1979523                    =
/usr/lib/x86_64-linux-gnu/libXcursor.so.1.0.2
  7f27506dd000-7f27506de000 r--p 00008000 08:05 1979523                    =
/usr/lib/x86_64-linux-gnu/libXcursor.so.1.0.2
  7f27506de000-7f27506df000 rw-p 00009000 08:05 1979523                    =
/usr/lib/x86_64-linux-gnu/libXcursor.so.1.0.2
  7f27506df000-7f2750763000 rw-p 00000000 00:00 0 =

  7f2750775000-7f2750776000 rw-p 00000000 00:00 0 =

  7f2750776000-7f2750890000 rw-s 00000000 00:04 1736706                    =
/SYSV00000000 (deleted)
  7f2750890000-7f2750a00000 rw-p 00000000 00:00 0 =

  7f2750a00000-7f2751200000 rw-p 00000000 00:00 0 =

  7f2751200000-7f2751291000 rw-p 00000000 00:00 0 =

  7f2751291000-7f2751292000 ---p 00000000 00:00 0 =

  7f2751292000-7f2751a92000 rw-p 00000000 00:00 0 =

  7f2751a92000-7f2751a93000 ---p 00000000 00:00 0 =

  7f2751a93000-7f2752293000 rw-p 00000000 00:00 0 =

  7f2752293000-7f2752294000 ---p 00000000 00:00 0 =

  7f2752294000-7f2752a94000 rw-p 00000000 00:00 0 =

  7f2752a94000-7f2752a95000 ---p 00000000 00:00 0 =

  7f2752a95000-7f2753295000 rw-p 00000000 00:00 0 =

  7f2753295000-7f2753296000 ---p 00000000 00:00 0 =

  7f2753296000-7f2753a96000 rw-p 00000000 00:00 0 =

  7f2753a96000-7f2753aa2000 r-xp 00000000 08:05 660536                     =
/lib/x86_64-linux-gnu/libnss_files-2.15.so
  7f2753aa2000-7f2753ca1000 ---p 0000c000 08:05 660536                     =
/lib/x86_64-linux-gnu/libnss_files-2.15.so
  7f2753ca1000-7f2753ca2000 r--p 0000b000 08:05 660536                     =
/lib/x86_64-linux-gnu/libnss_files-2.15.so
  7f2753ca2000-7f2753ca3000 rw-p 0000c000 08:05 660536                     =
/lib/x86_64-linux-gnu/libnss_files-2.15.so
  7f2753ca3000-7f2753cad000 r-xp 00000000 08:05 660540                     =
/lib/x86_64-linux-gnu/libnss_nis-2.15.so
  7f2753cad000-7f2753ead000 ---p 0000a000 08:05 660540                     =
/lib/x86_64-linux-gnu/libnss_nis-2.15.so
  7f2753ead000-7f2753eae000 r--p 0000a000 08:05 660540                     =
/lib/x86_64-linux-gnu/libnss_nis-2.15.so
  7f2753eae000-7f2753eaf000 rw-p 0000b000 08:05 660540                     =
/lib/x86_64-linux-gnu/libnss_nis-2.15.so
  7f2753eaf000-7f2753eb7000 r-xp 00000000 08:05 660532                     =
/lib/x86_64-linux-gnu/libnss_compat-2.15.so
  7f2753eb7000-7f27540b6000 ---p 00008000 08:05 660532                     =
/lib/x86_64-linux-gnu/libnss_compat-2.15.so
  7f27540b6000-7f27540b7000 r--p 00007000 08:05 660532                     =
/lib/x86_64-linux-gnu/libnss_compat-2.15.so
  7f27540b7000-7f27540b8000 rw-p 00008000 08:05 660532                     =
/lib/x86_64-linux-gnu/libnss_compat-2.15.so
  7f27540b8000-7f2755cb9000 rw-p 00000000 00:00 0 =

  7f2755cb9000-7f2755cce000 r-xp 00000000 08:05 660506                     =
/lib/x86_64-linux-gnu/libgcc_s.so.1
  7f2755cce000-7f2755ecd000 ---p 00015000 08:05 660506                     =
/lib/x86_64-linux-gnu/libgcc_s.so.1
  7f2755ecd000-7f2755ece000 r--p 00014000 08:05 660506                     =
/lib/x86_64-linux-gnu/libgcc_s.so.1
  7f2755ece000-7f2755ecf000 rw-p 00015000 08:05 660506                     =
/lib/x86_64-linux-gnu/libgcc_s.so.1
  7f2755ecf000-7f2755ee7000 r-xp 00000000 08:05 660569                     =
/lib/x86_64-linux-gnu/libresolv-2.15.so
  7f2755ee7000-7f27560e7000 ---p 00018000 08:05 660569                     =
/lib/x86_64-linux-gnu/libresolv-2.15.so
  7f27560e7000-7f27560e8000 r--p 00018000 08:05 660569                     =
/lib/x86_64-linux-gnu/libresolv-2.15.so
  7f27560e8000-7f27560e9000 rw-p 00019000 08:05 660569                     =
/lib/x86_64-linux-gnu/libresolv-2.15.so
  7f27560e9000-7f27560eb000 rw-p 00000000 00:00 0 =

  7f27560eb000-7f27560f1000 r-xp 00000000 08:05 1979942                    =
/usr/lib/x86_64-linux-gnu/libogg.so.0.7.1
  7f27560f1000-7f27562f0000 ---p 00006000 08:05 1979942                    =
/usr/lib/x86_64-linux-gnu/libogg.so.0.7.1
  7f27562f0000-7f27562f1000 r--p 00005000 08:05 1979942                    =
/usr/lib/x86_64-linux-gnu/libogg.so.0.7.1
  7f27562f1000-7f27562f2000 rw-p 00006000 08:05 1979942                    =
/usr/lib/x86_64-linux-gnu/libogg.so.0.7.1
  7f27562f2000-7f275631d000 r-xp 00000000 08:05 1980105                    =
/usr/lib/x86_64-linux-gnu/libvorbis.so.0.4.5
  7f275631d000-7f275651c000 ---p 0002b000 08:05 1980105                    =
/usr/lib/x86_64-linux-gnu/libvorbis.so.0.4.5
  7f275651c000-7f275651d000 r--p 0002a000 08:05 1980105                    =
/usr/lib/x86_64-linux-gnu/libvorbis.so.0.4.5
  7f275651d000-7f275651e000 rw-p 0002b000 08:05 1980105                    =
/usr/lib/x86_64-linux-gnu/libvorbis.so.0.4.5
  7f275651e000-7f27567d1000 r-xp 00000000 08:05 1980107                    =
/usr/lib/x86_64-linux-gnu/libvorbisenc.so.2.0.8
  7f27567d1000-7f27569d0000 ---p 002b3000 08:05 1980107                    =
/usr/lib/x86_64-linux-gnu/libvorbisenc.so.2.0.8
  7f27569d0000-7f27569ec000 r--p 002b2000 08:05 1980107                    =
/usr/lib/x86_64-linux-gnu/libvorbisenc.so.2.0.8
  7f27569ec000-7f27569ed000 rw-p 002ce000 08:05 1980107                    =
/usr/lib/x86_64-linux-gnu/libvorbisenc.so.2.0.8
  7f27569ed000-7f2756a35000 r-xp 00000000 08:05 1979438                    =
/usr/lib/x86_64-linux-gnu/libFLAC.so.8.2.0
  7f2756a35000-7f2756c35000 ---p 00048000 08:05 1979438                    =
/usr/lib/x86_64-linux-gnu/libFLAC.so.8.2.0
  7f2756c35000-7f2756c36000 r--p 00048000 08:05 1979438                    =
/usr/lib/x86_64-linux-gnu/libFLAC.so.8.2.0
  7f2756c36000-7f2756c37000 rw-p 00049000 08:05 1979438                    =
/usr/lib/x86_64-linux-gnu/libFLAC.so.8.2.0
  7f2756c37000-7f2756c4e000 r-xp 00000000 08:05 660530                     =
/lib/x86_64-linux-gnu/libnsl-2.15.so
  7f2756c4e000-7f2756e4d000 ---p 00017000 08:05 660530                     =
/lib/x86_64-linux-gnu/libnsl-2.15.so
  7f2756e4d000-7f2756e4e000 r--p 00016000 08:05 660530                     =
/lib/x86_64-linux-gnu/libnsl-2.15.so
  7f2756e4e000-7f2756e4f000 rw-p 00017000 08:05 660530                     =
/lib/x86_64-linux-gnu/libnsl-2.15.so
  7f2756e4f000-7f2756e51000 rw-p 00000000 00:00 0 =

  7f2756e51000-7f2756e56000 r-xp 00000000 08:05 1979527                    =
/usr/lib/x86_64-linux-gnu/libXdmcp.so.6.0.0
  7f2756e56000-7f2757055000 ---p 00005000 08:05 1979527                    =
/usr/lib/x86_64-linux-gnu/libXdmcp.so.6.0.0
  7f2757055000-7f2757056000 r--p 00004000 08:05 1979527                    =
/usr/lib/x86_64-linux-gnu/libXdmcp.so.6.0.0
  7f2757056000-7f2757057000 rw-p 00005000 08:05 1979527                    =
/usr/lib/x86_64-linux-gnu/libXdmcp.so.6.0.0
  7f2757057000-7f2757059000 r-xp 00000000 08:05 1979516                    =
/usr/lib/x86_64-linux-gnu/libXau.so.6.0.0
  7f2757059000-7f2757258000 ---p 00002000 08:05 1979516                    =
/usr/lib/x86_64-linux-gnu/libXau.so.6.0.0
  7f2757258000-7f2757259000 r--p 00001000 08:05 1979516                    =
/usr/lib/x86_64-linux-gnu/libXau.so.6.0.0
  7f2757259000-7f275725a000 rw-p 00002000 08:05 1979516                    =
/usr/lib/x86_64-linux-gnu/libXau.so.6.0.0
  7f275725a000-7f2757286000 r-xp 00000000 08:05 660525                     =
/lib/x86_64-linux-gnu/libncursesw.so.5.9
  7f2757286000-7f2757485000 ---p 0002c000 08:05 660525                     =
/lib/x86_64-linux-gnu/libncursesw.so.5.9
  7f2757485000-7f2757486000 r--p 0002b000 08:05 660525                     =
/lib/x86_64-linux-gnu/libncursesw.so.5.9
  7f2757486000-7f2757487000 rw-p 0002c000 08:05 660525                     =
/lib/x86_64-linux-gnu/libncursesw.so.5.9
  7f2757487000-7f2757578000 r-xp 00000000 08:05 660575                     =
/lib/x86_64-linux-gnu/libslang.so.2.2.4
  7f2757578000-7f2757778000 ---p 000f1000 08:05 660575                     =
/lib/x86_64-linux-gnu/libslang.so.2.2.4
  7f2757778000-7f275777c000 r--p 000f1000 08:05 660575                     =
/lib/x86_64-linux-gnu/libslang.so.2.2.4
  7f275777c000-7f2757794000 rw-p 000f5000 08:05 660575                     =
/lib/x86_64-linux-gnu/libslang.so.2.2.4
  7f2757794000-7f27577f8000 rw-p 00000000 00:00 0 =

  7f27577f8000-7f27578da000 r-xp 00000000 08:05 1980059                    =
/usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.16
  7f27578da000-7f2757ad9000 ---p 000e2000 08:05 1980059                    =
/usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.16
  7f2757ad9000-7f2757ae1000 r--p 000e1000 08:05 1980059                    =
/usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.16
  7f2757ae1000-7f2757ae3000 rw-p 000e9000 08:05 1980059                    =
/usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.16
  7f2757ae3000-7f2757af8000 rw-p 00000000 00:00 0 =

  7f2757af8000-7f2757afd000 r-xp 00000000 08:05 1979573                    =
/usr/lib/x86_64-linux-gnu/libasyncns.so.0.3.1
  7f2757afd000-7f2757cfc000 ---p 00005000 08:05 1979573                    =
/usr/lib/x86_64-linux-gnu/libasyncns.so.0.3.1
  7f2757cfc000-7f2757cfd000 r--p 00004000 08:05 1979573                    =
/usr/lib/x86_64-linux-gnu/libasyncns.so.0.3.1
  7f2757cfd000-7f2757cfe000 rw-p 00005000 08:05 1979573                    =
/usr/lib/x86_64-linux-gnu/libasyncns.so.0.3.1
  7f2757cfe000-7f2757d5e000 r-xp 00000000 08:05 1980037                    =
/usr/lib/x86_64-linux-gnu/libsndfile.so.1.0.25
  7f2757d5e000-7f2757f5e000 ---p 00060000 08:05 1980037                    =
/usr/lib/x86_64-linux-gnu/libsndfile.so.1.0.25
  7f2757f5e000-7f2757f60000 r--p 00060000 08:05 1980037                    =
/usr/lib/x86_64-linux-gnu/libsndfile.so.1.0.25
  7f2757f60000-7f2757f61000 rw-p 00062000 08:05 1980037                    =
/usr/lib/x86_64-linux-gnu/libsndfile.so.1.0.25
  7f2757f61000-7f2757f65000 rw-p 00000000 00:00 0 =

  7f2757f65000-7f2757f6d000 r-xp 00000000 08:05 660594                     =
/lib/x86_64-linux-gnu/libwrap.so.0.7.6
  7f2757f6d000-7f275816c000 ---p 00008000 08:05 660594                     =
/lib/x86_64-linux-gnu/libwrap.so.0.7.6
  7f275816c000-7f275816d000 r--p 00007000 08:05 660594                     =
/lib/x86_64-linux-gnu/libwrap.so.0.7.6
  7f275816d000-7f275816e000 rw-p 00008000 08:05 660594                     =
/lib/x86_64-linux-gnu/libwrap.so.0.7.6
  7f275816e000-7f275818b000 r-xp 00000000 08:05 1980136                    =
/usr/lib/x86_64-linux-gnu/libxcb.so.1.1.0
  7f275818b000-7f275838a000 ---p 0001d000 08:05 1980136                    =
/usr/lib/x86_64-linux-gnu/libxcb.so.1.1.0
  7f275838a000-7f275838b000 r--p 0001c000 08:05 1980136                    =
/usr/lib/x86_64-linux-gnu/libxcb.so.1.1.0
  7f275838b000-7f275838c000 rw-p 0001d000 08:05 1980136                    =
/usr/lib/x86_64-linux-gnu/libxcb.so.1.1.0
  7f275838c000-7f27583ae000 r-xp 00000000 08:05 1979609                    =
/usr/lib/x86_64-linux-gnu/libcaca.so.0.99.17
  7f27583ae000-7f27585ae000 ---p 00022000 08:05 1979609                    =
/usr/lib/x86_64-linux-gnu/libcaca.so.0.99.17
  7f27585ae000-7f27585af000 r--p 00022000 08:05 1979609                    =
/usr/lib/x86_64-linux-gnu/libcaca.so.0.99.17
  7f27585af000-7f2758652000 rw-p 00023000 08:05 1979609                    =
/usr/lib/x86_64-linux-gnu/libcaca.so.0.99.17
  7f2758652000-7f2758657000 rw-p 00000000 00:00 0 =

  7f2758657000-7f2758667000 r-xp 00000000 08:05 1979529                    =
/usr/lib/x86_64-linux-gnu/libXext.so.6.4.0
  7f2758667000-7f2758866000 ---p 00010000 08:05 1979529                    =
/usr/lib/x86_64-linux-gnu/libXext.so.6.4.0
  7f2758866000-7f2758867000 r--p 0000f000 08:05 1979529                    =
/usr/lib/x86_64-linux-gnu/libXext.so.6.4.0
  7f2758867000-7f2758868000 rw-p 00010000 08:05 1979529                    =
/usr/lib/x86_64-linux-gnu/libXext.so.6.4.0
  7f2758868000-7f275886b000 r-xp 00000000 08:05 1993708                    =
/usr/lib/x86_64-linux-gnu/libpulse-simple.so.0.0.3
  7f275886b000-7f2758a6a000 ---p 00003000 08:05 1993708                    =
/usr/lib/x86_64-linux-gnu/libpulse-simple.so.0.0.3
  7f2758a6a000-7f2758a6b000 r--p 00002000 08:05 1993708                    =
/usr/lib/x86_64-linux-gnu/libpulse-simple.so.0.0.3
  7f2758a6b000-7f2758a6c000 rw-p 00003000 08:05 1993708                    =
/usr/lib/x86_64-linux-gnu/libpulse-simple.so.0.0.3
  7f2758a6c000-7f2758a9b000 r-xp 00000000 08:05 1982675                    =
/usr/lib/x86_64-linux-gnu/libaudiofile.so.1.0.0
  7f2758a9b000-7f2758c9b000 ---p 0002f000 08:05 1982675                    =
/usr/lib/x86_64-linux-gnu/libaudiofile.so.1.0.0
  7f2758c9b000-7f2758c9d000 r--p 0002f000 08:05 1982675                    =
/usr/lib/x86_64-linux-gnu/libaudiofile.so.1.0.0
  7f2758c9d000-7f2758c9e000 rw-p 00031000 08:05 1982675                    =
/usr/lib/x86_64-linux-gnu/libaudiofile.so.1.0.0
  7f2758c9e000-7f2758ce0000 r-xp 00000000 08:05 660497                     =
/lib/x86_64-linux-gnu/libdbus-1.so.3.5.8
  7f2758ce0000-7f2758ee0000 ---p 00042000 08:05 660497                     =
/lib/x86_64-linux-gnu/libdbus-1.so.3.5.8
  7f2758ee0000-7f2758ee1000 r--p 00042000 08:05 660497                     =
/lib/x86_64-linux-gnu/libdbus-1.so.3.5.8
  7f2758ee1000-7f2758ee2000 rw-p 00043000 08:05 660497                     =
/lib/x86_64-linux-gnu/libdbus-1.so.3.5.8
  7f2758ee2000-7f2758f3e000 r-xp 00000000 08:05 1993709                    =
/usr/lib/x86_64-linux-gnu/libpulsecommon-1.1.so
  7f2758f3e000-7f275913e000 ---p 0005c000 08:05 1993709                    =
/usr/lib/x86_64-linux-gnu/libpulsecommon-1.1.so
  7f275913e000-7f275913f000 r--p 0005c000 08:05 1993709                    =
/usr/lib/x86_64-linux-gnu/libpulsecommon-1.1.so
  7f275913f000-7f2759140000 rw-p 0005d000 08:05 1993709                    =
/usr/lib/x86_64-linux-gnu/libpulsecommon-1.1.so
  7f2759140000-7f2759147000 r-xp 00000000 08:05 1979876                    =
/usr/lib/x86_64-linux-gnu/libjson.so.0.0.1
  7f2759147000-7f2759346000 ---p 00007000 08:05 1979876                    =
/usr/lib/x86_64-linux-gnu/libjson.so.0.0.1
  7f2759346000-7f2759347000 r--p 00006000 08:05 1979876                    =
/usr/lib/x86_64-linux-gnu/libjson.so.0.0.1
  7f2759347000-7f2759348000 rw-p 00007000 08:05 1979876                    =
/usr/lib/x86_64-linux-gnu/libjson.so.0.0.1./RUN_HISPA_1: l=C3=ADnea 17:  29=
52 Abortado                (`core' generado) qemu-system-i386 -m 128 -displ=
ay sdl -cpu pentium -k es -net nic,vlan=3D0,macaddr=3D52:54:00:12:02:04,mod=
el=3Dpcnet -net vde,vlan=3D0,sock=3D/var/run/vde2/tap0.ctl -serial unix:/tm=
p/com1,server,nowait -vga cirrus -boot c -hda "/home/VirtualMachines/Discos=
/Hispa70_1.vmdk" -cdrom "/home/VirtualMachines/CDROM/hf-7.0a.iso" 2> status=
RUN

  -----------------------------------

  .- output serial.c in statusRUN

  serial: write addr=3D0x01 val=3D0x02
  serial: read addr=3D0x01 val=3D0x02
  serial: read addr=3D0x02 val=3D0x02
  serial: write addr=3D0x01 val=3D0x00
  serial: read addr=3D0x01 val=3D0x00
  serial: write addr=3D0x01 val=3D0x00
  serial: read addr=3D0x01 val=3D0x00
  serial: write addr=3D0x01 val=3D0x00
  serial: read addr=3D0x03 val=3D0x00
  serial: write addr=3D0x03 val=3D0xbf
  serial: speed=3D9600 parity=3DE data=3D8 stop=3D2
  serial: write addr=3D0x02 val=3D0x00
  serial: write addr=3D0x03 val=3D0x00
  serial: speed=3D9600 parity=3DN data=3D5 stop=3D1
  serial: write addr=3D0x02 val=3D0x01
  serial: read addr=3D0x02 val=3D0xc1
  serial: write addr=3D0x03 val=3D0x80
  serial: speed=3D9600 parity=3DN data=3D5 stop=3D1
  serial: read addr=3D0x02 val=3D0xc1
  serial: write addr=3D0x03 val=3D0xbf
  serial: speed=3D9600 parity=3DE data=3D8 stop=3D2
  serial: read addr=3D0x02 val=3D0xc1
  serial: write addr=3D0x03 val=3D0x80
  serial: speed=3D9600 parity=3DN data=3D5 stop=3D1
  serial: write addr=3D0x02 val=3D0x21
  serial: read addr=3D0x02 val=3D0xc1
  serial: write addr=3D0x02 val=3D0x01
  serial: write addr=3D0x03 val=3D0x00
  serial: speed=3D9600 parity=3DN data=3D5 stop=3D1
  serial: write addr=3D0x04 val=3D0x00
  serial: write addr=3D0x02 val=3D0x06
  serial: read addr=3D0x00 val=3D0x00
  serial: write addr=3D0x01 val=3D0x00
  serial: write addr=3D0x02 val=3D0x06
  serial: read addr=3D0x05 val=3D0x60
  serial: read addr=3D0x00 val=3D0x00
  serial: read addr=3D0x02 val=3D0x01
  serial: read addr=3D0x06 val=3D0xb0
  serial: write addr=3D0x03 val=3D0x03
  serial: speed=3D9600 parity=3DN data=3D8 stop=3D1
  serial: write addr=3D0x04 val=3D0x0b
  serial: write addr=3D0x01 val=3D0x0d
  serial: read addr=3D0x05 val=3D0x60
  serial: read addr=3D0x00 val=3D0x00
  serial: read addr=3D0x02 val=3D0x01
  serial: read addr=3D0x06 val=3D0xb0
  serial: write addr=3D0x01 val=3D0x05
  serial: write addr=3D0x03 val=3D0x93
  serial: speed=3D9600 parity=3DN data=3D8 stop=3D1
  serial: write addr=3D0x00 val=3D0x0c
  serial: speed=3D9600 parity=3DN data=3D8 stop=3D1
  serial: write addr=3D0x01 val=3D0x00
  serial: speed=3D9600 parity=3DN data=3D8 stop=3D1
  serial: write addr=3D0x03 val=3D0x13
  serial: speed=3D9600 parity=3DN data=3D8 stop=3D1
  serial: write addr=3D0x02 val=3D0x01
  serial: write addr=3D0x02 val=3D0x81
  serial: read addr=3D0x06 val=3D0xb0
  serial: write addr=3D0x04 val=3D0x09
  serial: read addr=3D0x05 val=3D0x60
  serial: read addr=3D0x06 val=3D0xb0
  serial: write addr=3D0x01 val=3D0x05
  serial: read addr=3D0x02 val=3D0xc1
  serial: read addr=3D0x06 val=3D0xb0
  serial: write addr=3D0x01 val=3D0x05
  serial: write addr=3D0x03 val=3D0x96
  serial: speed=3D9600 parity=3DN data=3D7 stop=3D2
  serial: write addr=3D0x00 val=3D0x60
  serial: speed=3D1200 parity=3DN data=3D7 stop=3D2
  serial: write addr=3D0x01 val=3D0x00
  serial: speed=3D1200 parity=3DN data=3D7 stop=3D2
  serial: write addr=3D0x03 val=3D0x16
  serial: speed=3D1200 parity=3DN data=3D7 stop=3D2
  serial: write addr=3D0x02 val=3D0x01
  serial: write addr=3D0x02 val=3D0x01
  serial: write addr=3D0x04 val=3D0x08
  serial: write addr=3D0x04 val=3D0x09
  serial: write addr=3D0x04 val=3D0x0b
  serial: write addr=3D0x01 val=3D0x07
  serial: read addr=3D0x05 val=3D0x60
  serial: read addr=3D0x06 val=3D0xb0
  serial: write addr=3D0x00 val=3D0x41

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1060928/+subscriptions
