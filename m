Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7585FC35242
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7152072C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7152072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3b9e-0008Ej-8E
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 02:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b34-0004XH-Ei
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b30-0000dc-Gr
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3226 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
 id 1j3b2q-0000J9-FC; Mon, 17 Feb 2020 02:42:21 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 58A696934A672177F717;
 Mon, 17 Feb 2020 15:42:14 +0800 (CST)
Received: from localhost (10.175.124.177) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 15:42:04 +0800
From: Xu Yandong <xuyandong2@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH RFC 03/16] hw/arm: move shared memmap member to ArmMachine
Date: Mon, 17 Feb 2020 02:51:15 -0500
Message-ID: <1581925888-103620-4-git-send-email-xuyandong2@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
References: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.177]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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

Move memmap member from VirtMachineState to ArmMachineState.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
Signed-off-by: Xu Yandong <xuyandong2@huawei.com>
---
 hw/arm/virt-acpi-build.c |  21 +++--
 hw/arm/virt.c            | 178 ++++++++++++++++++++-------------------
 include/hw/arm/arm.h     |   1 +
 include/hw/arm/virt.h    |   4 +-
 4 files changed, 110 insertions(+), 94 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index bd5f771e9b..ef61a651c1 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -43,6 +43,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
+#include "hw/arm/arm.h"
 #include "hw/arm/virt.h"
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
@@ -383,6 +384,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     AcpiIortSmmu3 *smmu;
     size_t node_size, iort_node_offset, iort_length, smmu_offset = 0;
     AcpiIortRC *rc;
+    ArmMachineState *ams = ARM_MACHINE(vms);
 
     iort = acpi_data_push(table_data, sizeof(*iort));
 
@@ -424,7 +426,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         smmu->length = cpu_to_le16(node_size);
         smmu->mapping_count = cpu_to_le32(1);
         smmu->mapping_offset = cpu_to_le32(sizeof(*smmu));
-        smmu->base_address = cpu_to_le64(vms->memmap[VIRT_SMMU].base);
+        smmu->base_address = cpu_to_le64(ams->memmap[VIRT_SMMU].base);
         smmu->flags = cpu_to_le32(ACPI_IORT_SMMU_V3_COHACC_OVERRIDE);
         smmu->event_gsiv = cpu_to_le32(irq);
         smmu->pri_gsiv = cpu_to_le32(irq + 1);
@@ -484,7 +486,8 @@ static void
 build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     AcpiSerialPortConsoleRedirection *spcr;
-    const MemMapEntry *uart_memmap = &vms->memmap[VIRT_UART];
+    ArmMachineState *ams = ARM_MACHINE(vms);
+    const MemMapEntry *uart_memmap = &ams->memmap[VIRT_UART];
     int irq = vms->irqmap[VIRT_UART] + ARM_SPI_BASE;
     int spcr_start = table_data->len;
 
@@ -524,6 +527,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     uint64_t mem_base;
     MachineClass *mc = MACHINE_GET_CLASS(vms);
     MachineState *ms = MACHINE(vms);
+    ArmMachineState *ams = ARM_MACHINE(vms);
     const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(ms);
 
     srat_start = table_data->len;
@@ -539,7 +543,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         core->flags = cpu_to_le32(1);
     }
 
