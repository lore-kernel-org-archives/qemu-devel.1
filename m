Received: from eggs.gnu.org ([2001:4830:134:3::10]:54108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCPG-0003Zt-5x
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:51:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCPD-0006yP-Ey
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:51:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXCP7-0006v2-NK
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:50:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 72EBD7F6B2
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 21:50:51 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 01:48:43 +0400
Message-Id: <20181212214850.29953-22-marcandre.lureau@redhat.com>
In-Reply-To: <20181212214850.29953-1-marcandre.lureau@redhat.com>
References: <20181212214850.29953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 21/28] compat: remove remaining PC_COMPAT
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com

Use static arrays instead.  I decided to rename the conflicting
pc_compat_2_1() function with pc_compat_2_1_fn().

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/i386/pc.h | 236 +++----------------------------------------
 hw/i386/pc.c         | 232 ++++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc_piix.c    |  57 ++++-------
 3 files changed, 267 insertions(+), 258 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 6b7bf334cd..84720bede9 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -335,6 +335,21 @@ extern const size_t pc_compat_2_2_len;
 extern GlobalProperty pc_compat_2_1[];
 extern const size_t pc_compat_2_1_len;
=20
+extern GlobalProperty pc_compat_2_0[];
+extern const size_t pc_compat_2_0_len;
+
+extern GlobalProperty pc_compat_1_7[];
+extern const size_t pc_compat_1_7_len;
+
+extern GlobalProperty pc_compat_1_6[];
+extern const size_t pc_compat_1_6_len;
+
+extern GlobalProperty pc_compat_1_5[];
+extern const size_t pc_compat_1_5_len;
+
+extern GlobalProperty pc_compat_1_4[];
+extern const size_t pc_compat_1_4_len;
+
 /* Helper for setting model-id for CPU models that changed model-id
  * depending on QEMU versions up to QEMU 2.4.
  */
@@ -355,227 +370,6 @@ extern const size_t pc_compat_2_1_len;
         .value    =3D "QEMU Virtual CPU version " v,\
     },
