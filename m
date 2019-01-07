Received: from eggs.gnu.org ([209.51.188.92]:33422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ggabp-0008PR-VJ
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ggabo-0000eq-ER
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:30:49 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  7 Jan 2019 17:30:19 -0200
Message-Id: <20190107193020.21744-3-ehabkost@redhat.com>
In-Reply-To: <20190107193020.21744-1-ehabkost@redhat.com>
References: <20190107193020.21744-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] machine: Eliminate unnecessary stringify()
 usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org

stringify() is useful when we need to use macros in compat_props
(like when we set virtio-baloon-pci.class=PCI_CLASS_MEMORY_RAM at
pc_i440fx_1_0_machine_options()), but it is pointless when we are
already providing a number literal.

Replace stringify() with string literals when appropriate.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/machine.c |  8 ++--
 hw/i386/pc.c      | 94 +++++++++++++++++++++++------------------------
 hw/i386/pc_piix.c | 30 +++++++--------
 hw/ppc/spapr.c    |  2 +-
 4 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index f8563efb86..4b4d6c23de 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -135,11 +135,11 @@ GlobalProperty hw_compat_2_8[] = {
     {
         .driver   = "fw_cfg_mem",
         .property = "x-file-slots",
-        .value    = stringify(0x10),
+        .value    = "0x10",
     },{
         .driver   = "fw_cfg_io",
         .property = "x-file-slots",
-        .value    = stringify(0x10),
+        .value    = "0x10",
     },{
         .driver   = "pflash_cfi01",
         .property = "old-multiple-chip-handling",
@@ -337,11 +337,11 @@ GlobalProperty hw_compat_2_1[] = {
     },{
         .driver   = "usb-mouse",
         .property = "usb_version",
-        .value    = stringify(1),
+        .value    = "1",
     },{
         .driver   = "usb-kbd",
         .property = "usb_version",
-        .value    = stringify(1),
+        .value    = "1",
     },{
         .driver   = "virtio-pci",
         .property = "virtio-pci-bus-master-bug-migration",
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4952feb476..ff14b6d4df 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -148,11 +148,11 @@ GlobalProperty pc_compat_2_12[] = {
     },{
         .driver   = "EPYC-" TYPE_X86_CPU,
         .property = "xlevel",
-        .value    = stringify(0x8000000a),
+        .value    = "0x8000000a",
     },{
         .driver   = "EPYC-IBPB-" TYPE_X86_CPU,
         .property = "xlevel",
-        .value    = stringify(0x8000000a),
+        .value    = "0x8000000a",
     },
 };
 const size_t pc_compat_2_12_len = G_N_ELEMENTS(pc_compat_2_12);
@@ -191,7 +191,7 @@ GlobalProperty pc_compat_2_9[] = {
     {
         .driver   = "mch",
         .property = "extended-tseg-mbytes",
-        .value    = stringify(0),
+        .value    = "0",
     },
 };
 const size_t pc_compat_2_9_len = G_N_ELEMENTS(pc_compat_2_9);
@@ -365,75 +365,75 @@ GlobalProperty pc_compat_2_3[] = {
     },{
         .driver   = "qemu64" "-" TYPE_X86_CPU,
         .property = "min-level",
-        .value    = stringify(4),
+        .value    = "4",
     },{
         .driver   = "kvm64" "-" TYPE_X86_CPU,
         .property = "min-level",
-        .value    = stringify(5),
+        .value    = "5",
     },{
         .driver   = "pentium3" "-" TYPE_X86_CPU,
         .property = "min-level",
-        .value    = stringify(2),
+        .value    = "2",
     },{
         .driver   = "n270" "-" TYPE_X86_CPU,
         .property = "min-level",
-        .value    = stringify(5),
+        .value    = "5",
     },{
         .driver   = "Conroe" "-" TYPE_X86_CPU,
         .property = "min-level",
-        .value    = stringify(4),
+        .value    = "4",
     },{
         .driver   = "Penryn" "-" TYPE_X86_CPU,
         .property = "min-level",
-        .value    = stringify(4),
+        .value    = "4",
     },{
         .driver   = "Nehalem" "-" TYPE_X86_CPU,
         .property = "min-level",
-        .value    = stringify(4),
+        .value    = "4",
     },{
         .driver   = "n270" "-" TYPE_X86_CPU,
         .property = "min-xlevel",
-        .value    = stringify(0x8000000a),
+        .value    = "0x8000000a",
     },{
         .driver   = "Penryn" "-" TYPE_X86_CPU,
         .property = "min-xlevel",
-        .value    = stringify(0x8000000a),
+        .value    = "0x8000000a",
     },{
         .driver   = "Conroe" "-" TYPE_X86_CPU,
         .property = "min-xlevel",
-        .value    = stringify(0x8000000a),
+        .value    = "0x8000000a",
     },{
         .driver   = "Nehalem" "-" TYPE_X86_CPU,
         .property = "min-xlevel",
-        .value    = stringify(0x8000000a),
+        .value    = "0x8000000a",
     },{
         .driver   = "Westmere" "-" TYPE_X86_CPU,
         .property = "min-xlevel",
-        .value    = stringify(0x8000000a),
+        .value    = "0x8000000a",
     },{
         .driver   = "SandyBridge" "-" TYPE_X86_CPU,
         .property = "min-xlevel",
-        .value    = stringify(0x8000000a),
+        .value    = "0x8000000a",
     },{
         .driver   = "IvyBridge" "-" TYPE_X86_CPU,
         .property = "min-xlevel",
-        .value    = stringify(0x8000000a),
+        .value    = "0x8000000a",
     },{
         .driver   = "Haswell" "-" TYPE_X86_CPU,
         .property = "min-xlevel",
-        .value    = stringify(0x8000000a),
+        .value    = "0x8000000a",
     },{
         .driver   = "Haswell-noTSX" "-" TYPE_X86_CPU,
         .property = "min-xlevel",
-        .value    = stringify(0x8000000a),
+        .value    = "0x8000000a",
     },{
         .driver   = "Broadwell" "-" TYPE_X86_CPU,
         .property = "min-xlevel",
-        .value    = stringify(0x8000000a),
+        .value    = "0x8000000a",
     },{
         .driver   = "Broadwell-noTSX" "-" TYPE_X86_CPU,
         .property = "min-xlevel",
-        .value    = stringify(0x8000000a),
+        .value    = "0x8000000a",
     },{
         .driver = TYPE_X86_CPU,
         .property = "kvm-no-smi-migration",
@@ -566,7 +566,7 @@ GlobalProperty pc_compat_2_0[] = {
     {
         .driver   = "apic",
         .property = "version",
-        .value    = stringify(0x11),
+        .value    = "0x11",
     },
     {
         .driver   = "nec-usb-xhci",
@@ -581,17 +581,17 @@ GlobalProperty pc_compat_2_0[] = {
     {
         .driver   = "pci-serial",
         .property = "prog_if",
-        .value    = stringify(0),
+        .value    = "0",
     },
     {
         .driver   = "pci-serial-2x",
         .property = "prog_if",
-        .value    = stringify(0),
+        .value    = "0",
     },
     {
         .driver   = "pci-serial-4x",
         .property = "prog_if",
-        .value    = stringify(0),
+        .value    = "0",
     },
     {
         .driver   = "virtio-net-pci",
@@ -629,7 +629,7 @@ GlobalProperty pc_compat_1_7[] = {
     {
         .driver   = "hpet",
         .property = HPET_INTCAP,
-        .value    = stringify(4),
+        .value    = "4",
     },
 };
 const size_t pc_compat_1_7_len = G_N_ELEMENTS(pc_compat_1_7);
@@ -643,19 +643,19 @@ GlobalProperty pc_compat_1_6[] = {
     },{
         .driver   = "qemu64-" TYPE_X86_CPU,
         .property = "model",
-        .value    = stringify(2),
+        .value    = "2",
     },{
         .driver   = "qemu32-" TYPE_X86_CPU,
         .property = "model",
-        .value    = stringify(3),
+        .value    = "3",
     },{
         .driver   = "i440FX-pcihost",
         .property = "short_root_bus",
-        .value    = stringify(1),
+        .value    = "1",
     },{
         .driver   = "q35-pcihost",
         .property = "short_root_bus",
-        .value    = stringify(1),
+        .value    = "1",
     },
 };
 const size_t pc_compat_1_6_len = G_N_ELEMENTS(pc_compat_1_6);
@@ -665,27 +665,27 @@ GlobalProperty pc_compat_1_5[] = {
     {
         .driver   = "Conroe-" TYPE_X86_CPU,
         .property = "model",
-        .value    = stringify(2),
+        .value    = "2",
     },{
         .driver   = "Conroe-" TYPE_X86_CPU,
         .property = "min-level",
-        .value    = stringify(2),
+        .value    = "2",
     },{
         .driver   = "Penryn-" TYPE_X86_CPU,
         .property = "model",
-        .value    = stringify(2),
+        .value    = "2",
     },{
         .driver   = "Penryn-" TYPE_X86_CPU,
         .property = "min-level",
-        .value    = stringify(2),
+        .value    = "2",
     },{
         .driver   = "Nehalem-" TYPE_X86_CPU,
         .property = "model",
-        .value    = stringify(2),
+        .value    = "2",
     },{
         .driver   = "Nehalem-" TYPE_X86_CPU,
         .property = "min-level",
-        .value    = stringify(2),
+        .value    = "2",
     },{
         .driver   = "virtio-net-pci",
         .property = "any_layout",
@@ -697,11 +697,11 @@ GlobalProperty pc_compat_1_5[] = {
     },{
         .driver   = "i440FX-pcihost",
         .property = "short_root_bus",
-        .value    = stringify(0),
+        .value    = "0",
     },{
         .driver   = "q35-pcihost",
         .property = "short_root_bus",
-        .value    = stringify(0),
+        .value    = "0",
     },
 };
 const size_t pc_compat_1_5_len = G_N_ELEMENTS(pc_compat_1_5);
@@ -711,36 +711,36 @@ GlobalProperty pc_compat_1_4[] = {
     {
         .driver   = "scsi-hd",
         .property = "discard_granularity",
-        .value    = stringify(0),
+        .value    = "0",
     },{
         .driver   = "scsi-cd",
         .property = "discard_granularity",
-        .value    = stringify(0),
+        .value    = "0",
     },{
         .driver   = "scsi-disk",
         .property = "discard_granularity",
-        .value    = stringify(0),
+        .value    = "0",
     },{
         .driver   = "ide-hd",
         .property = "discard_granularity",
-        .value    = stringify(0),
+        .value    = "0",
     },{
         .driver   = "ide-cd",
         .property = "discard_granularity",
-        .value    = stringify(0),
+        .value    = "0",
     },{
         .driver   = "ide-drive",
         .property = "discard_granularity",
-        .value    = stringify(0),
+        .value    = "0",
     },{
         .driver   = "virtio-blk-pci",
         .property = "discard_granularity",
-        .value    = stringify(0),
+        .value    = "0",
     },{
         .driver   = "virtio-serial-pci",
         .property = "vectors",
         /* DEV_NVECTORS_UNSPECIFIED as a uint32_t string */
-        .value    = stringify(0xFFFFFFFF),
+        .value    = "0xFFFFFFFF",
     },{
         .driver   = "virtio-net-pci",
         .property = "ctrl_guest_offloads",
@@ -768,7 +768,7 @@ GlobalProperty pc_compat_1_4[] = {
     },{
         .driver   = "486-" TYPE_X86_CPU,
         .property = "model",
-        .value    = stringify(0),
+        .value    = "0",
     },
     {
         .driver = "n270" "-" TYPE_X86_CPU,
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ed6984638e..fd20227af3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -697,7 +697,7 @@ static void pc_i440fx_1_3_machine_options(MachineClass *m)
         {
             .driver   = "usb-tablet",
             .property = "usb_version",
-            .value    = stringify(1),
+            .value    = "1",
         },{
             .driver   = "virtio-net-pci",
             .property = "ctrl_mac_addr",
@@ -741,11 +741,11 @@ static void pc_i440fx_1_2_machine_options(MachineClass *m)
         },{
             .driver   = "qxl",
             .property = "revision",
-            .value    = stringify(3),
+            .value    = "3",
         },{
             .driver   = "qxl-vga",
             .property = "revision",
-            .value    = stringify(3),
+            .value    = "3",
         },{
             .driver   = "VGA",
             .property = "mmio",
@@ -777,19 +777,19 @@ static void pc_i440fx_1_1_machine_options(MachineClass *m)
         },{
             .driver   = "VGA",
             .property = "vgamem_mb",
-            .value    = stringify(8),
+            .value    = "8",
         },{
             .driver   = "vmware-svga",
             .property = "vgamem_mb",
-            .value    = stringify(8),
+            .value    = "8",
         },{
             .driver   = "qxl-vga",
             .property = "vgamem_mb",
-            .value    = stringify(8),
+            .value    = "8",
         },{
             .driver   = "qxl",
             .property = "vgamem_mb",
-            .value    = stringify(8),
+            .value    = "8",
         },{
             .driver   = "virtio-blk-pci",
             .property = "config-wce",
@@ -876,11 +876,11 @@ static void pc_i440fx_0_14_machine_options(MachineClass *m)
         },{
             .driver   = "qxl",
             .property = "revision",
-            .value    = stringify(2),
+            .value    = "2",
         },{
             .driver   = "qxl-vga",
             .property = "revision",
-            .value    = stringify(2),
+            .value    = "2",
         },
     };
 
@@ -904,19 +904,19 @@ static void pc_i440fx_0_13_machine_options(MachineClass *m)
         },{
             .driver   = "AC97",
             .property = "use_broken_id",
-            .value    = stringify(1),
+            .value    = "1",
         },{
             .driver   = "virtio-9p-pci",
             .property = "vectors",
-            .value    = stringify(0),
+            .value    = "0",
         },{
             .driver   = "VGA",
             .property = "rombar",
-            .value    = stringify(0),
+            .value    = "0",
         },{
             .driver   = "vmware-svga",
             .property = "rombar",
-            .value    = stringify(0),
+            .value    = "0",
         },
     };
 
@@ -936,11 +936,11 @@ static void pc_i440fx_0_12_machine_options(MachineClass *m)
         {
             .driver   = "virtio-serial-pci",
             .property = "max_ports",
-            .value    = stringify(1),
+            .value    = "1",
         },{
             .driver   = "virtio-serial-pci",
             .property = "vectors",
-            .value    = stringify(0),
+            .value    = "0",
         },{
             .driver   = "usb-mouse",
             .property = "serial",
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bff42f0adb..d7d87b0ae8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4264,7 +4264,7 @@ static void spapr_machine_2_6_class_options(MachineClass *mc)
         {
             .driver   = TYPE_SPAPR_PCI_HOST_BRIDGE,
             .property = "ddw",
-            .value    = stringify(off),
+            .value    = "off",
         },
     };
 
-- 
2.18.0.rc1.1.g3f1ff2140
