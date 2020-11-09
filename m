Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530A8C388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 03:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4EE206B7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 03:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4EE206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbxar-0002dG-Su
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 22:11:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kbxUs-0001bM-TJ; Sun, 08 Nov 2020 22:05:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kbxUn-0006jR-KE; Sun, 08 Nov 2020 22:05:34 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CTwpm0RnVz15SkF;
 Mon,  9 Nov 2020 11:05:20 +0800 (CST)
Received: from localhost (10.174.186.67) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Nov 2020
 11:05:17 +0800
From: Ying Fang <fangying1@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [RFC PATCH v3 11/13] hw/arm/virt: add fdt cache information
Date: Mon, 9 Nov 2020 11:04:50 +0800
Message-ID: <20201109030452.2197-12-fangying1@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201109030452.2197-1-fangying1@huawei.com>
References: <20201109030452.2197-1-fangying1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.67]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=fangying1@huawei.com;
 helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 22:05:17
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: drjones@redhat.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, alistair.francis@wdc.com,
 Ying Fang <fangying1@huawei.com>, imammedo@redhat.com, salil.mehta@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Support devicetree cpu cache information descriptions

Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 hw/arm/virt.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b6cebb5549..21275e03c2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -346,6 +346,89 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
                        GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL2_IRQ, irqflags);
 }
 
+static void fdt_add_l3cache_nodes(const VirtMachineState *vms)
+{
+    int i;
+    const MachineState *ms = MACHINE(vms);
+    ARMCPU *cpu = ARM_CPU(first_cpu);
+    unsigned int smp_cores = ms->smp.cores;
+    unsigned int sockets = ms->smp.max_cpus / smp_cores;
+
+    for (i = 0; i < sockets; i++) {
+        char *nodename = g_strdup_printf("/cpus/l3-cache%d", i);
+        qemu_fdt_add_subnode(vms->fdt, nodename);
+        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible", "cache");
+        qemu_fdt_setprop_string(vms->fdt, nodename, "cache-unified", "true");
+        qemu_fdt_setprop_cell(vms->fdt, nodename, "cache-level", 3);
+        qemu_fdt_setprop_cell(vms->fdt, nodename, "cache-size",
+                              cpu->caches.l3_cache->size);
+        qemu_fdt_setprop_cell(vms->fdt, nodename, "cache-line-size",
+                              cpu->caches.l3_cache->line_size);
+        qemu_fdt_setprop_cell(vms->fdt, nodename, "cache-sets",
+                              cpu->caches.l3_cache->sets);
+        qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle",
+                              qemu_fdt_alloc_phandle(vms->fdt));
+        g_free(nodename);
+    }
+}
+
+static void fdt_add_l2cache_nodes(const VirtMachineState *vms)
+{
+    int i, j;
+    const MachineState *ms = MACHINE(vms);
+    unsigned int smp_cores = ms->smp.cores;
+    signed int sockets = ms->smp.max_cpus / smp_cores;
+    ARMCPU *cpu = ARM_CPU(first_cpu);
+
+    for (i = 0; i < sockets; i++) {
+        char *next_path = g_strdup_printf("/cpus/l3-cache%d", i);
+        for (j = 0; j < smp_cores; j++) {
+            char *nodename = g_strdup_printf("/cpus/l2-cache%d",
+                                  i * smp_cores + j);
+            qemu_fdt_add_subnode(vms->fdt, nodename);
+            qemu_fdt_setprop_string(vms->fdt, nodename, "compatible", "cache");
+            qemu_fdt_setprop_cell(vms->fdt, nodename, "cache-size",
+                                  cpu->caches.l2_cache->size);
+            qemu_fdt_setprop_cell(vms->fdt, nodename, "cache-line-size",
+                                  cpu->caches.l2_cache->line_size);
+            qemu_fdt_setprop_cell(vms->fdt, nodename, "cache-sets",
+                                  cpu->caches.l2_cache->sets);
+            qemu_fdt_setprop_phandle(vms->fdt, nodename,
+                                  "next-level-cache", next_path);
+            qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle",
+                                  qemu_fdt_alloc_phandle(vms->fdt));
+            g_free(nodename);
+        }
+        g_free(next_path);
+    }
+}
+
+static void fdt_add_l1cache_prop(const VirtMachineState *vms,
+                            char *nodename, int cpu_index)
+{
+
+    ARMCPU *cpu = ARM_CPU(qemu_get_cpu(cpu_index));
+    CPUCaches caches = cpu->caches;
+
+    char *cachename = g_strdup_printf("/cpus/l2-cache%d", cpu_index);
+
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "d-cache-size",
+                          caches.l1d_cache->size);
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "d-cache-line-size",
+                          caches.l1d_cache->line_size);
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "d-cache-sets",
+                          caches.l1d_cache->sets);
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "i-cache-size",
+                          caches.l1i_cache->size);
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "i-cache-line-size",
+                          caches.l1i_cache->line_size);
+    qemu_fdt_setprop_cell(vms->fdt, nodename, "i-cache-sets",
+                          caches.l1i_cache->sets);
+    qemu_fdt_setprop_phandle(vms->fdt, nodename, "next-level-cache",
+                          cachename);
+    g_free(cachename);
+}
+
 static void fdt_add_cpu_nodes(const VirtMachineState *vms)
 {
     int cpu;
@@ -379,6 +462,11 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
     qemu_fdt_setprop_cell(vms->fdt, "/cpus", "#address-cells", addr_cells);
     qemu_fdt_setprop_cell(vms->fdt, "/cpus", "#size-cells", 0x0);
 
+    if (!vmc->ignore_cpu_topology) {
+        fdt_add_l3cache_nodes(vms);
+        fdt_add_l2cache_nodes(vms);
+    }
+
     for (cpu = ms->smp.cpus - 1; cpu >= 0; cpu--) {
         char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
@@ -408,6 +496,10 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
                 ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
         }
 
+        if (!vmc->ignore_cpu_topology) {
+            fdt_add_l1cache_prop(vms, nodename, cpu);
+        }
+
         if (ms->smp.cpus > 1 && !vmc->ignore_cpu_topology) {
             qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle",
                                   qemu_fdt_alloc_phandle(vms->fdt));
-- 
2.23.0


