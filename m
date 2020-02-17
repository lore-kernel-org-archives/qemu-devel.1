Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2948FC7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10D62067D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10D62067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3b8h-00066K-I8
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 02:48:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b34-0004Xf-IK
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b31-0000eI-0s
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2716 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
 id 1j3b2r-0000ME-Of; Mon, 17 Feb 2020 02:42:22 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id D09AD3EBCC26B2E87BB5;
 Mon, 17 Feb 2020 15:42:17 +0800 (CST)
Received: from localhost (10.175.124.177) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 15:42:08 +0800
From: Xu Yandong <xuyandong2@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH RFC 09/16] hw/arm: move shared gic member to ArmMachine
Date: Mon, 17 Feb 2020 02:51:21 -0500
Message-ID: <1581925888-103620-10-git-send-email-xuyandong2@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
References: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.177]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
 "Michael S. Tsirkin" <mst@redhat.com>, Xu Yandong <xuyandong2@huawei.com>,
 qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>, wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move gic member from VirtMachineState to ArmMachineState.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
Signed-off-by: Xu Yandong <xuyandong2@huawei.com>
---
 hw/arm/arm.c             |  35 ++++++++++
 hw/arm/virt-acpi-build.c |   8 +--
 hw/arm/virt.c            | 139 +++++++++++++++------------------------
 include/hw/arm/arm.h     |  17 +++++
 include/hw/arm/virt.h    |  15 -----
 5 files changed, 110 insertions(+), 104 deletions(-)

diff --git a/hw/arm/arm.c b/hw/arm/arm.c
index 4261d56832..ecb99611ed 100644
--- a/hw/arm/arm.c
+++ b/hw/arm/arm.c
@@ -39,6 +39,32 @@
 #include "hw/intc/arm_gic.h"
 #include "kvm_arm.h"
 
