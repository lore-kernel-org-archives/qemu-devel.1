Received: from eggs.gnu.org ([2001:4830:134:3::10]:46175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eyUh3-0006oA-Og
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eyUgy-0002ec-VB
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:45:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:59980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eyUgy-0002e0-Ob
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:45:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eyUgx-0005R0-Mi
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 03:45:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AA9C42E8042
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 03:45:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Mar 2018 03:37:56 -0000
From: piersh <1757323@bugs.launchpad.net>
Reply-To: Bug 1757323 <1757323@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152160343164.22698.3488159788073699285.malonedeb@soybean.canonical.com>
Message-Id: <152160347702.25755.5801190147114518805.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1757323] Re: blue screen running windows 10
 install DVD on qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

i should add: i do NOT get these crashes if I boot the same image on the
host bare-metal.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1757323

Title:
  blue screen running windows 10 install DVD on qemu

Status in QEMU:
  New

Bug description:
  i get a blue screen at the first screen of the windows 10 DVD setup
  (Win10_1709_English_x64.iso, available from MS).

  The DVD boots fine, and gets to the first dialog: http://codewithoutborde=
rs.com/posted/qemu1.png
  and then if i just wait a minute of so it blue screen's.
  either DRIVER IRQL NOT LESS OR EQUAL: http://codewithoutborders.com/poste=
d/qemu2.png
  or KMODE EXCEPTION NOT HANDLED: http://codewithoutborders.com/posted/qemu=
3.png


  =

  the qemu command-line is:

  /usr/bin/qemu-system-x87_64 \
   -boot strict=3Don \
   -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-gen=
eric/monitor.sock,server,nowait \
   -chardev spicevmc,id=3Dcharchannel0,name=3Dvdagent \
   -cpu core2duo,+lahf_lm,+pdcm,+xtpr,+cx16,+tm2,+est,+vmx,+ds_cpl,+dtes64,=
+pbe,+tm,+ht,+ss,+acpi,+ds,kvm=3Doff \
   -device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x6.0x7 \
   -device ich9-usb-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multi=
function=3Don,addr=3D0x6 \
   -device ich9-usb-uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=
=3D0x6.0x1 \
   -device ich9-usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=
=3D0x6.0x2 \
   -device ide-cd,bus=3Dide.0,unit=3D1,drive=3Ddrive-ide0-0-1,id=3Dide0-0-1=
,bootindex=3D1 \
   -device qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vga=
mem_mb=3D16,bus=3Dpci.0,addr=3D0x2 \
   -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x7 \
   -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x5 \
   -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchann=
el0,id=3Dchannel0,name=3Dcom.redhat.spice.0 \
   -drive file=3D/mnt/ISOs/Win10_1709_English_x64.iso,format=3Draw,if=3Dnon=
e,id=3Ddrive-ide0-0-1,readonly=3Don \
   -global kvm-pit.lost_tick_policy=3Ddiscard \
   -global PIIX4_PM.disable_s3=3D1 \
   -global PIIX4_PM.disable_s4=3D1 \
   -m 4096 \
   -machine pc-i440fx-xenial,accel=3Dtcg,usb=3Doff \
   -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol \
   -msg timestamp=3Don \
   -name generic \
   -nodefaults \
   -no-hpet \
   -no-shutdown \
   -no-user-config \
   -realtime mlock=3Doff \
   -rtc base=3Dutc,driftfix=3Dslew \
   -S \
   -smp 2,sockets=3D2,cores=3D1,threads=3D1 \
   -spice port=3D5900,addr=3D127.0.0.1,disable-ticketing,image-compression=
=3Doff,seamless-migration=3Don \
   -uuid 3902a801-42dd-4bf2-8f3a-cbc68f4f8564

  =

  $ /usr/bin/qemu-system-x87_64 --version
  QEMU emulator version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.24), Copyright (=
c) 2003-2008 Fabrice Bellard

  $ uname -a
  Linux host 4.13.0-37-generic #42~16.04.1-Ubuntu SMP Wed Mar 7 16:03:28 UT=
C 2018 x86_64 x86_64 x86_64 GNU/Linux

  $ cat /proc/cpuinfo =

  processor	: 0
  vendor_id	: GenuineIntel
  cpu family	: 6
  model		: 15
  model name	: Intel(R) Core(TM)2 Quad CPU           @ 2.66GHz
  stepping	: 7
  microcode	: 0x66
  cpu MHz		: 2671.406
  cache size	: 4096 KB
  physical id	: 0
  siblings	: 4
  core id		: 0
  cpu cores	: 4
  apicid		: 0
  initial apicid	: 0
  fpu		: yes
  fpu_exception	: yes
  cpuid level	: 10
  wp		: yes
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm const=
ant_tsc arch_perfmon pebs bts rep_good nopl cpuid aperfmperf pni dtes64 mon=
itor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm lahf_lm pti retpoline tpr_shad=
ow dtherm
  bugs		: cpu_meltdown spectre_v1 spectre_v2
  bogomips	: 5342.81
  clflush size	: 64
  cache_alignment	: 64
  address sizes	: 36 bits physical, 48 bits virtual
  power management:

  ... 3 more times

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1757323/+subscriptions
