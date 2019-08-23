Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86205C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369B42166E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXhv4NUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369B42166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i12Bt-00005Y-LR
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 01:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11rN-0004EO-JW
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11rL-0002e7-F4
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:37 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44967)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i11rL-0002dT-64; Fri, 23 Aug 2019 01:11:35 -0400
Received: by mail-pl1-x641.google.com with SMTP id t14so4863400plr.11;
 Thu, 22 Aug 2019 22:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=2N3MMQbYegU5OKFwZyOm9rmR6mP/9YQI4z2n6x0ztbw=;
 b=GXhv4NUkT9988N2SCjg0ajJ4pfkM+Wub5HT4vaZWt1SXvtams/pQfzpNMGUJQJ2pAz
 n79al6oBLFzLEDOsq7h9rrJbRvHq7aSpCUlo7uxW7nI3WCu+36OLHdzMNGjFzmqq0x37
 Asafu1YKJJQL7hTSJf1xoMSMYxSu0IFep6tzy5tKz77232RbUiqRnBBVIP9c+q+hiFMb
 xDRxA4ettpWeeWlv5lZgh9XA06ndmIkWZiS2aGpyTgyoC/UJmF6Ir1l38axmxfaHHg3v
 /lDpM1Wz1Y3C8oi+rU1sdwzsj7b03hKdOyfkvf+B7+CmjlNyeol4JcCZ98EdS60Bxwl4
 BFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=2N3MMQbYegU5OKFwZyOm9rmR6mP/9YQI4z2n6x0ztbw=;
 b=ekHQd+BOrEmxn4DazuE/DHIbFKdCXEFAyEBuaxKhxGtnYMhszJ5/gAtduydZAL4/1B
 VyBRQ0j2RoP/HCWkdshJb0UAFPFLbS/RgxFloh+AjEe76+zUwKUz4KMUcJSfZBCoULyD
 KXExYKbg1fSq/g6xOeDRzGvRY1rPPFdFVwgX381MqtOGaJpLRjTouYs1NqcDgYVzlE4H
 tK2SNdGdtzlzyUiMbsywGC6MMzrvFCXfGRk+cQflKDf7qA2rxkl7zCfU6jRfnyGz7pIm
 6P38Ht7qA7GDKv4CjFeDgqWNUqLZQK6hBQKW96/mgcajkY6T7aMuJ8eYLXhaPP4/ZNbJ
 feXA==
X-Gm-Message-State: APjAAAVAxWmcCu+nA9tl8uIIq3PaXVmEQZYJlRaLsHbhTmNb4Vyu+AvA
 y+TT+5UraTE7dG9mVIqeaGk=
X-Google-Smtp-Source: APXvYqx1F/a9gV1y7WDV8D/9BkJXR4GtPmbJbuwyAHSJC17FtrAw2Ty6fLo0FsKEWQH6gpXPyp6CSg==
X-Received: by 2002:a17:902:b68f:: with SMTP id
 c15mr2686187pls.104.1566537094370; 
 Thu, 22 Aug 2019 22:11:34 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v189sm1122527pfv.176.2019.08.22.22.11.33
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 22 Aug 2019 22:11:33 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Thu, 22 Aug 2019 22:10:55 -0700
Message-Id: <1566537069-22741-17-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
References: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v5 16/30] riscv: sifive_u: Update hart
 configuration to reflect the real FU540 SoC
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The FU540-C000 includes a 64-bit E51 RISC-V core and four 64-bit U54
RISC-V cores. Currently the sifive_u machine only populates 4 U54
cores. Update the max cpu number to 5 to reflect the real hardware,
by creating 2 CPU clusters as containers for RISC-V hart arrays to
populate heterogeneous harts.

The cpu nodes in the generated DTS have been updated as well.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v5: None
Changes in v4:
- changed to create clusters for each cpu type

Changes in v3:
- changed to use macros for management and compute cpu count

Changes in v2:
- fixed the "interrupts-extended" property size

 hw/riscv/sifive_u.c         | 102 +++++++++++++++++++++++++++++++++-----------
 include/hw/riscv/sifive_u.h |   8 +++-
 2 files changed, 84 insertions(+), 26 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3f58f61..0e5bbe7 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -10,7 +10,8 @@
  * 1) CLINT (Core Level Interruptor)
  * 2) PLIC (Platform Level Interrupt Controller)
  *
