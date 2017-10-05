Received: from eggs.gnu.org ([2001:4830:134:3::10]:54606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e03l9-00032K-Ef
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e03l7-0003Vz-St
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:52:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e03l7-0003V8-K0
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:52:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 955A180B29
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 10:52:04 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  5 Oct 2017 11:51:57 +0100
Message-Id: <20171005105157.10831-6-dgilbert@redhat.com>
In-Reply-To: <20171005105157.10831-1-dgilbert@redhat.com>
References: <20171005105157.10831-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/5] hmp-commands-info: Change "@findex FOO" to
 "@findex info FOO"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

From: Markus Armbruster <armbru@redhat.com>

qemu-doc has the monitor commands in the "Function Index".  The "info
FOO" are listed as "FOO" there.  List them as "info FOO" instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20171002134538.23332-4-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands-info.hx | 118 +++++++++++++++++++++++++--------------------=
------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index d27d3b1227..54c3e5eac6 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -23,7 +23,7 @@ ETEXI
=20
 STEXI
 @item info version
-@findex version
+@findex info version
 Show the version of QEMU.
 ETEXI
=20
@@ -37,7 +37,7 @@ ETEXI
=20
 STEXI
 @item info network
-@findex network
+@findex info network
 Show the network state.
 ETEXI
=20
@@ -51,7 +51,7 @@ ETEXI
=20
 STEXI
 @item info chardev
-@findex chardev
+@findex info chardev
 Show the character devices.
 ETEXI
=20
@@ -66,7 +66,7 @@ ETEXI
=20
 STEXI
 @item info block
-@findex block
+@findex info block
 Show info of one block device or all block devices.
 ETEXI
=20
@@ -80,7 +80,7 @@ ETEXI
=20
 STEXI
 @item info blockstats
-@findex blockstats
+@findex info blockstats
 Show block device statistics.
 ETEXI
=20
@@ -94,7 +94,7 @@ ETEXI
=20
 STEXI
 @item info block-jobs
-@findex block-jobs
+@findex info block-jobs
 Show progress of ongoing block device operations.
 ETEXI
=20
@@ -108,7 +108,7 @@ ETEXI
=20
 STEXI
 @item info registers
-@findex registers
+@findex info registers
 Show the cpu registers.
 ETEXI
=20
@@ -125,7 +125,7 @@ ETEXI
=20
 STEXI
 @item info lapic
-@findex lapic
+@findex info lapic
 Show local APIC state
 ETEXI
=20
@@ -141,7 +141,7 @@ ETEXI
=20
 STEXI
 @item info ioapic
-@findex ioapic
+@findex info ioapic
 Show io APIC state
 ETEXI
=20
@@ -155,7 +155,7 @@ ETEXI
=20
 STEXI
 @item info cpus
-@findex cpus
+@findex info cpus
 Show infos for each CPU.
 ETEXI
=20
@@ -169,7 +169,7 @@ ETEXI
=20
 STEXI
 @item info history
-@findex history
+@findex info history
 Show the command line history.
 ETEXI
=20
@@ -183,7 +183,7 @@ ETEXI
=20
 STEXI
 @item info irq
-@findex irq
+@findex info irq
 Show the interrupts statistics (if available).
 ETEXI
=20
@@ -197,7 +197,7 @@ ETEXI
=20
 STEXI
 @item info pic
-@findex pic
+@findex info pic
 Show i8259 (PIC) state.
 ETEXI
=20
@@ -211,7 +211,7 @@ ETEXI
=20
 STEXI
 @item info pci
-@findex pci
+@findex info pci
 Show PCI information.
 ETEXI
=20
@@ -228,7 +228,7 @@ ETEXI
=20
 STEXI
 @item info tlb
-@findex tlb
+@findex info tlb
 Show virtual to physical memory mappings.
 ETEXI
=20
@@ -244,7 +244,7 @@ ETEXI
=20
 STEXI
 @item info mem
-@findex mem
+@findex info mem
 Show the active virtual memory mappings.
 ETEXI
=20
@@ -259,7 +259,7 @@ ETEXI
=20
 STEXI
 @item info mtree
-@findex mtree
+@findex info mtree
 Show memory tree.
 ETEXI
=20
@@ -275,7 +275,7 @@ ETEXI
=20
 STEXI
 @item info jit
-@findex jit
+@findex info jit
 Show dynamic compiler info.
 ETEXI