=20
-#define PC_COMPAT_2_0 \
-    PC_CPU_MODEL_IDS("2.0.0") \
-    {\
-        .driver   =3D "virtio-scsi-pci",\
-        .property =3D "any_layout",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "PIIX4_PM",\
-        .property =3D "memory-hotplug-support",\
-        .value    =3D "off",\
-    },\
-    {\
-        .driver   =3D "apic",\
-        .property =3D "version",\
-        .value    =3D stringify(0x11),\
-    },\
-    {\
-        .driver   =3D "nec-usb-xhci",\
-        .property =3D "superspeed-ports-first",\
-        .value    =3D "off",\
-    },\
-    {\
-        .driver   =3D "nec-usb-xhci",\
-        .property =3D "force-pcie-endcap",\
-        .value    =3D "on",\
-    },\
-    {\
-        .driver   =3D "pci-serial",\
-        .property =3D "prog_if",\
-        .value    =3D stringify(0),\
-    },\
-    {\
-        .driver   =3D "pci-serial-2x",\
-        .property =3D "prog_if",\
-        .value    =3D stringify(0),\
-    },\
-    {\
-        .driver   =3D "pci-serial-4x",\
-        .property =3D "prog_if",\
-        .value    =3D stringify(0),\
-    },\
-    {\
-        .driver   =3D "virtio-net-pci",\
-        .property =3D "guest_announce",\
-        .value    =3D "off",\
-    },\
-    {\
-        .driver   =3D "ICH9-LPC",\
-        .property =3D "memory-hotplug-support",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "xio3130-downstream",\
-        .property =3D COMPAT_PROP_PCP,\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "ioh3420",\
-        .property =3D COMPAT_PROP_PCP,\
-        .value    =3D "off",\
-    },
-
-#define PC_COMPAT_1_7 \
-    PC_CPU_MODEL_IDS("1.7.0") \
-    {\
-        .driver   =3D TYPE_USB_DEVICE,\
-        .property =3D "msos-desc",\
-        .value    =3D "no",\
-    },\
-    {\
-        .driver   =3D "PIIX4_PM",\
-        .property =3D "acpi-pci-hotplug-with-bridge-support",\
-        .value    =3D "off",\
-    },\
-    {\
-        .driver   =3D "hpet",\
-        .property =3D HPET_INTCAP,\
-        .value    =3D stringify(4),\
-    },
-
-#define PC_COMPAT_1_6 \
-    PC_CPU_MODEL_IDS("1.6.0") \
-    {\
-        .driver   =3D "e1000",\
-        .property =3D "mitigation",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "qemu64-" TYPE_X86_CPU,\
-        .property =3D "model",\
-        .value    =3D stringify(2),\
-    },{\
-        .driver   =3D "qemu32-" TYPE_X86_CPU,\
-        .property =3D "model",\
-        .value    =3D stringify(3),\
-    },{\
-        .driver   =3D "i440FX-pcihost",\
-        .property =3D "short_root_bus",\
-        .value    =3D stringify(1),\
-    },{\
-        .driver   =3D "q35-pcihost",\
-        .property =3D "short_root_bus",\
-        .value    =3D stringify(1),\
-    },
-
-#define PC_COMPAT_1_5 \
-    PC_CPU_MODEL_IDS("1.5.0") \
-    {\
-        .driver   =3D "Conroe-" TYPE_X86_CPU,\
-        .property =3D "model",\
-        .value    =3D stringify(2),\
-    },{\
-        .driver   =3D "Conroe-" TYPE_X86_CPU,\
-        .property =3D "min-level",\
-        .value    =3D stringify(2),\
-    },{\
-        .driver   =3D "Penryn-" TYPE_X86_CPU,\
-        .property =3D "model",\
-        .value    =3D stringify(2),\
-    },{\
-        .driver   =3D "Penryn-" TYPE_X86_CPU,\
-        .property =3D "min-level",\
-        .value    =3D stringify(2),\
-    },{\
-        .driver   =3D "Nehalem-" TYPE_X86_CPU,\
-        .property =3D "model",\
-        .value    =3D stringify(2),\
-    },{\
-        .driver   =3D "Nehalem-" TYPE_X86_CPU,\
-        .property =3D "min-level",\
-        .value    =3D stringify(2),\
-    },{\
-        .driver   =3D "virtio-net-pci",\
-        .property =3D "any_layout",\
-        .value    =3D "off",\
-    },{\
-        .driver =3D TYPE_X86_CPU,\
-        .property =3D "pmu",\
-        .value =3D "on",\
-    },{\
-        .driver   =3D "i440FX-pcihost",\
-        .property =3D "short_root_bus",\
-        .value    =3D stringify(0),\
-    },{\
-        .driver   =3D "q35-pcihost",\
-        .property =3D "short_root_bus",\
-        .value    =3D stringify(0),\
-    },
-
-#define PC_COMPAT_1_4 \
-    PC_CPU_MODEL_IDS("1.4.0") \
-    {\
-        .driver   =3D "scsi-hd",\
-        .property =3D "discard_granularity",\
-        .value    =3D stringify(0),\
-    },{\
-        .driver   =3D "scsi-cd",\
-        .property =3D "discard_granularity",\
-        .value    =3D stringify(0),\
-    },{\
-        .driver   =3D "scsi-disk",\
-        .property =3D "discard_granularity",\
-        .value    =3D stringify(0),\
-    },{\
-        .driver   =3D "ide-hd",\
-        .property =3D "discard_granularity",\
-        .value    =3D stringify(0),\
-    },{\
-        .driver   =3D "ide-cd",\
-        .property =3D "discard_granularity",\
-        .value    =3D stringify(0),\
-    },{\
-        .driver   =3D "ide-drive",\
-        .property =3D "discard_granularity",\
-        .value    =3D stringify(0),\
-    },{\
-        .driver   =3D "virtio-blk-pci",\
-        .property =3D "discard_granularity",\
-        .value    =3D stringify(0),\
-    },{\
-        .driver   =3D "virtio-serial-pci",\
-        .property =3D "vectors",\
-        /* DEV_NVECTORS_UNSPECIFIED as a uint32_t string */\
-        .value    =3D stringify(0xFFFFFFFF),\
-    },{ \
-        .driver   =3D "virtio-net-pci", \
-        .property =3D "ctrl_guest_offloads", \
-        .value    =3D "off", \
-    },{\
-        .driver   =3D "e1000",\
-        .property =3D "romfile",\
-        .value    =3D "pxe-e1000.rom",\
-    },{\
-        .driver   =3D "ne2k_pci",\
-        .property =3D "romfile",\
-        .value    =3D "pxe-ne2k_pci.rom",\
-    },{\
-        .driver   =3D "pcnet",\
-        .property =3D "romfile",\
-        .value    =3D "pxe-pcnet.rom",\
-    },{\
-        .driver   =3D "rtl8139",\
-        .property =3D "romfile",\
-        .value    =3D "pxe-rtl8139.rom",\
-    },{\
-        .driver   =3D "virtio-net-pci",\
-        .property =3D "romfile",\
-        .value    =3D "pxe-virtio.rom",\
-    },{\
-        .driver   =3D "486-" TYPE_X86_CPU,\
-        .property =3D "model",\
-        .value    =3D stringify(0),\
-    },\
-    {\
-        .driver =3D "n270" "-" TYPE_X86_CPU,\
-        .property =3D "movbe",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver =3D "Westmere" "-" TYPE_X86_CPU,\
-        .property =3D "pclmulqdq",\
-        .value =3D "off",\
-    },
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *=
data) \
     { \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 46132827e5..04fecb5811 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -72,6 +72,7 @@
 #include "qapi/visitor.h"
 #include "qom/cpu.h"
 #include "hw/nmi.h"
+#include "hw/usb.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
=20
@@ -545,6 +546,237 @@ GlobalProperty pc_compat_2_1[] =3D {
 };
 const size_t pc_compat_2_1_len =3D G_N_ELEMENTS(pc_compat_2_1);
=20
+GlobalProperty pc_compat_2_0[] =3D {
+    PC_CPU_MODEL_IDS("2.0.0")
+    {
+        .driver   =3D "virtio-scsi-pci",
+        .property =3D "any_layout",
+        .value    =3D "off",
+    },{
+        .driver   =3D "PIIX4_PM",
+        .property =3D "memory-hotplug-support",
+        .value    =3D "off",
+    },
+    {
+        .driver   =3D "apic",
+        .property =3D "version",
+        .value    =3D stringify(0x11),
+    },
+    {
+        .driver   =3D "nec-usb-xhci",
+        .property =3D "superspeed-ports-first",
+        .value    =3D "off",
+    },
+    {
+        .driver   =3D "nec-usb-xhci",
+        .property =3D "force-pcie-endcap",
+        .value    =3D "on",
+    },
+    {
+        .driver   =3D "pci-serial",
+        .property =3D "prog_if",
+        .value    =3D stringify(0),
+    },
+    {
+        .driver   =3D "pci-serial-2x",
+        .property =3D "prog_if",
+        .value    =3D stringify(0),
+    },
+    {
+        .driver   =3D "pci-serial-4x",
+        .property =3D "prog_if",
+        .value    =3D stringify(0),
+    },
+    {
+        .driver   =3D "virtio-net-pci",
+        .property =3D "guest_announce",
+        .value    =3D "off",
+    },
+    {
+        .driver   =3D "ICH9-LPC",
+        .property =3D "memory-hotplug-support",
+        .value    =3D "off",
+    },{
+        .driver   =3D "xio3130-downstream",
+        .property =3D COMPAT_PROP_PCP,
+        .value    =3D "off",
+    },{
+        .driver   =3D "ioh3420",
+        .property =3D COMPAT_PROP_PCP,
+        .value    =3D "off",
+    },
+};
+const size_t pc_compat_2_0_len =3D G_N_ELEMENTS(pc_compat_2_0);
+
+GlobalProperty pc_compat_1_7[] =3D {
+    PC_CPU_MODEL_IDS("1.7.0")
+    {
+        .driver   =3D TYPE_USB_DEVICE,
+        .property =3D "msos-desc",
+        .value    =3D "no",
+    },
+    {
+        .driver   =3D "PIIX4_PM",
+        .property =3D "acpi-pci-hotplug-with-bridge-support",
+        .value    =3D "off",
+    },
+    {
+        .driver   =3D "hpet",
+        .property =3D HPET_INTCAP,
+        .value    =3D stringify(4),
+    },
+};
+const size_t pc_compat_1_7_len =3D G_N_ELEMENTS(pc_compat_1_7);
+
+GlobalProperty pc_compat_1_6[] =3D {
+    PC_CPU_MODEL_IDS("1.6.0")
+    {
+        .driver   =3D "e1000",
+        .property =3D "mitigation",
+        .value    =3D "off",
+    },{
+        .driver   =3D "qemu64-" TYPE_X86_CPU,
+        .property =3D "model",
+        .value    =3D stringify(2),
+    },{
+        .driver   =3D "qemu32-" TYPE_X86_CPU,
+        .property =3D "model",
+        .value    =3D stringify(3),
+    },{
+        .driver   =3D "i440FX-pcihost",
+        .property =3D "short_root_bus",
+        .value    =3D stringify(1),
+    },{
+        .driver   =3D "q35-pcihost",
+        .property =3D "short_root_bus",
+        .value    =3D stringify(1),
+    },
+};
+const size_t pc_compat_1_6_len =3D G_N_ELEMENTS(pc_compat_1_6);
+
+GlobalProperty pc_compat_1_5[] =3D {
+    PC_CPU_MODEL_IDS("1.5.0")
+    {
+        .driver   =3D "Conroe-" TYPE_X86_CPU,
+        .property =3D "model",
+        .value    =3D stringify(2),
+    },{
+        .driver   =3D "Conroe-" TYPE_X86_CPU,
+        .property =3D "min-level",
+        .value    =3D stringify(2),
+    },{
+        .driver   =3D "Penryn-" TYPE_X86_CPU,
+        .property =3D "model",
+        .value    =3D stringify(2),
+    },{
+        .driver   =3D "Penryn-" TYPE_X86_CPU,
+        .property =3D "min-level",
+        .value    =3D stringify(2),
+    },{
+        .driver   =3D "Nehalem-" TYPE_X86_CPU,
+        .property =3D "model",
+        .value    =3D stringify(2),
+    },{
+        .driver   =3D "Nehalem-" TYPE_X86_CPU,
+        .property =3D "min-level",
+        .value    =3D stringify(2),
+    },{
+        .driver   =3D "virtio-net-pci",
+        .property =3D "any_layout",
+        .value    =3D "off",
+    },{
+        .driver =3D TYPE_X86_CPU,
+        .property =3D "pmu",
+        .value =3D "on",
+    },{
+        .driver   =3D "i440FX-pcihost",
+        .property =3D "short_root_bus",
+        .value    =3D stringify(0),
+    },{
+        .driver   =3D "q35-pcihost",
+        .property =3D "short_root_bus",
+        .value    =3D stringify(0),
+    },
+};
+const size_t pc_compat_1_5_len =3D G_N_ELEMENTS(pc_compat_1_5);
+
+GlobalProperty pc_compat_1_4[] =3D {
+    PC_CPU_MODEL_IDS("1.4.0")
+    {
+        .driver   =3D "scsi-hd",
+        .property =3D "discard_granularity",
+        .value    =3D stringify(0),
+    },{
+        .driver   =3D "scsi-cd",
+        .property =3D "discard_granularity",
+        .value    =3D stringify(0),
+    },{
+        .driver   =3D "scsi-disk",
+        .property =3D "discard_granularity",
+        .value    =3D stringify(0),
+    },{
+        .driver   =3D "ide-hd",
+        .property =3D "discard_granularity",
+        .value    =3D stringify(0),
+    },{
+        .driver   =3D "ide-cd",
+        .property =3D "discard_granularity",
+        .value    =3D stringify(0),
+    },{
+        .driver   =3D "ide-drive",
+        .property =3D "discard_granularity",
+        .value    =3D stringify(0),
+    },{
+        .driver   =3D "virtio-blk-pci",
+        .property =3D "discard_granularity",
+        .value    =3D stringify(0),
+    },{
+        .driver   =3D "virtio-serial-pci",
+        .property =3D "vectors",
+        /* DEV_NVECTORS_UNSPECIFIED as a uint32_t string */
+        .value    =3D stringify(0xFFFFFFFF),
+    },{
+        .driver   =3D "virtio-net-pci",
+        .property =3D "ctrl_guest_offloads",
+        .value    =3D "off",
+    },{
+        .driver   =3D "e1000",
+        .property =3D "romfile",
+        .value    =3D "pxe-e1000.rom",
+    },{
+        .driver   =3D "ne2k_pci",
+        .property =3D "romfile",
+        .value    =3D "pxe-ne2k_pci.rom",
+    },{
+        .driver   =3D "pcnet",
+        .property =3D "romfile",
+        .value    =3D "pxe-pcnet.rom",
+    },{
+        .driver   =3D "rtl8139",
+        .property =3D "romfile",
+        .value    =3D "pxe-rtl8139.rom",
+    },{
+        .driver   =3D "virtio-net-pci",
+        .property =3D "romfile",
+        .value    =3D "pxe-virtio.rom",
+    },{
+        .driver   =3D "486-" TYPE_X86_CPU,
+        .property =3D "model",
+        .value    =3D stringify(0),
+    },
+    {
+        .driver =3D "n270" "-" TYPE_X86_CPU,
+        .property =3D "movbe",
+        .value =3D "off",
+    },
+    {
+        .driver =3D "Westmere" "-" TYPE_X86_CPU,
+        .property =3D "pclmulqdq",
+        .value =3D "off",
+    },
+};
+const size_t pc_compat_1_4_len =3D G_N_ELEMENTS(pc_compat_1_4);
+
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c7b5e0a3ad..1c77119877 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -329,35 +329,35 @@ static void pc_compat_2_1_fn(MachineState *machine)
     x86_cpu_change_kvm_default("svm", NULL);
 }
