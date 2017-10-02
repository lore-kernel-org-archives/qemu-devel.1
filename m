Received: from eggs.gnu.org ([2001:4830:134:3::10]:34462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz12X-000459-9J
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz12T-0002cY-HB
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:45:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz12T-0002aR-8s
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:45:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51C5C4D4A9
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 13:45:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 15:45:38 +0200
Message-Id: <20171002134538.23332-4-armbru@redhat.com>
In-Reply-To: <20171002134538.23332-1-armbru@redhat.com>
References: <20171002134538.23332-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] hmp-commands-info: Change "@findex FOO" to
 "@findex info FOO"
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com
List-ID: <qemu-devel.nongnu.org>

qemu-doc has the monitor commands in the "Function Index".  The "info
FOO" are listed as "FOO" there.  List them as "info FOO" instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hmp-commands-info.hx | 118 +++++++++++++++++++++++++--------------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index d27d3b1227..54c3e5eac6 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -23,7 +23,7 @@ ETEXI
 
 STEXI
 @item info version
-@findex version
+@findex info version
 Show the version of QEMU.
 ETEXI
 
@@ -37,7 +37,7 @@ ETEXI
 
 STEXI
 @item info network
-@findex network
+@findex info network
 Show the network state.
 ETEXI
 
@@ -51,7 +51,7 @@ ETEXI
 
 STEXI
 @item info chardev
-@findex chardev
+@findex info chardev
 Show the character devices.
 ETEXI
 
@@ -66,7 +66,7 @@ ETEXI
 
 STEXI
 @item info block
-@findex block
+@findex info block
 Show info of one block device or all block devices.
 ETEXI
 
@@ -80,7 +80,7 @@ ETEXI
 
 STEXI
 @item info blockstats
-@findex blockstats
+@findex info blockstats
 Show block device statistics.
 ETEXI
 
@@ -94,7 +94,7 @@ ETEXI
 
 STEXI
 @item info block-jobs
-@findex block-jobs
+@findex info block-jobs
 Show progress of ongoing block device operations.
 ETEXI
 
@@ -108,7 +108,7 @@ ETEXI
 
 STEXI
 @item info registers
-@findex registers
+@findex info registers
 Show the cpu registers.
 ETEXI
 
@@ -125,7 +125,7 @@ ETEXI
 
 STEXI
 @item info lapic
-@findex lapic
+@findex info lapic
 Show local APIC state
 ETEXI
 
@@ -141,7 +141,7 @@ ETEXI
 
 STEXI
 @item info ioapic
-@findex ioapic
+@findex info ioapic
 Show io APIC state
 ETEXI
 
@@ -155,7 +155,7 @@ ETEXI
 
 STEXI
 @item info cpus
-@findex cpus
+@findex info cpus
 Show infos for each CPU.
 ETEXI
 
@@ -169,7 +169,7 @@ ETEXI
 
 STEXI
 @item info history
-@findex history
+@findex info history
 Show the command line history.
 ETEXI
 
@@ -183,7 +183,7 @@ ETEXI
 
 STEXI
 @item info irq
-@findex irq
+@findex info irq
 Show the interrupts statistics (if available).
 ETEXI
 
@@ -197,7 +197,7 @@ ETEXI
 
 STEXI
 @item info pic
-@findex pic
+@findex info pic
 Show i8259 (PIC) state.
 ETEXI
 
@@ -211,7 +211,7 @@ ETEXI
 
 STEXI
 @item info pci
-@findex pci
+@findex info pci
 Show PCI information.
 ETEXI
 
@@ -228,7 +228,7 @@ ETEXI
 
 STEXI
 @item info tlb
-@findex tlb
+@findex info tlb
 Show virtual to physical memory mappings.
 ETEXI
 
@@ -244,7 +244,7 @@ ETEXI
 
 STEXI
 @item info mem
-@findex mem
+@findex info mem
 Show the active virtual memory mappings.
 ETEXI
 
@@ -259,7 +259,7 @@ ETEXI
 
 STEXI
 @item info mtree
-@findex mtree
+@findex info mtree
 Show memory tree.
 ETEXI
 
@@ -275,7 +275,7 @@ ETEXI
 
 STEXI
 @item info jit
