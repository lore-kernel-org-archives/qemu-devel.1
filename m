Received: from eggs.gnu.org ([2001:4830:134:3::10]:55999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cTU1g-0007aV-3J
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cTU1c-0006Nl-1p
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:42:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1cTU1b-0006N9-MQ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:42:11 -0500
Date: Tue, 17 Jan 2017 13:42:08 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170117134208.GB14855@redhat.com>
References: <20170116195452.23532-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20170116195452.23532-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] i386: Support "-cpu host" on TCG too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 16, 2017 at 05:54:52PM -0200, Eduardo Habkost wrote:
> Change the meaning of "-cpu host" to "enable all features
> supported by the accelerator in the current host", so that it can
> be used to enable/query all features supported by TCG.
> 
> To make sure "host" is still at the end of the list in "-cpu
> help", add a "ordering" field that will be used when sorting the
> CPU model list.

As far as I can tell from light testing, the patch itself works
as advertized.

However a current Fedora debug kernel seems to have a lot of problems
booting on the TCG + -cpu host machine.  See the attached debug
messages.

I'll try it with a non-debug kernel shortly.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=log

./run test-tool/libguestfs-test-tool 
     ************************************************************
     *                    IMPORTANT NOTICE
     *
     * When reporting bugs, include the COMPLETE, UNEDITED
     * output below in your bug report.
     *
     ************************************************************