+static char *virt_get_gic_version(Object *obj, Error **errp)
+{
+    ArmMachineState *ams = ARM_MACHINE(obj);
+    const char *val = ams->gic_version == 3 ? "3" : "2";
+
+    return g_strdup(val);
+}
+
+static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
+{
+    ArmMachineState *ams = ARM_MACHINE(obj);
+
+    if (!strcmp(value, "3")) {
+        ams->gic_version = 3;
+    } else if (!strcmp(value, "2")) {
+        ams->gic_version = 2;
+    } else if (!strcmp(value, "host")) {
+        ams->gic_version = 0; /* Will probe later */
+    } else if (!strcmp(value, "max")) {
+        ams->gic_version = -1; /* Will probe later */
+    } else {
+        error_setg(errp, "Invalid gic-version value");
+        error_append_hint(errp, "Valid values are 3, 2, host, max.\n");
+    }
+}
+
 static void arm_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -55,6 +81,15 @@ static void arm_machine_class_init(ObjectClass *oc, void *data)
 
 static void arm_instance_init(Object *obj)
 {
+    ArmMachineState *ams = ARM_MACHINE(obj);
+    /* Default GIC type is v2 */
+    ams->gic_version = 2;
+    object_property_add_str(obj, "gic-version", virt_get_gic_version,
+                        virt_set_gic_version, NULL);
+    object_property_set_description(obj, "gic-version",
+                                    "Set GIC version. "
+                                    "Valid values are 2, 3 and host", NULL);
+
 }
 
 static const TypeInfo arm_machine_info = {
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index ef2761ef77..770c53f5d0 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -621,7 +621,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     gicd->type = ACPI_APIC_GENERIC_DISTRIBUTOR;
     gicd->length = sizeof(*gicd);
     gicd->base_address = cpu_to_le64(memmap[VIRT_GIC_DIST].base);
-    gicd->version = vms->gic_version;
+    gicd->version = ams->gic_version;
 
     for (i = 0; i < ams->smp_cpus; i++) {
         AcpiMadtGenericCpuInterface *gicc = acpi_data_push(table_data,
@@ -630,7 +630,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
         gicc->type = ACPI_APIC_GENERIC_CPU_INTERFACE;
         gicc->length = sizeof(*gicc);
-        if (vms->gic_version == 2) {
+        if (ams->gic_version == 2) {
             gicc->base_address = cpu_to_le64(memmap[VIRT_GIC_CPU].base);
             gicc->gich_base_address = cpu_to_le64(memmap[VIRT_GIC_HYP].base);
             gicc->gicv_base_address = cpu_to_le64(memmap[VIRT_GIC_VCPU].base);
@@ -648,9 +648,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     }
 
-    if (vms->gic_version == 3) {
+    if (ams->gic_version == 3) {
         AcpiMadtGenericTranslator *gic_its;
-        int nb_redist_regions = virt_gicv3_redist_region_count(vms);
+        int nb_redist_regions = virt_gicv3_redist_region_count(ams);
         AcpiMadtGenericRedistributor *gicr = acpi_data_push(table_data,
                                                          sizeof *gicr);
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 087616190e..b9689b0f0c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -100,10 +100,6 @@
 #define DEFINE_VIRT_MACHINE(major, minor) \
     DEFINE_VIRT_MACHINE_LATEST(major, minor, false)
 
-
-/* Number of external interrupt lines to configure the GIC with */
-#define NUM_IRQS 256
-
 #define PLATFORM_BUS_NUM_IRQS 64
 
 /* Legacy RAM limit in GB (< version 4.0) */
@@ -297,7 +293,7 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
         irqflags = GIC_FDT_IRQ_FLAGS_EDGE_LO_HI;
     }
 
-    if (vms->gic_version == 2) {
+    if (ams->gic_version == 2) {
         irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
                              GIC_FDT_IRQ_PPI_CPU_WIDTH,
                              (1 << ams->smp_cpus) - 1);
@@ -435,7 +431,7 @@ static void fdt_gic_set_virt_extension(VirtMachineState *vms)
                                ams->memmap[VIRT_GIC_DIST].base);
 
 
-    if (vms->gic_version == 3) {
+    if (ams->gic_version == 3) {
         if (vms->virt) {
             qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
                                    GIC_FDT_IRQ_TYPE_PPI, ARCH_GIC_MAINT_IRQ,
@@ -470,8 +466,8 @@ static void fdt_add_gic_node(VirtMachineState *vms)
     char *nodename;
     ArmMachineState *ams = ARM_MACHINE(vms);
 
-    vms->gic_phandle = qemu_fdt_alloc_phandle(ams->fdt);
-    qemu_fdt_setprop_cell(ams->fdt, "/", "interrupt-parent", vms->gic_phandle);
+    ams->gic_phandle = qemu_fdt_alloc_phandle(ams->fdt);
+    qemu_fdt_setprop_cell(ams->fdt, "/", "interrupt-parent", ams->gic_phandle);
 
     nodename = g_strdup_printf("/intc@%" PRIx64,
                                ams->memmap[VIRT_GIC_DIST].base);
@@ -481,8 +477,8 @@ static void fdt_add_gic_node(VirtMachineState *vms)
     qemu_fdt_setprop_cell(ams->fdt, nodename, "#address-cells", 0x2);
     qemu_fdt_setprop_cell(ams->fdt, nodename, "#size-cells", 0x2);
     qemu_fdt_setprop(ams->fdt, nodename, "ranges", NULL, 0);
-    if (vms->gic_version == 3) {
-        int nb_redist_regions = virt_gicv3_redist_region_count(vms);
+    if (ams->gic_version == 3) {
+        int nb_redist_regions = virt_gicv3_redist_region_count(ams);
 
         qemu_fdt_setprop_string(ams->fdt, nodename, "compatible",
                                 "arm,gic-v3");
@@ -511,7 +507,7 @@ static void fdt_add_gic_node(VirtMachineState *vms)
                                 "arm,cortex-a15-gic");
     }
 
-    qemu_fdt_setprop_cell(ams->fdt, nodename, "phandle", vms->gic_phandle);
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "phandle", ams->gic_phandle);
     g_free(nodename);
 }
 
@@ -535,7 +531,7 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
         }
     }
 
-    if (vms->gic_version == 2) {
+    if (ams->gic_version == 2) {
         irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
                              GIC_FDT_IRQ_PPI_CPU_WIDTH,
                              (1 << ams->smp_cpus) - 1);
@@ -569,7 +565,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ams->memmap[VIRT_ACPI_GED].base);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, ams->memmap[VIRT_PCDIMM_ACPI].base);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(vms->gic, irq));
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(ams->gic, irq));
 
     qdev_init_nofail(dev);
 
@@ -589,7 +585,7 @@ static void create_its(VirtMachineState *vms)
 
     dev = qdev_create(NULL, itsclass);
 
-    object_property_set_link(OBJECT(dev), OBJECT(vms->gic), "parent-gicv3",
+    object_property_set_link(OBJECT(dev), OBJECT(ams->gic), "parent-gicv3",
                              &error_abort);
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ams->memmap[VIRT_GIC_ITS].base);
@@ -612,7 +608,7 @@ static void create_v2m(VirtMachineState *vms)
 
     for (i = 0; i < NUM_GICV2M_SPIS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
-                           qdev_get_gpio_in(vms->gic, irq + i));
+                           qdev_get_gpio_in(ams->gic, irq + i));
     }
 
     fdt_add_v2m_gic_node(vms);
