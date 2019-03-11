Received: from eggs.gnu.org ([209.51.188.92]:42877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <me@carlosedp.com>) id 1h3MxC-0007LL-NN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <me@carlosedp.com>) id 1h3Mx3-0003mq-9w
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:35:00 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <me@carlosedp.com>) id 1h3Mx1-0003ii-Bo
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:34:52 -0400
Received: by mail-ot1-x341.google.com with SMTP id i12so4299567otp.12
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 08:34:45 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com.
	[209.85.167.179])
	by smtp.gmail.com with ESMTPSA id z5sm2439362otm.14.2019.03.11.08.34.42
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 Mar 2019 08:34:43 -0700 (PDT)
Sender: Carlos de Paula <carlosedp@carlosedp.com>
Received: by mail-oi1-f179.google.com with SMTP id e7so3980438oia.8
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 08:34:42 -0700 (PDT)
MIME-Version: 1.0
From: Carlos Eduardo de Paula <me@carlosedp.com>
Date: Mon, 11 Mar 2019 12:34:31 -0300
Message-ID: <CADnnUqeL+CxiAXzC_cXJcxWY_KKtXWnLfL0AwOFzi6rWrZcD2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Freezes on Qemu 3.1 using latest Glib 2.60.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I currently use Qemu on Mac via Homebrew and recently updated the packages
which included Glib to 2.60.0.

This update broke Qemu 3.1 that now freezes while booting a VM. On 2.58.3
Qemu worked perfectly.

Qemu was launched with:

qemu-system-riscv64 \    -nographic \    -machine virt \    -smp 4 \
 -m 4G \    -kernel bbl-kernel-5.0.1.riscv64 \    -object
rng-random,filename=/dev/urandom,id=rng0 \    -device
virtio-rng-device,rng=rng0 \    -append "console=ttyS0 rw
root=/dev/vda" \    -device virtio-blk-device,drive=hd0 \    -drive
file=debian-latest.qcow2,format=qcow2,id=hd0 \    -device
virtio-net-device,netdev=usernet \    -netdev
user,id=usernet,hostfwd=tcp::22222-:22

It's boot logs are:

[    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000[
   0.000000] No DTB passed to the kernel[    0.000000] Linux version
5.0.1 (carlosedp@DietPi) (gcc version 8.2.0 (Debian 8.2.0-11)) #5 SMP
Sun Mar 10 21:28:05 -03 2019[    0.000000] initrd not found or empty -
disabling initrd[    0.000000] Zone ranges:[    0.000000]   DMA32
[mem 0x0000000080200000-0x00000000ffffffff][    0.000000]   Normal
[mem 0x0000000100000000-0x000000017fffffff][    0.000000] Movable zone
start for each node[    0.000000] Early memory node ranges[
0.000000]   node   0: [mem 0x0000000080200000-0x000000017fffffff][
0.000000] Initmem setup node 0 [mem
0x0000000080200000-0x000000017fffffff][    0.000000] software IO TLB:
mapped [mem 0xfbfff000-0xfffff000] (64MB)[    0.000000] elf_hwcap is
0x112d[    0.000000] percpu: Embedded 17 pages/cpu @(____ptrval____)
s30488 r8192 d30952 u69632[    0.000000] Built 1 zonelists, mobility
grouping on.  Total pages: 1031688[    0.000000] Kernel command line:
console=ttyS0 rw root=/dev/vda[    0.000000] Dentry cache hash table
entries: 524288 (order: 10, 4194304 bytes)[    0.000000] Inode-cache
hash table entries: 262144 (order: 9, 2097152 bytes)[    0.000000]
Sorting __ex_table...[    0.000000] Memory: 4045120K/4192256K
available (5951K kernel code, 397K rwdata, 1852K rodata, 201K init,
814K bss, 147136K reserved, 0K cma-reserved)[    0.000000] SLUB:
HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1[    0.000000]
rcu: Hierarchical RCU implementation.[    0.000000] rcu: 	RCU
restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.[    0.000000] rcu:
RCU calculated value of scheduler-enlistment delay is 25 jiffies.[
0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16,
nr_cpu_ids=4[    0.000000] NR_IRQS: 0, nr_irqs: 0, preallocated irqs:
0[    0.000000] plic: mapped 10 interrupts to 4 (out of 8) handlers.[
  0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff
max_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns[    0.000088]
sched_clock: 64 bits at 10MHz, resolution 100ns, wraps every
4398046511100ns[    0.002296] Console: colour dummy device 80x25[
0.003253] Calibrating delay loop (skipped), value calculated using
timer frequency.. 20.00 BogoMIPS (lpj=40000)[    0.003367] pid_max:
default: 32768 minimum: 301[    0.004376] Mount-cache hash table
entries: 8192 (order: 4, 65536 bytes)[    0.004474] Mountpoint-cache
hash table entries: 8192 (order: 4, 65536 bytes)[    0.027119] rcu:
Hierarchical SRCU implementation.[    0.032202] smp: Bringing up
secondary CPUs ...[    0.041773] smp: Brought up 1 node, 4 CPUs[
0.066270] devtmpfs: initialized[    0.071293] random: get_random_u32
called from bucket_table_alloc+0x76/0x182 with crng_init=0[
0.073326] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns[    0.073476] futex hash
table entries: 1024 (order: 4, 65536 bytes)[    0.078168] NET:
Registered protocol family 16[    0.106061] vgaarb: loaded[
0.106733] SCSI subsystem initialized[    0.108768] usbcore: registered
new interface driver usbfs[    0.109006] usbcore: registered new
interface driver hub[    0.110238] usbcore: registered new device
driver usb[    0.116919] clocksource: Switched to clocksource
riscv_clocksource[    0.117678] VFS: Disk quotas dquot_6.6.0[
0.117849] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
bytes)[    0.150760] NET: Registered protocol family 2[    0.157190]
tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768
bytes)[    0.157345] TCP established hash table entries: 32768 (order:
6, 262144 bytes)[    0.158250] TCP bind hash table entries: 32768
(order: 7, 524288 bytes)[    0.158829] TCP: Hash tables configured
(established 32768 bind 32768)[    0.159971] UDP hash table entries:
2048 (order: 4, 65536 bytes)[    0.160209] UDP-Lite hash table
entries: 2048 (order: 4, 65536 bytes)[    0.162046] NET: Registered
protocol family 1[    0.164895] RPC: Registered named UNIX socket
transport module.[    0.164945] RPC: Registered udp transport module.[
   0.164978] RPC: Registered tcp transport module.[    0.165010] RPC:
Registered tcp NFSv4.1 backchannel transport module.[    0.165078]
NET: Registered protocol family 44[    0.171287] Initialise system
trusted keyrings[    0.172360] workingset: timestamp_bits=46
max_order=20 bucket_order=0[    0.184327] NFS: Registering the
id_resolver key type[    0.184521] Key type id_resolver registered[
0.184574] Key type id_legacy registered[    0.184685]
nfs4filelayout_init: NFSv4 File Layout Driver Registering...[
0.206251] NET: Registered protocol family 38[    0.206373] Key type
asymmetric registered[    0.206441] Asymmetric key parser 'x509'
registered[    0.206657] Block layer SCSI generic (bsg) driver version
0.4 loaded (major 254)[    0.207634] io scheduler mq-deadline
registered[    0.207724] io scheduler kyber registered[    0.395426]
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled[    0.402464]
printk: console [ttyS0] disabled[    0.403093] 10000000.uart: ttyS0 at
MMIO 0x10000000 (irq = 10, base_baud = 230400) is a 16550A[
0.420181] printk: console [ttyS0] enabled

And freezes at that point. Nothing else was changed, only the Glib version.
Qemu is built on Homebrew by this formula:
https://github.com/Homebrew/homebrew-core/blob/master/Formula/glib.rb

I tried rebuilding Qemu from source after updating to 2.60.0 but got same
problem.

Thanks

-- 
________________________________________
*Carlos Eduardo de Paula*
me@carlosedp.com
http://carlosedp.com
http://twitter.com/carlosedp
Linkedin <http://br.linkedin.com/in/carlosedp>
________________________________________