LIBGUESTFS_PATH=/home/rjones/d/libguestfs/appliance
LIBGUESTFS_CACHEDIR=/home/rjones/d/libguestfs/tmp
LD_LIBRARY_PATH=/home/rjones/d/libguestfs/ruby/ext/guestfs:/home/rjones/d/libguestfs/src/.libs:/home/rjones/d/libguestfs/java/.libs:/home/rjones/d/libguestfs/gobject/.libs
LIBGUESTFS_TMPDIR=/home/rjones/d/libguestfs/tmp
LIBGUESTFS_BACKEND_SETTINGS=force_tcg
LIBGUESTFS_HV=/home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64
LIBGUESTFS_BACKEND=direct
PATH=/home/rjones/d/libguestfs/v2v:/home/rjones/d/libguestfs/tools:/home/rjones/d/libguestfs/test-tool:/home/rjones/d/libguestfs/sysprep:/home/rjones/d/libguestfs/sparsify:/home/rjones/d/libguestfs/resize:/home/rjones/d/libguestfs/rescue:/home/rjones/d/libguestfs/p2v:/home/rjones/d/libguestfs/make-fs:/home/rjones/d/libguestfs/inspector:/home/rjones/d/libguestfs/get-kernel:/home/rjones/d/libguestfs/fuse:/home/rjones/d/libguestfs/format:/home/rjones/d/libguestfs/fish:/home/rjones/d/libguestfs/erlang:/home/rjones/d/libguestfs/edit:/home/rjones/d/libguestfs/diff:/home/rjones/d/libguestfs/dib:/home/rjones/d/libguestfs/df:/home/rjones/d/libguestfs/customize:/home/rjones/d/libguestfs/cat:/home/rjones/d/libguestfs/builder:/home/rjones/d/libguestfs/align:/usr/lib64/qt-3.3/bin:/usr/lib64/ccache:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/home/rjones/.local/bin:/home/rjones/bin
XDG_RUNTIME_DIR=/run/user/1000
SELinux: Enforcing
guestfs_get_append: (null)
guestfs_get_autosync: 1
guestfs_get_backend: direct
guestfs_get_backend_settings: [force_tcg]
guestfs_get_cachedir: /home/rjones/d/libguestfs/tmp
guestfs_get_direct: 0
guestfs_get_hv: /home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64
guestfs_get_memsize: 500
guestfs_get_network: 0
guestfs_get_path: /home/rjones/d/libguestfs/appliance
guestfs_get_pgroup: 0
guestfs_get_program: libguestfs-test-tool
guestfs_get_recovery_proc: 1
guestfs_get_smp: 1
guestfs_get_sockdir: /run/user/1000
guestfs_get_tmpdir: /home/rjones/d/libguestfs/tmp
guestfs_get_trace: 0
guestfs_get_verbose: 1
host_cpu: x86_64
Launching appliance, timeout set to 600 seconds.
libguestfs: launch: program=libguestfs-test-tool
libguestfs: launch: version=1.35.19local,libvirt
libguestfs: launch: backend registered: unix
libguestfs: launch: backend registered: uml
libguestfs: launch: backend registered: libvirt
libguestfs: launch: backend registered: direct
libguestfs: launch: backend=direct
libguestfs: launch: tmpdir=/home/rjones/d/libguestfs/tmp/libguestfswYMKuY
libguestfs: launch: umask=0002
libguestfs: launch: euid=1000
libguestfs: begin building supermin appliance
libguestfs: run supermin
libguestfs: command: run: /home/rjones/d/supermin/src/supermin
libguestfs: command: run: \ --build
libguestfs: command: run: \ --verbose
libguestfs: command: run: \ --if-newer
libguestfs: command: run: \ --lock /home/rjones/d/libguestfs/tmp/.guestfs-1000/lock
libguestfs: command: run: \ --copy-kernel
libguestfs: command: run: \ -f ext2
libguestfs: command: run: \ --host-cpu x86_64
libguestfs: command: run: \ /home/rjones/d/libguestfs/appliance/supermin.d
libguestfs: command: run: \ -o /home/rjones/d/libguestfs/tmp/.guestfs-1000/appliance.d
supermin: version: 5.1.17
supermin: rpm: detected RPM version 4.13
supermin: package handler: fedora/rpm
supermin: acquiring lock on /home/rjones/d/libguestfs/tmp/.guestfs-1000/lock
supermin: if-newer: output does not need rebuilding
libguestfs: finished building supermin appliance
libguestfs: begin testing qemu features
libguestfs: checking for previously cached test results of /home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64, in /home/rjones/d/libguestfs/tmp/.guestfs-1000
libguestfs: loading previously cached test results
libguestfs: qemu version 2.8
libguestfs: finished testing qemu features
libguestfs: command: run: dmesg | grep -Eoh 'lpj=[[:digit:]]+'
libguestfs: read_lpj_from_dmesg: calculated lpj=2594043
[00126ms] /home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64 \
    -global virtio-blk-pci.scsi=off \
    -nodefconfig \
    -enable-fips \
    -nodefaults \
    -display none \
    -machine accel=tcg \
    -cpu host \
    -m 500 \
    -no-reboot \
    -rtc driftfix=slew \
    -no-hpet \
    -global kvm-pit.lost_tick_policy=discard \
    -kernel /home/rjones/d/libguestfs/tmp/.guestfs-1000/appliance.d/kernel \
    -initrd /home/rjones/d/libguestfs/tmp/.guestfs-1000/appliance.d/initrd \
    -object rng-random,filename=/dev/urandom,id=rng0 \
    -device virtio-rng-pci,rng=rng0 \
    -device virtio-scsi-pci,id=scsi \
    -drive file=/home/rjones/d/libguestfs/tmp/libguestfswYMKuY/scratch.1,cache=unsafe,format=raw,id=hd0,if=none \
    -device scsi-hd,drive=hd0 \
    -drive file=/home/rjones/d/libguestfs/tmp/.guestfs-1000/appliance.d/root,snapshot=on,id=appliance,cache=unsafe,if=none,format=raw \
    -device scsi-hd,drive=appliance \
    -device virtio-serial-pci \
    -serial stdio \
    -device sga \
    -chardev socket,path=/run/user/1000/libguestfsgqWsAE/guestfsd.sock,id=channel0 \
    -device virtserialport,chardev=channel0,name=org.libguestfs.channel.0 \
    -append 'panic=1 console=ttyS0 edd=off udevtimeout=6000 udev.event-timeout=6000 no_timer_check lpj=2594043 printk.time=1 cgroup_disable=memory usbcore.nousb cryptomgr.notests tsc=reliable 8250.nr_uarts=1 root=/dev/sdb selinux=0 guestfs_verbose=1 TERM=xterm-256color'