=20
@@ -291,7 +291,7 @@ ETEXI
=20
 STEXI
 @item info opcount
-@findex opcount
+@findex info opcount
 Show dynamic compiler opcode counters
 ETEXI
=20
@@ -305,7 +305,7 @@ ETEXI
=20
 STEXI
 @item info kvm
-@findex kvm
+@findex info kvm
 Show KVM information.
 ETEXI
=20
@@ -319,7 +319,7 @@ ETEXI
=20
 STEXI
 @item info numa
-@findex numa
+@findex info numa
 Show NUMA information.
 ETEXI
=20
@@ -333,7 +333,7 @@ ETEXI
=20
 STEXI
 @item info usb
-@findex usb
+@findex info usb
 Show guest USB devices.
 ETEXI
=20
@@ -347,7 +347,7 @@ ETEXI
=20
 STEXI
 @item info usbhost
-@findex usbhost
+@findex info usbhost
 Show host USB devices.
 ETEXI
=20
@@ -361,7 +361,7 @@ ETEXI
=20
 STEXI
 @item info profile
-@findex profile
+@findex info profile
 Show profiling information.
 ETEXI
=20
@@ -375,7 +375,7 @@ ETEXI
=20
 STEXI
 @item info capture
-@findex capture
+@findex info capture
 Show capture information.
 ETEXI
=20
@@ -389,7 +389,7 @@ ETEXI
=20
 STEXI
 @item info snapshots
-@findex snapshots
+@findex info snapshots
 Show the currently saved VM snapshots.
 ETEXI
=20
@@ -403,7 +403,7 @@ ETEXI
=20
 STEXI
 @item info status
-@findex status
+@findex info status
 Show the current VM status (running|paused).
 ETEXI
=20
@@ -417,7 +417,7 @@ ETEXI
=20
 STEXI
 @item info mice
-@findex mice
+@findex info mice
 Show which guest mouse is receiving events.
 ETEXI
=20
@@ -431,7 +431,7 @@ ETEXI
=20
 STEXI
 @item info vnc
-@findex vnc
+@findex info vnc
 Show the vnc server status.
 ETEXI
=20
@@ -447,7 +447,7 @@ ETEXI
=20
 STEXI
 @item info spice
-@findex spice
+@findex info spice
 Show the spice server status.
 ETEXI
=20
@@ -461,7 +461,7 @@ ETEXI
=20
 STEXI
 @item info name
-@findex name
+@findex info name
 Show the current VM name.
 ETEXI
=20
@@ -475,7 +475,7 @@ ETEXI
=20
 STEXI
 @item info uuid
-@findex uuid
+@findex info uuid
 Show the current VM UUID.
 ETEXI
=20
@@ -489,7 +489,7 @@ ETEXI
=20
 STEXI
 @item info cpustats
-@findex cpustats
+@findex info cpustats
 Show CPU statistics.
 ETEXI
=20
@@ -505,7 +505,7 @@ ETEXI
=20
 STEXI
 @item info usernet
-@findex usernet
+@findex info usernet
 Show user network stack connection states.
 ETEXI
=20
@@ -519,7 +519,7 @@ ETEXI
=20
 STEXI
 @item info migrate
-@findex migrate
+@findex info migrate
 Show migration status.
 ETEXI
=20
@@ -533,7 +533,7 @@ ETEXI
=20
 STEXI
 @item info migrate_capabilities
-@findex migrate_capabilities
+@findex info migrate_capabilities
 Show current migration capabilities.
 ETEXI
=20
@@ -547,7 +547,7 @@ ETEXI
=20
 STEXI
 @item info migrate_parameters
-@findex migrate_parameters
+@findex info migrate_parameters
 Show current migration parameters.
 ETEXI
=20
@@ -561,7 +561,7 @@ ETEXI
=20
 STEXI
 @item info migrate_cache_size
-@findex migrate_cache_size
+@findex info migrate_cache_size
 Show current migration xbzrle cache size.
 ETEXI
=20
@@ -575,7 +575,7 @@ ETEXI
=20
 STEXI
 @item info balloon
-@findex balloon
+@findex info balloon
 Show balloon information.
 ETEXI
=20
@@ -589,7 +589,7 @@ ETEXI
=20
 STEXI
 @item info qtree
-@findex qtree
+@findex info qtree
 Show device tree.
 ETEXI
