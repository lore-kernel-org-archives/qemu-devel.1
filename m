Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6A1C35242
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC182067D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC182067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3b9X-0007xf-Vf
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 02:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b30-0004Mn-3w
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b2x-0000Zq-6j
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:30 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36472 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
 id 1j3b2q-0000JB-FC; Mon, 17 Feb 2020 02:42:21 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id EFF76E45A823E766DEB0;
 Mon, 17 Feb 2020 15:42:13 +0800 (CST)
Received: from localhost (10.175.124.177) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 15:42:03 +0800
From: Xu Yandong <xuyandong2@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH RFC 01/16] hw/arm/arm: Introduce ArmMachineState and
 ArmMachineClass
Date: Mon, 17 Feb 2020 02:51:13 -0500
Message-ID: <1581925888-103620-2-git-send-email-xuyandong2@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
References: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.177]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: zhang.zhanghailiang@huawei.com, slp@redhat.com,
 Xu Yandong <xuyandong2@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the following patches, VirtMachineState and VirtMachineClass will
splited to and deriving ArmMachineState and ArmMachineClass.
This allows sharing code with other arm machine types.

Signed-off-by: Xu Yandong <xuyandong2@huawei.com>
---
 hw/arm/Makefile.objs  |   2 +-
 hw/arm/arm.c          |  77 ++++++++++++++++++++++++++++++++
 hw/arm/virt.c         |  11 +----
 include/hw/arm/arm.h  | 100 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h |  61 ++------------------------
 5 files changed, 183 insertions(+), 68 deletions(-)
 create mode 100644 hw/arm/arm.c
 create mode 100644 include/hw/arm/arm.h

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 336f6dd374..51fcee2ac8 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -1,6 +1,6 @@
 obj-y += boot.o
 obj-$(CONFIG_PLATFORM_BUS) += sysbus-fdt.o
-obj-$(CONFIG_ARM_VIRT) += virt.o
+obj-$(CONFIG_ARM_VIRT) += arm.o virt.o
 obj-$(CONFIG_ACPI) += virt-acpi-build.o
 obj-$(CONFIG_DIGIC) += digic_boards.o
 obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
diff --git a/hw/arm/arm.c b/hw/arm/arm.c
new file mode 100644
index 0000000000..4261d56832
--- /dev/null
+++ b/hw/arm/arm.c
@@ -0,0 +1,77 @@
+/*
+ * ARM mach-virt emulation
+ * Copyright (c) 2013 Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Emulate a virtual board which works by passing Linux all the information
+ * it needs about what devices are present via the device tree.
+ * There are some restrictions about what we can do here:
+ *  + we can only present devices whose Linux drivers will work based
+ *    purely on the device tree with no platform data at all
+ * This is essentially the same approach kvmtool uses.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/arm/arm.h"
+#include "sysemu/device_tree.h"
+#include "sysemu/numa.h"
+#include "hw/loader.h"
+#include "exec/address-spaces.h"
+#include "qemu/bitops.h"
+#include "qemu/error-report.h"
+#include "qemu/module.h"
+#include "hw/arm/sysbus-fdt.h"
+#include "hw/platform-bus.h"
+#include "hw/qdev-properties.h"
+#include "hw/arm/fdt.h"
+#include "hw/intc/arm_gic.h"
+#include "kvm_arm.h"
+
+static void arm_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->block_default_type = IF_VIRTIO;
+    mc->no_cdrom = 1;
+    mc->pci_allow_0_address = true;
+    /* We know we will never create a pre-ARMv7 CPU which needs 1K pages */
+    mc->minimum_page_bits = 12;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
+    mc->numa_mem_supported = true;
+    mc->auto_enable_numa_with_memhp = true;
+}
+
+static void arm_instance_init(Object *obj)
+{
+}
+
+static const TypeInfo arm_machine_info = {
+    .name          = TYPE_ARM_MACHINE,
+    .parent        = TYPE_MACHINE,
+    .abstract      = true,
+    .instance_size = sizeof(ArmMachineState),
+    .class_size    = sizeof(ArmMachineClass),
+    .class_init    = arm_machine_class_init,
+    .instance_init = arm_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+         { }
+    },
+};
+
+static void macharm_machine_init(void)
+{
+    type_register_static(&arm_machine_info);
+}
+type_init(macharm_machine_init);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f788fe27d6..355007fd32 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -37,6 +37,7 @@
 #include "hw/boards.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