=20
-static void pc_compat_2_0(MachineState *machine)
+static void pc_compat_2_0_fn(MachineState *machine)
 {
     pc_compat_2_1_fn(machine);
 }
=20
-static void pc_compat_1_7(MachineState *machine)
+static void pc_compat_1_7_fn(MachineState *machine)
 {
-    pc_compat_2_0(machine);
+    pc_compat_2_0_fn(machine);
     x86_cpu_change_kvm_default("x2apic", NULL);
 }
=20
-static void pc_compat_1_6(MachineState *machine)
+static void pc_compat_1_6_fn(MachineState *machine)
 {
-    pc_compat_1_7(machine);
+    pc_compat_1_7_fn(machine);
 }
=20
-static void pc_compat_1_5(MachineState *machine)
+static void pc_compat_1_5_fn(MachineState *machine)
 {
-    pc_compat_1_6(machine);
+    pc_compat_1_6_fn(machine);
 }
=20
-static void pc_compat_1_4(MachineState *machine)
+static void pc_compat_1_4_fn(MachineState *machine)
 {
-    pc_compat_1_5(machine);
+    pc_compat_1_5_fn(machine);
 }
=20
 static void pc_compat_1_3(MachineState *machine)
 {
-    pc_compat_1_4(machine);
+    pc_compat_1_4_fn(machine);
     enable_compat_apic_id_mode();
 }
