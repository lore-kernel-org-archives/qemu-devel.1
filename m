Received: from eggs.gnu.org ([2001:4830:134:3::10]:33078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1enGcj-0007FH-Js
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 23:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1enGcg-0000Td-Vv
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 23:30:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:32994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1enGcg-0000Sl-PW
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 23:30:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1enGcf-0008Jx-Dl
	for <qemu-devel@nongnu.org>; Sun, 18 Feb 2018 04:30:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 673532E80C9
	for <qemu-devel@nongnu.org>; Sun, 18 Feb 2018 04:30:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Feb 2018 04:17:33 -0000
From: Launchpad Bug Tracker <1202289@bugs.launchpad.net>
Reply-To: Bug 1202289 <1202289@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130717162048.20408.57161.malonedeb@gac.canonical.com>
Message-Id: <151892745413.17410.16924014947265879904.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1202289] Re: Windows 2008/7 Guest to Guest Very
 slow 10-20Mbit/s
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
https://bugs.launchpad.net/bugs/1202289

Title:
  Windows 2008/7 Guest to Guest Very slow 10-20Mbit/s

Status in QEMU:
  Expired

Bug description:
  I'm not sure if I'm submitting this to the proper place or not, if
  not, please direct me accordingly.

  At this point I'm starting to get desperate, I'll take any options or
  suggestions that spring to mind:

  Anyway, the problem exists on multiple hosts of various quality.
  From 4 core 8g mem machines to 12 core 64Gig mem machines with LVM and
  Raid-10.

  Using iperf as the testing utility: (windows guest can be either Windows =
7 or 2008R2)
  -Windows Guest -> Windows Guest averages 20Mbit/s (The problem)
  -Windows Guest -> Host averages 800Mbit/s
  -Host -> Windows Guest averages 1.1Gbit/s
  -Linux Guest -> Host averages 12GBit/s
  -Linux Guest -> Linux Guest averages 10.2Gbit/s

  For windows guests, switching between e1000 and virtio drivers doesn't
  make much of a difference.

  I use openvswitch to handle the bridging (makes bonding nics much
  easier)

  Disabling TSO GRO on all the host nics, and virtual nics, as well as modd=
ing the registry using:
  netsh int tcp set global (various params here)  can slightly improve Wind=
ows -> windows throughput.   up to maybe 100Mbit/s    but even that is spot=
ty at best.

  The Particulars of the fastest host which benchmarks about the same as
  the slowest host.

  Ubuntu 12.04 64bit (updated to lastest as of  July 15th)
  Linux cckvm03 3.5.0-36-generic #57~precise1-Ubuntu SMP Thu Jun 20 18:21:0=
9 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux

  libvirt: =

  Source: libvirt
  Version: 0.9.8-2ubuntu17.10

  qemu-kvm
  Package: qemu-kvm
  Version: 1.0+noroms-0ubuntu14.8
  Replaces: kvm (<< 1:84+dfsg-0ubuntu16+0.11.0), kvm-data, qemu

  openvswitch
  Source: openvswitch
  Version: 1.4.0-1ubuntu1.5

  /proc/cpuifo

  processor       : 0
  vendor_id       : GenuineIntel
  cpu family      : 6
  model           : 45
  model name      : Intel(R) Xeon(R) CPU E5-2440 0 @ 2.40GHz
  stepping        : 7
  microcode       : 0x70d
  cpu MHz         : 2400.226
  cache size      : 15360 KB
  physical id     : 0
  siblings        : 12
  core id         : 0
  cpu cores       : 6
  apicid          : 0
  initial apicid  : 0
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 13
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mc=
a cmov
  pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe=
1gb rdt
  scp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop=
_tsc ap
  erfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 x=
tpr pdc
  m pcid dca sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx l=
ahf_lm
  ida arat xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
  bogomips        : 4800.45
  clflush size    : 64
  cache_alignment : 64
  address sizes   : 46 bits physical, 48 bits virtual
  power management:

  =

  -Sample KVM line
  usr/bin/kvm -S -M pc-1.0 -enable-kvm -m 4096 -smp 2,sockets=3D2,cores=3D1=
,threads=3D1 -name gvexch01 -uuid d28ffb4b-d809-3b40-ae3d-2925e6995394 -nod=
efconfig -nodefaults -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvi=
rt/qemu/gvexch01.monitor,server,nowait -mon chardev=3Dcharmonitor,id=3Dmoni=
tor,mode=3Dcontrol -rtc base=3Dlocaltime -no-shutdown -boot order=3Ddc,menu=
=3Don -drive file=3D/dev/vgroup/gvexch01,if=3Dnone,id=3Ddrive-virtio-disk0,=
format=3Draw,cache=3Dnone,aio=3Dnative -device virtio-blk-pci,bus=3Dpci.0,a=
ddr=3D0x4,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0 -drive file=3D/dev/v=
group/gvexch01-d,if=3Dnone,id=3Ddrive-virtio-disk1,format=3Draw,cache=3Dnon=
e -device virtio-blk-pci,bus=3Dpci.0,addr=3D0x6,drive=3Ddrive-virtio-disk1,=
id=3Dvirtio-disk1 -drive if=3Dnone,media=3Dcdrom,id=3Ddrive-ide0-0-0,readon=
ly=3Don,format=3Draw -device ide-drive,bus=3Dide.0,unit=3D0,drive=3Ddrive-i=
de0-0-0,id=3Dide0-0-0 -netdev tap,fd=3D18,id=3Dhostnet0,vhost=3Don,vhostfd=
=3D21 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:bf:=
4e:1c,bus=3Dpci.0,addr=3D0x3 -chardev pty,id=3Dcharserial0 -device isa-seri=
al,chardev=3Dcharserial0,id=3Dserial0 -usb -device usb-tablet,id=3Dinput0 -=
vnc 127.0.0.1:2 -vga std -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci=
.0,addr=3D0x5

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1202289/+subscriptions
