Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8211C35242
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF03206D5
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF03206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3b5E-0000vW-RU
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 02:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b2x-0004J2-Qu
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b2v-0000WJ-Hj
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2790 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
 id 1j3b2r-0000Ih-5M; Mon, 17 Feb 2020 02:42:21 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id AA30DC16177AB9FE83FA;
 Mon, 17 Feb 2020 15:42:13 +0800 (CST)
Received: from localhost (10.175.124.177) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 15:42:05 +0800
From: Xu Yandong <xuyandong2@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH RFC 04/16] hw/arm: move shared irqmap member to ArmMachine
Date: Mon, 17 Feb 2020 02:51:16 -0500
Message-ID: <1581925888-103620-5-git-send-email-xuyandong2@huawei.com>
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

Move irqmap member from VirtMachineState to ArmMachineState.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
Signed-off-by: Xu Yandong <xuyandong2@huawei.com>
---
 hw/arm/virt-acpi-build.c |  8 ++++----
 hw/arm/virt.c            | 25 +++++++++++++------------
 include/hw/arm/arm.h     |  1 +
 include/hw/arm/virt.h    |  1 -
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index ef61a651c1..27e6c95eca 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -414,7 +414,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     its->identifiers[0] = 0; /* MADT translation_id */
 
     if (vms->iommu == VIRT_IOMMU_SMMUV3) {
-        int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
+        int irq =  ams->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
 
         /* SMMUv3 node */
         smmu_offset = iort_node_offset + node_size;
@@ -488,7 +488,7 @@ build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     AcpiSerialPortConsoleRedirection *spcr;
     ArmMachineState *ams = ARM_MACHINE(vms);
     const MemMapEntry *uart_memmap = &ams->memmap[VIRT_UART];
-    int irq = vms->irqmap[VIRT_UART] + ARM_SPI_BASE;
+    int irq = ams->irqmap[VIRT_UART] + ARM_SPI_BASE;
     int spcr_start = table_data->len;
 
     spcr = acpi_data_push(table_data, sizeof(*spcr));
@@ -609,7 +609,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     ArmMachineState *ams = ARM_MACHINE(vms);
     int madt_start = table_data->len;
     const MemMapEntry *memmap = ams->memmap;
-    const int *irqmap = vms->irqmap;
+    const int *irqmap = ams->irqmap;
     AcpiMultipleApicTable *madt;
     AcpiMadtGenericDistributor *gicd;
     AcpiMadtGenericMsiFrame *gic_msi;
@@ -730,7 +730,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     MachineState *ms = MACHINE(vms);
     ArmMachineState *ams = ARM_MACHINE(vms);
     const MemMapEntry *memmap = ams->memmap;
-    const int *irqmap = vms->irqmap;
+    const int *irqmap = ams->irqmap;
 
     dsdt = init_aml_allocator();
     /* Reserve space for header */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1dea640719..e7eee13385 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -544,7 +544,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
     DeviceState *dev;
     MachineState *ms = MACHINE(vms);
     ArmMachineState *ams = ARM_MACHINE(vms);
-    int irq = vms->irqmap[VIRT_ACPI_GED];
+    int irq = ams->irqmap[VIRT_ACPI_GED];
     uint32_t event = ACPI_GED_PWR_DOWN_EVT;
 
     if (ms->ram_slots) {
@@ -588,7 +588,7 @@ static void create_v2m(VirtMachineState *vms)
 {
     int i;
     ArmMachineState *ams = ARM_MACHINE(vms);
-    int irq = vms->irqmap[VIRT_GIC_V2M];
+    int irq = ams->irqmap[VIRT_GIC_V2M];
     DeviceState *dev;
 
     dev = qdev_create(NULL, "arm-gicv2m");
@@ -734,7 +734,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
     const ArmMachineState *ams = ARM_MACHINE(vms);
     hwaddr base = ams->memmap[uart].base;
     hwaddr size = ams->memmap[uart].size;
-    int irq = vms->irqmap[uart];
+    int irq = ams->irqmap[uart];
     const char compat[] = "arm,pl011\0arm,primecell";
     const char clocknames[] = "uartclk\0apb_pclk";
     DeviceState *dev = qdev_create(NULL, "pl011");
@@ -782,7 +782,7 @@ static void create_rtc(const VirtMachineState *vms)
     const ArmMachineState *ams = ARM_MACHINE(vms);
     hwaddr base = ams->memmap[VIRT_RTC].base;
     hwaddr size = ams->memmap[VIRT_RTC].size;
-    int irq = vms->irqmap[VIRT_RTC];
+    int irq = ams->irqmap[VIRT_RTC];
     const char compat[] = "arm,pl031\0arm,primecell";
 
     sysbus_create_simple("pl031", base, qdev_get_gpio_in(vms->gic, irq));
@@ -820,7 +820,7 @@ static void create_gpio(const VirtMachineState *vms)
     const ArmMachineState *ams = ARM_MACHINE(vms);
     hwaddr base = ams->memmap[VIRT_GPIO].base;
     hwaddr size = ams->memmap[VIRT_GPIO].size;
-    int irq = vms->irqmap[VIRT_GPIO];
+    int irq = ams->irqmap[VIRT_GPIO];
     const char compat[] = "arm,pl061\0arm,primecell";
 
     pl061_dev = sysbus_create_simple("pl061", base,
@@ -892,7 +892,7 @@ static void create_virtio_devices(const VirtMachineState *vms)
      * of disks users must use UUIDs or similar mechanisms.
      */
     for (i = 0; i < NUM_VIRTIO_TRANSPORTS; i++) {
-        int irq = vms->irqmap[VIRT_MMIO] + i;
+        int irq = ams->irqmap[VIRT_MMIO] + i;
         hwaddr base = ams->memmap[VIRT_MMIO].base + i * size;
 
         sysbus_create_simple("virtio-mmio", base,
@@ -908,7 +908,7 @@ static void create_virtio_devices(const VirtMachineState *vms)
      */
     for (i = NUM_VIRTIO_TRANSPORTS - 1; i >= 0; i--) {
         char *nodename;
-        int irq = vms->irqmap[VIRT_MMIO] + i;
+        int irq = ams->irqmap[VIRT_MMIO] + i;
         hwaddr base = ams->memmap[VIRT_MMIO].base + i * size;
 
         nodename = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
@@ -1155,7 +1155,7 @@ static void create_smmu(const VirtMachineState *vms,
     char *node;
     const ArmMachineState *ams = ARM_MACHINE(vms);
     const char compat[] = "arm,smmu-v3";
-    int irq =  vms->irqmap[VIRT_SMMU];
+    int irq = ams->irqmap[VIRT_SMMU];
     int i;
     hwaddr base = ams->memmap[VIRT_SMMU].base;
     hwaddr size = ams->memmap[VIRT_SMMU].size;
@@ -1213,7 +1213,7 @@ static void create_pcie(VirtMachineState *vms)
     hwaddr base_ecam, size_ecam;
     hwaddr base = base_mmio;
     int nr_pcie_buses;
-    int irq = vms->irqmap[VIRT_PCIE];
+    int irq = ams->irqmap[VIRT_PCIE];
     MemoryRegion *mmio_alias;
     MemoryRegion *mmio_reg;
     MemoryRegion *ecam_alias;
@@ -1349,7 +1349,7 @@ static void create_platform_bus(VirtMachineState *vms)
 
     s = SYS_BUS_DEVICE(dev);
     for (i = 0; i < PLATFORM_BUS_NUM_IRQS; i++) {
-        int irq = vms->irqmap[VIRT_PLATFORM_BUS] + i;
+        int irq = ams->irqmap[VIRT_PLATFORM_BUS] + i;
         sysbus_connect_irq(s, i, qdev_get_gpio_in(vms->gic, irq));
     }
 
@@ -1440,7 +1440,7 @@ void virt_machine_done(Notifier *notifier, void *data)
         platform_bus_add_all_fdt_nodes(ams->fdt, "/intc",
                                        ams->memmap[VIRT_PLATFORM_BUS].base,
                                        ams->memmap[VIRT_PLATFORM_BUS].size,
-                                       vms->irqmap[VIRT_PLATFORM_BUS]);
+                                       ams->irqmap[VIRT_PLATFORM_BUS]);
     }
     if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms) < 0) {
         exit(1);
@@ -2084,6 +2084,7 @@ static void virt_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+    ArmMachineState *ams = ARM_MACHINE(vms);
 
     /* EL3 is disabled by default on virt: this makes us consistent
      * between KVM and TCG for this board, and it also allows us to
@@ -2146,7 +2147,7 @@ static void virt_instance_init(Object *obj)
                                     "Valid values are none and smmuv3",
                                     NULL);
 
-    vms->irqmap = a15irqmap;
+    ams->irqmap = a15irqmap;
 
     virt_flash_create(vms);
 }
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index f269668d41..97cb902b6a 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -88,6 +88,7 @@ typedef struct {
 typedef struct {
     MachineState parent;
     MemMapEntry *memmap;
+    const int *irqmap;
     void *fdt;
     int fdt_size;
 } ArmMachineState;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 1b460d8d31..4028821a09 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -71,7 +71,6 @@ typedef struct {
     int32_t gic_version;
     VirtIOMMUType iommu;
     struct arm_boot_info bootinfo;
-    const int *irqmap;
     int smp_cpus;
     uint32_t clock_phandle;
     uint32_t gic_phandle;
-- 
2.18.1


