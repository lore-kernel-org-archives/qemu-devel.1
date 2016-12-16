Received: from eggs.gnu.org ([2001:4830:134:3::10]:45034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHoqi-00041Y-CS
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHoqf-0004bZ-8L
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:30:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:40763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cHoqf-0004bC-2N
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:30:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cHoqe-0002ks-52
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 09:30:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 229F62E80C6
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 09:30:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Dec 2016 09:17:18 -0000
From: Thomas Huth <1063807@bugs.launchpad.net>
Reply-To: Bug 1063807 <1063807@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121008142835.25530.46858.malonedeb@gac.canonical.com>
Message-Id: <20161216091718.20061.16382.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1063807] Re: KVM crashes when booting a PointSec
 encrypted Windows 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since this is very likely rather a KVM kernel bug than a QEMU userspace
bug, could you please report it to the KVM mailing list / bug tracker
instead (see http://www.linux-kvm.org/page/Bugs)? Thanks!

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1063807

Title:
  KVM crashes when booting a PointSec encrypted Windows 7

Status in QEMU:
  Invalid

Bug description:
  Hi all,

  KVM crashes each time the VM boots after installing PointSec.

  Steps to reproduce are:
  1) install win7 64bits
  2) install PointSec FDE (Full Disk Encryption =3D> http://www.checkpoint.=
com/products/full-disk-encryption/index.html)
  3) regardless any other qemu parameters, one gets a "KVM internal error. =
Suberror: 1 / emulation failure" error message and a qemu dump like this on=
e:

  KVM internal error. Suberror: 1
  emulation failure
  EAX=3D00000130 EBX=3D00000000 ECX=3D00014000 EDX=3D00050000
  ESI=3D00000000 EDI=3D00000000 EBP=3D00008e3f ESP=3D0001802d
  EIP=3D000006d3 EFL=3D00017087 [--S--PC] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HL=
T=3D0
  ES =3D0048 00000000 ffffffff 00c09300 DPL=3D0 DS [-WA]
  CS =3D25a1 00025a10 0000ffff 00009b00 DPL=3D0 CS16 [-RA]
  SS =3D0040 00028050 ffffffff 00c09300 DPL=3D0 DS [-WA]
  DS =3D0040 00028050 ffffffff 00c09300 DPL=3D0 DS [-WA]
  FS =3D0130 00300000 ffffffff 00c09300 DPL=3D0 DS [-WA]
  GS =3D0040 00028050 ffffffff 00c09300 DPL=3D0 DS [-WA]
  LDT=3D0000 00000000 0000ffff 00008200 DPL=3D0 LDT
  TR =3D0000 00000000 0000ffff 00008b00 DPL=3D0 TSS32-busy
  GDT=3D 00028050 00001dd8
  IDT=3D 00029e40 00000188
  CR0=3D00000011 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
  DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=
=3D0000000000000000
  DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
  EFER=3D0000000000000000
  Code=3D00 8e c0 b8 30 01 8e e0 66 b9 00 00 00 00 66 ba 00 00 00 00 <66> 2=
6 67 8b 9a 00 00 05 00 66 64 67 89 1a 66 83 c2 04 66 41 66 81 f9 00 80 01 0=
0 75 e3 0f

  =

  My system info:
  root@RJZ-LNX:/home/rjz# cat /proc/cpuinfo | tail -24
  cpu family : 6
  model : 37
  model name : Intel(R) Core(TM) i5 CPU M 480 @ 2.67GHz
  stepping : 5
  microcode : 0x2
  cpu MHz : 1199.000
  cache size : 3072 KB
  physical id : 0
  siblings : 4
  core id : 2
  cpu cores : 2
  apicid : 5
  initial apicid : 5
  fpu : yes
  fpu_exception : yes
  cpuid level : 11
  wp : yes
  flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat=
 pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm=
 constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc ape=
rfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse=
4_1 sse4_2 popcnt lahf_lm ida arat dtherm tpr_shadow vnmi flexpriority ept =
vpid
  bogomips : 5319.72
  clflush size : 64
  cache_alignment : 64
  address sizes : 36 bits physical, 48 bits virtual
  power management:


  and qemu (Ubuntu distribution) info is:

  root@RJZ-LNX:/home/rjz# qemu-system-x86_64 --version
  QEMU emulator version 1.0 (qemu-kvm-1.0), Copyright (c) 2003-2008 Fabrice=
 Bellard


  Best regards,
  Rolando.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1063807/+subscriptions
