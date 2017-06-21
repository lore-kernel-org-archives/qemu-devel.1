Received: from eggs.gnu.org ([2001:4830:134:3::10]:44822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dNTr3-0005zF-61
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 20:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dNTr0-0002C7-1T
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 20:50:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:60880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dNTqz-0002C3-NV
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 20:50:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dNTqy-0008As-Ep
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 00:50:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 61C872E806B
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 00:50:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Jun 2017 00:32:49 -0000
From: Thomas Huth <1699277@bugs.launchpad.net>
Reply-To: Bug 1699277 <1699277@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149797819499.4157.2941448503406579843.malonedeb@gac.canonical.com>
Message-Id: <149800516953.28970.11755950293948350673.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1699277] Re: qemu-system-s390x: asserts while
 booting Debian Stretch installer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks for the bug report! If you've got a chance to use the latest
development version of QEMU from the git repository instead, could you
please try whether you could also reproduce the problem there? I think
we've already got the fix for this problem in there:

http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D2cf9953beebd194a432ebd

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1699277

Title:
  qemu-system-s390x: asserts while booting Debian Stretch installer

Status in QEMU:
  Fix Committed

Bug description:
  QEMU 2.9.0 (Arch Linux) asserts when I try to install Debian Stretch.

  Steps to reproduce:

  wget http://ftp.debian.org/debian/dists/stretch/main/installer-s390x/curr=
ent/images/generic/initrd.debian
  wget http://ftp.debian.org/debian/dists/stretch/main/installer-s390x/curr=
ent/images/generic/kernel.debian
  qemu-img create -f qcow2 hda.qcow2 80G
  qemu-system-s390x -kernel kernel.debian -initrd initrd.debian -nographic =
-drive file=3Dhda.qcow2

  Output:

  [    0.051915] Linux version 4.9.0-3-s390x (debian-kernel@lists.debian.or=
g) (gcc version 6.3.0 20170516 (Debian 6.3.0-18) ) #1 SMP Debian 4.9.30-2 (=
2017-06-12)
  [    0.053000] setup: Linux is running under KVM in 64-bit mode
  [    0.053780] setup: Max memory size: 128MB
  [    0.067239] Write protected kernel read-only data: 8848k
  [    0.082461] Zone ranges:
  [    0.083717]   DMA      [mem 0x0000000000000000-0x000000007fffffff]
  [    0.084163]   Normal   empty
  [    0.084185] Movable zone start for each node
  [    0.084223] Early memory node ranges
  [    0.084306]   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
  [    0.084468] Initmem setup node 0 [mem 0x0000000000000000-0x0000000007f=
fffff]
  [    0.087697] percpu: Embedded 19 pages/cpu @0000000007f87000 s40704 r81=
92 d28928 u77824
  [    0.088991] Built 1 zonelists in Zone order, mobility grouping on.  To=
tal pages: 32256
  [    0.089108] Kernel command line: =

  [    0.096684] PID hash table entries: 512 (order: 0, 4096 bytes)
  [    0.096853] Dentry cache hash table entries: 16384 (order: 5, 131072 b=
ytes)
  [    0.097041] Inode-cache hash table entries: 8192 (order: 4, 65536 byte=
s)
  [    0.102453] Memory: 105164K/131072K available (6060K kernel code, 802K=
 rwdata, 2784K rodata, 508K init, 648K bss, 25908K reserved, 0K cma-reserve=
d)
  [    0.109112] Hierarchical RCU implementation.
  [    0.109134] 	Build-time adjustment of leaf fanout to 64.
  [    0.109155] 	RCU restricting CPUs from NR_CPUS=3D256 to nr_cpu_ids=3D2.
  [    0.109194] RCU: Adjusting geometry for rcu_fanout_leaf=3D64, nr_cpu_i=
ds=3D2
  [    0.122047] NR_IRQS:3 nr_irqs:3 3
  [    0.124317] clocksource: tod: mask: 0xffffffffffffffff max_cycles: 0x3=
b0a9be803b0a9, max_idle_ns: 1805497147909793 ns
  [    0.138366] console [ttyS1] enabled
  [    0.139126] pid_max: default: 32768 minimum: 301
  [    0.143164] Security Framework initialized
  [    0.143215] Yama: disabled by default; enable with sysctl kernel.yama.*
  [    0.143955] AppArmor: AppArmor disabled by boot time parameter
  [    0.144489] Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
  [    0.144538] Mountpoint-cache hash table entries: 512 (order: 0, 4096 b=
ytes)
  [    0.156937] ftrace: allocating 19165 entries in 75 pages
  [    0.408921] cpu: 1 configured CPUs, 0 standby CPUs
  [    0.433942] Brought up 1 CPUs
  [    0.451811] devtmpfs: initialized
  [    0.467021] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 7645041785100000 ns
  [    0.467549] futex hash table entries: 512 (order: 5, 131072 bytes)
  [    0.476626] NET: Registered protocol family 16
  [    0.482575] The s390-virtio transport is deprecated. Please switch to =
