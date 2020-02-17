Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5584C35242
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700222067D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700222067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3bAU-0001BZ-L4
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 02:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b35-0004ZM-7h
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b30-0000dr-NJ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2791 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
 id 1j3b2q-0000Ij-F5; Mon, 17 Feb 2020 02:42:21 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id B16FA629FD86864EA7EF;
 Mon, 17 Feb 2020 15:42:13 +0800 (CST)
Received: from localhost (10.175.124.177) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 15:42:04 +0800
From: Xu Yandong <xuyandong2@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH RFC 02/16] hw/arm: move shared fdt member to ArmMachine
Date: Mon, 17 Feb 2020 02:51:14 -0500
Message-ID: <1581925888-103620-3-git-send-email-xuyandong2@huawei.com>
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
 Xu Yandong <xuyandong2@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move fdt and fdt_size member from VirtMachineState to ArmMachineState.

Signed-off-by: Xu Yandong <xuyandong2@huawei.com>
---
 hw/arm/virt.c         | 303 ++++++++++++++++++++++--------------------
 include/hw/arm/arm.h  |   2 +
 include/hw/arm/virt.h |   2 -
 3 files changed, 163 insertions(+), 144 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 355007fd32..41b2076ce1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -211,15 +211,16 @@ static bool cpu_type_valid(const char *cpu)
 static void create_fdt(VirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
+    ArmMachineState *ams = ARM_MACHINE(vms);
     int nb_numa_nodes = ms->numa_state->num_nodes;
-    void *fdt = create_device_tree(&vms->fdt_size);
+    void *fdt = create_device_tree(&ams->fdt_size);
 
     if (!fdt) {
         error_report("create_device_tree() failed");
         exit(1);
     }
 
-    vms->fdt = fdt;
+    ams->fdt = fdt;
 
     /* Header */
     qemu_fdt_setprop_string(fdt, "/", "compatible", "linux,dummy-virt");
@@ -288,6 +289,7 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
      * the correct information.
      */
     ARMCPU *armcpu;
+    ArmMachineState *ams = ARM_MACHINE(vms);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
 
@@ -301,19 +303,19 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
                              (1 << vms->smp_cpus) - 1);
     }
 
-    qemu_fdt_add_subnode(vms->fdt, "/timer");
+    qemu_fdt_add_subnode(ams->fdt, "/timer");
 
     armcpu = ARM_CPU(qemu_get_cpu(0));
     if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
         const char compat[] = "arm,armv8-timer\0arm,armv7-timer";