-    mem_base = vms->memmap[VIRT_MEM].base;
+    mem_base = ams->memmap[VIRT_MEM].base;
     for (i = 0; i < ms->numa_state->num_nodes; ++i) {
         if (ms->numa_state->nodes[i].node_mem > 0) {
             numamem = acpi_data_push(table_data, sizeof(*numamem));
@@ -602,8 +606,9 @@ static void
 build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+    ArmMachineState *ams = ARM_MACHINE(vms);
     int madt_start = table_data->len;
-    const MemMapEntry *memmap = vms->memmap;
+    const MemMapEntry *memmap = ams->memmap;
     const int *irqmap = vms->irqmap;
     AcpiMultipleApicTable *madt;
     AcpiMadtGenericDistributor *gicd;
@@ -723,7 +728,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     Aml *scope, *dsdt;
     MachineState *ms = MACHINE(vms);
-    const MemMapEntry *memmap = vms->memmap;
+    ArmMachineState *ams = ARM_MACHINE(vms);
+    const MemMapEntry *memmap = ams->memmap;
     const int *irqmap = vms->irqmap;
 
     dsdt = init_aml_allocator();
@@ -796,6 +802,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     unsigned dsdt, xsdt;
     GArray *tables_blob = tables->table_data;
     MachineState *ms = MACHINE(vms);
+    ArmMachineState *ams = ARM_MACHINE(vms);
 
     table_offsets = g_array_new(false, true /* clear */,
                                         sizeof(uint32_t));
@@ -821,8 +828,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     {
         AcpiMcfgInfo mcfg = {
-           .base = vms->memmap[VIRT_ECAM_ID(vms->highmem_ecam)].base,
-           .size = vms->memmap[VIRT_ECAM_ID(vms->highmem_ecam)].size,
+           .base = ams->memmap[VIRT_ECAM_ID(vms->highmem_ecam)].base,
+           .size = ams->memmap[VIRT_ECAM_ID(vms->highmem_ecam)].size,
         };
         build_mcfg(tables_blob, tables->linker, &mcfg);
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 41b2076ce1..1dea640719 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -395,14 +395,14 @@ static void fdt_add_its_gic_node(VirtMachineState *vms)
 
     vms->msi_phandle = qemu_fdt_alloc_phandle(ams->fdt);
     nodename = g_strdup_printf("/intc/its@%" PRIx64,
-                               vms->memmap[VIRT_GIC_ITS].base);
+                               ams->memmap[VIRT_GIC_ITS].base);
     qemu_fdt_add_subnode(ams->fdt, nodename);
     qemu_fdt_setprop_string(ams->fdt, nodename, "compatible",
                             "arm,gic-v3-its");
     qemu_fdt_setprop(ams->fdt, nodename, "msi-controller", NULL, 0);
     qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
-                                 2, vms->memmap[VIRT_GIC_ITS].base,
-                                 2, vms->memmap[VIRT_GIC_ITS].size);
+                                 2, ams->memmap[VIRT_GIC_ITS].base,
+                                 2, ams->memmap[VIRT_GIC_ITS].size);
     qemu_fdt_setprop_cell(ams->fdt, nodename, "phandle", vms->msi_phandle);
     g_free(nodename);
 }
@@ -413,15 +413,15 @@ static void fdt_add_v2m_gic_node(VirtMachineState *vms)
     ArmMachineState *ams = ARM_MACHINE(vms);
 
     nodename = g_strdup_printf("/intc/v2m@%" PRIx64,
-                               vms->memmap[VIRT_GIC_V2M].base);
+                               ams->memmap[VIRT_GIC_V2M].base);
     vms->msi_phandle = qemu_fdt_alloc_phandle(ams->fdt);
     qemu_fdt_add_subnode(ams->fdt, nodename);
     qemu_fdt_setprop_string(ams->fdt, nodename, "compatible",
                             "arm,gic-v2m-frame");
     qemu_fdt_setprop(ams->fdt, nodename, "msi-controller", NULL, 0);
     qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
-                                 2, vms->memmap[VIRT_GIC_V2M].base,
-                                 2, vms->memmap[VIRT_GIC_V2M].size);
+                                 2, ams->memmap[VIRT_GIC_V2M].base,
+                                 2, ams->memmap[VIRT_GIC_V2M].size);
     qemu_fdt_setprop_cell(ams->fdt, nodename, "phandle", vms->msi_phandle);
     g_free(nodename);
 }
@@ -435,7 +435,7 @@ static void fdt_add_gic_node(VirtMachineState *vms)
     qemu_fdt_setprop_cell(ams->fdt, "/", "interrupt-parent", vms->gic_phandle);
 
     nodename = g_strdup_printf("/intc@%" PRIx64,
-                               vms->memmap[VIRT_GIC_DIST].base);
+                               ams->memmap[VIRT_GIC_DIST].base);
     qemu_fdt_add_subnode(ams->fdt, nodename);
     qemu_fdt_setprop_cell(ams->fdt, nodename, "#interrupt-cells", 3);
     qemu_fdt_setprop(ams->fdt, nodename, "interrupt-controller", NULL, 0);