@@ -620,25 +616,30 @@ static void create_v2m(VirtMachineState *vms)
 
 static void gic_set_msi_interrupt(VirtMachineState *vms)
 {
-    if (vms->gic_version == 3 && vms->its) {
+    ArmMachineState *ams = ARM_MACHINE(vms);
+    if (ams->gic_version == 3 && vms->its) {
         create_its(vms);
-    } else if (vms->gic_version == 2) {
+    } else if (ams->gic_version == 2) {
         create_v2m(vms);
     }
 }
 
 static void qdev_gic_set_secure_bit(VirtMachineState *vms)
 {
+    ArmMachineState *ams = ARM_MACHINE(vms);
+
     if (!kvm_irqchip_in_kernel()) {
-        qdev_prop_set_bit(vms->gic, "has-security-extensions",
+        qdev_prop_set_bit(ams->gic, "has-security-extensions",
                           vms->secure);
     }
 }
 
 static void qdev_gic_set_virt_bit(VirtMachineState *vms)
 {
-    if (vms->gic_version != 3 && !kvm_irqchip_in_kernel()) {
-        qdev_prop_set_bit(vms->gic, "has-virtualization-extensions",
+    ArmMachineState *ams = ARM_MACHINE(vms);
+
+    if (ams->gic_version != 3 && !kvm_irqchip_in_kernel()) {
+        qdev_prop_set_bit(ams->gic, "has-virtualization-extensions",
                           vms->virt);
     }
 }
@@ -648,14 +649,14 @@ static void set_gic_virt_sysbus(VirtMachineState *vms)
     MachineState *ms = MACHINE(vms);
     ArmMachineState *ams = ARM_MACHINE(vms);
     SysBusDevice *gicbusdev;
-    int type = vms->gic_version, i;
+    int type = ams->gic_version, i;
     unsigned int smp_cpus = ms->smp.cpus;
 
     if (!vms->virt) {
         return;
     }
 
-    gicbusdev = SYS_BUS_DEVICE(vms->gic);
+    gicbusdev = SYS_BUS_DEVICE(ams->gic);
     if (type != 3) {
         sysbus_mmio_map(gicbusdev, 2, ams->memmap[VIRT_GIC_HYP].base);
         sysbus_mmio_map(gicbusdev, 3, ams->memmap[VIRT_GIC_VCPU].base);
@@ -663,7 +664,7 @@ static void set_gic_virt_sysbus(VirtMachineState *vms)
 
     for (i = 0; i < smp_cpus; i++) {
         int ppibase = NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
-        qemu_irq irq = qdev_get_gpio_in(vms->gic,
+        qemu_irq irq = qdev_get_gpio_in(ams->gic,
                                         ppibase + ARCH_GIC_MAINT_IRQ);
         sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
     }
@@ -676,43 +677,43 @@ static void create_gic(VirtMachineState *vms)
     /* We create a standalone GIC */
     SysBusDevice *gicbusdev;
     const char *gictype;
-    int type = vms->gic_version, i;
+    int type = ams->gic_version, i;
     unsigned int smp_cpus = ms->smp.cpus;
     uint32_t nb_redist_regions = 0;
 
     gictype = (type == 3) ? gicv3_class_name() : gic_class_name();
 
-    vms->gic = qdev_create(NULL, gictype);
-    qdev_prop_set_uint32(vms->gic, "revision", type);
-    qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
+    ams->gic = qdev_create(NULL, gictype);
+    qdev_prop_set_uint32(ams->gic, "revision", type);
+    qdev_prop_set_uint32(ams->gic, "num-cpu", smp_cpus);
     /* Note that the num-irq property counts both internal and external
      * interrupts; there are always 32 of the former (mandated by GIC spec).
      */
-    qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
+    qdev_prop_set_uint32(ams->gic, "num-irq", NUM_IRQS + 32);
 
     if (type == 3) {
         uint32_t redist0_capacity =
                     ams->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
         uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
 
-        nb_redist_regions = virt_gicv3_redist_region_count(vms);
+        nb_redist_regions = virt_gicv3_redist_region_count(ams);
 
-        qdev_prop_set_uint32(vms->gic, "len-redist-region-count",
+        qdev_prop_set_uint32(ams->gic, "len-redist-region-count",
                              nb_redist_regions);
-        qdev_prop_set_uint32(vms->gic, "redist-region-count[0]", redist0_count);
+        qdev_prop_set_uint32(ams->gic, "redist-region-count[0]", redist0_count);
 
         if (nb_redist_regions == 2) {
             uint32_t redist1_capacity =
                     ams->memmap[VIRT_HIGH_GIC_REDIST2].size / GICV3_REDIST_SIZE;
 
-            qdev_prop_set_uint32(vms->gic, "redist-region-count[1]",
+            qdev_prop_set_uint32(ams->gic, "redist-region-count[1]",
                 MIN(smp_cpus - redist0_count, redist1_capacity));
         }
     }
     qdev_gic_set_secure_bit(vms);
     qdev_gic_set_virt_bit(vms);
-    qdev_init_nofail(vms->gic);
-    gicbusdev = SYS_BUS_DEVICE(vms->gic);
+    qdev_init_nofail(ams->gic);
+    gicbusdev = SYS_BUS_DEVICE(ams->gic);
     sysbus_mmio_map(gicbusdev, 0, ams->memmap[VIRT_GIC_DIST].base);
     if (type == 3) {
         sysbus_mmio_map(gicbusdev, 1, ams->memmap[VIRT_GIC_REDIST].base);
@@ -744,19 +745,19 @@ static void create_gic(VirtMachineState *vms)
 
         for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
             qdev_connect_gpio_out(cpudev, irq,
-                                  qdev_get_gpio_in(vms->gic,
+                                  qdev_get_gpio_in(ams->gic,
                                                    ppibase + timer_irq[irq]));
         }
 
         if (type == 3) {
-            qemu_irq irq = qdev_get_gpio_in(vms->gic,
+            qemu_irq irq = qdev_get_gpio_in(ams->gic,
                                             ppibase + ARCH_GIC_MAINT_IRQ);
             qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
                                         0, irq);
         }
 
         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
-                                    qdev_get_gpio_in(vms->gic, ppibase
+                                    qdev_get_gpio_in(ams->gic, ppibase
                                                      + VIRTUAL_PMU_IRQ));
 
         sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
@@ -792,7 +793,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
     qdev_init_nofail(dev);
     memory_region_add_subregion(mem, base,
                                 sysbus_mmio_get_region(s, 0));
-    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(ams->gic, irq));
 
     nodename = g_strdup_printf("/pl011@%" PRIx64, base);
     qemu_fdt_add_subnode(ams->fdt, nodename);
@@ -833,7 +834,7 @@ static void create_rtc(const VirtMachineState *vms)
     int irq = ams->irqmap[VIRT_RTC];
     const char compat[] = "arm,pl031\0arm,primecell";
 
-    sysbus_create_simple("pl031", base, qdev_get_gpio_in(vms->gic, irq));
+    sysbus_create_simple("pl031", base, qdev_get_gpio_in(ams->gic, irq));
 
     nodename = g_strdup_printf("/pl031@%" PRIx64, base);
     qemu_fdt_add_subnode(ams->fdt, nodename);
@@ -872,7 +873,7 @@ static void create_gpio(const VirtMachineState *vms)
     const char compat[] = "arm,pl061\0arm,primecell";
 
     pl061_dev = sysbus_create_simple("pl061", base,
-                                     qdev_get_gpio_in(vms->gic, irq));
+                                     qdev_get_gpio_in(ams->gic, irq));
 
     uint32_t phandle = qemu_fdt_alloc_phandle(ams->fdt);
     nodename = g_strdup_printf("/pl061@%" PRIx64, base);
@@ -944,7 +945,7 @@ static void create_virtio_devices(const VirtMachineState *vms)
         hwaddr base = ams->memmap[VIRT_MMIO].base + i * size;
 
         sysbus_create_simple("virtio-mmio", base,
-                             qdev_get_gpio_in(vms->gic, irq));
+                             qdev_get_gpio_in(ams->gic, irq));
     }
 
     /* We add dtb nodes in reverse order so that they appear in the finished
@@ -1222,7 +1223,7 @@ static void create_smmu(const VirtMachineState *vms,
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
-                           qdev_get_gpio_in(vms->gic, irq + i));
+                           qdev_get_gpio_in(ams->gic, irq + i));
     }
 
     node = g_strdup_printf("/smmuv3@%" PRIx64, base);
@@ -1311,7 +1312,7 @@ static void create_pcie(VirtMachineState *vms)
 
     for (i = 0; i < GPEX_NUM_IRQS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
-                           qdev_get_gpio_in(vms->gic, irq + i));
+                           qdev_get_gpio_in(ams->gic, irq + i));
         gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
     }
 
@@ -1366,7 +1367,7 @@ static void create_pcie(VirtMachineState *vms)
     }
 
     qemu_fdt_setprop_cell(ams->fdt, nodename, "#interrupt-cells", 1);
-    create_pcie_irq_map(vms, vms->gic_phandle, irq, nodename);
+    create_pcie_irq_map(vms, ams->gic_phandle, irq, nodename);
 
     if (vms->iommu) {
         vms->iommu_phandle = qemu_fdt_alloc_phandle(ams->fdt);
@@ -1398,7 +1399,7 @@ static void create_platform_bus(VirtMachineState *vms)
     s = SYS_BUS_DEVICE(dev);
     for (i = 0; i < PLATFORM_BUS_NUM_IRQS; i++) {
         int irq = ams->irqmap[VIRT_PLATFORM_BUS] + i;
-        sysbus_connect_irq(s, i, qdev_get_gpio_in(vms->gic, irq));
+        sysbus_connect_irq(s, i, qdev_get_gpio_in(ams->gic, irq));
     }
 
     memory_region_add_subregion(sysmem,
@@ -1501,6 +1502,7 @@ void virt_machine_done(Notifier *notifier, void *data)
 static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
 {
     uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
+    ArmMachineState *ams = ARM_MACHINE(vms);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
 
     if (!vmc->disallow_affinity_adjustment) {
@@ -1512,7 +1514,7 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
          * purposes are to make TCG consistent (with 64-bit KVM hosts)
          * and to improve SGI efficiency.
          */
-        if (vms->gic_version == 3) {
+        if (ams->gic_version == 3) {
             clustersz = GICV3_TARGETLIST_BITS;
         } else {
             clustersz = GIC_TARGETLIST_BITS;
@@ -1606,19 +1608,19 @@ static void machvirt_init(MachineState *machine)
     /* We can probe only here because during property set
      * KVM is not available yet
      */
-    if (vms->gic_version <= 0) {
+    if (ams->gic_version <= 0) {
         /* "host" or "max" */
         if (!kvm_enabled()) {
-            if (vms->gic_version == 0) {
+            if (ams->gic_version == 0) {
                 error_report("gic-version=host requires KVM");
                 exit(1);
             } else {
                 /* "max": currently means 3 for TCG */
-                vms->gic_version = 3;
+                ams->gic_version = 3;
             }
         } else {
-            vms->gic_version = kvm_arm_vgic_probe();
-            if (!vms->gic_version) {
+            ams->gic_version = kvm_arm_vgic_probe();
+            if (!ams->gic_version) {
                 error_report(
                     "Unable to determine GIC version supported by host");
                 exit(1);
@@ -1673,7 +1675,7 @@ static void machvirt_init(MachineState *machine)
     /* The maximum number of CPUs depends on the GIC version, or on how
      * many redistributors we can fit into the memory map.
      */
-    if (vms->gic_version == 3) {
+    if (ams->gic_version == 3) {
         virt_max_cpus =
             ams->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
         virt_max_cpus +=
@@ -1899,32 +1901,6 @@ static void virt_set_its(Object *obj, bool value, Error **errp)
     vms->its = value;
 }
 
-static char *virt_get_gic_version(Object *obj, Error **errp)
-{
-    VirtMachineState *vms = VIRT_MACHINE(obj);
-    const char *val = vms->gic_version == 3 ? "3" : "2";
-
-    return g_strdup(val);
-}
-
-static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
-{
-    VirtMachineState *vms = VIRT_MACHINE(obj);
-
-    if (!strcmp(value, "3")) {
-        vms->gic_version = 3;
-    } else if (!strcmp(value, "2")) {
-        vms->gic_version = 2;
-    } else if (!strcmp(value, "host")) {
-        vms->gic_version = 0; /* Will probe later */
-    } else if (!strcmp(value, "max")) {
-        vms->gic_version = -1; /* Will probe later */
-    } else {
-        error_setg(errp, "Invalid gic-version value");
-        error_append_hint(errp, "Valid values are 3, 2, host, max.\n");
-    }
-}
-
 static char *virt_get_iommu(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -2164,13 +2140,6 @@ static void virt_instance_init(Object *obj)
                                     "Set on/off to enable/disable using "
                                     "physical address space above 32 bits",
                                     NULL);
-    /* Default GIC type is v2 */
-    vms->gic_version = 2;
-    object_property_add_str(obj, "gic-version", virt_get_gic_version,
-                        virt_set_gic_version, NULL);
-    object_property_set_description(obj, "gic-version",
-                                    "Set GIC version. "
-                                    "Valid values are 2, 3 and host", NULL);
 
     vms->highmem_ecam = !vmc->no_highmem_ecam;
 
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index 469f603e77..f8bde03cc3 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -74,6 +74,9 @@ enum {
     VIRT_HIGH_PCIE_MMIO,
 };
 
+/* Number of external interrupt lines to configure the GIC with */
+#define NUM_IRQS 256
+
 /* indices of IO regions located after the RAM */
 
 typedef struct MemMapEntry {
@@ -87,11 +90,14 @@ typedef struct {
 
 typedef struct {
     MachineState parent;
+    int32_t gic_version;
     MemMapEntry *memmap;
     const int *irqmap;
     int smp_cpus;
     void *fdt;
     int fdt_size;
+    uint32_t gic_phandle;
+    DeviceState *gic;
 } ArmMachineState;
 
 #define TYPE_ARM_MACHINE   MACHINE_TYPE_NAME("arm")
@@ -102,4 +108,15 @@ typedef struct {
 #define ARM_MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(ArmMachineClass, klass, TYPE_ARM_MACHINE)
 
+/* Return the number of used redistributor regions  */
+static inline int virt_gicv3_redist_region_count(ArmMachineState *ams)
+{
+    uint32_t redist0_capacity =
+                ams->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
+
+    assert(ams->gic_version == 3);
+
+    return ams->smp_cpus > redist0_capacity ? 2 : 1;
+}
+
 #endif /* QEMU_ARM_ARM_H */
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index dfc2a16010..393afb7faf 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -68,16 +68,13 @@ typedef struct {
     bool highmem_ecam;
     bool its;
     bool virt;
-    int32_t gic_version;
     VirtIOMMUType iommu;
     struct arm_boot_info bootinfo;
     uint32_t clock_phandle;
-    uint32_t gic_phandle;
     uint32_t msi_phandle;
     uint32_t iommu_phandle;
     int psci_conduit;
     hwaddr highest_gpa;
-    DeviceState *gic;
     DeviceState *acpi_dev;
     Notifier powerdown_notifier;
 } VirtMachineState;
@@ -94,16 +91,4 @@ typedef struct {
 
 void virt_acpi_setup(VirtMachineState *vms);
 
-/* Return the number of used redistributor regions  */
-static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
-{
-    ArmMachineState *ams = ARM_MACHINE(vms);
-    uint32_t redist0_capacity =
-                ams->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
-
-    assert(vms->gic_version == 3);
-
-    return ams->smp_cpus > redist0_capacity ? 2 : 1;
-}
-
 #endif /* QEMU_ARM_VIRT_H */
-- 
2.18.1