-        qemu_fdt_setprop(vms->fdt, "/timer", "compatible",
+        qemu_fdt_setprop(ams->fdt, "/timer", "compatible",
                          compat, sizeof(compat));
     } else {
-        qemu_fdt_setprop_string(vms->fdt, "/timer", "compatible",
+        qemu_fdt_setprop_string(ams->fdt, "/timer", "compatible",
                                 "arm,armv7-timer");
     }
-    qemu_fdt_setprop(vms->fdt, "/timer", "always-on", NULL, 0);
-    qemu_fdt_setprop_cells(vms->fdt, "/timer", "interrupts",
+    qemu_fdt_setprop(ams->fdt, "/timer", "always-on", NULL, 0);
+    qemu_fdt_setprop_cells(ams->fdt, "/timer", "interrupts",
                        GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_S_EL1_IRQ, irqflags,
                        GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL1_IRQ, irqflags,
                        GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_VIRT_IRQ, irqflags,
@@ -325,6 +327,7 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
     int cpu;
     int addr_cells = 1;
     const MachineState *ms = MACHINE(vms);
+    const ArmMachineState *ams = ARM_MACHINE(vms);
 
     /*
      * From Documentation/devicetree/bindings/arm/cpus.txt
@@ -348,36 +351,36 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
         }
     }
 
-    qemu_fdt_add_subnode(vms->fdt, "/cpus");
-    qemu_fdt_setprop_cell(vms->fdt, "/cpus", "#address-cells", addr_cells);
-    qemu_fdt_setprop_cell(vms->fdt, "/cpus", "#size-cells", 0x0);
+    qemu_fdt_add_subnode(ams->fdt, "/cpus");
+    qemu_fdt_setprop_cell(ams->fdt, "/cpus", "#address-cells", addr_cells);
+    qemu_fdt_setprop_cell(ams->fdt, "/cpus", "#size-cells", 0x0);
 
     for (cpu = vms->smp_cpus - 1; cpu >= 0; cpu--) {
         char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
         CPUState *cs = CPU(armcpu);
 
-        qemu_fdt_add_subnode(vms->fdt, nodename);
-        qemu_fdt_setprop_string(vms->fdt, nodename, "device_type", "cpu");
-        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
+        qemu_fdt_add_subnode(ams->fdt, nodename);
+        qemu_fdt_setprop_string(ams->fdt, nodename, "device_type", "cpu");
+        qemu_fdt_setprop_string(ams->fdt, nodename, "compatible",
                                     armcpu->dtb_compatible);
 
         if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED
             && vms->smp_cpus > 1) {
-            qemu_fdt_setprop_string(vms->fdt, nodename,
+            qemu_fdt_setprop_string(ams->fdt, nodename,
                                         "enable-method", "psci");
         }
 
         if (addr_cells == 2) {
-            qemu_fdt_setprop_u64(vms->fdt, nodename, "reg",
+            qemu_fdt_setprop_u64(ams->fdt, nodename, "reg",
                                  armcpu->mp_affinity);
         } else {
-            qemu_fdt_setprop_cell(vms->fdt, nodename, "reg",
+            qemu_fdt_setprop_cell(ams->fdt, nodename, "reg",
                                   armcpu->mp_affinity);
         }
 
         if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
-            qemu_fdt_setprop_cell(vms->fdt, nodename, "numa-node-id",
+            qemu_fdt_setprop_cell(ams->fdt, nodename, "numa-node-id",
                 ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
         }
 
@@ -388,71 +391,74 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
 static void fdt_add_its_gic_node(VirtMachineState *vms)
 {
     char *nodename;
+    ArmMachineState *ams = ARM_MACHINE(vms);
 
-    vms->msi_phandle = qemu_fdt_alloc_phandle(vms->fdt);
+    vms->msi_phandle = qemu_fdt_alloc_phandle(ams->fdt);
     nodename = g_strdup_printf("/intc/its@%" PRIx64,
                                vms->memmap[VIRT_GIC_ITS].base);
-    qemu_fdt_add_subnode(vms->fdt, nodename);
-    qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
+    qemu_fdt_add_subnode(ams->fdt, nodename);
+    qemu_fdt_setprop_string(ams->fdt, nodename, "compatible",
                             "arm,gic-v3-its");
-    qemu_fdt_setprop(vms->fdt, nodename, "msi-controller", NULL, 0);
-    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+    qemu_fdt_setprop(ams->fdt, nodename, "msi-controller", NULL, 0);
+    qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
                                  2, vms->memmap[VIRT_GIC_ITS].base,
                                  2, vms->memmap[VIRT_GIC_ITS].size);
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle", vms->msi_phandle);
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "phandle", vms->msi_phandle);
     g_free(nodename);
 }
 
 static void fdt_add_v2m_gic_node(VirtMachineState *vms)
 {
     char *nodename;
+    ArmMachineState *ams = ARM_MACHINE(vms);
 
     nodename = g_strdup_printf("/intc/v2m@%" PRIx64,
                                vms->memmap[VIRT_GIC_V2M].base);
-    vms->msi_phandle = qemu_fdt_alloc_phandle(vms->fdt);
-    qemu_fdt_add_subnode(vms->fdt, nodename);
-    qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
+    vms->msi_phandle = qemu_fdt_alloc_phandle(ams->fdt);
+    qemu_fdt_add_subnode(ams->fdt, nodename);
+    qemu_fdt_setprop_string(ams->fdt, nodename, "compatible",
                             "arm,gic-v2m-frame");
-    qemu_fdt_setprop(vms->fdt, nodename, "msi-controller", NULL, 0);
-    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+    qemu_fdt_setprop(ams->fdt, nodename, "msi-controller", NULL, 0);
+    qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
                                  2, vms->memmap[VIRT_GIC_V2M].base,
                                  2, vms->memmap[VIRT_GIC_V2M].size);
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle", vms->msi_phandle);
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "phandle", vms->msi_phandle);
     g_free(nodename);
 }
 
 static void fdt_add_gic_node(VirtMachineState *vms)
 {
     char *nodename;
+    ArmMachineState *ams = ARM_MACHINE(vms);
 
-    vms->gic_phandle = qemu_fdt_alloc_phandle(vms->fdt);
-    qemu_fdt_setprop_cell(vms->fdt, "/", "interrupt-parent", vms->gic_phandle);
+    vms->gic_phandle = qemu_fdt_alloc_phandle(ams->fdt);
+    qemu_fdt_setprop_cell(ams->fdt, "/", "interrupt-parent", vms->gic_phandle);
 
     nodename = g_strdup_printf("/intc@%" PRIx64,
                                vms->memmap[VIRT_GIC_DIST].base);
-    qemu_fdt_add_subnode(vms->fdt, nodename);
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "#interrupt-cells", 3);
-    qemu_fdt_setprop(vms->fdt, nodename, "interrupt-controller", NULL, 0);
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "#address-cells", 0x2);
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "#size-cells", 0x2);
-    qemu_fdt_setprop(vms->fdt, nodename, "ranges", NULL, 0);
+    qemu_fdt_add_subnode(ams->fdt, nodename);
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "#interrupt-cells", 3);
+    qemu_fdt_setprop(ams->fdt, nodename, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "#address-cells", 0x2);
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "#size-cells", 0x2);
+    qemu_fdt_setprop(ams->fdt, nodename, "ranges", NULL, 0);
     if (vms->gic_version == 3) {
         int nb_redist_regions = virt_gicv3_redist_region_count(vms);
 
-        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
+        qemu_fdt_setprop_string(ams->fdt, nodename, "compatible",
                                 "arm,gic-v3");
 
-        qemu_fdt_setprop_cell(vms->fdt, nodename,
+        qemu_fdt_setprop_cell(ams->fdt, nodename,
                               "#redistributor-regions", nb_redist_regions);
 
         if (nb_redist_regions == 1) {
-            qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+            qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
                                          2, vms->memmap[VIRT_GIC_DIST].base,
                                          2, vms->memmap[VIRT_GIC_DIST].size,
                                          2, vms->memmap[VIRT_GIC_REDIST].base,
                                          2, vms->memmap[VIRT_GIC_REDIST].size);
         } else {
-            qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+            qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
                                  2, vms->memmap[VIRT_GIC_DIST].base,
                                  2, vms->memmap[VIRT_GIC_DIST].size,
                                  2, vms->memmap[VIRT_GIC_REDIST].base,
@@ -462,22 +468,22 @@ static void fdt_add_gic_node(VirtMachineState *vms)
         }
 
         if (vms->virt) {
-            qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
+            qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
                                    GIC_FDT_IRQ_TYPE_PPI, ARCH_GIC_MAINT_IRQ,
                                    GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         }
     } else {
         /* 'cortex-a15-gic' means 'GIC v2' */
-        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
+        qemu_fdt_setprop_string(ams->fdt, nodename, "compatible",
                                 "arm,cortex-a15-gic");
         if (!vms->virt) {
-            qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+            qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
                                          2, vms->memmap[VIRT_GIC_DIST].base,
                                          2, vms->memmap[VIRT_GIC_DIST].size,
                                          2, vms->memmap[VIRT_GIC_CPU].base,
                                          2, vms->memmap[VIRT_GIC_CPU].size);
         } else {
-            qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+            qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
                                          2, vms->memmap[VIRT_GIC_DIST].base,
                                          2, vms->memmap[VIRT_GIC_DIST].size,
                                          2, vms->memmap[VIRT_GIC_CPU].base,
@@ -486,13 +492,13 @@ static void fdt_add_gic_node(VirtMachineState *vms)
                                          2, vms->memmap[VIRT_GIC_HYP].size,
                                          2, vms->memmap[VIRT_GIC_VCPU].base,
                                          2, vms->memmap[VIRT_GIC_VCPU].size);
-            qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
+            qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
                                    GIC_FDT_IRQ_TYPE_PPI, ARCH_GIC_MAINT_IRQ,
                                    GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         }
     }
 
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle", vms->gic_phandle);
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "phandle", vms->gic_phandle);
     g_free(nodename);
 }
 
