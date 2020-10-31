Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CCEC388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 13:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D299B2071A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 13:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D299B2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYr8n-000311-Mn
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 09:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kYr7p-0002YL-83
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 09:40:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:47874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kYr7l-00052U-0l
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 09:40:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kYr7i-0000uB-Kq
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 13:40:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6A2822E813A
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 13:40:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2020 13:35:44 -0000
From: Germano Massullo <1902365@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: germano.massullo
X-Launchpad-Bug-Reporter: Germano Massullo (germano.massullo)
X-Launchpad-Bug-Modifier: Germano Massullo (germano.massullo)
Message-Id: <160415134441.32721.13907448081294609819.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1902365] [NEW] 3x 100% host CPU core usage while virtual machine
 is in idle
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="96ff31b88b65a0d0ea73b89333fe7c4a2669d8fb"; Instance="production"
X-Launchpad-Hash: 66d2e5d9be77e80ac20ea395dc5e675340964da7
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 09:40:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1902365 <1902365@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

My Fedora 33 machine "top" command shows qemu-system-x86_64 process
using ~300% CPU, that means 3x CPU cores at 100%. Since the virtual
machine (named CentOS 8) is almost in idle (top command inside the VM
shows ~0% CPU usage), there must be something wrong. I attach qemu
process GDB backtrace, and virtual machine libvirt XML

Host details:
libvirt-6.6.0-2.fc33.x86_64
qemu-system-x86-5.1.0-5.fc33.x86_64
virt-manager-3.1.0-1.fc33.noarch
kernel 5.8.16-300.fc33.x86_64
CPU: AMD Ryzen 5 3600

# gdb qemu-system-x86_64 405756
GNU gdb (GDB) Fedora 9.2-7.fc33
Copyright (C) 2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-redhat-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from qemu-system-x86_64...
Reading symbols from .gnu_debugdata for /usr/bin/qemu-system-x86_64...
(No debugging symbols found in .gnu_debugdata for /usr/bin/qemu-system-x86_=
64)
Attaching to program: /usr/bin/qemu-system-x86_64, process 405756
[New LWP 405788]
[New LWP 405798]
[New LWP 405799]
[New LWP 405800]
[New LWP 405801]
[New LWP 405802]
[New LWP 405804]
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
0x00007f549d0bdb0e in ppoll () from target:/lib64/libc.so.6
(gdb) set height 0
(gdb) set print elements 0
(gdb) set print frame-arguments all
(gdb) thread apply all backtrace

Thread 8 (Thread 0x7f53837ff640 (LWP 405804)):
#0  0x00007f549d0bda0f in poll () from target:/lib64/libc.so.6
#1  0x00007f549e4c2d1e in g_main_context_iterate.constprop () from target:/=
lib64/libglib-2.0.so.0
#2  0x00007f549e4716ab in g_main_loop_run () from target:/lib64/libglib-2.0=
.so.0
#3  0x00007f549dcfcc66 in red_worker_main.lto_priv () from target:/lib64/li=
bspice-server.so.1
#4  0x00007f549d19c3f9 in start_thread () from target:/lib64/libpthread.so.0
#5  0x00007f549d0c8b03 in clone () from target:/lib64/libc.so.6

Thread 7 (Thread 0x7f5390dfd640 (LWP 405802)):
#0  0x00007f549d0bf58b in ioctl () from target:/lib64/libc.so.6
#1  0x000055a60728ec87 in kvm_vcpu_ioctl ()
#2  0x000055a60728edc1 in kvm_cpu_exec ()
#3  0x000055a60734dc04 in qemu_kvm_cpu_thread_fn ()
#4  0x000055a6076dc0ff in qemu_thread_start ()
#5  0x00007f549d19c3f9 in start_thread () from target:/lib64/libpthread.so.0
#6  0x00007f549d0c8b03 in clone () from target:/lib64/libc.so.6

Thread 6 (Thread 0x7f53915fe640 (LWP 405801)):
#0  0x00007f549d0bf58b in ioctl () from target:/lib64/libc.so.6
#1  0x000055a60728ec87 in kvm_vcpu_ioctl ()
#2  0x000055a60728edc1 in kvm_cpu_exec ()
#3  0x000055a60734dc04 in qemu_kvm_cpu_thread_fn ()
#4  0x000055a6076dc0ff in qemu_thread_start ()
#5  0x00007f549d19c3f9 in start_thread () from target:/lib64/libpthread.so.0
#6  0x00007f549d0c8b03 in clone () from target:/lib64/libc.so.6

Thread 5 (Thread 0x7f5391dff640 (LWP 405800)):
#0  0x00007f549d0bf58b in ioctl () from target:/lib64/libc.so.6
#1  0x000055a60728ec87 in kvm_vcpu_ioctl ()
#2  0x000055a60728edc1 in kvm_cpu_exec ()
#3  0x000055a60734dc04 in qemu_kvm_cpu_thread_fn ()
#4  0x000055a6076dc0ff in qemu_thread_start ()
#5  0x00007f549d19c3f9 in start_thread () from target:/lib64/libpthread.so.0
#6  0x00007f549d0c8b03 in clone () from target:/lib64/libc.so.6