libguestfs: responding to serial console Device Status Report
\x1b[1;256r\x1b[256;256H\x1b[6n
Google, Inc.
Serial Graphics Adapter 11/03/11
SGABIOS $Id$ (pbonzini@yakj.usersys.redhat.com) Thu Nov  3 13:33:51 UTC 2011
Term: 80x24
4 0
\x1b[2J
SeaBIOS (version rel-1.10.1-0-g8891697-prebuilt.qemu-project.org)

Booting from ROM...
\x1b[2J[    0.000000] Linux version 4.8.16-300.fc25.x86_64+debug (mockbuild@bkernel02.phx2.fedoraproject.org) (gcc version 6.3.1 20161221 (Red Hat 6.3.1-1) (GCC) ) #1 SMP Fri Jan 6 17:49:44 UTC 2017
[    0.000000] Command line: panic=1 console=ttyS0 edd=off udevtimeout=6000 udev.eventtimeout=6000 no_timer_check lpj=2594043 printk.time=1 cgroup_disable=memory usbcore.nousb cryptomgr.notests tsc=reliable 8250.nr_uarts=1 root=/dev/sdb selinux=0 guestfs_verbose=1 TERM=xterm-256color
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point re00000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protectiors'
[    0.000000] x86/fpu: xstate_offset[3]:  960, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]: 1024, xstate_sizes[4]:   64
[    0.000000] x86/fpu: xstate_offset[9]: 2688, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x21b, contees, using 'standard' format.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001f3ddfff] usable
[    0.000000] BIOS-e820: [mem 0x000000001f3de000-0x000000001f3fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000ffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] e820: last_pfn = 0x1f3de max_arch_pfn = 0x400000000
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] at [mem 0x000f6aa0-0x000f6aaf] mapped at [ffff8887c00f6aa0]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Using GB pages for direct mapping
[    0.000000] RAMDISK: [mem 0x1f28d000-0x1f3cffff]
[    0.000000] ACPI: Early table checksum verification00000] ACPI: RSDP 0x00000000000F68B0 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x000000001F3E14EF 00002C (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: FACP 0x000000001F3E1403 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.000000] ACPI: DSD0 0013C3 (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: FACS 0x000000001F3E0000 000040
[    0.000000] ACPI: APIC 0x000000001F3E1477 000078 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node0000000-0x000000001f3ddfff]
[    0.000000] NODE_DATA(0) allocated [mem 0x1f276000-0x1f28cfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x000000001f3ddfff]
[    0.0000y
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001f3ddfff]
[    0.0 node 0 [mem 0x0000000000001000-0x000000001f3ddfff]
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bal_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] ACPI: INT_SRC11 global_irq 11 high level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [memff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] e820: [mem 0x1f400000-0xfffbffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on   0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:1024 nr_cpumask_bits:1 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] percpu: Embedded 485 pages/cpu @ffff8887dee00000 s1948120 52
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 125847
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: panic=1 console=ttyS0 edd=off udevtimeout=6000 udev.event-timeout=6000 no_timer_check lpj=2594043 printk.time=1ry usbcore.nousb cryptomgr.notests tsc=reliable 8250.nr_uarts=1 root=/dev/sdb selinux=0 guestfs_verbose=1 TERM=xterm-256color
[    0.000000] PID hash table entries: 2048 (order: 2, 16384 bytes)
[    0.000000] Memory: 462948K/511472K available (9206K kernel code, 1607K rwdata, init, 16516K bss, 48524K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Hierarchical RCU implementation.
[    0.000000] \tRCU lockdep checking is enabled.
[    0.0000ustment of leaf fanout to 64.
[    0.000000] \tRCU restricting CPUs from NR_CPUS=1024 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=1
[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] NR_IRQS:65792 nr_ir00000] \tOffload RCU callbacks from all CPUs
[    0.000000] \tOffload RCU callbacks from CPUs: 0.
[    0.000000] Console: colour *CGA 80x25
[    0.000000] console [ttyS0] enabled
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.0DEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.000000] ... MAX_LOCKDEP_CHAINS:      65536
[    0.0H_SIZE:          32768
[    0.000000]  memory used by lock dependency info: 8671 kB
[    0.000000]  per task-struct memory footprint: 2688 bytes
[    0.000000] BUG: unable to handle kernel paging request at ffffffffffffffff
[    0.000000] IP: [<ffffffffffffffff>] 0xffffffffffffffff
[    0.000000] PGD fe09067 PUD fe0b067 PMD 0 
[    0.000000] Oops: 0010 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffffffffffff>]  [<ffffffffffffffff>] 0xffffffffffffffff
[    0.000000] RSP: 0000:ffff8887dee03ef0  EFLAGS: 00000282
[    0.000000] RAX: 0000000000000000 RBX: 0000000000000012 RCX: ffffffff8ff85cc0
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000010 RDI: ffffffff8fe051d0
[    0.000000] RBP: ffff8887dee03f58 R08: ffffffffffffffff R09: 0000000000000102
[    0.000000] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000011
[    0.000000] R13: 0000000000000012 R14: ffffffff8fe051d0 R15: 0000000000000012
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#2] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>]  [<ffffffff8f02c3b4>] __show_regs+0x254/0x2a0
[    0.000000] RSP: 0000:ffff8887dee03bf8  EFLAGS: 00000002
[    0.000000] RAX: 0000000000010018 RBX: 0000000000000000 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[    0.000000] RBP: ffff8887dee03c58 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffff8fe0d580 R11: 0000000000000096 R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000ffff0ff0
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#3] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>]  [<ffffffff8f02c3b4>] __show_regs+0x254/0x2a0
[    0.000000] RSP: 0000:ffff8887dee03908  EFLAGS: 00000002
[    0.000000] RAX: 0000000000010018 RBX: 0000000000000000 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[    0.000000] RBP: ffff8887dee03968 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffff8fe0d580 R11: 00000000000000a5 R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000ffff0ff0
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#4] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>]  [<ffffffff8f02c3b4>] __show_regs+0x254/0x2a0
[    0.000000] RSP: 0000:ffff8887dee03618  EFLAGS: 00000002
[    0.000000] RAX: 0000000000010018 RBX: 0000000000000000 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[    0.000000] RBP: ffff8887dee03678 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffff8fe0d580 R11: 00000000000000b4 R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000ffff0ff0
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#5] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>]  [<ffffffff8f02c3b4>] __show_regs+0x254/0x2a0
[    0.000000] RSP: 0000:ffff8887dee03328  EFLAGS: 00000002
[    0.000000] RAX: 0000000000010018 RBX: 0000000000000000 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[    0.000000] RBP: ffff8887dee03388 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffff8fe0d580 R11: 00000000000000c3 R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000ffff0ff0
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#6] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>]  [<ffffffff8f02c3b4>] __show_regs+0x254/0x2a0
[    0.000000] RSP: 0000:ffff8887dee03038  EFLAGS: 00000002
[    0.000000] RAX: 0000000000010018 RBX: 0000000000000000 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[    0.000000] RBP: ffff8887dee03098 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffff8fe0d580 R11: 00000000000000d2 R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000ffff0ff0
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#7] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>]  [<ffffffff8f02c3b4>] __show_regs+0x254/0x2a0
[    0.000000] RSP: 0000:ffff8887dee02d48  EFLAGS: 00000002
[    0.000000] RAX: 0000000000010018 RBX: 0000000000000000 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[    0.000000] RBP: ffff8887dee02da8 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffff8fe0d580 R11: 00000000000000e1 R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000ffff0ff0
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#8] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>]  [<ffffffff8f02c3b4>] __show_regs+0x254/0x2a0
[    0.000000] RSP: 0000:ffff8887dee02a58  EFLAGS: 00000002
[    0.000000] RAX: 0000000000010018 RBX: 0000000000000000 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[    0.000000] RBP: ffff8887dee02ab8 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffff8fe0d580 R11: 00000000000000f0 R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000ffff0ff0
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#9] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>]  [<ffffffff8f02c3b4>] __show_regs+0x254/0x2a0
[    0.000000] RSP: 0000:ffff8887dee02768  EFLAGS: 00000002
[    0.000000] RAX: 0000000000010018 RBX: 0000000000000000 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[    0.000000] RBP: ffff8887dee027c8 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffff8fe0d580 R11: 00000000000000ff R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000ffff0ff0
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#10] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>]  [<ffffffff8f02c3b4>] __show_regs+0x254/0x2a0
[    0.000000] RSP: 0000:ffff8887dee02478  EFLAGS: 00000002
[    0.000000] RAX: 0000000000010018 RBX: 0000000000000000 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[    0.000000] RBP: ffff8887dee024d8 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffff8fe0d580 R11: 000000000000010e R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000ffff0ff0
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#11] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>]  [<ffffffff8f02c3b4>] __show_regs+0x254/0x2a0
[    0.000000] RSP: 0000:ffff8887dee02188  EFLAGS: 00000002
[    0.000000] RAX: 0000000000010018 RBX: 0000000000000000 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[    0.000000] RBP: ffff8887dee021e8 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffff8fe0d580 R11: 000000000000011d R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000ffff0ff0
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#12] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>]  [<ffffffff8f02c3b4>] __show_regs+0x254/0x2a0
[    0.000000] RSP: 0000:ffff8887dee01e98  EFLAGS: 00000002
[    0.000000] RAX: 0000000000010018 RBX: 0000000000000000 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[    0.000000] RBP: ffff8887dee01ef8 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffff8fe0d580 R11: 000000000000012c R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000ffff0ff0
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#13] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>]  [<ffffffff8f02c3b4>] __show_regs+0x254/0x2a0
[    0.000000] RSP: 0000:ffff8887dee01ba8  EFLAGS: 00000002
[    0.000000] RAX: 0000000000010018 RBX: 0000000000000000 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[    0.000000] RBP: ffff8887dee01c08 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffff8fe0d580 R11: 000000000000013b R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000ffff0ff0
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#14] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>]  [<ffffffff8f02c3b4>] __show_regs+0x254/0x2a0
[    0.000000] RSP: 0000:ffff8887dee018b8  EFLAGS: 00000002
[    0.000000] RAX: 0000000000010018 RBX: 0000000000000000 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[    0.000000] RBP: ffff8887dee01918 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffff8fe0d580 R11: 000000000000014a R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000ffff0ff0
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#15] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>]  [<ffffffff8f02c3b4>] __show_regs+0x254/0x2a0
[    0.000000] RSP: 0000:ffff8887dee015c8  EFLAGS: 00000002
[    0.000000] RAX: 0000000000010018 RBX: 0000000000000000 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[    0.000000] RBP: ffff8887dee01628 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffff8fe0d580 R11: 0000000000000159 R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000ffff0ff0
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#16] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>]  [<ffffffff8f02c3b4>] __show_regs+0x254/0x2a0
[    0.000000] RSP: 0000:ffff8887dee012d8  EFLAGS: 00000002
[    0.000000] RAX: 0000000000010018 RBX: 0000000000000000 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[    0.000000] RBP: ffff8887dee01338 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffff8fe0d580 R11: 0000000000000168 R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000ffff0ff0
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#17] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>]  [<ffffffff8f02c3b4>] __show_regs+0x254/0x2a0
[    0.000000] RSP: 0000:ffff8887dee00fe8  EFLAGS: 00000002
[    0.000000] RAX: 0000000000010018 RBX: 0000000000000000 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[    0.000000] RBP: ffff8887dee01048 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffff8fe0d580 R11: 0000000000000177 R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000ffff0ff0
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#18] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>]  [<ffffffff8f02c3b4>] __show_regs+0x254/0x2a0
[    0.000000] RSP: 0000:ffff8887dee00cf8  EFLAGS: 00000002
[    0.000000] RAX: 0000000000010018 RBX: 0000000000000000 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[    0.000000] RBP: ffff8887dee00d58 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffff8fe0d580 R11: 0000000000000186 R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000ffff0ff0
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#19] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>]  [<ffffffff8f02c3b4>] __show_regs+0x254/0x2a0
[    0.000000] RSP: 0000:ffff8887dee00a08  EFLAGS: 00000002
[    0.000000] RAX: 0000000000010018 RBX: 0000000000000000 RCX: 0000000000000000
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
[    0.000000] RBP: ffff8887dee00a68 R08: 0000000000000000 R09: 0000000000000001
[    0.000000] R10: ffffffff8fe0d580 R11: 0000000000000195 R12: 0000000000000000
[    0.000000] R13: 0000000000000000 R14: 0000000000000400 R15: 00000000ffff0ff0
[    0.000000] FS:  0000000000000000(0000) GS:ffff8887dee00000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffffffffffffff CR3: 000000000fe06000 CR4: 00000000000406b0
[    0.000000] invalid opcode: 0000 [#20] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.16-300.fc25.x86_64+debug #1
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.1-0-g8891697-prebuilt.qemu-project.org 04/01/2014
[    0.000000] task: ffffffff8fe0d580 task.stack: ffffffff8fe00000
[    0.000000] RIP: 0010:[<ffffffff8f02c3b4>] 
[    0.000000] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: ffffffff8f473aad
[    0.000000] 
[    0.000000] Rebooting in 1 seconds..libguestfs: error: error reading console messages from the appliance: Connection reset by peer
libguestfs: error: appliance closed the connection unexpectedly, see earlier error messages
libguestfs: child_cleanup: 0x55733b084990: child process died
libguestfs: sending SIGTERM to process 18528
libguestfs: qemu maxrss 203360K
libguestfs: error: guestfs_launch failed, see earlier error messages
libguestfs: closing guestfs handle 0x55733b084990 (state 0)
libguestfs: command: run: rm
libguestfs: command: run: \ -rf /home/rjones/d/libguestfs/tmp/libguestfswYMKuY
libguestfs: command: run: rm
libguestfs: command: run: \ -rf /run/user/1000/libguestfsgqWsAE
Makefile:2414: recipe for target 'quickcheck' failed
make: *** [quickcheck] Error 1

--Nq2Wo0NMKNjxTN9z--