- * This board currently uses a hardcoded devicetree that indicates one hart.
+ * This board currently generates devicetree dynamically that indicates at most
+ * five harts.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -26,6 +27,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -34,6 +36,7 @@
 #include "hw/loader.h"
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
+#include "hw/cpu/cluster.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_plic.h"
@@ -69,6 +72,7 @@ static const struct MemmapEntry {
 static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     void *fdt;
     int cpu;
     uint32_t *cells;
@@ -109,15 +113,21 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
 
-    for (cpu = s->soc.cpus.num_harts - 1; cpu >= 0; cpu--) {
+    for (cpu = ms->smp.cpus - 1; cpu >= 0; cpu--) {
         int cpu_phandle = phandle++;
         nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        char *isa = riscv_isa_string(&s->soc.cpus.harts[cpu]);
+        char *isa;
         qemu_fdt_add_subnode(fdt, nodename);
         qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
                               SIFIVE_U_CLOCK_FREQ);
-        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+        /* cpu 0 is the management hart that does not have mmu */
+        if (cpu != 0) {
+            qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+            isa = riscv_isa_string(&s->soc.u_cpus.harts[cpu - 1]);
+        } else {
+            isa = riscv_isa_string(&s->soc.e_cpus.harts[0]);
+        }
         qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
         qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
         qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
@@ -133,8 +143,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         g_free(nodename);
     }
 
-    cells =  g_new0(uint32_t, s->soc.cpus.num_harts * 4);
-    for (cpu = 0; cpu < s->soc.cpus.num_harts; cpu++) {
+    cells =  g_new0(uint32_t, ms->smp.cpus * 4);
+    for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
         nodename =
             g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
         uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
@@ -152,20 +162,26 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         0x0, memmap[SIFIVE_U_CLINT].base,
         0x0, memmap[SIFIVE_U_CLINT].size);
     qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
-        cells, s->soc.cpus.num_harts * sizeof(uint32_t) * 4);
+        cells, ms->smp.cpus * sizeof(uint32_t) * 4);
     g_free(cells);
     g_free(nodename);
 
     plic_phandle = phandle++;
-    cells =  g_new0(uint32_t, s->soc.cpus.num_harts * 4);
-    for (cpu = 0; cpu < s->soc.cpus.num_harts; cpu++) {
+    cells =  g_new0(uint32_t, ms->smp.cpus * 4 - 2);
+    for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
         nodename =
             g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
         uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
-        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
-        cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_EXT);
-        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
-        cells[cpu * 4 + 3] = cpu_to_be32(IRQ_S_EXT);
+        /* cpu 0 is the management hart that does not have S-mode */
+        if (cpu == 0) {
+            cells[0] = cpu_to_be32(intc_phandle);
+            cells[1] = cpu_to_be32(IRQ_M_EXT);
+        } else {
+            cells[cpu * 4 - 2] = cpu_to_be32(intc_phandle);
+            cells[cpu * 4 - 1] = cpu_to_be32(IRQ_M_EXT);
+            cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
+            cells[cpu * 4 + 1] = cpu_to_be32(IRQ_S_EXT);
+        }
         g_free(nodename);
     }
     nodename = g_strdup_printf("/soc/interrupt-controller@%lx",
@@ -175,7 +191,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,plic0");
     qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
     qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
-        cells, s->soc.cpus.num_harts * sizeof(uint32_t) * 4);
+        cells, (ms->smp.cpus * 4 - 2) * sizeof(uint32_t));
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[SIFIVE_U_PLIC].base,
         0x0, memmap[SIFIVE_U_PLIC].size);
@@ -338,12 +354,39 @@ static void riscv_sifive_u_soc_init(Object *obj)
     MachineState *ms = MACHINE(qdev_get_machine());
     SiFiveUSoCState *s = RISCV_U_SOC(obj);
 