Thread 4 (Thread 0x7f54988b7640 (LWP 405799)):
#0  0x00007f549d0bf58b in ioctl () from target:/lib64/libc.so.6
#1  0x000055a60728ec87 in kvm_vcpu_ioctl ()
#2  0x000055a60728edc1 in kvm_cpu_exec ()
#3  0x000055a60734dc04 in qemu_kvm_cpu_thread_fn ()
#4  0x000055a6076dc0ff in qemu_thread_start ()
#5  0x00007f549d19c3f9 in start_thread () from target:/lib64/libpthread.so.0
#6  0x00007f549d0c8b03 in clone () from target:/lib64/libc.so.6

Thread 3 (Thread 0x7f549917b640 (LWP 405798)):
#0  0x00007f549d0bda0f in poll () from target:/lib64/libc.so.6
#1  0x00007f549e4c2d1e in g_main_context_iterate.constprop () from target:/=
lib64/libglib-2.0.so.0
#2  0x00007f549e4716ab in g_main_loop_run () from target:/lib64/libglib-2.0=
.so.0
#3  0x000055a6073c4c81 in iothread_run ()
#4  0x000055a6076dc0ff in qemu_thread_start ()
#5  0x00007f549d19c3f9 in start_thread () from target:/lib64/libpthread.so.0
#6  0x00007f549d0c8b03 in clone () from target:/lib64/libc.so.6

Thread 2 (Thread 0x7f549b93a640 (LWP 405788)):
#0  0x00007f549d0c350d in syscall () from target:/lib64/libc.so.6
#1  0x000055a6076dce9a in qemu_event_wait ()
#2  0x000055a6076e56ca in call_rcu_thread ()
#3  0x000055a6076dc0ff in qemu_thread_start ()
#4  0x00007f549d19c3f9 in start_thread () from target:/lib64/libpthread.so.0
#5  0x00007f549d0c8b03 in clone () from target:/lib64/libc.so.6

Thread 1 (Thread 0x7f549bb10f00 (LWP 405756)):
#0  0x00007f549d0bdb0e in ppoll () from target:/lib64/libc.so.6
#1  0x000055a6076f4901 in qemu_poll_ns ()
#2  0x000055a6076f0485 in main_loop_wait ()
#3  0x000055a60735cdd7 in qemu_main_loop ()
#4  0x000055a607234a1e in main ()
(gdb) =



# virsh  dumpxml centos8
<domain type=3D'kvm' id=3D'1'>
  <name>centos8</name>
  <metadata>
    <libosinfo:libosinfo xmlns:libosinfo=3D"http://libosinfo.org/xmlns/libv=