+#include "hw/arm/arm.h"
 #include "hw/arm/virt.h"
 #include "hw/block/flash.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
@@ -2041,14 +2042,8 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
-    mc->block_default_type = IF_VIRTIO;
-    mc->no_cdrom = 1;
-    mc->pci_allow_0_address = true;
-    /* We know we will never create a pre-ARMv7 CPU which needs 1K pages */
-    mc->minimum_page_bits = 12;
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
     assert(!mc->get_hotplug_handler);
@@ -2056,8 +2051,6 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     hc->pre_plug = virt_machine_device_pre_plug_cb;
     hc->plug = virt_machine_device_plug_cb;
     hc->unplug_request = virt_machine_device_unplug_request_cb;
-    mc->numa_mem_supported = true;
-    mc->auto_enable_numa_with_memhp = true;
 }
 
 static void virt_instance_init(Object *obj)
@@ -2133,7 +2126,7 @@ static void virt_instance_init(Object *obj)
 
 static const TypeInfo virt_machine_info = {
     .name          = TYPE_VIRT_MACHINE,
-    .parent        = TYPE_MACHINE,
+    .parent        = TYPE_ARM_MACHINE,
     .abstract      = true,
     .instance_size = sizeof(VirtMachineState),
     .class_size    = sizeof(VirtMachineClass),
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
new file mode 100644
index 0000000000..2aa9ee3d05
--- /dev/null
+++ b/include/hw/arm/arm.h
@@ -0,0 +1,100 @@
+/*
+ * Copyright (c) 2015 Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.*
+ */
+
+#ifndef QEMU_ARM_ARM_H
+#define QEMU_ARM_ARM_H
+
+#include "exec/hwaddr.h"
+#include "hw/boards.h"
+#include "hw/arm/boot.h"
+#include "hw/intc/arm_gicv3_common.h"
+
+#define NUM_GICV2M_SPIS       64
+#define NUM_VIRTIO_TRANSPORTS 32
+#define NUM_SMMU_IRQS          4
+
+#define ARCH_GIC_MAINT_IRQ  9
+
+#define ARCH_TIMER_VIRT_IRQ   11
+#define ARCH_TIMER_S_EL1_IRQ  13
+#define ARCH_TIMER_NS_EL1_IRQ 14
+#define ARCH_TIMER_NS_EL2_IRQ 10
+
+#define VIRTUAL_PMU_IRQ 7
+
+#define PPI(irq) ((irq) + 16)
+
+
+enum {
+    VIRT_FLASH,
+    VIRT_MEM,
+    VIRT_CPUPERIPHS,
+    VIRT_GIC_DIST,
+    VIRT_GIC_CPU,
+    VIRT_GIC_V2M,
+    VIRT_GIC_HYP,
+    VIRT_GIC_VCPU,
+    VIRT_GIC_ITS,
+    VIRT_GIC_REDIST,
+    VIRT_SMMU,
+    VIRT_UART,
+    VIRT_MMIO,
+    VIRT_RTC,
+    VIRT_FW_CFG,
+    VIRT_PCIE,
+    VIRT_PCIE_MMIO,
+    VIRT_PCIE_PIO,
+    VIRT_PCIE_ECAM,
+    VIRT_PLATFORM_BUS,
+    VIRT_GPIO,
+    VIRT_SECURE_UART,
+    VIRT_SECURE_MEM,
+    VIRT_PCDIMM_ACPI,
+    VIRT_ACPI_GED,
+    VIRT_LOWMEMMAP_LAST,
+};
+
+/* indices of IO regions located after the RAM */
+enum {
+    VIRT_HIGH_GIC_REDIST2 =  VIRT_LOWMEMMAP_LAST,
+    VIRT_HIGH_PCIE_ECAM,
+    VIRT_HIGH_PCIE_MMIO,
+};
+
+/* indices of IO regions located after the RAM */
+
+typedef struct MemMapEntry {
+    hwaddr base;
+    hwaddr size;
+} MemMapEntry;
+
+typedef struct {
+    MachineClass parent;
+} ArmMachineClass;
+
+typedef struct {
+    MachineState parent;
+} ArmMachineState;
+
+#define TYPE_ARM_MACHINE   MACHINE_TYPE_NAME("arm")
+#define ARM_MACHINE(obj) \
+    OBJECT_CHECK(ArmMachineState, (obj), TYPE_ARM_MACHINE)
+#define ARM_MACHINE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(ArmMachineClass, obj, TYPE_ARM_MACHINE)
+#define ARM_MACHINE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(ArmMachineClass, klass, TYPE_ARM_MACHINE)
+
+#endif /* QEMU_ARM_ARM_H */
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 71508bf40c..aa0cc852a5 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -37,57 +37,7 @@
 #include "hw/block/flash.h"
 #include "sysemu/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
-
-#define NUM_GICV2M_SPIS       64
-#define NUM_VIRTIO_TRANSPORTS 32
-#define NUM_SMMU_IRQS          4
-
-#define ARCH_GIC_MAINT_IRQ  9
-
-#define ARCH_TIMER_VIRT_IRQ   11
-#define ARCH_TIMER_S_EL1_IRQ  13
-#define ARCH_TIMER_NS_EL1_IRQ 14
-#define ARCH_TIMER_NS_EL2_IRQ 10
-
-#define VIRTUAL_PMU_IRQ 7
-
-#define PPI(irq) ((irq) + 16)
-
-enum {
-    VIRT_FLASH,
-    VIRT_MEM,
-    VIRT_CPUPERIPHS,
-    VIRT_GIC_DIST,
-    VIRT_GIC_CPU,
-    VIRT_GIC_V2M,
-    VIRT_GIC_HYP,
-    VIRT_GIC_VCPU,
-    VIRT_GIC_ITS,
-    VIRT_GIC_REDIST,
-    VIRT_SMMU,
-    VIRT_UART,
-    VIRT_MMIO,
-    VIRT_RTC,
-    VIRT_FW_CFG,
-    VIRT_PCIE,
-    VIRT_PCIE_MMIO,
-    VIRT_PCIE_PIO,
-    VIRT_PCIE_ECAM,
-    VIRT_PLATFORM_BUS,
-    VIRT_GPIO,
-    VIRT_SECURE_UART,
-    VIRT_SECURE_MEM,
-    VIRT_PCDIMM_ACPI,
-    VIRT_ACPI_GED,
-    VIRT_LOWMEMMAP_LAST,
-};
-
-/* indices of IO regions located after the RAM */
-enum {
-    VIRT_HIGH_GIC_REDIST2 =  VIRT_LOWMEMMAP_LAST,
-    VIRT_HIGH_PCIE_ECAM,
-    VIRT_HIGH_PCIE_MMIO,
-};
+#include "hw/arm/arm.h"
 
 typedef enum VirtIOMMUType {
     VIRT_IOMMU_NONE,
@@ -95,13 +45,8 @@ typedef enum VirtIOMMUType {
     VIRT_IOMMU_VIRTIO,
 } VirtIOMMUType;
 
-typedef struct MemMapEntry {
-    hwaddr base;
-    hwaddr size;
-} MemMapEntry;
-
 typedef struct {
-    MachineClass parent;
+    ArmMachineClass parent;
     bool disallow_affinity_adjustment;
     bool no_its;
     bool no_pmu;
@@ -113,7 +58,7 @@ typedef struct {
 } VirtMachineClass;
 
 typedef struct {
-    MachineState parent;
+    ArmMachineState parent;
     Notifier machine_done;
     DeviceState *platform_bus_dev;
     FWCfgState *fw_cfg;
-- 
2.18.1