=20
@@ -603,7 +603,7 @@ ETEXI
=20
 STEXI
 @item info qdm
-@findex qdm
+@findex info qdm
 Show qdev device model list.
 ETEXI
=20
@@ -617,7 +617,7 @@ ETEXI
=20
 STEXI
 @item info qom-tree
-@findex qom-tree
+@findex info qom-tree
 Show QOM composition tree.
 ETEXI
=20
@@ -631,7 +631,7 @@ ETEXI
=20
 STEXI
 @item info roms
-@findex roms
+@findex info roms
 Show roms.
 ETEXI
=20
@@ -647,7 +647,7 @@ ETEXI
=20
 STEXI
 @item info trace-events
-@findex trace-events
+@findex info trace-events
 Show available trace-events & their state.
 ETEXI
=20
@@ -661,7 +661,7 @@ ETEXI
=20
 STEXI
 @item info tpm
-@findex tpm
+@findex info tpm
 Show the TPM device.
 ETEXI
=20
@@ -675,7 +675,7 @@ ETEXI
=20
 STEXI
 @item info memdev
-@findex memdev
+@findex info memdev
 Show memory backends
 ETEXI
=20
@@ -689,7 +689,7 @@ ETEXI
=20
 STEXI
 @item info memory-devices
-@findex memory-devices
+@findex info memory-devices
 Show memory devices.
 ETEXI
=20
@@ -703,7 +703,7 @@ ETEXI
=20
 STEXI
 @item info iothreads
-@findex iothreads
+@findex info iothreads
 Show iothread's identifiers.
 ETEXI
=20
@@ -717,7 +717,7 @@ ETEXI
=20
 STEXI
 @item info rocker @var{name}
-@findex rocker
+@findex info rocker
 Show rocker switch.
 ETEXI
=20
@@ -731,7 +731,7 @@ ETEXI
=20
 STEXI
 @item info rocker-ports @var{name}-ports
-@findex rocker-ports
+@findex info rocker-ports
 Show rocker ports.
 ETEXI
=20
@@ -745,7 +745,7 @@ ETEXI
=20
 STEXI
 @item info rocker-of-dpa-flows @var{name} [@var{tbl_id}]
-@findex rocker-of-dpa-flows
+@findex info rocker-of-dpa-flows
 Show rocker OF-DPA flow tables.
 ETEXI
=20
@@ -759,7 +759,7 @@ ETEXI
=20
 STEXI
 @item info rocker-of-dpa-groups @var{name} [@var{type}]
-@findex rocker-of-dpa-groups
+@findex info rocker-of-dpa-groups
 Show rocker OF-DPA groups.
 ETEXI
=20
@@ -775,7 +775,7 @@ ETEXI
=20
 STEXI
 @item info skeys @var{address}
-@findex skeys
+@findex info skeys
 Display the value of a storage key (s390 only)
 ETEXI
=20
@@ -791,7 +791,7 @@ ETEXI
=20
 STEXI
 @item info cmma @var{address}
-@findex cmma
+@findex info cmma
 Display the values of the CMMA storage attributes for a range of pages (=
s390 only)
 ETEXI
=20
@@ -805,7 +805,7 @@ ETEXI
=20
 STEXI
 @item info dump
-@findex dump
+@findex info dump
 Display the latest dump status.
 ETEXI
=20
@@ -819,7 +819,7 @@ ETEXI
=20
 STEXI
 @item info ramblock
-@findex ramblock
+@findex info ramblock
 Dump all the ramblocks of the system.
 ETEXI
=20
@@ -833,7 +833,7 @@ ETEXI
=20
 STEXI
 @item info hotpluggable-cpus
-@findex hotpluggable-cpus
+@findex info hotpluggable-cpus
 Show information about hotpluggable CPUs
 ETEXI
=20
@@ -847,7 +847,7 @@ ETEXI
=20
 STEXI
 @item info vm-generation-id
-@findex vm-generation-id
+@findex info vm-generation-id
 Show Virtual Machine Generation ID
 ETEXI
=20
@@ -862,7 +862,7 @@ ETEXI
=20
 STEXI
 @item info memory_size_summary
-@findex memory_size_summary
+@findex info memory_size_summary
 Display the amount of initially allocated and present hotpluggable (if
 enabled) memory in bytes.
 ETEXI
--=20
2.13.6