irt/domain/1.0">
      <libosinfo:os id=3D"http://centos.org/centos/8"/>
    </libosinfo:libosinfo>
  </metadata>
  <memory unit=3D'KiB'>4096000</memory>
  <currentMemory unit=3D'KiB'>4096000</currentMemory>
  <vcpu placement=3D'static'>4</vcpu>
  <resource>
    <partition>/machine</partition>
  </resource>
  <os>
    <type arch=3D'x86_64' machine=3D'pc-q35-4.2'>hvm</type>
    <boot dev=3D'hd'/>
  </os>
  <features>
    <acpi/>
    <apic/>
    <vmport state=3D'off'/>
  </features>
  <cpu mode=3D'custom' match=3D'exact' check=3D'full'>
    <model fallback=3D'forbid'>EPYC-IBPB</model>
    <vendor>AMD</vendor>
    <feature policy=3D'require' name=3D'x2apic'/>
    <feature policy=3D'require' name=3D'tsc-deadline'/>
    <feature policy=3D'require' name=3D'hypervisor'/>
    <feature policy=3D'require' name=3D'tsc_adjust'/>
    <feature policy=3D'require' name=3D'clwb'/>
    <feature policy=3D'require' name=3D'umip'/>
    <feature policy=3D'require' name=3D'rdpid'/>
    <feature policy=3D'require' name=3D'stibp'/>
    <feature policy=3D'require' name=3D'arch-capabilities'/>
    <feature policy=3D'require' name=3D'ssbd'/>
    <feature policy=3D'require' name=3D'xsaves'/>
    <feature policy=3D'require' name=3D'cmp_legacy'/>
    <feature policy=3D'require' name=3D'perfctr_core'/>
    <feature policy=3D'require' name=3D'clzero'/>
    <feature policy=3D'require' name=3D'xsaveerptr'/>
    <feature policy=3D'require' name=3D'wbnoinvd'/>
    <feature policy=3D'require' name=3D'amd-stibp'/>
    <feature policy=3D'require' name=3D'amd-ssbd'/>
    <feature policy=3D'require' name=3D'virt-ssbd'/>
    <feature policy=3D'disable' name=3D'npt'/>
    <feature policy=3D'disable' name=3D'nrip-save'/>
    <feature policy=3D'require' name=3D'rdctl-no'/>
    <feature policy=3D'require' name=3D'skip-l1dfl-vmentry'/>
    <feature policy=3D'require' name=3D'mds-no'/>
    <feature policy=3D'require' name=3D'pschange-mc-no'/>
    <feature policy=3D'disable' name=3D'monitor'/>
    <feature policy=3D'disable' name=3D'svm'/>
    <feature policy=3D'require' name=3D'topoext'/>
  </cpu>
  <clock offset=3D'utc'>
    <timer name=3D'rtc' tickpolicy=3D'catchup'/>
    <timer name=3D'pit' tickpolicy=3D'delay'/>
    <timer name=3D'hpet' present=3D'no'/>
  </clock>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>destroy</on_crash>
  <pm>
    <suspend-to-mem enabled=3D'no'/>
    <suspend-to-disk enabled=3D'no'/>
  </pm>
  <devices>
    <emulator>/usr/bin/qemu-system-x86_64</emulator>
    <disk type=3D'file' device=3D'disk'>
      <driver name=3D'qemu' type=3D'qcow2'/>
      <source file=3D'/var/lib/libvirt/images/centos8.qcow2' index=3D'6'/>
      <backingStore/>
      <target dev=3D'vda' bus=3D'virtio'/>
      <alias name=3D'virtio-disk0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x04' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </disk>
    <disk type=3D'file' device=3D'disk'>
      <driver name=3D'qemu' type=3D'qcow2'/>
      <source file=3D'/var/lib/libvirt/images/centos8-1.qcow2' index=3D'5'/>
      <backingStore/>
      <target dev=3D'vdb' bus=3D'virtio'/>
      <alias name=3D'virtio-disk1'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x07' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </disk>
    <disk type=3D'file' device=3D'disk'>
      <driver name=3D'qemu' type=3D'qcow2'/>
      <source file=3D'/var/lib/libvirt/images/centos8-2.qcow2' index=3D'4'/>
      <backingStore/>
      <target dev=3D'vdc' bus=3D'virtio'/>
      <alias name=3D'virtio-disk2'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x08' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </disk>
    <disk type=3D'file' device=3D'disk'>
      <driver name=3D'qemu' type=3D'qcow2'/>
      <source file=3D'/var/lib/libvirt/images/centos8-3.qcow2' index=3D'3'/>
      <backingStore/>
      <target dev=3D'vdd' bus=3D'virtio'/>
      <alias name=3D'virtio-disk3'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x09' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </disk>
    <disk type=3D'file' device=3D'disk'>
      <driver name=3D'qemu' type=3D'qcow2'/>
      <source file=3D'/var/lib/libvirt/images/centos8-4.qcow2' index=3D'2'/>
      <backingStore/>
      <target dev=3D'vde' bus=3D'virtio'/>
      <alias name=3D'virtio-disk4'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x0a' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </disk>
    <disk type=3D'file' device=3D'cdrom'>
      <driver name=3D'qemu'/>
      <target dev=3D'sda' bus=3D'sata'/>
      <readonly/>
      <alias name=3D'sata0-0-0'/>
      <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' unit=
=3D'0'/>
    </disk>
    <controller type=3D'usb' index=3D'0' model=3D'qemu-xhci' ports=3D'15'>
      <alias name=3D'usb'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x02' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </controller>
    <controller type=3D'sata' index=3D'0'>
      <alias name=3D'ide'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x1f' fu=
nction=3D'0x2'/>
    </controller>
    <controller type=3D'pci' index=3D'0' model=3D'pcie-root'>
      <alias name=3D'pcie.0'/>
    </controller>
    <controller type=3D'pci' index=3D'1' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'1' port=3D'0x10'/>
      <alias name=3D'pci.1'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x0' multifunction=3D'on'/>
    </controller>
    <controller type=3D'pci' index=3D'2' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'2' port=3D'0x11'/>
      <alias name=3D'pci.2'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x1'/>
    </controller>
    <controller type=3D'pci' index=3D'3' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'3' port=3D'0x12'/>
      <alias name=3D'pci.3'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x2'/>
    </controller>
    <controller type=3D'pci' index=3D'4' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'4' port=3D'0x13'/>
      <alias name=3D'pci.4'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x3'/>
    </controller>
    <controller type=3D'pci' index=3D'5' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'5' port=3D'0x14'/>
      <alias name=3D'pci.5'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x4'/>
    </controller>
    <controller type=3D'pci' index=3D'6' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'6' port=3D'0x15'/>
      <alias name=3D'pci.6'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x5'/>
    </controller>
    <controller type=3D'pci' index=3D'7' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'7' port=3D'0x16'/>
      <alias name=3D'pci.7'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x6'/>
    </controller>
    <controller type=3D'pci' index=3D'8' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'8' port=3D'0x17'/>
      <alias name=3D'pci.8'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x7'/>
    </controller>
    <controller type=3D'pci' index=3D'9' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'9' port=3D'0x18'/>
      <alias name=3D'pci.9'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03' fu=