@@ -453,18 +453,18 @@ static void fdt_add_gic_node(VirtMachineState *vms)
 
         if (nb_redist_regions == 1) {
             qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
-                                         2, vms->memmap[VIRT_GIC_DIST].base,
-                                         2, vms->memmap[VIRT_GIC_DIST].size,
-                                         2, vms->memmap[VIRT_GIC_REDIST].base,
-                                         2, vms->memmap[VIRT_GIC_REDIST].size);
+                                         2, ams->memmap[VIRT_GIC_DIST].base,
+                                         2, ams->memmap[VIRT_GIC_DIST].size,
+                                         2, ams->memmap[VIRT_GIC_REDIST].base,
+                                         2, ams->memmap[VIRT_GIC_REDIST].size);
         } else {
             qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
-                                 2, vms->memmap[VIRT_GIC_DIST].base,
-                                 2, vms->memmap[VIRT_GIC_DIST].size,
-                                 2, vms->memmap[VIRT_GIC_REDIST].base,
-                                 2, vms->memmap[VIRT_GIC_REDIST].size,
-                                 2, vms->memmap[VIRT_HIGH_GIC_REDIST2].base,
-                                 2, vms->memmap[VIRT_HIGH_GIC_REDIST2].size);
+                                 2, ams->memmap[VIRT_GIC_DIST].base,
+                                 2, ams->memmap[VIRT_GIC_DIST].size,
+                                 2, ams->memmap[VIRT_GIC_REDIST].base,
+                                 2, ams->memmap[VIRT_GIC_REDIST].size,
+                                 2, ams->memmap[VIRT_HIGH_GIC_REDIST2].base,
+                                 2, ams->memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
         if (vms->virt) {
@@ -478,20 +478,20 @@ static void fdt_add_gic_node(VirtMachineState *vms)
                                 "arm,cortex-a15-gic");
         if (!vms->virt) {
             qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
-                                         2, vms->memmap[VIRT_GIC_DIST].base,
-                                         2, vms->memmap[VIRT_GIC_DIST].size,
-                                         2, vms->memmap[VIRT_GIC_CPU].base,
-                                         2, vms->memmap[VIRT_GIC_CPU].size);
+                                         2, ams->memmap[VIRT_GIC_DIST].base,
+                                         2, ams->memmap[VIRT_GIC_DIST].size,
+                                         2, ams->memmap[VIRT_GIC_CPU].base,
+                                         2, ams->memmap[VIRT_GIC_CPU].size);
         } else {
             qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
-                                         2, vms->memmap[VIRT_GIC_DIST].base,
-                                         2, vms->memmap[VIRT_GIC_DIST].size,
-                                         2, vms->memmap[VIRT_GIC_CPU].base,
-                                         2, vms->memmap[VIRT_GIC_CPU].size,
-                                         2, vms->memmap[VIRT_GIC_HYP].base,
-                                         2, vms->memmap[VIRT_GIC_HYP].size,
-                                         2, vms->memmap[VIRT_GIC_VCPU].base,
-                                         2, vms->memmap[VIRT_GIC_VCPU].size);
+                                         2, ams->memmap[VIRT_GIC_DIST].base,
+                                         2, ams->memmap[VIRT_GIC_DIST].size,
+                                         2, ams->memmap[VIRT_GIC_CPU].base,
+                                         2, ams->memmap[VIRT_GIC_CPU].size,
+                                         2, ams->memmap[VIRT_GIC_HYP].base,
+                                         2, ams->memmap[VIRT_GIC_HYP].size,
+                                         2, ams->memmap[VIRT_GIC_VCPU].base,
+                                         2, ams->memmap[VIRT_GIC_VCPU].size);
             qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
                                    GIC_FDT_IRQ_TYPE_PPI, ARCH_GIC_MAINT_IRQ,
                                    GIC_FDT_IRQ_FLAGS_LEVEL_HI);