@@ -500,6 +506,7 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
 {
     CPUState *cpu;
     ARMCPU *armcpu;
+    const ArmMachineState *ams = ARM_MACHINE(vms);
     uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
 
     CPU_FOREACH(cpu) {
@@ -522,12 +529,12 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
     }
 
     armcpu = ARM_CPU(qemu_get_cpu(0));
-    qemu_fdt_add_subnode(vms->fdt, "/pmu");
+    qemu_fdt_add_subnode(ams->fdt, "/pmu");
     if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
         const char compat[] = "arm,armv8-pmuv3";
-        qemu_fdt_setprop(vms->fdt, "/pmu", "compatible",
+        qemu_fdt_setprop(ams->fdt, "/pmu", "compatible",
                          compat, sizeof(compat));
-        qemu_fdt_setprop_cells(vms->fdt, "/pmu", "interrupts",
+        qemu_fdt_setprop_cells(ams->fdt, "/pmu", "interrupts",
                                GIC_FDT_IRQ_TYPE_PPI, VIRTUAL_PMU_IRQ, irqflags);
     }
 }
@@ -720,6 +727,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
                         MemoryRegion *mem, Chardev *chr)
 {
     char *nodename;
+    const ArmMachineState *ams = ARM_MACHINE(vms);
     hwaddr base = vms->memmap[uart].base;
     hwaddr size = vms->memmap[uart].size;
     int irq = vms->irqmap[uart];
@@ -735,29 +743,29 @@ static void create_uart(const VirtMachineState *vms, int uart,
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
 
     nodename = g_strdup_printf("/pl011@%" PRIx64, base);
-    qemu_fdt_add_subnode(vms->fdt, nodename);
+    qemu_fdt_add_subnode(ams->fdt, nodename);
     /* Note that we can't use setprop_string because of the embedded NUL */
-    qemu_fdt_setprop(vms->fdt, nodename, "compatible",
+    qemu_fdt_setprop(ams->fdt, nodename, "compatible",
                          compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+    qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
                                      2, base, 2, size);
-    qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
+    qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
                                GIC_FDT_IRQ_TYPE_SPI, irq,
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop_cells(vms->fdt, nodename, "clocks",
+    qemu_fdt_setprop_cells(ams->fdt, nodename, "clocks",
                                vms->clock_phandle, vms->clock_phandle);
-    qemu_fdt_setprop(vms->fdt, nodename, "clock-names",
+    qemu_fdt_setprop(ams->fdt, nodename, "clock-names",
                          clocknames, sizeof(clocknames));
 
     if (uart == VIRT_UART) {
-        qemu_fdt_setprop_string(vms->fdt, "/chosen", "stdout-path", nodename);
+        qemu_fdt_setprop_string(ams->fdt, "/chosen", "stdout-path", nodename);
     } else {
         /* Mark as not usable by the normal world */
-        qemu_fdt_setprop_string(vms->fdt, nodename, "status", "disabled");
-        qemu_fdt_setprop_string(vms->fdt, nodename, "secure-status", "okay");
+        qemu_fdt_setprop_string(ams->fdt, nodename, "status", "disabled");
+        qemu_fdt_setprop_string(ams->fdt, nodename, "secure-status", "okay");
 
-        qemu_fdt_add_subnode(vms->fdt, "/secure-chosen");
-        qemu_fdt_setprop_string(vms->fdt, "/secure-chosen", "stdout-path",
+        qemu_fdt_add_subnode(ams->fdt, "/secure-chosen");
+        qemu_fdt_setprop_string(ams->fdt, "/secure-chosen", "stdout-path",
                                 nodename);
     }
 
@@ -767,6 +775,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
 static void create_rtc(const VirtMachineState *vms)
 {
     char *nodename;
+    const ArmMachineState *ams = ARM_MACHINE(vms);
     hwaddr base = vms->memmap[VIRT_RTC].base;
     hwaddr size = vms->memmap[VIRT_RTC].size;
     int irq = vms->irqmap[VIRT_RTC];
@@ -775,15 +784,15 @@ static void create_rtc(const VirtMachineState *vms)
     sysbus_create_simple("pl031", base, qdev_get_gpio_in(vms->gic, irq));
 
     nodename = g_strdup_printf("/pl031@%" PRIx64, base);
-    qemu_fdt_add_subnode(vms->fdt, nodename);
-    qemu_fdt_setprop(vms->fdt, nodename, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+    qemu_fdt_add_subnode(ams->fdt, nodename);
+    qemu_fdt_setprop(ams->fdt, nodename, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
                                  2, base, 2, size);
-    qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
+    qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
                            GIC_FDT_IRQ_TYPE_SPI, irq,
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "clocks", vms->clock_phandle);
-    qemu_fdt_setprop_string(vms->fdt, nodename, "clock-names", "apb_pclk");
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "clocks", vms->clock_phandle);
+    qemu_fdt_setprop_string(ams->fdt, nodename, "clock-names", "apb_pclk");
     g_free(nodename);
 }
 
@@ -804,6 +813,7 @@ static void create_gpio(const VirtMachineState *vms)
 {
     char *nodename;
     DeviceState *pl061_dev;
+    const ArmMachineState *ams = ARM_MACHINE(vms);
     hwaddr base = vms->memmap[VIRT_GPIO].base;
     hwaddr size = vms->memmap[VIRT_GPIO].size;
     int irq = vms->irqmap[VIRT_GPIO];
@@ -812,34 +822,34 @@ static void create_gpio(const VirtMachineState *vms)
     pl061_dev = sysbus_create_simple("pl061", base,
                                      qdev_get_gpio_in(vms->gic, irq));
 
-    uint32_t phandle = qemu_fdt_alloc_phandle(vms->fdt);
+    uint32_t phandle = qemu_fdt_alloc_phandle(ams->fdt);
     nodename = g_strdup_printf("/pl061@%" PRIx64, base);
-    qemu_fdt_add_subnode(vms->fdt, nodename);
-    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+    qemu_fdt_add_subnode(ams->fdt, nodename);
+    qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
                                  2, base, 2, size);
-    qemu_fdt_setprop(vms->fdt, nodename, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "#gpio-cells", 2);
-    qemu_fdt_setprop(vms->fdt, nodename, "gpio-controller", NULL, 0);
-    qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
+    qemu_fdt_setprop(ams->fdt, nodename, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "#gpio-cells", 2);
+    qemu_fdt_setprop(ams->fdt, nodename, "gpio-controller", NULL, 0);
+    qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
                            GIC_FDT_IRQ_TYPE_SPI, irq,
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "clocks", vms->clock_phandle);
-    qemu_fdt_setprop_string(vms->fdt, nodename, "clock-names", "apb_pclk");
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle", phandle);
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "clocks", vms->clock_phandle);
+    qemu_fdt_setprop_string(ams->fdt, nodename, "clock-names", "apb_pclk");
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "phandle", phandle);
 
     gpio_key_dev = sysbus_create_simple("gpio-key", -1,
                                         qdev_get_gpio_in(pl061_dev, 3));
-    qemu_fdt_add_subnode(vms->fdt, "/gpio-keys");
-    qemu_fdt_setprop_string(vms->fdt, "/gpio-keys", "compatible", "gpio-keys");
-    qemu_fdt_setprop_cell(vms->fdt, "/gpio-keys", "#size-cells", 0);
-    qemu_fdt_setprop_cell(vms->fdt, "/gpio-keys", "#address-cells", 1);
+    qemu_fdt_add_subnode(ams->fdt, "/gpio-keys");
+    qemu_fdt_setprop_string(ams->fdt, "/gpio-keys", "compatible", "gpio-keys");
+    qemu_fdt_setprop_cell(ams->fdt, "/gpio-keys", "#size-cells", 0);
+    qemu_fdt_setprop_cell(ams->fdt, "/gpio-keys", "#address-cells", 1);
 
-    qemu_fdt_add_subnode(vms->fdt, "/gpio-keys/poweroff");
-    qemu_fdt_setprop_string(vms->fdt, "/gpio-keys/poweroff",
+    qemu_fdt_add_subnode(ams->fdt, "/gpio-keys/poweroff");
+    qemu_fdt_setprop_string(ams->fdt, "/gpio-keys/poweroff",
                             "label", "GPIO Key Poweroff");
-    qemu_fdt_setprop_cell(vms->fdt, "/gpio-keys/poweroff", "linux,code",
+    qemu_fdt_setprop_cell(ams->fdt, "/gpio-keys/poweroff", "linux,code",
                           KEY_POWER);
-    qemu_fdt_setprop_cells(vms->fdt, "/gpio-keys/poweroff",
+    qemu_fdt_setprop_cells(ams->fdt, "/gpio-keys/poweroff",
                            "gpios", phandle, 3, 0);
     g_free(nodename);
 }
@@ -847,6 +857,7 @@ static void create_gpio(const VirtMachineState *vms)
 static void create_virtio_devices(const VirtMachineState *vms)
 {
     int i;
+    const ArmMachineState *ams = ARM_MACHINE(vms);
     hwaddr size = vms->memmap[VIRT_MMIO].size;
 
     /* We create the transports in forwards order. Since qbus_realize()
@@ -897,15 +908,15 @@ static void create_virtio_devices(const VirtMachineState *vms)
         hwaddr base = vms->memmap[VIRT_MMIO].base + i * size;
 
         nodename = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
-        qemu_fdt_add_subnode(vms->fdt, nodename);
-        qemu_fdt_setprop_string(vms->fdt, nodename,
+        qemu_fdt_add_subnode(ams->fdt, nodename);
+        qemu_fdt_setprop_string(ams->fdt, nodename,
                                 "compatible", "virtio,mmio");
-        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+        qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
                                      2, base, 2, size);
-        qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
+        qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
                                GIC_FDT_IRQ_TYPE_SPI, irq,
                                GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
-        qemu_fdt_setprop(vms->fdt, nodename, "dma-coherent", NULL, 0);
+        qemu_fdt_setprop(ams->fdt, nodename, "dma-coherent", NULL, 0);
         g_free(nodename);
     }
 }
@@ -985,6 +996,7 @@ static void virt_flash_fdt(VirtMachineState *vms,
                            MemoryRegion *sysmem,
                            MemoryRegion *secure_sysmem)
 {
+    ArmMachineState *ams = ARM_MACHINE(vms);
     hwaddr flashsize = vms->memmap[VIRT_FLASH].size / 2;
     hwaddr flashbase = vms->memmap[VIRT_FLASH].base;
     char *nodename;
@@ -992,12 +1004,12 @@ static void virt_flash_fdt(VirtMachineState *vms,
     if (sysmem == secure_sysmem) {
         /* Report both flash devices as a single node in the DT */
         nodename = g_strdup_printf("/flash@%" PRIx64, flashbase);
-        qemu_fdt_add_subnode(vms->fdt, nodename);
-        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible", "cfi-flash");
-        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+        qemu_fdt_add_subnode(ams->fdt, nodename);
+        qemu_fdt_setprop_string(ams->fdt, nodename, "compatible", "cfi-flash");
+        qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
                                      2, flashbase, 2, flashsize,
                                      2, flashbase + flashsize, 2, flashsize);
-        qemu_fdt_setprop_cell(vms->fdt, nodename, "bank-width", 4);
+        qemu_fdt_setprop_cell(ams->fdt, nodename, "bank-width", 4);
         g_free(nodename);
     } else {
         /*
@@ -1005,21 +1017,21 @@ static void virt_flash_fdt(VirtMachineState *vms,
          * only visible to the secure world.
          */
         nodename = g_strdup_printf("/secflash@%" PRIx64, flashbase);
-        qemu_fdt_add_subnode(vms->fdt, nodename);
-        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible", "cfi-flash");
-        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+        qemu_fdt_add_subnode(ams->fdt, nodename);
+        qemu_fdt_setprop_string(ams->fdt, nodename, "compatible", "cfi-flash");
+        qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
                                      2, flashbase, 2, flashsize);
-        qemu_fdt_setprop_cell(vms->fdt, nodename, "bank-width", 4);
-        qemu_fdt_setprop_string(vms->fdt, nodename, "status", "disabled");
-        qemu_fdt_setprop_string(vms->fdt, nodename, "secure-status", "okay");
+        qemu_fdt_setprop_cell(ams->fdt, nodename, "bank-width", 4);
+        qemu_fdt_setprop_string(ams->fdt, nodename, "status", "disabled");
+        qemu_fdt_setprop_string(ams->fdt, nodename, "secure-status", "okay");
         g_free(nodename);
 
         nodename = g_strdup_printf("/flash@%" PRIx64, flashbase);
-        qemu_fdt_add_subnode(vms->fdt, nodename);
-        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible", "cfi-flash");
-        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+        qemu_fdt_add_subnode(ams->fdt, nodename);
+        qemu_fdt_setprop_string(ams->fdt, nodename, "compatible", "cfi-flash");
+        qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
                                      2, flashbase + flashsize, 2, flashsize);
-        qemu_fdt_setprop_cell(vms->fdt, nodename, "bank-width", 4);
+        qemu_fdt_setprop_cell(ams->fdt, nodename, "bank-width", 4);
         g_free(nodename);
     }
 }
