Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F62C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 10:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC7420818
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 10:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC7420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38834 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDo8x-0003KK-PP
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 06:38:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDo28-0006H9-LE
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDo27-0007Mq-2A
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:31:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44070 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDo23-0007KF-8m; Tue, 09 Apr 2019 06:31:11 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id A9B5356529DF89A7538A;
	Tue,  9 Apr 2019 18:31:07 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
	DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server
	id 14.3.408.0; Tue, 9 Apr 2019 18:30:57 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
	<imammedo@redhat.com>
Date: Tue, 9 Apr 2019 11:29:32 +0100
Message-ID: <20190409102935.28292-6-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
Subject: [Qemu-devel] [PATCH v4 5/8] hw/arm/virt: Enable device memory
 cold/hot plug with ACPI boot
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
	linuxarm@huawei.com, xuwei5@hisilicon.com,
	shannon.zhaosl@gmail.com, sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409102932.oHOEVnkKi7-Oq9lT2x19RwNood0namDNMemsOtREiKU@z>

This initializes the GED device with base memory and irq, configures
ged memory hotplug event and builds the corresponding aml code. GED
irq routing to Guest is also enabled. With this, both hot and cold
plug of device memory is enabled now for Guest with ACPI boot.

Memory cold plug support with Guest DT boot is not yet supported.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 default-configs/arm-softmmu.mak |  2 ++
 hw/arm/virt-acpi-build.c        |  9 ++++++
 hw/arm/virt.c                   | 61 +++++++++++++++++++++++++++++++++++++++--
 include/hw/arm/virt.h           |  4 +++
 4 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 9f4b803..c9a9b34 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -163,3 +163,5 @@ CONFIG_LSI_SCSI_PCI=y
 
 CONFIG_MEM_DEVICE=y
 CONFIG_DIMM=y
+CONFIG_ACPI_MEMORY_HOTPLUG=y
+CONFIG_ACPI_HW_REDUCED=y
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index bf9c0bc..1ad394b 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -40,6 +40,8 @@
 #include "hw/loader.h"
 #include "hw/hw.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/memory_hotplug.h"
+#include "hw/acpi/generic_event_device.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
 #include "hw/arm/virt.h"
@@ -727,6 +729,7 @@ static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     Aml *scope, *dsdt;
+    MachineState *ms = MACHINE(vms);
     const MemMapEntry *memmap = vms->memmap;
     const int *irqmap = vms->irqmap;
 
