Received: from eggs.gnu.org ([209.51.188.92]:43091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gtJYc-0006n8-EF
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 16:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gtJYZ-0007tI-9A
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 16:56:06 -0500
Received: from indium.canonical.com ([91.189.90.7]:34866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gtJYW-0007gO-I3
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 16:56:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gtJY7-0002yd-3g
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 21:55:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 19C632E80C9
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 21:55:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Feb 2019 21:50:00 -0000
From: liang yan <lyan@suse.com>
Reply-To: Bug 1815143 <1815143@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154957727033.18791.11498118265359264370.malonedeb@soybean.canonical.com>
Message-Id: <154992180100.19096.11877301553291167380.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1815143] Re: qemu-system-s390x fails when running
 without kvm: fatal: EXECUTE on instruction prefix 0x7f4 not implemented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A little bit confused here, I tired to bisect it from 2.10, but it was
always good from this branch. then I went back to 2.9.1, it was always
crashed. Machine type related?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815143

Title:
   qemu-system-s390x fails when running without kvm: fatal: EXECUTE on
  instruction prefix 0x7f4 not implemented

Status in QEMU:
  Incomplete

Bug description:
  just wondering if TCG implements instruction prefix 0x7f4

  server3:~ # zcat /boot/vmlinux-4.4.162-94.72-default.gz > /tmp/kernel

  --> starting qemu with kvm enabled works fine
  server3:~ # qemu-system-s390x -nographic -kernel /tmp/kernel -initrd /boo=
t/initrd -enable-kvm
  Initializing cgroup subsys cpuset
  Initializing cgroup subsys cpu
  Initializing cgroup subsys cpuacct
  Linux version 4.4.162-94.72-default (geeko@buildhost) (gcc version 4.8.5 =
(SUSE Linux) ) #1 SMP Mon Nov 12 18:57:45 UTC 2018 (9de753f)
  setup.289988: Linux is running under KVM in 64-bit mode
  setup.b050d0: The maximum memory size is 128MB
  numa.196305: NUMA mode: plain
  Write protected kernel read-only data: 8692k
  [...]

  --> but starting qemu without kvm enabled works fails
  server3:~ # qemu-system-s390x -nographic -kernel /tmp/kernel -initrd /boo=
t/initrd =

  qemu: fatal: EXECUTE on instruction prefix 0x7f4 not implemented

  PSW=3Dmask 0000000180000000 addr 000000000067ed6e cc 00
  R00=3D0000000080000000 R01=3D000000000067ed76 R02=3D0000000000000000 R03=
=3D0000000000000000
  R04=3D0000000000111548 R05=3D0000000000000000 R06=3D0000000000000000 R07=
=3D0000000000000000
  R08=3D00000000000100f6 R09=3D0000000000000000 R10=3D0000000000000000 R11=
=3D0000000000000000
  R12=3D0000000000ae2000 R13=3D0000000000681978 R14=3D0000000000111548 R15=
=3D000000000000bef0
  F00=3D0000000000000000 F01=3D0000000000000000 F02=3D0000000000000000 F03=
=3D0000000000000000
  F04=3D0000000000000000 F05=3D0000000000000000 F06=3D0000000000000000 F07=
=3D0000000000000000
  F08=3D0000000000000000 F09=3D0000000000000000 F10=3D0000000000000000 F11=
=3D0000000000000000
  F12=3D0000000000000000 F13=3D0000000000000000 F14=3D0000000000000000 F15=
=3D0000000000000000
  V00=3D00000000000000000000000000000000 V01=3D0000000000000000000000000000=
0000
  V02=3D00000000000000000000000000000000 V03=3D0000000000000000000000000000=
0000
  V04=3D00000000000000000000000000000000 V05=3D0000000000000000000000000000=
0000
  V06=3D00000000000000000000000000000000 V07=3D0000000000000000000000000000=
0000
  V08=3D00000000000000000000000000000000 V09=3D0000000000000000000000000000=
0000
  V10=3D00000000000000000000000000000000 V11=3D0000000000000000000000000000=
0000
  V12=3D00000000000000000000000000000000 V13=3D0000000000000000000000000000=
0000
  V14=3D00000000000000000000000000000000 V15=3D0000000000000000000000000000=
0000
  V16=3D00000000000000000000000000000000 V17=3D0000000000000000000000000000=
0000
  V18=3D00000000000000000000000000000000 V19=3D0000000000000000000000000000=
0000
  V20=3D00000000000000000000000000000000 V21=3D0000000000000000000000000000=
0000
  V22=3D00000000000000000000000000000000 V23=3D0000000000000000000000000000=
0000
  V24=3D00000000000000000000000000000000 V25=3D0000000000000000000000000000=
0000
  V26=3D00000000000000000000000000000000 V27=3D0000000000000000000000000000=
0000
  V28=3D00000000000000000000000000000000 V29=3D0000000000000000000000000000=
0000
  V30=3D00000000000000000000000000000000 V31=3D0000000000000000000000000000=
0000
  C00=3D0000000000000000 C01=3D0000000000000000 C02=3D0000000000000000 C03=
=3D0000000000000000
  C04=3D0000000000000000 C05=3D0000000000000000 C06=3D0000000000000000 C07=
=3D0000000000000000
  C08=3D0000000000000000 C09=3D0000000000000000 C10=3D0000000000000000 C11=
=3D0000000000000000
  C12=3D0000000000000000 C13=3D0000000000000000 C14=3D0000000000000000 C15=
=3D0000000000000000

  Aborted (core dumped)

  =

  server3:~ # lscpu
  Architecture:          s390x
  CPU op-mode(s):        32-bit, 64-bit
  Byte Order:            Big Endian
  CPU(s):                2
  On-line CPU(s) list:   0,1
  Thread(s) per core:    1
  Core(s) per socket:    1
  Socket(s) per book:    1
  Book(s) per drawer:    1
  Drawer(s):             2
  NUMA node(s):          1
  Vendor ID:             IBM/S390
  Machine type:          2964
  BogoMIPS:              20325.00
  Hypervisor:            z/VM 6.4.0
  Hypervisor vendor:     IBM
  Virtualization type:   full
  Dispatching mode:      horizontal
  L1d cache:             128K
  L1i cache:             96K
  L2d cache:             2048K
  L2i cache:             2048K
  L3 cache:              65536K
  L4 cache:              491520K
  NUMA node0 CPU(s):     0-63
  Flags:                 esan3 zarch stfle msa ldisp eimm dfp edat etf3eh h=
ighgprs te vx sie
  server3:~ # uname -a
  Linux server3 4.4.126-94.22-default #1 SMP Wed Apr 11 07:45:03 UTC 2018 (=
9649989) s390x s390x s390x GNU/Linux
  server3:~ #

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1815143/+subscriptions