@@ -1075,6 +1087,7 @@ static bool virt_firmware_init(VirtMachineState *vms,
 static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
 {
     MachineState *ms = MACHINE(vms);
+    const ArmMachineState *ams = ARM_MACHINE(vms);
     hwaddr base = vms->memmap[VIRT_FW_CFG].base;
     hwaddr size = vms->memmap[VIRT_FW_CFG].size;
     FWCfgState *fw_cfg;
@@ -1084,12 +1097,12 @@ static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)ms->smp.cpus);
 
     nodename = g_strdup_printf("/fw-cfg@%" PRIx64, base);
-    qemu_fdt_add_subnode(vms->fdt, nodename);
-    qemu_fdt_setprop_string(vms->fdt, nodename,
+    qemu_fdt_add_subnode(ams->fdt, nodename);
+    qemu_fdt_setprop_string(ams->fdt, nodename,
                             "compatible", "qemu,fw-cfg-mmio");
-    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+    qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
                                  2, base, 2, size);
-    qemu_fdt_setprop(vms->fdt, nodename, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop(ams->fdt, nodename, "dma-coherent", NULL, 0);
     g_free(nodename);
     return fw_cfg;
 }
@@ -1101,6 +1114,7 @@ static void create_pcie_irq_map(const VirtMachineState *vms,
     int devfn, pin;
     uint32_t full_irq_map[4 * 4 * 10] = { 0 };
     uint32_t *irq_map = full_irq_map;
+    const ArmMachineState *ams = ARM_MACHINE(vms);
 
     for (devfn = 0; devfn <= 0x18; devfn += 0x8) {
         for (pin = 0; pin < 4; pin++) {
@@ -1122,10 +1136,10 @@ static void create_pcie_irq_map(const VirtMachineState *vms,
         }
     }
 
-    qemu_fdt_setprop(vms->fdt, nodename, "interrupt-map",
+    qemu_fdt_setprop(ams->fdt, nodename, "interrupt-map",
                      full_irq_map, sizeof(full_irq_map));
 
-    qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupt-map-mask",
+    qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupt-map-mask",
                            0x1800, 0, 0, /* devfn (PCI_SLOT(3)) */
                            0x7           /* PCI irq */);
 }
@@ -1134,6 +1148,7 @@ static void create_smmu(const VirtMachineState *vms,
                         PCIBus *bus)
 {
     char *node;
+    const ArmMachineState *ams = ARM_MACHINE(vms);
     const char compat[] = "arm,smmu-v3";
     int irq =  vms->irqmap[VIRT_SMMU];
     int i;
@@ -1158,31 +1173,32 @@ static void create_smmu(const VirtMachineState *vms,
     }
 
     node = g_strdup_printf("/smmuv3@%" PRIx64, base);
-    qemu_fdt_add_subnode(vms->fdt, node);
-    qemu_fdt_setprop(vms->fdt, node, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(vms->fdt, node, "reg", 2, base, 2, size);
+    qemu_fdt_add_subnode(ams->fdt, node);
+    qemu_fdt_setprop(ams->fdt, node, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(ams->fdt, node, "reg", 2, base, 2, size);
 
-    qemu_fdt_setprop_cells(vms->fdt, node, "interrupts",
+    qemu_fdt_setprop_cells(ams->fdt, node, "interrupts",
             GIC_FDT_IRQ_TYPE_SPI, irq    , GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
             GIC_FDT_IRQ_TYPE_SPI, irq + 1, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
             GIC_FDT_IRQ_TYPE_SPI, irq + 2, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
             GIC_FDT_IRQ_TYPE_SPI, irq + 3, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
 
-    qemu_fdt_setprop(vms->fdt, node, "interrupt-names", irq_names,
+    qemu_fdt_setprop(ams->fdt, node, "interrupt-names", irq_names,
                      sizeof(irq_names));
 
-    qemu_fdt_setprop_cell(vms->fdt, node, "clocks", vms->clock_phandle);
-    qemu_fdt_setprop_string(vms->fdt, node, "clock-names", "apb_pclk");
-    qemu_fdt_setprop(vms->fdt, node, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop_cell(ams->fdt, node, "clocks", vms->clock_phandle);
+    qemu_fdt_setprop_string(ams->fdt, node, "clock-names", "apb_pclk");
+    qemu_fdt_setprop(ams->fdt, node, "dma-coherent", NULL, 0);
 
-    qemu_fdt_setprop_cell(vms->fdt, node, "#iommu-cells", 1);
+    qemu_fdt_setprop_cell(ams->fdt, node, "#iommu-cells", 1);
 
-    qemu_fdt_setprop_cell(vms->fdt, node, "phandle", vms->iommu_phandle);
+    qemu_fdt_setprop_cell(ams->fdt, node, "phandle", vms->iommu_phandle);
     g_free(node);
 }
 
 static void create_pcie(VirtMachineState *vms)
 {
+    ArmMachineState *ams = ARM_MACHINE(vms);
     hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
     hwaddr size_mmio = vms->memmap[VIRT_PCIE_MMIO].size;
     hwaddr base_mmio_high = vms->memmap[VIRT_HIGH_PCIE_MMIO].base;
@@ -1260,27 +1276,27 @@ static void create_pcie(VirtMachineState *vms)
     }
 
     nodename = g_strdup_printf("/pcie@%" PRIx64, base);
-    qemu_fdt_add_subnode(vms->fdt, nodename);
-    qemu_fdt_setprop_string(vms->fdt, nodename,
+    qemu_fdt_add_subnode(ams->fdt, nodename);
+    qemu_fdt_setprop_string(ams->fdt, nodename,
                             "compatible", "pci-host-ecam-generic");
-    qemu_fdt_setprop_string(vms->fdt, nodename, "device_type", "pci");
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "#address-cells", 3);
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "#size-cells", 2);
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "linux,pci-domain", 0);
-    qemu_fdt_setprop_cells(vms->fdt, nodename, "bus-range", 0,
+    qemu_fdt_setprop_string(ams->fdt, nodename, "device_type", "pci");
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "#address-cells", 3);
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "#size-cells", 2);
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "linux,pci-domain", 0);
+    qemu_fdt_setprop_cells(ams->fdt, nodename, "bus-range", 0,
                            nr_pcie_buses - 1);
-    qemu_fdt_setprop(vms->fdt, nodename, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop(ams->fdt, nodename, "dma-coherent", NULL, 0);
 
     if (vms->msi_phandle) {
-        qemu_fdt_setprop_cells(vms->fdt, nodename, "msi-parent",
+        qemu_fdt_setprop_cells(ams->fdt, nodename, "msi-parent",
                                vms->msi_phandle);
     }
 
-    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+    qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
                                  2, base_ecam, 2, size_ecam);
 
     if (vms->highmem) {
-        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "ranges",
+        qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "ranges",
                                      1, FDT_PCI_RANGE_IOPORT, 2, 0,
                                      2, base_pio, 2, size_pio,
                                      1, FDT_PCI_RANGE_MMIO, 2, base_mmio,
@@ -1289,22 +1305,22 @@ static void create_pcie(VirtMachineState *vms)
                                      2, base_mmio_high,
                                      2, base_mmio_high, 2, size_mmio_high);
     } else {
-        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "ranges",
+        qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "ranges",
                                      1, FDT_PCI_RANGE_IOPORT, 2, 0,
                                      2, base_pio, 2, size_pio,
                                      1, FDT_PCI_RANGE_MMIO, 2, base_mmio,
                                      2, base_mmio, 2, size_mmio);
     }
 
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "#interrupt-cells", 1);
+    qemu_fdt_setprop_cell(ams->fdt, nodename, "#interrupt-cells", 1);
     create_pcie_irq_map(vms, vms->gic_phandle, irq, nodename);
 
     if (vms->iommu) {
-        vms->iommu_phandle = qemu_fdt_alloc_phandle(vms->fdt);
+        vms->iommu_phandle = qemu_fdt_alloc_phandle(ams->fdt);
 
         create_smmu(vms, pci->bus);
 
-        qemu_fdt_setprop_cells(vms->fdt, nodename, "iommu-map",
+        qemu_fdt_setprop_cells(ams->fdt, nodename, "iommu-map",
                                0x0, vms->iommu_phandle, 0x0, 0x10000);
     }
 
@@ -1341,6 +1357,7 @@ static void create_secure_ram(VirtMachineState *vms,
 {
     MemoryRegion *secram = g_new(MemoryRegion, 1);
     char *nodename;
+    ArmMachineState *ams = ARM_MACHINE(vms);
     hwaddr base = vms->memmap[VIRT_SECURE_MEM].base;
     hwaddr size = vms->memmap[VIRT_SECURE_MEM].size;
 
@@ -1349,20 +1366,21 @@ static void create_secure_ram(VirtMachineState *vms,
     memory_region_add_subregion(secure_sysmem, base, secram);
 
     nodename = g_strdup_printf("/secram@%" PRIx64, base);
-    qemu_fdt_add_subnode(vms->fdt, nodename);
-    qemu_fdt_setprop_string(vms->fdt, nodename, "device_type", "memory");
-    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg", 2, base, 2, size);
-    qemu_fdt_setprop_string(vms->fdt, nodename, "status", "disabled");
-    qemu_fdt_setprop_string(vms->fdt, nodename, "secure-status", "okay");
+    qemu_fdt_add_subnode(ams->fdt, nodename);
+    qemu_fdt_setprop_string(ams->fdt, nodename, "device_type", "memory");
+    qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg", 2, base, 2, size);
+    qemu_fdt_setprop_string(ams->fdt, nodename, "status", "disabled");
+    qemu_fdt_setprop_string(ams->fdt, nodename, "secure-status", "okay");
 
     g_free(nodename);
 }
 
 static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
 {
-    const VirtMachineState *board = container_of(binfo, VirtMachineState,
+    const VirtMachineState *vms = container_of(binfo, VirtMachineState,
                                                  bootinfo);
 
+    ArmMachineState *board = ARM_MACHINE(vms);
     *fdt_size = board->fdt_size;
     return board->fdt;
 }
@@ -1400,6 +1418,7 @@ void virt_machine_done(Notifier *notifier, void *data)
     VirtMachineState *vms = container_of(notifier, VirtMachineState,
                                          machine_done);
     MachineState *ms = MACHINE(vms);
+    ArmMachineState *ams = ARM_MACHINE(vms);
     ARMCPU *cpu = ARM_CPU(first_cpu);
     struct arm_boot_info *info = &vms->bootinfo;
     AddressSpace *as = arm_boot_address_space(cpu, info);
@@ -1412,7 +1431,7 @@ void virt_machine_done(Notifier *notifier, void *data)
      * while qemu takes charge of the qom stuff.
      */
     if (info->dtb_filename == NULL) {
-        platform_bus_add_all_fdt_nodes(vms->fdt, "/intc",
+        platform_bus_add_all_fdt_nodes(ams->fdt, "/intc",
                                        vms->memmap[VIRT_PLATFORM_BUS].base,
                                        vms->memmap[VIRT_PLATFORM_BUS].size,
                                        vms->irqmap[VIRT_PLATFORM_BUS]);
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index 2aa9ee3d05..b3b3daa95a 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -87,6 +87,8 @@ typedef struct {
 
 typedef struct {
     MachineState parent;
+    void *fdt;
+    int fdt_size;
 } ArmMachineState;
 
 #define TYPE_ARM_MACHINE   MACHINE_TYPE_NAME("arm")
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index aa0cc852a5..ad353bad92 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -74,8 +74,6 @@ typedef struct {
     MemMapEntry *memmap;
     const int *irqmap;
     int smp_cpus;
-    void *fdt;
-    int fdt_size;
     uint32_t clock_phandle;
     uint32_t gic_phandle;
     uint32_t msi_phandle;
-- 
2.18.1