a modern host providing virtio-ccw.
  [    0.693017] VFS: Disk quotas dquot_6.6.0
  [    0.693296] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 by=
tes)
  [    0.695029] hugetlbfs: disabling because there are no supported hugepa=
ge sizes
  [    0.703040] NET: Registered protocol family 2
  [    0.709803] TCP established hash table entries: 1024 (order: 1, 8192 b=
ytes)
  [    0.710003] TCP bind hash table entries: 1024 (order: 2, 16384 bytes)
  [    0.710134] TCP: Hash tables configured (established 1024 bind 1024)
  [    0.710879] UDP hash table entries: 256 (order: 1, 8192 bytes)
  [    0.711005] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
  [    0.712409] NET: Registered protocol family 1
  [    0.717432] Unpacking initramfs...
  [    1.308935] random: fast init done
  [    1.597369] Freeing initrd memory: 10152K (0000000000f90000 - 00000000=
0197a000)
  [    1.600200] hypfs: The hardware system does not support hypfs
  [    1.601718] hypfs: Initialization of hypfs failed with rc=3D-61
  [    1.605317] audit: initializing netlink subsys (disabled)
  [    1.606211] audit: type=3D2000 audit(1497977949.601:1): initialized
  [    1.611137] workingset: timestamp_bits=3D46 max_order=3D15 bucket_orde=
r=3D0
  [    1.612066] zbud: loaded
  [    1.642108] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 252)
  [    1.643111] io scheduler noop registered
  [    1.643160] io scheduler deadline registered
  [    1.643383] io scheduler cfq registered (default)
  [    1.644143] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
  [    1.644221] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
  [    1.645626] hvc_iucv: The z/VM IUCV HVC device driver cannot be used w=
ithout z/VM
  [    1.647547] mousedev: PS/2 mouse device common for all mice
  [    1.649359] ledtrig-cpu: registered to indicate activity on CPUs
  [    1.649884] cio: Channel measurement facility initialized using format=
 extended (mode autodetected)
  [    1.657228] NET: Registered protocol family 10
  [    1.663924] mip6: Mobile IPv6
  [    1.664068] NET: Registered protocol family 17
  [    1.664195] mpls_gso: MPLS GSO support
  [    1.667936] registered taskstats version 1
  [    1.669547] zswap: loaded using pool lzo/zbud
  [    1.674474] ima: No TPM chip found, activating TPM-bypass!
  [    1.739953] Freeing unused kernel memory: 508K (0000000000a6f000 - 000=
0000000aee000)
  [    1.740381] Write protected read-only-after-init data: 4k
  **
  ERROR:/build/qemu/src/qemu-2.9.0/translate-common.c:34:tcg_handle_interru=
pt: assertion failed: (qemu_mutex_iothread_locked())
  [1]    13880 abort (core dumped)  qemu-system-s390x -kernel kernel.debian=
 -initrd initrd.debian -nographic =


  Trace:
  #0  0x00007ffff10fb670 in raise () at /usr/lib/libc.so.6
  #1  0x00007ffff10fcd00 in abort () at /usr/lib/libc.so.6
  #2  0x00007ffff35dfc9d in g_assertion_message () at /usr/lib/libglib-2.0.=
so.0
  #3  0x00007ffff35dfd2a in g_assertion_message_expr () at /usr/lib/libglib=
-2.0.so.0
  #4  0x00005555556abb84 in  ()
  #5  0x000055555572ab73 in css_adapter_interrupt ()
  #6  0x000055555571be68 in virtio_notify ()
  #7  0x00005555556f84ce in  ()
  #8  0x00005555556f9afd in  ()
  #9  0x00005555556fa78f in virtio_blk_handle_vq ()
  #10 0x000055555571b7f1 in virtio_queue_notify ()
  #11 0x000055555572ceb7 in  ()
  #12 0x0000555555726f86 in s390_virtio_hypercall ()
  #13 0x0000555555752c85 in helper_diag ()
  #14 0x00007fffe46664bf in code_gen_buffer ()
  #15 0x00005555556ab2f5 in cpu_exec ()
  #16 0x00005555556ce08d in  ()
  #17 0x00007ffff1474297 in start_thread () at /usr/lib/libpthread.so.0
  #18 0x00007ffff11b525f in clone () at /usr/lib/libc.so.6

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1699277/+subscriptions