nction=3D'0x0' multifunction=3D'on'/>
    </controller>
    <controller type=3D'pci' index=3D'10' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'10' port=3D'0x19'/>
      <alias name=3D'pci.10'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03' fu=
nction=3D'0x1'/>
    </controller>
    <controller type=3D'virtio-serial' index=3D'0'>
      <alias name=3D'virtio-serial0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x03' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </controller>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:d4:02:c2'/>
      <source network=3D'default' portid=3D'643b50a3-f347-4c2e-995e-7644a7a=
d0a96' bridge=3D'virbr0'/>
      <target dev=3D'vnet0'/>
      <model type=3D'virtio'/>
      <alias name=3D'net0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x01' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </interface>
    <serial type=3D'pty'>
      <source path=3D'/dev/pts/4'/>
      <target type=3D'isa-serial' port=3D'0'>
        <model name=3D'isa-serial'/>
      </target>
      <alias name=3D'serial0'/>
    </serial>
    <console type=3D'pty' tty=3D'/dev/pts/4'>
      <source path=3D'/dev/pts/4'/>
      <target type=3D'serial' port=3D'0'/>
      <alias name=3D'serial0'/>
    </console>
    <channel type=3D'unix'>
      <source mode=3D'bind' path=3D'/var/lib/libvirt/qemu/channel/target/do=
main-1-centos8/org.qemu.guest_agent.0'/>
      <target type=3D'virtio' name=3D'org.qemu.guest_agent.0' state=3D'conn=
ected'/>
      <alias name=3D'channel0'/>
      <address type=3D'virtio-serial' controller=3D'0' bus=3D'0' port=3D'1'=
/>
    </channel>
    <channel type=3D'spicevmc'>
      <target type=3D'virtio' name=3D'com.redhat.spice.0' state=3D'connecte=
d'/>
      <alias name=3D'channel1'/>
      <address type=3D'virtio-serial' controller=3D'0' bus=3D'0' port=3D'2'=
/>
    </channel>
    <input type=3D'tablet' bus=3D'usb'>
      <alias name=3D'input0'/>
      <address type=3D'usb' bus=3D'0' port=3D'1'/>
    </input>
    <input type=3D'mouse' bus=3D'ps2'>
      <alias name=3D'input1'/>
    </input>
    <input type=3D'keyboard' bus=3D'ps2'>
      <alias name=3D'input2'/>
    </input>
    <graphics type=3D'spice' port=3D'5900' autoport=3D'yes' listen=3D'127.0=
.0.1'>
      <listen type=3D'address' address=3D'127.0.0.1'/>
      <image compression=3D'off'/>
    </graphics>
    <sound model=3D'ich9'>
      <alias name=3D'sound0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x1b' fu=
nction=3D'0x0'/>
    </sound>
    <video>
      <model type=3D'qxl' ram=3D'65536' vram=3D'65536' vgamem=3D'16384' hea=
ds=3D'1' primary=3D'yes'/>
      <alias name=3D'video0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' fu=
nction=3D'0x0'/>
    </video>
    <redirdev bus=3D'usb' type=3D'spicevmc'>
      <alias name=3D'redir0'/>
      <address type=3D'usb' bus=3D'0' port=3D'2'/>
    </redirdev>
    <redirdev bus=3D'usb' type=3D'spicevmc'>
      <alias name=3D'redir1'/>
      <address type=3D'usb' bus=3D'0' port=3D'3'/>
    </redirdev>
    <memballoon model=3D'virtio'>
      <alias name=3D'balloon0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x05' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </memballoon>
    <rng model=3D'virtio'>
      <backend model=3D'random'>/dev/urandom</backend>
      <alias name=3D'rng0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x06' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </rng>
  </devices>
  <seclabel type=3D'dynamic' model=3D'selinux' relabel=3D'yes'>
    <label>system_u:system_r:svirt_t:s0:c571,c902</label>
    <imagelabel>system_u:object_r:svirt_image_t:s0:c571,c902</imagelabel>
  </seclabel>
  <seclabel type=3D'dynamic' model=3D'dac' relabel=3D'yes'>
    <label>+107:+107</label>
    <imagelabel>+107:+107</imagelabel>
  </seclabel>
</domain>

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1902365

Title:
  3x 100% host CPU core usage while virtual machine is in idle

Status in QEMU:
  New

