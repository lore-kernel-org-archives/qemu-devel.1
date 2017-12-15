Received: from eggs.gnu.org ([2001:4830:134:3::10]:44584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsrT-0004T2-E4
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:29:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsrS-0007Hl-7n
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:29:23 -0500
Received: from indium.canonical.com ([91.189.90.7]:58252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePsrS-0007Fo-1F
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:29:22 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePsrQ-0006Q3-WC
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:29:21 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F11712E80CC
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:29:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 16:18:19 -0000
From: Thomas Huth <1497204@bugs.launchpad.net>
Reply-To: Bug 1497204 <1497204@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150918100158.14067.83526.malonedeb@chaenomeles.canonical.com>
Message-Id: <151335470074.16309.3582507004367560035.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1497204] Re: qemu-system-s390x: no SMP support
 without KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1497204

Title:
  qemu-system-s390x: no SMP support without KVM

Status in QEMU:
  Fix Released

Bug description:
  It seems SMP support is not implemented for s390x target, at least
  when not running under KVM. There is also no error message when
  starting qemu, it just fails when the kernel tries to bring up the
  CPUs:

  $ qemu-system-s390x -nographic -smp 8 -kernel s390x/kernel.debian =

  [    0.003309] Initializing cgroup subsys cpuset
  [    0.004183] Initializing cgroup subsys cpu
  [    0.004263] Initializing cgroup subsys cpuacct
  [    0.004493] Linux version 3.16.0-4-s390x (debian-kernel@lists.debian.o=
rg) (gcc version 4.8.4 (Debian 4.8.4-1) ) #1 SMP Debian 3.16.7-ckt9-2 (2015=
-04-13)
  [    0.005816] setup: Linux is running under KVM in 64-bit mode
  [    0.007231] setup: Max memory size: 128MB
  [    0.032383] Zone ranges:
  [    0.034115]   DMA      [mem 0x00000000-0x7fffffff]
  [    0.034652]   Normal   empty
  [    0.034686] Movable zone start for each node
  [    0.034737] Early memory node ranges
  [    0.034847]   node   0: [mem 0x00000000-0x07ffffff]
  [    0.047489] PERCPU: Embedded 12 pages/cpu @0000000007f29000 s17920 r81=
92 d23040 u49152
  [    0.049613] Built 1 zonelists in Zone order, mobility grouping on.  To=
tal pages: 32320
  [    0.049802] Kernel command line: =

  [    0.053715] PID hash table entries: 512 (order: 0, 4096 bytes)
  [    0.053993] Dentry cache hash table entries: 16384 (order: 5, 131072 b=
ytes)
  [    0.054330] Inode-cache hash table entries: 8192 (order: 4, 65536 byte=
s)
  [    0.061216] Memory: 115912K/131072K available (5701K kernel code, 847K=
 rwdata, 2512K rodata, 452K init, 776K bss, 15160K reserved)
  [    0.062432] Write protected kernel read-only data: 0x100000 - 0x905fff
  [    0.068906] Hierarchical RCU implementation.
  [    0.068934]  CONFIG_RCU_FANOUT set to non-default value of 32
  [    0.068953]  RCU dyntick-idle grace-period acceleration is enabled.
  [    0.068989]  RCU restricting CPUs from NR_CPUS=3D32 to nr_cpu_ids=3D9.
  [    0.069045] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D9
  [    0.070043] NR_IRQS:260
  [    0.094273] console [ttyS1] enabled
  [    0.095630] pid_max: default: 32768 minimum: 301
  [    0.097792] Security Framework initialized
  [    0.100624] AppArmor: AppArmor disabled by boot time parameter
  [    0.100677] Yama: disabled by default; enable with sysctl kernel.yama.*
  [    0.102466] Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
  [    0.102556] Mountpoint-cache hash table entries: 512 (order: 0, 4096 b=
ytes)
  [    0.116828] Initializing cgroup subsys memory
  [    0.117460] Initializing cgroup subsys devices
  [    0.117678] Initializing cgroup subsys freezer
  [    0.118080] Initializing cgroup subsys net_cls
  [    0.118267] Initializing cgroup subsys blkio
  [    0.118393] Initializing cgroup subsys perf_event
  [    0.118477] Initializing cgroup subsys net_prio
  [    0.119176] ftrace: allocating 17140 entries in 67 pages
  XXX unknown sigp: 0xb
  XXX unknown sigp: 0xb
  XXX unknown sigp: 0xb
  [...]
  XXX unknown sigp: 0xb
  [    0.211835] cpu: 8 configured CPUs, 0 standby CPUs
  XXX unknown sigp: 0xb
  XXX unknown sigp: 0xb
  [endless stream of messages continues until qemu is killed]

  The XXX message is printed by qemu FWIW.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1497204/+subscriptions