@@ -543,6 +543,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 {
     DeviceState *dev;
     MachineState *ms = MACHINE(vms);
+    ArmMachineState *ams = ARM_MACHINE(vms);
     int irq = vms->irqmap[VIRT_ACPI_GED];
     uint32_t event = ACPI_GED_PWR_DOWN_EVT;
 
@@ -553,8 +554,8 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
     dev = qdev_create(NULL, TYPE_ACPI_GED);
     qdev_prop_set_uint32(dev, "ged-event", event);
 
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_ACPI_GED].base);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, vms->memmap[VIRT_PCDIMM_ACPI].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ams->memmap[VIRT_ACPI_GED].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, ams->memmap[VIRT_PCDIMM_ACPI].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(vms->gic, irq));
 
     qdev_init_nofail(dev);
@@ -564,6 +565,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 
 static void create_its(VirtMachineState *vms)
 {
+    ArmMachineState *ams = ARM_MACHINE(vms);
     const char *itsclass = its_class_name();
     DeviceState *dev;
 
@@ -577,7 +579,7 @@ static void create_its(VirtMachineState *vms)
     object_property_set_link(OBJECT(dev), OBJECT(vms->gic), "parent-gicv3",
                              &error_abort);
     qdev_init_nofail(dev);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_ITS].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ams->memmap[VIRT_GIC_ITS].base);
 
     fdt_add_its_gic_node(vms);
 }
@@ -585,11 +587,12 @@ static void create_its(VirtMachineState *vms)
 static void create_v2m(VirtMachineState *vms)
 {
     int i;
+    ArmMachineState *ams = ARM_MACHINE(vms);
     int irq = vms->irqmap[VIRT_GIC_V2M];
     DeviceState *dev;
 
     dev = qdev_create(NULL, "arm-gicv2m");
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_V2M].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ams->memmap[VIRT_GIC_V2M].base);
     qdev_prop_set_uint32(dev, "base-spi", irq);
     qdev_prop_set_uint32(dev, "num-spi", NUM_GICV2M_SPIS);
     qdev_init_nofail(dev);
@@ -605,6 +608,7 @@ static void create_v2m(VirtMachineState *vms)
 static void create_gic(VirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
+    ArmMachineState *ams = ARM_MACHINE(vms);
     /* We create a standalone GIC */
     SysBusDevice *gicbusdev;
     const char *gictype;
@@ -627,7 +631,7 @@ static void create_gic(VirtMachineState *vms)
 
     if (type == 3) {
         uint32_t redist0_capacity =
-                    vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
+                    ams->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
         uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
 
         nb_redist_regions = virt_gicv3_redist_region_count(vms);
@@ -638,7 +642,7 @@ static void create_gic(VirtMachineState *vms)
 
         if (nb_redist_regions == 2) {
             uint32_t redist1_capacity =
-                    vms->memmap[VIRT_HIGH_GIC_REDIST2].size / GICV3_REDIST_SIZE;
+                    ams->memmap[VIRT_HIGH_GIC_REDIST2].size / GICV3_REDIST_SIZE;
 
             qdev_prop_set_uint32(vms->gic, "redist-region-count[1]",
                 MIN(smp_cpus - redist0_count, redist1_capacity));
@@ -651,18 +655,18 @@ static void create_gic(VirtMachineState *vms)
     }
     qdev_init_nofail(vms->gic);
     gicbusdev = SYS_BUS_DEVICE(vms->gic);
-    sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
+    sysbus_mmio_map(gicbusdev, 0, ams->memmap[VIRT_GIC_DIST].base);
     if (type == 3) {
-        sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_REDIST].base);
+        sysbus_mmio_map(gicbusdev, 1, ams->memmap[VIRT_GIC_REDIST].base);
         if (nb_redist_regions == 2) {
             sysbus_mmio_map(gicbusdev, 2,
-                            vms->memmap[VIRT_HIGH_GIC_REDIST2].base);
+                            ams->memmap[VIRT_HIGH_GIC_REDIST2].base);
         }
     } else {
-        sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_CPU].base);
+        sysbus_mmio_map(gicbusdev, 1, ams->memmap[VIRT_GIC_CPU].base);
         if (vms->virt) {
-            sysbus_mmio_map(gicbusdev, 2, vms->memmap[VIRT_GIC_HYP].base);
-            sysbus_mmio_map(gicbusdev, 3, vms->memmap[VIRT_GIC_VCPU].base);
+            sysbus_mmio_map(gicbusdev, 2, ams->memmap[VIRT_GIC_HYP].base);
+            sysbus_mmio_map(gicbusdev, 3, ams->memmap[VIRT_GIC_VCPU].base);
         }
     }
 
