Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EB9C388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 03:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7D9206E3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 03:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7D9206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbxWQ-0003Nt-Eo
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 22:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kbxUq-0001aA-Mu; Sun, 08 Nov 2020 22:05:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kbxUn-0006eZ-CS; Sun, 08 Nov 2020 22:05:32 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CTwpc2L7Lzkgtd;
 Mon,  9 Nov 2020 11:05:12 +0800 (CST)
Received: from localhost (10.174.186.67) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Nov 2020
 11:05:13 +0800
From: Ying Fang <fangying1@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [RFC PATCH v3 06/13] hw/arm/virt: DT: add cpu-map
Date: Mon, 9 Nov 2020 11:04:45 +0800
Message-ID: <20201109030452.2197-7-fangying1@huawei.com>
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

From: Andrew Jones <drjones@redhat.com>

Support devicetree CPU topology descriptions.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 hw/arm/virt.c         | 40 +++++++++++++++++++++++++++++++++++++++-
 include/hw/arm/virt.h |  1 +
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ff8a14439e..d23b941020 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -351,9 +351,10 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
     int cpu;
     int addr_cells = 1;
     const MachineState *ms = MACHINE(vms);
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
 
     /*
-     * From Documentation/devicetree/bindings/arm/cpus.txt
+     * See Linux Documentation/devicetree/bindings/arm/cpus.yaml
      *  On ARM v8 64-bit systems value should be set to 2,
      *  that corresponds to the MPIDR_EL1 register size.
      *  If MPIDR_EL1[63:32] value is equal to 0 on all CPUs
@@ -407,8 +408,42 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
                 ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
         }
 
+        if (ms->smp.cpus > 1 && !vmc->ignore_cpu_topology) {
+            qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle",
+                                  qemu_fdt_alloc_phandle(vms->fdt));
+        }
+
         g_free(nodename);
     }
+
+    if (ms->smp.cpus > 1 && !vmc->ignore_cpu_topology) {
+        /*
+         * See Linux Documentation/devicetree/bindings/cpu/cpu-topology.txt
+         */
+        qemu_fdt_add_subnode(vms->fdt, "/cpus/cpu-map");
+
+        for (cpu = ms->smp.cpus - 1; cpu >= 0; cpu--) {
+            char *cpu_path = g_strdup_printf("/cpus/cpu@%d", cpu);
+            char *map_path;
+
+            if (ms->smp.threads > 1) {
+                map_path = g_strdup_printf(
+                            "/cpus/cpu-map/%s%d/%s%d/%s%d",
+                            "cluster", cpu / (ms->smp.cores * ms->smp.threads),
+                            "core", (cpu / ms->smp.threads) % ms->smp.cores,
+                            "thread", cpu % ms->smp.threads);
+            } else {
+                map_path = g_strdup_printf(
+                            "/cpus/cpu-map/%s%d/%s%d",
+                            "cluster", cpu / ms->smp.cores,
+                            "core", cpu % ms->smp.cores);
+            }
+            qemu_fdt_add_path(vms->fdt, map_path);
+            qemu_fdt_setprop_phandle(vms->fdt, map_path, "cpu", cpu_path);
+            g_free(map_path);
+            g_free(cpu_path);
+        }
+    }
 }
 
 static void fdt_add_its_gic_node(VirtMachineState *vms)
@@ -2672,8 +2707,11 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 3)
 
 static void virt_machine_5_2_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_5_3_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_2, hw_compat_5_2_len);
+    vmc->ignore_cpu_topology = true;
 }
 DEFINE_VIRT_MACHINE(5, 2)
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 010f24f580..917bd8b645 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -118,6 +118,7 @@ typedef enum VirtGICType {
 struct VirtMachineClass {
     MachineClass parent;
     bool disallow_affinity_adjustment;
+    bool ignore_cpu_topology;
     bool no_its;
     bool no_pmu;
     bool claim_edge_triggered_timers;
-- 
2.23.0