Bug description:
  My Fedora 33 machine "top" command shows qemu-system-x86_64 process
  using ~300% CPU, that means 3x CPU cores at 100%. Since the virtual
  machine (named CentOS 8) is almost in idle (top command inside the VM
  shows ~0% CPU usage), there must be something wrong. I attach qemu
  process GDB backtrace, and virtual machine libvirt XML

  Host details:
  libvirt-6.6.0-2.fc33.x86_64
  qemu-system-x86-5.1.0-5.fc33.x86_64
  virt-manager-3.1.0-1.fc33.noarch
  kernel 5.8.16-300.fc33.x86_64
  CPU: AMD Ryzen 5 3600

  # gdb qemu-system-x86_64 405756
  GNU gdb (GDB) Fedora 9.2-7.fc33
  Copyright (C) 2020 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.
  Type "show copying" and "show warranty" for details.
  This GDB was configured as "x86_64-redhat-linux-gnu".
  Type "show configuration" for configuration details.
  For bug reporting instructions, please see:
  <http://www.gnu.org/software/gdb/bugs/>.
  Find the GDB manual and other documentation resources online at:
      <http://www.gnu.org/software/gdb/documentation/>.

  For help, type "help".
  Type "apropos word" to search for commands related to "word"...
  Reading symbols from qemu-system-x86_64...
  Reading symbols from .gnu_debugdata for /usr/bin/qemu-system-x86_64...
  (No debugging symbols found in .gnu_debugdata for /usr/bin/qemu-system-x8=
6_64)
  Attaching to program: /usr/bin/qemu-system-x86_64, process 405756
  [New LWP 405788]
  [New LWP 405798]
  [New LWP 405799]
  [New LWP 405800]
  [New LWP 405801]
  [New LWP 405802]
  [New LWP 405804]
  [Thread debugging using libthread_db enabled]
  Using host libthread_db library "/lib64/libthread_db.so.1".
  0x00007f549d0bdb0e in ppoll () from target:/lib64/libc.so.6
  (gdb) set height 0
  (gdb) set print elements 0
  (gdb) set print frame-arguments all
  (gdb) thread apply all backtrace

  Thread 8 (Thread 0x7f53837ff640 (LWP 405804)):
  #0  0x00007f549d0bda0f in poll () from target:/lib64/libc.so.6
  #1  0x00007f549e4c2d1e in g_main_context_iterate.constprop () from target=
:/lib64/libglib-2.0.so.0
  #2  0x00007f549e4716ab in g_main_loop_run () from target:/lib64/libglib-2=
.0.so.0
  #3  0x00007f549dcfcc66 in red_worker_main.lto_priv () from target:/lib64/=
libspice-server.so.1
  #4  0x00007f549d19c3f9 in start_thread () from target:/lib64/libpthread.s=
o.0
  #5  0x00007f549d0c8b03 in clone () from target:/lib64/libc.so.6

  Thread 7 (Thread 0x7f5390dfd640 (LWP 405802)):
  #0  0x00007f549d0bf58b in ioctl () from target:/lib64/libc.so.6
  #1  0x000055a60728ec87 in kvm_vcpu_ioctl ()
  #2  0x000055a60728edc1 in kvm_cpu_exec ()
  #3  0x000055a60734dc04 in qemu_kvm_cpu_thread_fn ()
  #4  0x000055a6076dc0ff in qemu_thread_start ()
  #5  0x00007f549d19c3f9 in start_thread () from target:/lib64/libpthread.s=
o.0
  #6  0x00007f549d0c8b03 in clone () from target:/lib64/libc.so.6

  Thread 6 (Thread 0x7f53915fe640 (LWP 405801)):
  #0  0x00007f549d0bf58b in ioctl () from target:/lib64/libc.so.6
  #1  0x000055a60728ec87 in kvm_vcpu_ioctl ()
  #2  0x000055a60728edc1 in kvm_cpu_exec ()
  #3  0x000055a60734dc04 in qemu_kvm_cpu_thread_fn ()
  #4  0x000055a6076dc0ff in qemu_thread_start ()
  #5  0x00007f549d19c3f9 in start_thread () from target:/lib64/libpthread.s=
o.0
  #6  0x00007f549d0c8b03 in clone () from target:/lib64/libc.so.6

  Thread 5 (Thread 0x7f5391dff640 (LWP 405800)):
  #0  0x00007f549d0bf58b in ioctl () from target:/lib64/libc.so.6
  #1  0x000055a60728ec87 in kvm_vcpu_ioctl ()
  #2  0x000055a60728edc1 in kvm_cpu_exec ()
  #3  0x000055a60734dc04 in qemu_kvm_cpu_thread_fn ()
  #4  0x000055a6076dc0ff in qemu_thread_start ()
  #5  0x00007f549d19c3f9 in start_thread () from target:/lib64/libpthread.s=
o.0
  #6  0x00007f549d0c8b03 in clone () from target:/lib64/libc.so.6

  Thread 4 (Thread 0x7f54988b7640 (LWP 405799)):
  #0  0x00007f549d0bf58b in ioctl () from target:/lib64/libc.so.6
  #1  0x000055a60728ec87 in kvm_vcpu_ioctl ()
  #2  0x000055a60728edc1 in kvm_cpu_exec ()
  #3  0x000055a60734dc04 in qemu_kvm_cpu_thread_fn ()
  #4  0x000055a6076dc0ff in qemu_thread_start ()
  #5  0x00007f549d19c3f9 in start_thread () from target:/lib64/libpthread.s=
o.0
  #6  0x00007f549d0c8b03 in clone () from target:/lib64/libc.so.6

  Thread 3 (Thread 0x7f549917b640 (LWP 405798)):
  #0  0x00007f549d0bda0f in poll () from target:/lib64/libc.so.6
  #1  0x00007f549e4c2d1e in g_main_context_iterate.constprop () from target=