-    object_initialize_child(obj, "cpus", &s->cpus, sizeof(s->cpus),
-                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->cpus), SIFIVE_U_CPU, "cpu-type",
-                            &error_abort);
-    object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
-                            &error_abort);
+    object_initialize_child(obj, "e-cluster", &s->e_cluster,
+                            sizeof(s->e_cluster), TYPE_CPU_CLUSTER,
+                            &error_abort, NULL);
+    qdev_prop_set_uint32(DEVICE(&s->e_cluster), "cluster-id", 0);
+
+    object_initialize_child(OBJECT(&s->e_cluster), "e-cpus",
+                            &s->e_cpus, sizeof(s->e_cpus),
+                            TYPE_RISCV_HART_ARRAY, &error_abort,
+                            NULL);
+    object_property_set_uint(OBJECT(&s->e_cpus), 1,
+                             "num-harts", &error_abort);
+    object_property_set_uint(OBJECT(&s->e_cpus), 0,
+                             "hartid-base", &error_abort);
+    object_property_set_str(OBJECT(&s->e_cpus), SIFIVE_E_CPU,
+                            "cpu-type", &error_abort);
+
+    if (ms->smp.cpus > 1) {
+        object_initialize_child(obj, "u-cluster", &s->u_cluster,
+                                sizeof(s->u_cluster), TYPE_CPU_CLUSTER,
+                                &error_abort, NULL);
+        qdev_prop_set_uint32(DEVICE(&s->u_cluster), "cluster-id", 1);
+
+        object_initialize_child(OBJECT(&s->u_cluster), "u-cpus",
+                                &s->u_cpus, sizeof(s->u_cpus),
+                                TYPE_RISCV_HART_ARRAY, &error_abort,
+                                NULL);
+        object_property_set_uint(OBJECT(&s->u_cpus), ms->smp.cpus - 1,
+                                 "num-harts", &error_abort);
+        object_property_set_uint(OBJECT(&s->u_cpus), 1,
+                                 "hartid-base", &error_abort);
+        object_property_set_str(OBJECT(&s->u_cpus), SIFIVE_U_CPU,
+                                "cpu-type", &error_abort);
+    }
 
     sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
                           TYPE_CADENCE_GEM);
@@ -363,7 +406,19 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     Error *err = NULL;
     NICInfo *nd = &nd_table[0];
 
-    object_property_set_bool(OBJECT(&s->cpus), true, "realized",
+    object_property_set_bool(OBJECT(&s->e_cpus), true, "realized",
+                             &error_abort);
+    object_property_set_bool(OBJECT(&s->u_cpus), true, "realized",
+                             &error_abort);
+    /*
+     * The cluster must be realized after the RISC-V hart array container,
+     * as the container's CPU object is only created on realize, and the
+     * CPU must exist and have been parented into the cluster before the
+     * cluster is realized.
+     */
+    object_property_set_bool(OBJECT(&s->e_cluster), true, "realized",
+                             &error_abort);
+    object_property_set_bool(OBJECT(&s->u_cluster), true, "realized",
                              &error_abort);
 
     /* boot rom */
@@ -429,10 +484,7 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
 {
     mc->desc = "RISC-V Board compatible with SiFive U SDK";
     mc->init = riscv_sifive_u_init;
-    /* The real hardware has 5 CPUs, but one of them is a small embedded power
-     * management CPU.
-     */
-    mc->max_cpus = 4;
+    mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
 }
 
 DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 4abc621..7a1a4f3 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -31,7 +31,10 @@ typedef struct SiFiveUSoCState {
     SysBusDevice parent_obj;
 
     /*< public >*/
-    RISCVHartArrayState cpus;
+    CPUClusterState e_cluster;
+    CPUClusterState u_cluster;
+    RISCVHartArrayState e_cpus;
+    RISCVHartArrayState u_cpus;
     DeviceState *plic;
     CadenceGEMState gem;
 } SiFiveUSoCState;
@@ -68,6 +71,9 @@ enum {
     SIFIVE_U_GEM_CLOCK_FREQ = 125000000
 };
 
+#define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
+#define SIFIVE_U_COMPUTE_CPU_COUNT      4
+
 #define SIFIVE_U_PLIC_HART_CONFIG "MS"
 #define SIFIVE_U_PLIC_NUM_SOURCES 54
 #define SIFIVE_U_PLIC_NUM_PRIORITIES 7
-- 
2.7.4


