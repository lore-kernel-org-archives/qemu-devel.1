Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EE2C7619D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C55B206D5
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C55B206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3b3q-0005ws-Lt
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 02:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b2v-0004Hc-Kc
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b2t-0000U0-Q0
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:25 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45474 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
 id 1j3b2q-0000Jp-F4; Mon, 17 Feb 2020 02:42:20 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C1114725AEB8CBDF36BB;
 Mon, 17 Feb 2020 15:42:14 +0800 (CST)
Received: from localhost (10.175.124.177) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 15:42:06 +0800
From: Xu Yandong <xuyandong2@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH RFC 05/16] hw/arm: move shared smp_cpus member to ArmMachine
Date: Mon, 17 Feb 2020 02:51:17 -0500
Message-ID: <1581925888-103620-6-git-send-email-xuyandong2@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
References: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.177]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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

Move smp_cpus member from VirtMachineState to ArmMachineState.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
Signed-off-by: Xu Yandong <xuyandong2@huawei.com>
---
 hw/arm/virt-acpi-build.c |  4 ++--
 hw/arm/virt.c            | 12 ++++++------
 include/hw/arm/arm.h     |  1 +
 include/hw/arm/virt.h    |  3 +--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 27e6c95eca..ef2761ef77 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -623,7 +623,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     gicd->base_address = cpu_to_le64(memmap[VIRT_GIC_DIST].base);
     gicd->version = vms->gic_version;
 
-    for (i = 0; i < vms->smp_cpus; i++) {
+    for (i = 0; i < ams->smp_cpus; i++) {
         AcpiMadtGenericCpuInterface *gicc = acpi_data_push(table_data,
                                                            sizeof(*gicc));
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
@@ -742,7 +742,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
      * the RTC ACPI device at all when using UEFI.
      */
     scope = aml_scope("\\_SB");
-    acpi_dsdt_add_cpus(scope, vms->smp_cpus);
+    acpi_dsdt_add_cpus(scope, ams->smp_cpus);
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
                        (irqmap[VIRT_UART] + ARM_SPI_BASE));
     acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e7eee13385..9031fd6757 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -300,7 +300,7 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
     if (vms->gic_version == 2) {
         irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
                              GIC_FDT_IRQ_PPI_CPU_WIDTH,
-                             (1 << vms->smp_cpus) - 1);
+                             (1 << ams->smp_cpus) - 1);
     }
 
     qemu_fdt_add_subnode(ams->fdt, "/timer");
@@ -342,7 +342,7 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
      *  The simplest way to go is to examine affinity IDs of all our CPUs. If
      *  at least one of them has Aff3 populated, we set #address-cells to 2.
      */
-    for (cpu = 0; cpu < vms->smp_cpus; cpu++) {
+    for (cpu = 0; cpu < ams->smp_cpus; cpu++) {
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
 
         if (armcpu->mp_affinity & ARM_AFF3_MASK) {
@@ -355,7 +355,7 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
     qemu_fdt_setprop_cell(ams->fdt, "/cpus", "#address-cells", addr_cells);
     qemu_fdt_setprop_cell(ams->fdt, "/cpus", "#size-cells", 0x0);
 
-    for (cpu = vms->smp_cpus - 1; cpu >= 0; cpu--) {
+    for (cpu = ams->smp_cpus - 1; cpu >= 0; cpu--) {
         char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
         CPUState *cs = CPU(armcpu);
@@ -366,7 +366,7 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
                                     armcpu->dtb_compatible);
 
         if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED
-            && vms->smp_cpus > 1) {
+            && ams->smp_cpus > 1) {
             qemu_fdt_setprop_string(ams->fdt, nodename,
                                         "enable-method", "psci");
         }
@@ -525,7 +525,7 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
     if (vms->gic_version == 2) {
         irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
                              GIC_FDT_IRQ_PPI_CPU_WIDTH,
-                             (1 << vms->smp_cpus) - 1);
+                             (1 << ams->smp_cpus) - 1);
     }
 
     armcpu = ARM_CPU(qemu_get_cpu(0));
@@ -1641,7 +1641,7 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    vms->smp_cpus = smp_cpus;
+    ams->smp_cpus = smp_cpus;
 
     if (vms->virt && kvm_enabled()) {
         error_report("mach-virt: KVM does not support providing "
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index 97cb902b6a..469f603e77 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -89,6 +89,7 @@ typedef struct {
     MachineState parent;
     MemMapEntry *memmap;
     const int *irqmap;
+    int smp_cpus;
     void *fdt;
     int fdt_size;
 } ArmMachineState;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 4028821a09..dfc2a16010 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -71,7 +71,6 @@ typedef struct {
     int32_t gic_version;
     VirtIOMMUType iommu;
     struct arm_boot_info bootinfo;
-    int smp_cpus;
     uint32_t clock_phandle;
     uint32_t gic_phandle;
     uint32_t msi_phandle;
@@ -104,7 +103,7 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
 
     assert(vms->gic_version == 3);
 
-    return vms->smp_cpus > redist0_capacity ? 2 : 1;
+    return ams->smp_cpus > redist0_capacity ? 2 : 1;
 }
 
 #endif /* QEMU_ARM_VIRT_H */
-- 
2.18.1