:/lib64/libglib-2.0.so.0
  #2  0x00007f549e4716ab in g_main_loop_run () from target:/lib64/libglib-2=
.0.so.0
  #3  0x000055a6073c4c81 in iothread_run ()
  #4  0x000055a6076dc0ff in qemu_thread_start ()
  #5  0x00007f549d19c3f9 in start_thread () from target:/lib64/libpthread.s=
o.0
  #6  0x00007f549d0c8b03 in clone () from target:/lib64/libc.so.6

  Thread 2 (Thread 0x7f549b93a640 (LWP 405788)):
  #0  0x00007f549d0c350d in syscall () from target:/lib64/libc.so.6
  #1  0x000055a6076dce9a in qemu_event_wait ()
  #2  0x000055a6076e56ca in call_rcu_thread ()
  #3  0x000055a6076dc0ff in qemu_thread_start ()
  #4  0x00007f549d19c3f9 in start_thread () from target:/lib64/libpthread.s=
o.0
  #5  0x00007f549d0c8b03 in clone () from target:/lib64/libc.so.6

  Thread 1 (Thread 0x7f549bb10f00 (LWP 405756)):
  #0  0x00007f549d0bdb0e in ppoll () from target:/lib64/libc.so.6
  #1  0x000055a6076f4901 in qemu_poll_ns ()
  #2  0x000055a6076f0485 in main_loop_wait ()
  #3  0x000055a60735cdd7 in qemu_main_loop ()
  #4  0x000055a607234a1e in main ()
  (gdb) =



  =

  # virsh  dumpxml centos8
  <domain type=3D'kvm' id=3D'1'>
    <name>centos8</name>
    <metadata>
      <libosinfo:libosinfo xmlns:libosinfo=3D"http://libosinfo.org/xmlns/li=
bvirt/domain/1.0">
        <libosinfo:os id=3D"http://centos.org/centos/8"/>
      </libosinfo:libosinfo>
    </metadata>
    <memory unit=3D'KiB'>4096000</memory>
    <currentMemory unit=3D'KiB'>4096000</currentMemory>
    <vcpu placement=3D'static'>4</vcpu>
    <resource>
      <partition>/machine</partition>
    </resource>
    <os>
      <type arch=3D'x86_64' machine=3D'pc-q35-4.2'>hvm</type>
      <boot dev=3D'hd'/>
    </os>
    <features>
      <acpi/>
      <apic/>
      <vmport state=3D'off'/>
    </features>
    <cpu mode=3D'custom' match=3D'exact' check=3D'full'>
      <model fallback=3D'forbid'>EPYC-IBPB</model>
      <vendor>AMD</vendor>
      <feature policy=3D'require' name=3D'x2apic'/>
      <feature policy=3D'require' name=3D'tsc-deadline'/>
      <feature policy=3D'require' name=3D'hypervisor'/>
      <feature policy=3D'require' name=3D'tsc_adjust'/>
      <feature policy=3D'require' name=3D'clwb'/>
      <feature policy=3D'require' name=3D'umip'/>
      <feature policy=3D'require' name=3D'rdpid'/>
      <feature policy=3D'require' name=3D'stibp'/>
      <feature policy=3D'require' name=3D'arch-capabilities'/>
      <feature policy=3D'require' name=3D'ssbd'/>
      <feature policy=3D'require' name=3D'xsaves'/>
      <feature policy=3D'require' name=3D'cmp_legacy'/>
      <feature policy=3D'require' name=3D'perfctr_core'/>
      <feature policy=3D'require' name=3D'clzero'/>
      <feature policy=3D'require' name=3D'xsaveerptr'/>
      <feature policy=3D'require' name=3D'wbnoinvd'/>
      <feature policy=3D'require' name=3D'amd-stibp'/>
      <feature policy=3D'require' name=3D'amd-ssbd'/>
      <feature policy=3D'require' name=3D'virt-ssbd'/>
      <feature policy=3D'disable' name=3D'npt'/>
      <feature policy=3D'disable' name=3D'nrip-save'/>
      <feature policy=3D'require' name=3D'rdctl-no'/>
      <feature policy=3D'require' name=3D'skip-l1dfl-vmentry'/>
      <feature policy=3D'require' name=3D'mds-no'/>
      <feature policy=3D'require' name=3D'pschange-mc-no'/>
      <feature policy=3D'disable' name=3D'monitor'/>
      <feature policy=3D'disable' name=3D'svm'/>
      <feature policy=3D'require' name=3D'topoext'/>
    </cpu>
    <clock offset=3D'utc'>
      <timer name=3D'rtc' tickpolicy=3D'catchup'/>
      <timer name=3D'pit' tickpolicy=3D'delay'/>
      <timer name=3D'hpet' present=3D'no'/>
    </clock>
    <on_poweroff>destroy</on_poweroff>
    <on_reboot>restart</on_reboot>
    <on_crash>destroy</on_crash>
    <pm>
      <suspend-to-mem enabled=3D'no'/>
      <suspend-to-disk enabled=3D'no'/>
    </pm>
    <devices>
      <emulator>/usr/bin/qemu-system-x86_64</emulator>
      <disk type=3D'file' device=3D'disk'>
        <driver name=3D'qemu' type=3D'qcow2'/>
        <source file=3D'/var/lib/libvirt/images/centos8.qcow2' index=3D'6'/>
        <backingStore/>
        <target dev=3D'vda' bus=3D'virtio'/>
        <alias name=3D'virtio-disk0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x04' slot=3D'0x00' =