-@findex jit
+@findex info jit
 Show dynamic compiler info.
 ETEXI
 
@@ -291,7 +291,7 @@ ETEXI
 
 STEXI
 @item info opcount
-@findex opcount
+@findex info opcount
 Show dynamic compiler opcode counters
 ETEXI
 
@@ -305,7 +305,7 @@ ETEXI
 
 STEXI
 @item info kvm
-@findex kvm
+@findex info kvm
 Show KVM information.
 ETEXI
 
@@ -319,7 +319,7 @@ ETEXI
 
 STEXI
 @item info numa
-@findex numa
+@findex info numa
 Show NUMA information.
 ETEXI
 
@@ -333,7 +333,7 @@ ETEXI
 
 STEXI
 @item info usb
-@findex usb
+@findex info usb
 Show guest USB devices.
 ETEXI
 
@@ -347,7 +347,7 @@ ETEXI
 
 STEXI
 @item info usbhost
-@findex usbhost
+@findex info usbhost
 Show host USB devices.
 ETEXI
 
@@ -361,7 +361,7 @@ ETEXI
 
 STEXI
 @item info profile
-@findex profile
+@findex info profile
 Show profiling information.
 ETEXI
 
@@ -375,7 +375,7 @@ ETEXI
 
 STEXI
 @item info capture
-@findex capture
+@findex info capture
 Show capture information.
 ETEXI
 
@@ -389,7 +389,7 @@ ETEXI
 
 STEXI
 @item info snapshots
-@findex snapshots
+@findex info snapshots
 Show the currently saved VM snapshots.
 ETEXI
 
@@ -403,7 +403,7 @@ ETEXI
 
 STEXI
 @item info status
-@findex status
+@findex info status
 Show the current VM status (running|paused).
 ETEXI
 
@@ -417,7 +417,7 @@ ETEXI
 
 STEXI
 @item info mice
-@findex mice
+@findex info mice
 Show which guest mouse is receiving events.
 ETEXI
 
@@ -431,7 +431,7 @@ ETEXI
 
 STEXI
 @item info vnc
-@findex vnc
+@findex info vnc
 Show the vnc server status.
 ETEXI
 
@@ -447,7 +447,7 @@ ETEXI
 
 STEXI
 @item info spice
-@findex spice
+@findex info spice
 Show the spice server status.
 ETEXI
 
@@ -461,7 +461,7 @@ ETEXI
 
 STEXI
 @item info name
-@findex name
+@findex info name
 Show the current VM name.
 ETEXI
 
@@ -475,7 +475,7 @@ ETEXI
 
 STEXI
 @item info uuid
-@findex uuid
+@findex info uuid
 Show the current VM UUID.
 ETEXI
 
@@ -489,7 +489,7 @@ ETEXI
 
 STEXI
 @item info cpustats
-@findex cpustats
+@findex info cpustats
 Show CPU statistics.
 ETEXI
 
@@ -505,7 +505,7 @@ ETEXI
 
 STEXI
 @item info usernet
-@findex usernet
+@findex info usernet
 Show user network stack connection states.
 ETEXI
 
@@ -519,7 +519,7 @@ ETEXI
 
 STEXI
 @item info migrate
-@findex migrate
+@findex info migrate
 Show migration status.
 ETEXI
 
@@ -533,7 +533,7 @@ ETEXI
 
 STEXI
 @item info migrate_capabilities
-@findex migrate_capabilities
+@findex info migrate_capabilities
 Show current migration capabilities.
 ETEXI
 
@@ -547,7 +547,7 @@ ETEXI
 
 STEXI
 @item info migrate_parameters
-@findex migrate_parameters
+@findex info migrate_parameters
 Show current migration parameters.
 ETEXI
 
@@ -561,7 +561,7 @@ ETEXI
 
 STEXI
 @item info migrate_cache_size
-@findex migrate_cache_size
+@findex info migrate_cache_size
 Show current migration xbzrle cache size.
 ETEXI
 
@@ -575,7 +575,7 @@ ETEXI
 
 STEXI
 @item info balloon
-@findex balloon
+@findex info balloon
 Show balloon information.
 ETEXI
 
@@ -589,7 +589,7 @@ ETEXI
 
 STEXI
 @item info qtree
-@findex qtree
+@findex info qtree
 Show device tree.
 ETEXI
 