@@ -728,8 +732,8 @@ static void create_uart(const VirtMachineState *vms, int uart,
 {
     char *nodename;
     const ArmMachineState *ams = ARM_MACHINE(vms);
-    hwaddr base = vms->memmap[uart].base;
-    hwaddr size = vms->memmap[uart].size;
+    hwaddr base = ams->memmap[uart].base;
+    hwaddr size = ams->memmap[uart].size;
     int irq = vms->irqmap[uart];
     const char compat[] = "arm,pl011\0arm,primecell";
     const char clocknames[] = "uartclk\0apb_pclk";
@@ -776,8 +780,8 @@ static void create_rtc(const VirtMachineState *vms)
 {
     char *nodename;
     const ArmMachineState *ams = ARM_MACHINE(vms);
-    hwaddr base = vms->memmap[VIRT_RTC].base;
-    hwaddr size = vms->memmap[VIRT_RTC].size;
+    hwaddr base = ams->memmap[VIRT_RTC].base;
+    hwaddr size = ams->memmap[VIRT_RTC].size;
     int irq = vms->irqmap[VIRT_RTC];
     const char compat[] = "arm,pl031\0arm,primecell";
 
@@ -814,8 +818,8 @@ static void create_gpio(const VirtMachineState *vms)
     char *nodename;
     DeviceState *pl061_dev;
     const ArmMachineState *ams = ARM_MACHINE(vms);
-    hwaddr base = vms->memmap[VIRT_GPIO].base;
-    hwaddr size = vms->memmap[VIRT_GPIO].size;
+    hwaddr base = ams->memmap[VIRT_GPIO].base;
+    hwaddr size = ams->memmap[VIRT_GPIO].size;
     int irq = vms->irqmap[VIRT_GPIO];
     const char compat[] = "arm,pl061\0arm,primecell";
 
@@ -858,7 +862,7 @@ static void create_virtio_devices(const VirtMachineState *vms)
 {
     int i;
     const ArmMachineState *ams = ARM_MACHINE(vms);
-    hwaddr size = vms->memmap[VIRT_MMIO].size;
+    hwaddr size = ams->memmap[VIRT_MMIO].size;
 
     /* We create the transports in forwards order. Since qbus_realize()
      * prepends (not appends) new child buses, the incrementing loop below will
@@ -889,7 +893,7 @@ static void create_virtio_devices(const VirtMachineState *vms)
      */
     for (i = 0; i < NUM_VIRTIO_TRANSPORTS; i++) {
         int irq = vms->irqmap[VIRT_MMIO] + i;
-        hwaddr base = vms->memmap[VIRT_MMIO].base + i * size;
+        hwaddr base = ams->memmap[VIRT_MMIO].base + i * size;
 
         sysbus_create_simple("virtio-mmio", base,
                              qdev_get_gpio_in(vms->gic, irq));
@@ -905,7 +909,7 @@ static void create_virtio_devices(const VirtMachineState *vms)
     for (i = NUM_VIRTIO_TRANSPORTS - 1; i >= 0; i--) {
         char *nodename;
         int irq = vms->irqmap[VIRT_MMIO] + i;
-        hwaddr base = vms->memmap[VIRT_MMIO].base + i * size;
+        hwaddr base = ams->memmap[VIRT_MMIO].base + i * size;
 
         nodename = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
         qemu_fdt_add_subnode(ams->fdt, nodename);
@@ -975,6 +979,7 @@ static void virt_flash_map(VirtMachineState *vms,
                            MemoryRegion *sysmem,
                            MemoryRegion *secure_sysmem)
 {
+    ArmMachineState *ams = ARM_MACHINE(vms);
     /*
      * Map two flash devices to fill the VIRT_FLASH space in the memmap.
      * sysmem is the system memory space. secure_sysmem is the secure view
@@ -983,8 +988,8 @@ static void virt_flash_map(VirtMachineState *vms,
      * If sysmem == secure_sysmem this means there is no separate Secure
      * address space and both flash devices are generally visible.
      */
-    hwaddr flashsize = vms->memmap[VIRT_FLASH].size / 2;
-    hwaddr flashbase = vms->memmap[VIRT_FLASH].base;
+    hwaddr flashsize = ams->memmap[VIRT_FLASH].size / 2;
+    hwaddr flashbase = ams->memmap[VIRT_FLASH].base;
 
     virt_flash_map1(vms->flash[0], flashbase, flashsize,
                     secure_sysmem);
@@ -997,8 +1002,8 @@ static void virt_flash_fdt(VirtMachineState *vms,
                            MemoryRegion *secure_sysmem)
 {
     ArmMachineState *ams = ARM_MACHINE(vms);
-    hwaddr flashsize = vms->memmap[VIRT_FLASH].size / 2;
-    hwaddr flashbase = vms->memmap[VIRT_FLASH].base;
+    hwaddr flashsize = ams->memmap[VIRT_FLASH].size / 2;
+    hwaddr flashbase = ams->memmap[VIRT_FLASH].base;
     char *nodename;
 
     if (sysmem == secure_sysmem) {
@@ -1088,8 +1093,8 @@ static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
 {
     MachineState *ms = MACHINE(vms);
     const ArmMachineState *ams = ARM_MACHINE(vms);
-    hwaddr base = vms->memmap[VIRT_FW_CFG].base;
-    hwaddr size = vms->memmap[VIRT_FW_CFG].size;
+    hwaddr base = ams->memmap[VIRT_FW_CFG].base;
+    hwaddr size = ams->memmap[VIRT_FW_CFG].size;
     FWCfgState *fw_cfg;
     char *nodename;
 
@@ -1152,8 +1157,8 @@ static void create_smmu(const VirtMachineState *vms,
     const char compat[] = "arm,smmu-v3";
     int irq =  vms->irqmap[VIRT_SMMU];
     int i;
-    hwaddr base = vms->memmap[VIRT_SMMU].base;
-    hwaddr size = vms->memmap[VIRT_SMMU].size;
+    hwaddr base = ams->memmap[VIRT_SMMU].base;
+    hwaddr size = ams->memmap[VIRT_SMMU].size;
     const char irq_names[] = "eventq\0priq\0cmdq-sync\0gerror";
     DeviceState *dev;
 
@@ -1199,12 +1204,12 @@ static void create_smmu(const VirtMachineState *vms,
 static void create_pcie(VirtMachineState *vms)
 {
     ArmMachineState *ams = ARM_MACHINE(vms);
-    hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
-    hwaddr size_mmio = vms->memmap[VIRT_PCIE_MMIO].size;
-    hwaddr base_mmio_high = vms->memmap[VIRT_HIGH_PCIE_MMIO].base;
-    hwaddr size_mmio_high = vms->memmap[VIRT_HIGH_PCIE_MMIO].size;
-    hwaddr base_pio = vms->memmap[VIRT_PCIE_PIO].base;
-    hwaddr size_pio = vms->memmap[VIRT_PCIE_PIO].size;
+    hwaddr base_mmio = ams->memmap[VIRT_PCIE_MMIO].base;
+    hwaddr size_mmio = ams->memmap[VIRT_PCIE_MMIO].size;
+    hwaddr base_mmio_high = ams->memmap[VIRT_HIGH_PCIE_MMIO].base;
+    hwaddr size_mmio_high = ams->memmap[VIRT_HIGH_PCIE_MMIO].size;
+    hwaddr base_pio = ams->memmap[VIRT_PCIE_PIO].base;
+    hwaddr size_pio = ams->memmap[VIRT_PCIE_PIO].size;
     hwaddr base_ecam, size_ecam;
     hwaddr base = base_mmio;
     int nr_pcie_buses;
@@ -1222,8 +1227,8 @@ static void create_pcie(VirtMachineState *vms)
     qdev_init_nofail(dev);
 
     ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
-    base_ecam = vms->memmap[ecam_id].base;
-    size_ecam = vms->memmap[ecam_id].size;
+    base_ecam = ams->memmap[ecam_id].base;
+    size_ecam = ams->memmap[ecam_id].size;
     nr_pcie_buses = size_ecam / PCIE_MMCFG_SIZE_MIN;
     /* Map only the first size_ecam bytes of ECAM space */
     ecam_alias = g_new0(MemoryRegion, 1);
@@ -1333,11 +1338,12 @@ static void create_platform_bus(VirtMachineState *vms)
     SysBusDevice *s;
     int i;
     MemoryRegion *sysmem = get_system_memory();
+    ArmMachineState *ams = ARM_MACHINE(vms);
 
     dev = qdev_create(NULL, TYPE_PLATFORM_BUS_DEVICE);
     dev->id = TYPE_PLATFORM_BUS_DEVICE;
     qdev_prop_set_uint32(dev, "num_irqs", PLATFORM_BUS_NUM_IRQS);
-    qdev_prop_set_uint32(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_BUS].size);
+    qdev_prop_set_uint32(dev, "mmio_size", ams->memmap[VIRT_PLATFORM_BUS].size);
     qdev_init_nofail(dev);
     vms->platform_bus_dev = dev;
 
@@ -1348,7 +1354,7 @@ static void create_platform_bus(VirtMachineState *vms)
     }
 
     memory_region_add_subregion(sysmem,
-                                vms->memmap[VIRT_PLATFORM_BUS].base,
+                                ams->memmap[VIRT_PLATFORM_BUS].base,
                                 sysbus_mmio_get_region(s, 0));
 }
 
@@ -1358,8 +1364,8 @@ static void create_secure_ram(VirtMachineState *vms,
     MemoryRegion *secram = g_new(MemoryRegion, 1);
     char *nodename;
     ArmMachineState *ams = ARM_MACHINE(vms);
-    hwaddr base = vms->memmap[VIRT_SECURE_MEM].base;
-    hwaddr size = vms->memmap[VIRT_SECURE_MEM].size;
+    hwaddr base = ams->memmap[VIRT_SECURE_MEM].base;
+    hwaddr size = ams->memmap[VIRT_SECURE_MEM].size;
 
     memory_region_init_ram(secram, NULL, "virt.secure-ram", size,
                            &error_fatal);
@@ -1432,8 +1438,8 @@ void virt_machine_done(Notifier *notifier, void *data)
      */
     if (info->dtb_filename == NULL) {
         platform_bus_add_all_fdt_nodes(ams->fdt, "/intc",
-                                       vms->memmap[VIRT_PLATFORM_BUS].base,
-                                       vms->memmap[VIRT_PLATFORM_BUS].size,
+                                       ams->memmap[VIRT_PLATFORM_BUS].base,
+                                       ams->memmap[VIRT_PLATFORM_BUS].size,
                                        vms->irqmap[VIRT_PLATFORM_BUS]);
     }
     if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms) < 0) {
@@ -1470,13 +1476,14 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
 static void virt_set_memmap(VirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
+    ArmMachineState *ams = ARM_MACHINE(vms);
     hwaddr base, device_memory_base, device_memory_size;
     int i;
 
-    vms->memmap = extended_memmap;
+    ams->memmap = extended_memmap;
 
     for (i = 0; i < ARRAY_SIZE(base_memmap); i++) {
-        vms->memmap[i] = base_memmap[i];
+        ams->memmap[i] = base_memmap[i];
     }
 
     if (ms->ram_slots > ACPI_MAX_RAM_SLOTS) {
@@ -1493,7 +1500,7 @@ static void virt_set_memmap(VirtMachineState *vms)
      * The device region size assumes 1GiB page max alignment per slot.
      */
     device_memory_base =
-        ROUND_UP(vms->memmap[VIRT_MEM].base + ms->ram_size, GiB);
+        ROUND_UP(ams->memmap[VIRT_MEM].base + ms->ram_size, GiB);
     device_memory_size = ms->maxram_size - ms->ram_size + ms->ram_slots * GiB;
 
     /* Base address of the high IO region */
@@ -1502,16 +1509,16 @@ static void virt_set_memmap(VirtMachineState *vms)
         error_report("maxmem/slots too huge");
         exit(EXIT_FAILURE);
     }
-    if (base < vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES) {
-        base = vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
+    if (base < ams->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES) {
+        base = ams->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
     }
 
     for (i = VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++) {
         hwaddr size = extended_memmap[i].size;
 
         base = ROUND_UP(base, size);
-        vms->memmap[i].base = base;
-        vms->memmap[i].size = size;
+        ams->memmap[i].base = base;
+        ams->memmap[i].size = size;
         base += size;
     }
     vms->highest_gpa = base - 1;
@@ -1526,6 +1533,7 @@ static void virt_set_memmap(VirtMachineState *vms)
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
+    ArmMachineState *ams = ARM_MACHINE(vms);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(machine);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *possible_cpus;
@@ -1543,7 +1551,7 @@ static void machvirt_init(MachineState *machine)
      * In accelerated mode, the memory map is computed earlier in kvm_type()
      * to create a VM with the right number of IPA bits.
      */
-    if (!vms->memmap) {
+    if (!ams->memmap) {
         virt_set_memmap(vms);
     }
 
@@ -1619,9 +1627,9 @@ static void machvirt_init(MachineState *machine)
      */
     if (vms->gic_version == 3) {
         virt_max_cpus =
-            vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
+            ams->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
         virt_max_cpus +=
-            vms->memmap[VIRT_HIGH_GIC_REDIST2].size / GICV3_REDIST_SIZE;
+            ams->memmap[VIRT_HIGH_GIC_REDIST2].size / GICV3_REDIST_SIZE;
     } else {
         virt_max_cpus = GIC_NCPU;
     }
@@ -1693,7 +1701,7 @@ static void machvirt_init(MachineState *machine)
         }
 
         if (object_property_find(cpuobj, "reset-cbar", NULL)) {
-            object_property_set_int(cpuobj, vms->memmap[VIRT_CPUPERIPHS].base,
+            object_property_set_int(cpuobj, ams->memmap[VIRT_CPUPERIPHS].base,
                                     "reset-cbar", &error_abort);
         }
 
@@ -1728,7 +1736,7 @@ static void machvirt_init(MachineState *machine)
 
     memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
                                          machine->ram_size);
-    memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
+    memory_region_add_subregion(sysmem, ams->memmap[VIRT_MEM].base, ram);
     if (machine->device_memory) {
         memory_region_add_subregion(sysmem, machine->device_memory->base,
                                     &machine->device_memory->mr);
@@ -1777,7 +1785,7 @@ static void machvirt_init(MachineState *machine)
     vms->bootinfo.ram_size = machine->ram_size;
     vms->bootinfo.nb_cpus = smp_cpus;
     vms->bootinfo.board_id = -1;
-    vms->bootinfo.loader_start = vms->memmap[VIRT_MEM].base;
+    vms->bootinfo.loader_start = ams->memmap[VIRT_MEM].base;
     vms->bootinfo.get_dtb = machvirt_dtb;
     vms->bootinfo.skip_dtb_autoload = true;
     vms->bootinfo.firmware_loaded = firmware_loaded;
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index b3b3daa95a..f269668d41 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -87,6 +87,7 @@ typedef struct {
 
 typedef struct {
     MachineState parent;
+    MemMapEntry *memmap;
     void *fdt;
     int fdt_size;
 } ArmMachineState;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index ad353bad92..1b460d8d31 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -71,7 +71,6 @@ typedef struct {
     int32_t gic_version;
     VirtIOMMUType iommu;
     struct arm_boot_info bootinfo;
-    MemMapEntry *memmap;
     const int *irqmap;
     int smp_cpus;
     uint32_t clock_phandle;
@@ -100,8 +99,9 @@ void virt_acpi_setup(VirtMachineState *vms);
 /* Return the number of used redistributor regions  */
 static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
 {
+    ArmMachineState *ams = ARM_MACHINE(vms);
     uint32_t redist0_capacity =
-                vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
+                ams->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
 
     assert(vms->gic_version == 3);
 
-- 
2.18.1