function=3D'0x0'/>
      </disk>
      <disk type=3D'file' device=3D'disk'>
        <driver name=3D'qemu' type=3D'qcow2'/>
        <source file=3D'/var/lib/libvirt/images/centos8-1.qcow2' index=3D'5=
'/>
        <backingStore/>
        <target dev=3D'vdb' bus=3D'virtio'/>
        <alias name=3D'virtio-disk1'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x07' slot=3D'0x00' =
function=3D'0x0'/>
      </disk>
      <disk type=3D'file' device=3D'disk'>
        <driver name=3D'qemu' type=3D'qcow2'/>
        <source file=3D'/var/lib/libvirt/images/centos8-2.qcow2' index=3D'4=
'/>
        <backingStore/>
        <target dev=3D'vdc' bus=3D'virtio'/>
        <alias name=3D'virtio-disk2'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x08' slot=3D'0x00' =
function=3D'0x0'/>
      </disk>
      <disk type=3D'file' device=3D'disk'>
        <driver name=3D'qemu' type=3D'qcow2'/>
        <source file=3D'/var/lib/libvirt/images/centos8-3.qcow2' index=3D'3=
'/>
        <backingStore/>
        <target dev=3D'vdd' bus=3D'virtio'/>
        <alias name=3D'virtio-disk3'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x09' slot=3D'0x00' =
function=3D'0x0'/>
      </disk>
      <disk type=3D'file' device=3D'disk'>
        <driver name=3D'qemu' type=3D'qcow2'/>
        <source file=3D'/var/lib/libvirt/images/centos8-4.qcow2' index=3D'2=
'/>
        <backingStore/>
        <target dev=3D'vde' bus=3D'virtio'/>
        <alias name=3D'virtio-disk4'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x0a' slot=3D'0x00' =
function=3D'0x0'/>
      </disk>
      <disk type=3D'file' device=3D'cdrom'>
        <driver name=3D'qemu'/>
        <target dev=3D'sda' bus=3D'sata'/>
        <readonly/>
        <alias name=3D'sata0-0-0'/>
        <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' uni=
t=3D'0'/>
      </disk>
      <controller type=3D'usb' index=3D'0' model=3D'qemu-xhci' ports=3D'15'>
        <alias name=3D'usb'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x02' slot=3D'0x00' =
function=3D'0x0'/>
      </controller>
      <controller type=3D'sata' index=3D'0'>
        <alias name=3D'ide'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x1f' =
function=3D'0x2'/>
      </controller>
      <controller type=3D'pci' index=3D'0' model=3D'pcie-root'>
        <alias name=3D'pcie.0'/>
      </controller>
      <controller type=3D'pci' index=3D'1' model=3D'pcie-root-port'>
        <model name=3D'pcie-root-port'/>
        <target chassis=3D'1' port=3D'0x10'/>
        <alias name=3D'pci.1'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x0' multifunction=3D'on'/>
      </controller>
      <controller type=3D'pci' index=3D'2' model=3D'pcie-root-port'>
        <model name=3D'pcie-root-port'/>
        <target chassis=3D'2' port=3D'0x11'/>
        <alias name=3D'pci.2'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x1'/>
      </controller>
      <controller type=3D'pci' index=3D'3' model=3D'pcie-root-port'>
        <model name=3D'pcie-root-port'/>
        <target chassis=3D'3' port=3D'0x12'/>
        <alias name=3D'pci.3'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x2'/>
      </controller>
      <controller type=3D'pci' index=3D'4' model=3D'pcie-root-port'>
        <model name=3D'pcie-root-port'/>
        <target chassis=3D'4' port=3D'0x13'/>
        <alias name=3D'pci.4'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x3'/>
      </controller>
      <controller type=3D'pci' index=3D'5' model=3D'pcie-root-port'>
        <model name=3D'pcie-root-port'/>
        <target chassis=3D'5' port=3D'0x14'/>
        <alias name=3D'pci.5'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x4'/>
      </controller>
      <controller type=3D'pci' index=3D'6' model=3D'pcie-root-port'>
        <model name=3D'pcie-root-port'/>
        <target chassis=3D'6' port=3D'0x15'/>
        <alias name=3D'pci.6'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x5'/>
      </controller>
      <controller type=3D'pci' index=3D'7' model=3D'pcie-root-port'>
        <model name=3D'pcie-root-port'/>
        <target chassis=3D'7' port=3D'0x16'/>
        <alias name=3D'pci.7'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x6'/>
      </controller>
      <controller type=3D'pci' index=3D'8' model=3D'pcie-root-port'>
        <model name=3D'pcie-root-port'/>
        <target chassis=3D'8' port=3D'0x17'/>
        <alias name=3D'pci.8'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x7'/>
      </controller>
      <controller type=3D'pci' index=3D'9' model=3D'pcie-root-port'>
        <model name=3D'pcie-root-port'/>
        <target chassis=3D'9' port=3D'0x18'/>
        <alias name=3D'pci.9'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03' =