@@ -603,7 +603,7 @@ ETEXI
 
 STEXI
 @item info qdm
-@findex qdm
+@findex info qdm
 Show qdev device model list.
 ETEXI
 
@@ -617,7 +617,7 @@ ETEXI
 
 STEXI
 @item info qom-tree
-@findex qom-tree
+@findex info qom-tree
 Show QOM composition tree.
 ETEXI
 
@@ -631,7 +631,7 @@ ETEXI
 
 STEXI
 @item info roms
-@findex roms
+@findex info roms
 Show roms.
 ETEXI
 
@@ -647,7 +647,7 @@ ETEXI
 
 STEXI
 @item info trace-events
-@findex trace-events
+@findex info trace-events
 Show available trace-events & their state.
 ETEXI
 
@@ -661,7 +661,7 @@ ETEXI
 
 STEXI
 @item info tpm
-@findex tpm
+@findex info tpm
 Show the TPM device.
 ETEXI
 
@@ -675,7 +675,7 @@ ETEXI
 
 STEXI
 @item info memdev
-@findex memdev
+@findex info memdev
 Show memory backends
 ETEXI
 
@@ -689,7 +689,7 @@ ETEXI
 
 STEXI
 @item info memory-devices
-@findex memory-devices
+@findex info memory-devices
 Show memory devices.
 ETEXI
 
@@ -703,7 +703,7 @@ ETEXI
 
 STEXI
 @item info iothreads
-@findex iothreads
+@findex info iothreads
 Show iothread's identifiers.
 ETEXI
 
@@ -717,7 +717,7 @@ ETEXI
 
 STEXI
 @item info rocker @var{name}
-@findex rocker
+@findex info rocker
 Show rocker switch.
 ETEXI
 
@@ -731,7 +731,7 @@ ETEXI
 
 STEXI
 @item info rocker-ports @var{name}-ports
-@findex rocker-ports
+@findex info rocker-ports
 Show rocker ports.
 ETEXI
 
@@ -745,7 +745,7 @@ ETEXI
 
 STEXI
 @item info rocker-of-dpa-flows @var{name} [@var{tbl_id}]
-@findex rocker-of-dpa-flows
+@findex info rocker-of-dpa-flows
 Show rocker OF-DPA flow tables.
 ETEXI
 
@@ -759,7 +759,7 @@ ETEXI
 
 STEXI
 @item info rocker-of-dpa-groups @var{name} [@var{type}]
-@findex rocker-of-dpa-groups
+@findex info rocker-of-dpa-groups
 Show rocker OF-DPA groups.
 ETEXI
 
@@ -775,7 +775,7 @@ ETEXI
 
 STEXI
 @item info skeys @var{address}
-@findex skeys
+@findex info skeys
 Display the value of a storage key (s390 only)
 ETEXI
 
@@ -791,7 +791,7 @@ ETEXI
 
 STEXI
 @item info cmma @var{address}
-@findex cmma
+@findex info cmma
 Display the values of the CMMA storage attributes for a range of pages (s390 only)
 ETEXI
 
@@ -805,7 +805,7 @@ ETEXI
 
 STEXI
 @item info dump
-@findex dump
+@findex info dump
 Display the latest dump status.
 ETEXI
 
@@ -819,7 +819,7 @@ ETEXI
 
 STEXI
 @item info ramblock
-@findex ramblock
+@findex info ramblock
 Dump all the ramblocks of the system.
 ETEXI
 
@@ -833,7 +833,7 @@ ETEXI
 
 STEXI
 @item info hotpluggable-cpus
-@findex hotpluggable-cpus
+@findex info hotpluggable-cpus
 Show information about hotpluggable CPUs
 ETEXI
 
@@ -847,7 +847,7 @@ ETEXI
 
 STEXI
 @item info vm-generation-id
-@findex vm-generation-id
+@findex info vm-generation-id
 Show Virtual Machine Generation ID
 ETEXI
 
@@ -862,7 +862,7 @@ ETEXI
 
 STEXI
 @item info memory_size_summary
-@findex memory_size_summary
+@findex info memory_size_summary
 Display the amount of initially allocated and present hotpluggable (if
 enabled) memory in bytes.
 ETEXI
-- 
2.13.6