@@ -753,6 +756,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                        (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
     acpi_dsdt_add_power_button(scope);
 
+    build_ged_aml(scope, "\\_SB."GED_DEVICE, HOTPLUG_HANDLER(vms->acpi_dev),
+                  irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE, AML_SYSTEM_MEMORY);
+
+    build_memory_hotplug_aml(scope, ms->ram_slots, "\\_SB", NULL,
+                             AML_SYSTEM_MEMORY);
+
     aml_append(dsdt, scope);
 
     /* copy AML table into ACPI tables blob and patch header there */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index da516b3..8179b3e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -63,6 +63,7 @@
 #include "target/arm/internals.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/acpi/generic_event_device.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -133,6 +134,8 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
     [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
     [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
+    [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
+    [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_REG_LEN },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
@@ -168,6 +171,7 @@ static const int a15irqmap[] = {
     [VIRT_PCIE] = 3, /* ... to 6 */
     [VIRT_GPIO] = 7,
     [VIRT_SECURE_UART] = 8,
+    [VIRT_ACPI_GED] = 9,
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
     [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
@@ -183,6 +187,13 @@ static const char *valid_cpus[] = {
     ARM_CPU_TYPE_NAME("max"),
 };
 
+static GedEvent ged_events[] = {
+    {
+        .selector = ACPI_GED_IRQ_SEL_MEM,
+        .event    = GED_MEMORY_HOTPLUG,
+    },
+};
+
 static bool cpu_type_valid(const char *cpu)
 {
     int i;
@@ -516,6 +527,26 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
     }
 }
 
+static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
+{
+    DeviceState *dev;
+
+    dev = DEVICE(object_new(TYPE_ACPI_GED));
+    qdev_prop_set_uint64(dev, "memhp-base",
+                         vms->memmap[VIRT_PCDIMM_ACPI].base);
+    qdev_prop_set_ptr(dev, "gsi", vms->gsi);
+    qdev_prop_set_uint64(dev, "ged-base", vms->memmap[VIRT_ACPI_GED].base);
+    qdev_prop_set_uint32(dev, "ged-irq", vms->irqmap[VIRT_ACPI_GED]);
+    qdev_prop_set_ptr(dev, "ged-events", ged_events);
+    qdev_prop_set_uint32(dev, "ged-events-size", ARRAY_SIZE(ged_events));
+
+    object_property_add_child(qdev_get_machine(), "acpi-ged",
+                              OBJECT(dev), NULL);
+    qdev_init_nofail(dev);
+
+    return dev;
+}
+
 static void create_its(VirtMachineState *vms, DeviceState *gicdev)
 {
     const char *itsclass = its_class_name();
@@ -555,6 +586,12 @@ static void create_v2m(VirtMachineState *vms, qemu_irq *pic)
     fdt_add_v2m_gic_node(vms);
 }
 
+static void virt_gsi_handler(void *opaque, int n, int level)
+{
+    qemu_irq *gic_irq = opaque;
+    qemu_set_irq(gic_irq[n], level);
+}
+
 static void create_gic(VirtMachineState *vms, qemu_irq *pic)
 {
     /* We create a standalone GIC */
@@ -670,6 +707,8 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
         pic[i] = qdev_get_gpio_in(gicdev, i);
     }
 
+    vms->gsi = qemu_allocate_irqs(virt_gsi_handler, pic, NUM_IRQS);
+
     fdt_add_gic_node(vms);
 
     if (type == 3 && vms->its) {
@@ -1418,7 +1457,7 @@ static void machvirt_init(MachineState *machine)
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(machine);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *possible_cpus;
-    qemu_irq pic[NUM_IRQS];
+    qemu_irq *pic;
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *secure_sysmem = NULL;
     int n, virt_max_cpus;
@@ -1614,6 +1653,7 @@ static void machvirt_init(MachineState *machine)
 
     create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
 
+    pic = g_new0(qemu_irq, NUM_IRQS);
     create_gic(vms, pic);
 
     fdt_add_pmu_nodes(vms);
@@ -1644,6 +1684,8 @@ static void machvirt_init(MachineState *machine)
 
     create_platform_bus(vms, pic);
 
+    vms->acpi_dev = create_acpi_ged(vms);
+
     vms->bootinfo.ram_size = machine->ram_size;
     vms->bootinfo.kernel_filename = machine->kernel_filename;
     vms->bootinfo.kernel_cmdline = machine->kernel_cmdline;
@@ -1811,21 +1853,34 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
 static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                  Error **errp)
 {
-    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        error_setg(errp, "memory cold/hot plug is not yet supported");
+    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+    const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
+
+    if (is_nvdimm) {
+        error_setg(errp, "nvdimm is not yet supported");
         return;
     }
 
+    if (!vms->acpi_dev) {
+        error_setg(errp, "memory hotplug is not enabled: missing acpi device");
+        return;
+    }
+
+    hotplug_handler_pre_plug(HOTPLUG_HANDLER(vms->acpi_dev), dev, errp);
+
     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
 }
 
 static void virt_memory_plug(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
+    HotplugHandlerClass *hhc;
     VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
 
     pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), NULL);
 
+    hhc = HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
+    hhc->plug(HOTPLUG_HANDLER(vms->acpi_dev), dev, NULL);
 }
 
 static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 507517c..9c6b0b1 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -77,6 +77,8 @@ enum {
     VIRT_GPIO,
     VIRT_SECURE_UART,
     VIRT_SECURE_MEM,
+    VIRT_PCDIMM_ACPI,
+    VIRT_ACPI_GED,
     VIRT_LOWMEMMAP_LAST,
 };
 
@@ -132,6 +134,8 @@ typedef struct {
     uint32_t iommu_phandle;
     int psci_conduit;
     hwaddr highest_gpa;
+    DeviceState *acpi_dev;
+    qemu_irq *gsi;
 } VirtMachineState;
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
-- 
2.7.4