=20
@@ -609,13 +609,10 @@ DEFINE_I440FX_MACHINE(v2_1, "pc-i440fx-2.1", pc_com=
pat_2_1_fn,
 static void pc_i440fx_2_0_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_0
-    };
=20
     pc_i440fx_2_1_machine_options(m);
     m->hw_version =3D "2.0.0";
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, pc_compat_2_0, pc_compat_2_0_len);
     pcmc->smbios_legacy_mode =3D true;
     pcmc->has_reserved_memory =3D false;
     /* This value depends on the actual DSDT and SSDT compiled into
@@ -638,73 +635,59 @@ static void pc_i440fx_2_0_machine_options(MachineCl=
ass *m)
     pcmc->acpi_data_size =3D 0x10000;
 }
=20
-DEFINE_I440FX_MACHINE(v2_0, "pc-i440fx-2.0", pc_compat_2_0,
+DEFINE_I440FX_MACHINE(v2_0, "pc-i440fx-2.0", pc_compat_2_0_fn,
                       pc_i440fx_2_0_machine_options);
=20
 static void pc_i440fx_1_7_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_1_7
-    };
=20
     pc_i440fx_2_0_machine_options(m);
     m->hw_version =3D "1.7.0";
     m->default_machine_opts =3D NULL;
     m->option_rom_has_mr =3D true;
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, pc_compat_1_7, pc_compat_1_7_len);
     pcmc->smbios_defaults =3D false;
     pcmc->gigabyte_align =3D false;
     pcmc->legacy_acpi_table_size =3D 6414;
 }
=20
-DEFINE_I440FX_MACHINE(v1_7, "pc-i440fx-1.7", pc_compat_1_7,
+DEFINE_I440FX_MACHINE(v1_7, "pc-i440fx-1.7", pc_compat_1_7_fn,
                       pc_i440fx_1_7_machine_options);
=20
 static void pc_i440fx_1_6_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_1_6
-    };
=20
     pc_i440fx_1_7_machine_options(m);
     m->hw_version =3D "1.6.0";
     m->rom_file_has_mr =3D false;
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, pc_compat_1_6, pc_compat_1_6_len);
     pcmc->has_acpi_build =3D false;
 }
=20
-DEFINE_I440FX_MACHINE(v1_6, "pc-i440fx-1.6", pc_compat_1_6,
+DEFINE_I440FX_MACHINE(v1_6, "pc-i440fx-1.6", pc_compat_1_6_fn,
                       pc_i440fx_1_6_machine_options);
=20
 static void pc_i440fx_1_5_machine_options(MachineClass *m)
 {
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_1_5
-    };
-
     pc_i440fx_1_6_machine_options(m);
     m->hw_version =3D "1.5.0";
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, pc_compat_1_5, pc_compat_1_5_len);
 }
=20
-DEFINE_I440FX_MACHINE(v1_5, "pc-i440fx-1.5", pc_compat_1_5,
+DEFINE_I440FX_MACHINE(v1_5, "pc-i440fx-1.5", pc_compat_1_5_fn,
                       pc_i440fx_1_5_machine_options);
=20
 static void pc_i440fx_1_4_machine_options(MachineClass *m)
 {
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_1_4
-    };
-
     pc_i440fx_1_5_machine_options(m);
     m->hw_version =3D "1.4.0";
     m->hot_add_cpu =3D NULL;
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, pc_compat_1_4, pc_compat_1_4_len);
 }
=20
-DEFINE_I440FX_MACHINE(v1_4, "pc-i440fx-1.4", pc_compat_1_4,
+DEFINE_I440FX_MACHINE(v1_4, "pc-i440fx-1.4", pc_compat_1_4_fn,
                       pc_i440fx_1_4_machine_options);
=20
 static void pc_i440fx_1_3_machine_options(MachineClass *m)
--=20
2.20.0