function=3D'0x0' multifunction=3D'on'/>
      </controller>
      <controller type=3D'pci' index=3D'10' model=3D'pcie-root-port'>
        <model name=3D'pcie-root-port'/>
        <target chassis=3D'10' port=3D'0x19'/>
        <alias name=3D'pci.10'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03' =
function=3D'0x1'/>
      </controller>
      <controller type=3D'virtio-serial' index=3D'0'>
        <alias name=3D'virtio-serial0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x03' slot=3D'0x00' =
function=3D'0x0'/>
      </controller>
      <interface type=3D'network'>
        <mac address=3D'52:54:00:d4:02:c2'/>
        <source network=3D'default' portid=3D'643b50a3-f347-4c2e-995e-7644a=
7ad0a96' bridge=3D'virbr0'/>
        <target dev=3D'vnet0'/>
        <model type=3D'virtio'/>
        <alias name=3D'net0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x01' slot=3D'0x00' =
function=3D'0x0'/>
      </interface>
      <serial type=3D'pty'>
        <source path=3D'/dev/pts/4'/>
        <target type=3D'isa-serial' port=3D'0'>
          <model name=3D'isa-serial'/>
        </target>
        <alias name=3D'serial0'/>
      </serial>
      <console type=3D'pty' tty=3D'/dev/pts/4'>
        <source path=3D'/dev/pts/4'/>
        <target type=3D'serial' port=3D'0'/>
        <alias name=3D'serial0'/>
      </console>
      <channel type=3D'unix'>
        <source mode=3D'bind' path=3D'/var/lib/libvirt/qemu/channel/target/=
domain-1-centos8/org.qemu.guest_agent.0'/>
        <target type=3D'virtio' name=3D'org.qemu.guest_agent.0' state=3D'co=
nnected'/>
        <alias name=3D'channel0'/>
        <address type=3D'virtio-serial' controller=3D'0' bus=3D'0' port=3D'=
1'/>
      </channel>
      <channel type=3D'spicevmc'>
        <target type=3D'virtio' name=3D'com.redhat.spice.0' state=3D'connec=
ted'/>
        <alias name=3D'channel1'/>
        <address type=3D'virtio-serial' controller=3D'0' bus=3D'0' port=3D'=
2'/>
      </channel>
      <input type=3D'tablet' bus=3D'usb'>
        <alias name=3D'input0'/>
        <address type=3D'usb' bus=3D'0' port=3D'1'/>
      </input>
      <input type=3D'mouse' bus=3D'ps2'>
        <alias name=3D'input1'/>
      </input>
      <input type=3D'keyboard' bus=3D'ps2'>
        <alias name=3D'input2'/>
      </input>
      <graphics type=3D'spice' port=3D'5900' autoport=3D'yes' listen=3D'127=
.0.0.1'>
        <listen type=3D'address' address=3D'127.0.0.1'/>
        <image compression=3D'off'/>
      </graphics>
      <sound model=3D'ich9'>
        <alias name=3D'sound0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x1b' =
function=3D'0x0'/>
      </sound>
      <video>
        <model type=3D'qxl' ram=3D'65536' vram=3D'65536' vgamem=3D'16384' h=
eads=3D'1' primary=3D'yes'/>
        <alias name=3D'video0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x0'/>
      </video>
      <redirdev bus=3D'usb' type=3D'spicevmc'>
        <alias name=3D'redir0'/>
        <address type=3D'usb' bus=3D'0' port=3D'2'/>
      </redirdev>
      <redirdev bus=3D'usb' type=3D'spicevmc'>
        <alias name=3D'redir1'/>
        <address type=3D'usb' bus=3D'0' port=3D'3'/>
      </redirdev>
      <memballoon model=3D'virtio'>
        <alias name=3D'balloon0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x05' slot=3D'0x00' =
function=3D'0x0'/>
      </memballoon>
      <rng model=3D'virtio'>
        <backend model=3D'random'>/dev/urandom</backend>
        <alias name=3D'rng0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x06' slot=3D'0x00' =
function=3D'0x0'/>
      </rng>
    </devices>
    <seclabel type=3D'dynamic' model=3D'selinux' relabel=3D'yes'>
      <label>system_u:system_r:svirt_t:s0:c571,c902</label>
      <imagelabel>system_u:object_r:svirt_image_t:s0:c571,c902</imagelabel>
    </seclabel>
    <seclabel type=3D'dynamic' model=3D'dac' relabel=3D'yes'>
      <label>+107:+107</label>
      <imagelabel>+107:+107</imagelabel>
    </seclabel>
  </domain>

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1902365/+subscriptions

