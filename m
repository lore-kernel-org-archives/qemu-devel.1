Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6360ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8ED2084D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8ED2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7ySc-0002rZ-6R
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 04:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xwG-0008Cj-Tx
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xwF-0006me-0L
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:20 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:55432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xwE-0006mH-Pr
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:18 -0400
Received: by mail-wm1-f49.google.com with SMTP id g207so2321085wmg.5
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=P7VabXfas9eiGrOMMiabUTjFR8zAzPPXsWhfGKuvZ/Y=;
 b=B2UofkxvRFXxEA9X+XQ9llbsjgfE74DIxif+eZnbW/LF7uu5bWmorumdcYzU4awBve
 Se2qYPb0d0U321mRolla7FWTU0SGCbgYOaaniDZfMX1NmBEE0o9iliHMyumQrid6IYCD
 jQLZXrbpY8F/NVWaIZLmGEtMPhe0Vyt5i5GJ1E+reg7oEmWfAuEsKvaXzws1VYGAmYjQ
 oqQhlvVAkoPWD84g5AGDSlIVWqcuHbkRqy+QYEOJ4/QrFTUXCLFb1iYhzoMFkFRy8BOt
 2zgiKTCp5mXJYL9KK1F5WoUwbawGbWrV4r2UJ/J9igDwpYnOsMoEeHnO8JyMYUIPlALf
 3KYw==
X-Gm-Message-State: APjAAAXwdwdb739rbqRsjXJAoxHh3Jljc70sgWKCSO0THTOV2wQfPIFp
 OOQfok7oc+krgI0Qwlp/1ATamQ==
X-Google-Smtp-Source: APXvYqy/n/wfaTc1XGGPyvsQA9FykrEUreXV0m89M3nsjkAuY5MkF2hH/ITZyib56KUJ6v+HeADZ7w==
X-Received: by 2002:a05:600c:220c:: with SMTP id
 z12mr2982563wml.125.1568190317597; 
 Wed, 11 Sep 2019 01:25:17 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id j1sm26305080wrg.24.2019.09.11.01.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:25:17 -0700 (PDT)
Date: Tue, 10 Sep 2019 12:04:57 -0700
Message-Id: <20190910190513.21160-32-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910190513.21160-1-palmer@sifive.com>
References: <20190910190513.21160-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.49
Subject: [Qemu-devel] [PULL 31/47] riscv: sifive_u: Update hart
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

The FU540-C000 includes a 64-bit E51 RISC-V core and four 64-bit U54
RISC-V cores. Currently the sifive_u machine only populates 4 U54
cores. Update the max cpu number to 5 to reflect the real hardware,
by creating 2 CPU clusters as containers for RISC-V hart arrays to
populate heterogeneous harts.

The cpu nodes in the generated DTS have been updated as well.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c         | 92 +++++++++++++++++++++++++++----------
 include/hw/riscv/sifive_u.h |  6 ++-
 2 files changed, 72 insertions(+), 26 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 2023b71d53..6c4634dcac 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -11,7 +11,7 @@
  * 2) PLIC (Platform Level Interrupt Controller)
  *
  * This board currently generates devicetree dynamically that indicates at least
- * two harts.
+ * two harts and up to five harts.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -34,6 +34,7 @@
 #include "hw/loader.h"
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
+#include "hw/cpu/cluster.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_plic.h"
@@ -70,6 +71,7 @@ static const struct MemmapEntry {
 static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     void *fdt;
     int cpu;
     uint32_t *cells;
@@ -110,15 +112,21 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
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
@@ -134,8 +142,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         g_free(nodename);
     }
 
-    cells =  g_new0(uint32_t, s->soc.cpus.num_harts * 4);
-    for (cpu = 0; cpu < s->soc.cpus.num_harts; cpu++) {
+    cells =  g_new0(uint32_t, ms->smp.cpus * 4);
+    for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
         nodename =
             g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
         uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
@@ -153,20 +161,26 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
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
@@ -176,7 +190,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,plic0");
     qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
     qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
-        cells, s->soc.cpus.num_harts * sizeof(uint32_t) * 4);
+        cells, (ms->smp.cpus * 4 - 2) * sizeof(uint32_t));
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[SIFIVE_U_PLIC].base,
         0x0, memmap[SIFIVE_U_PLIC].size);
@@ -339,12 +353,31 @@ static void riscv_sifive_u_soc_init(Object *obj)
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
+    qdev_prop_set_uint32(DEVICE(&s->e_cpus), "num-harts", 1);
+    qdev_prop_set_uint32(DEVICE(&s->e_cpus), "hartid-base", 0);
+    qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", SIFIVE_E_CPU);
+
+    object_initialize_child(obj, "u-cluster", &s->u_cluster,
+                            sizeof(s->u_cluster), TYPE_CPU_CLUSTER,
+                            &error_abort, NULL);
+    qdev_prop_set_uint32(DEVICE(&s->u_cluster), "cluster-id", 1);
+
+    object_initialize_child(OBJECT(&s->u_cluster), "u-cpus",
+                            &s->u_cpus, sizeof(s->u_cpus),
+                            TYPE_RISCV_HART_ARRAY, &error_abort,
+                            NULL);
+    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
+    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
+    qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type", SIFIVE_U_CPU);
 
     sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
                           TYPE_CADENCE_GEM);
@@ -364,7 +397,19 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
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
@@ -430,10 +475,7 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
 {
     mc->desc = "RISC-V Board compatible with SiFive U SDK";
     mc->init = riscv_sifive_u_init;
-    /* The real hardware has 5 CPUs, but one of them is a small embedded power
-     * management CPU.
-     */
-    mc->max_cpus = 4;
+    mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
     mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
 }
 
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 6d227410f8..6b2b5b68e2 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -32,7 +32,10 @@ typedef struct SiFiveUSoCState {
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
@@ -70,6 +73,7 @@ enum {
 };
 
 #define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
+#define SIFIVE_U_COMPUTE_CPU_COUNT      4
 
 #define SIFIVE_U_PLIC_HART_CONFIG "MS"
 #define SIFIVE_U_PLIC_NUM_SOURCES 54
-- 
2.21.0


