Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC15C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB0B20782
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k+L/ULlu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB0B20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeB3-0005HU-5r
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9u-0003W9-A7
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:02 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9r-0002vu-Ux
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598381941; x=1629917941;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WN34E2Kp1GOIgyZeYGdnQaJiK91IAYIEelANbFuu2is=;
 b=k+L/ULluc4Z34+OcyZtDF5F8RIKXecqhfyefPVfopYHAzIVa6gUyO99Y
 LvuNbnyYErijmtSwPMazZ7yjOPEMoK5Wh44CHia1KPC23Kz9+aKPNXZ11
 F3//ipr5vAwD0Zcxq8uVsc3F8a3r9BDLCOidNDz4boEK+zz9OBVQkCsim
 2Hc/fstxXp6ivSyDaEfD1fOkd6KGfAo5OZPUeAfS0KgKmFisS98/zwql3
 tHpcxdzq/fqxRPjZZNDP9b9o77+l5dmXvJ9yDEwbNIFo4BX7ex2OVeIxy
 MOJumPxj2lT54zbdS4J4RphL1DQoowGdKQ7zgICVyLQI21IlulgUlTGHG A==;
IronPort-SDR: APS7lF5Azc3KNZ2RdF+JBFvtleYvTtegmcfS4+uZDHRva8CtBDdgdtbNKgXR3g2Qr/q58kwIlj
 /p8uq9Z1kzBAVPjd2VEOrhfke2+z3hiMWg8oAuEWEHFr4mKK6cObIgVz1iuchai1XoeZ9LnlCz
 8XiqATMFUMdkaM4GXMl27PTxfiOCq6ZL/R/iOZJFdpE7YezcGlRlwpf3tGlLDeU5qwUmgSqJaI
 67mLdDP/M2rOx9jHuzIBLWU/gIwAnMq3h/g1x5ViB6NGZ2lIdjVDZH14fuXytOdgcRnxApLXHz
 N94=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="150145286"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 02:58:55 +0800
IronPort-SDR: Q7BwrAo9ReuIwG9LpEtzuMassjADRGaCEl3cpWlIfjcAD7hJ13IUea66fOIPWLXmIXZxUrJW3w
 9blzi2nrGW+w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:46:30 -0700
IronPort-SDR: rmDDOUTxSzaOPCKSKwTU/HzUykQu+3pcya6qkeFJalwo/tjP7SnGsIzXnfotyAHZ/t/bWlWD/B
 5orJbZXwsRtg==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 11:58:54 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/18] hw/riscv: spike: Allow creating multiple NUMA sockets
Date: Tue, 25 Aug 2020 11:48:22 -0700
Message-Id: <20200825184836.1282371-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825184836.1282371-1-alistair.francis@wdc.com>
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=49978a6e9=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 14:58:53
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair23@gmail.com, Anup Patel <anup.patel@wdc.com>,
 alistair.francis@wdc.com, Atish Patra <atish.patra@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anup Patel <anup.patel@wdc.com>

We extend RISC-V spike machine to allow creating a multi-socket
machine. Each RISC-V spike machine socket is a NUMA node having
a set of HARTs, a memory instance, and a CLINT instance. Other
devices are shared between all sockets. We also update the
generated device tree accordingly.

By default, NUMA multi-socket support is disabled for RISC-V spike
machine. To enable it, users can use "-numa" command-line options
of QEMU.

Example1: For two NUMA nodes with 2 CPUs each, append following
to command-line options: "-smp 4 -numa node -numa node"

Example2: For two NUMA nodes with 1 and 3 CPUs, append following
to command-line options:
"-smp 4 -numa node -numa node -numa cpu,node-id=0,core-id=0 \
-numa cpu,node-id=1,core-id=1 -numa cpu,node-id=1,core-id=2 \
-numa cpu,node-id=1,core-id=3"

The maximum number of sockets in a RISC-V spike machine is 8
but this limit can be changed in future.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
Message-Id: <20200616032229.766089-5-anup.patel@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/spike.h |  11 +-
 hw/riscv/spike.c         | 232 ++++++++++++++++++++++++++-------------
 2 files changed, 167 insertions(+), 76 deletions(-)

diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index 1cd72b85d6..b0a18a9c94 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -22,12 +22,19 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
 
+#define SPIKE_CPUS_MAX 8
+#define SPIKE_SOCKETS_MAX 8
+
+#define TYPE_SPIKE_MACHINE MACHINE_TYPE_NAME("spike")
+#define SPIKE_MACHINE(obj) \
+    OBJECT_CHECK(SpikeState, (obj), TYPE_SPIKE_MACHINE)
+
 typedef struct {
     /*< private >*/
-    SysBusDevice parent_obj;
+    MachineState parent;
 
     /*< public >*/
-    RISCVHartArrayState soc;
+    RISCVHartArrayState soc[SPIKE_SOCKETS_MAX];
     void *fdt;
     int fdt_size;
 } SpikeState;
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 5d422b4944..56f5fe73c7 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -36,6 +36,7 @@
 #include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/spike.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/numa.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
@@ -66,9 +67,14 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
     void *fdt;
-    int cpu;
-    uint32_t *cells;
-    char *nodename;
+    uint64_t addr, size;
+    unsigned long clint_addr;
+    int cpu, socket;
+    MachineState *mc = MACHINE(s);
+    uint32_t *clint_cells;
+    uint32_t cpu_phandle, intc_phandle, phandle = 1;
+    char *name, *mem_name, *clint_name, *clust_name;
+    char *core_name, *cpu_name, *intc_name;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
     if (!fdt) {
@@ -90,68 +96,91 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
 
-    nodename = g_strdup_printf("/memory@%lx",
-        (long)memmap[SPIKE_DRAM].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        memmap[SPIKE_DRAM].base >> 32, memmap[SPIKE_DRAM].base,
-        mem_size >> 32, mem_size);
-    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
-    g_free(nodename);
-
     qemu_fdt_add_subnode(fdt, "/cpus");
     qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
         SIFIVE_CLINT_TIMEBASE_FREQ);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
+    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
+
+    for (socket = (riscv_socket_count(mc) - 1); socket >= 0; socket--) {
+        clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket);
+        qemu_fdt_add_subnode(fdt, clust_name);
+
+        clint_cells =  g_new0(uint32_t, s->soc[socket].num_harts * 4);
 
-    for (cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
-        nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
-        char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        char *isa = riscv_isa_string(&s->soc.harts[cpu]);
-        qemu_fdt_add_subnode(fdt, nodename);
+        for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
+            cpu_phandle = phandle++;
+
+            cpu_name = g_strdup_printf("/cpus/cpu@%d",
+                s->soc[socket].hartid_base + cpu);
+            qemu_fdt_add_subnode(fdt, cpu_name);
 #if defined(TARGET_RISCV32)
-        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
+            qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv32");
 #else
-        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+            qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv48");
 #endif
-        qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
-        qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
-        qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
-        qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
-        qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
-        qemu_fdt_add_subnode(fdt, intc);
-        qemu_fdt_setprop_cell(fdt, intc, "phandle", 1);
-        qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
-        qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
-        qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
-        g_free(isa);
-        g_free(intc);
-        g_free(nodename);
-    }
+            name = riscv_isa_string(&s->soc[socket].harts[cpu]);
+            qemu_fdt_setprop_string(fdt, cpu_name, "riscv,isa", name);
+            g_free(name);
+            qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
+            qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
+            qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
+                s->soc[socket].hartid_base + cpu);
+            qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
+            riscv_socket_fdt_write_id(mc, fdt, cpu_name, socket);
+            qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle);
 
-    cells =  g_new0(uint32_t, s->soc.num_harts * 4);
-    for (cpu = 0; cpu < s->soc.num_harts; cpu++) {
-        nodename =
-            g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
-        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
-        cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
-        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
-        cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
-        g_free(nodename);
+            intc_name = g_strdup_printf("%s/interrupt-controller", cpu_name);
+            qemu_fdt_add_subnode(fdt, intc_name);
+            intc_phandle = phandle++;
+            qemu_fdt_setprop_cell(fdt, intc_name, "phandle", intc_phandle);
+            qemu_fdt_setprop_string(fdt, intc_name, "compatible",
+                "riscv,cpu-intc");
+            qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NULL, 0);
+            qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells", 1);
+
+            clint_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
+            clint_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
+            clint_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
+            clint_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
+
+            core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
+            qemu_fdt_add_subnode(fdt, core_name);
+            qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
+
+            g_free(core_name);
+            g_free(intc_name);
+            g_free(cpu_name);
+        }
+
+        addr = memmap[SPIKE_DRAM].base + riscv_socket_mem_offset(mc, socket);
+        size = riscv_socket_mem_size(mc, socket);
+        mem_name = g_strdup_printf("/memory@%lx", (long)addr);
+        qemu_fdt_add_subnode(fdt, mem_name);
+        qemu_fdt_setprop_cells(fdt, mem_name, "reg",
+            addr >> 32, addr, size >> 32, size);
+        qemu_fdt_setprop_string(fdt, mem_name, "device_type", "memory");
+        riscv_socket_fdt_write_id(mc, fdt, mem_name, socket);
+        g_free(mem_name);
+
+        clint_addr = memmap[SPIKE_CLINT].base +
+            (memmap[SPIKE_CLINT].size * socket);
+        clint_name = g_strdup_printf("/soc/clint@%lx", clint_addr);
+        qemu_fdt_add_subnode(fdt, clint_name);
+        qemu_fdt_setprop_string(fdt, clint_name, "compatible", "riscv,clint0");
+        qemu_fdt_setprop_cells(fdt, clint_name, "reg",
+            0x0, clint_addr, 0x0, memmap[SPIKE_CLINT].size);
+        qemu_fdt_setprop(fdt, clint_name, "interrupts-extended",
+            clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
+        riscv_socket_fdt_write_id(mc, fdt, clint_name, socket);
+
+        g_free(clint_name);
+        g_free(clint_cells);
+        g_free(clust_name);
     }
-    nodename = g_strdup_printf("/soc/clint@%lx",
-        (long)memmap[SPIKE_CLINT].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,clint0");
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        0x0, memmap[SPIKE_CLINT].base,
-        0x0, memmap[SPIKE_CLINT].size);
-    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
-        cells, s->soc.num_harts * sizeof(uint32_t) * 4);
-    g_free(cells);
-    g_free(nodename);
+
+    riscv_socket_fdt_write_distance_matrix(mc, fdt);
 
     if (cmdline) {
         qemu_fdt_add_subnode(fdt, "/chosen");
@@ -162,23 +191,59 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
 static void spike_board_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = spike_memmap;
-
-    SpikeState *s = g_new0(SpikeState, 1);
+    SpikeState *s = SPIKE_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
-    unsigned int smp_cpus = machine->smp.cpus;
     uint32_t fdt_load_addr;
     uint64_t kernel_entry;
+    char *soc_name;
+    int i, base_hartid, hart_count;
 
-    /* Initialize SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc,
-                            TYPE_RISCV_HART_ARRAY);
-    object_property_set_str(OBJECT(&s->soc), "cpu-type", machine->cpu_type,
-                            &error_abort);
-    object_property_set_int(OBJECT(&s->soc), "num-harts", smp_cpus,
-                            &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_abort);
+    /* Check socket count limit */
+    if (SPIKE_SOCKETS_MAX < riscv_socket_count(machine)) {
+        error_report("number of sockets/nodes should be less than %d",
+            SPIKE_SOCKETS_MAX);
+        exit(1);
+    }
+
+    /* Initialize sockets */
+    for (i = 0; i < riscv_socket_count(machine); i++) {
+        if (!riscv_socket_check_hartids(machine, i)) {
+            error_report("discontinuous hartids in socket%d", i);
+            exit(1);
+        }
+
+        base_hartid = riscv_socket_first_hartid(machine, i);
+        if (base_hartid < 0) {
+            error_report("can't find hartid base for socket%d", i);
+            exit(1);
+        }
+
+        hart_count = riscv_socket_hart_count(machine, i);
+        if (hart_count < 0) {
+            error_report("can't find hart count for socket%d", i);
+            exit(1);
+        }
+
+        soc_name = g_strdup_printf("soc%d", i);
+        object_initialize_child(OBJECT(machine), soc_name, &s->soc[i],
+                                TYPE_RISCV_HART_ARRAY);
+        g_free(soc_name);
+        object_property_set_str(OBJECT(&s->soc[i]), "cpu-type",
+                                machine->cpu_type, &error_abort);
+        object_property_set_int(OBJECT(&s->soc[i]), "hartid-base",
+                                base_hartid, &error_abort);
+        object_property_set_int(OBJECT(&s->soc[i]), "num-harts",
+                                hart_count, &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_abort);
+
+        /* Core Local Interruptor (timer and IPI) for each socket */
+        sifive_clint_create(
+            memmap[SPIKE_CLINT].base + i * memmap[SPIKE_CLINT].size,
+            memmap[SPIKE_CLINT].size, base_hartid, hart_count,
+            SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
+    }
 
     /* register system main memory (actual RAM) */
     memory_region_init_ram(main_mem, NULL, "riscv.spike.ram",
@@ -230,21 +295,40 @@ static void spike_board_init(MachineState *machine)
                               fdt_load_addr, s->fdt);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
+    htif_mm_init(system_memory, mask_rom,
+                 &s->soc[0].harts[0].env, serial_hd(0));
+}
 
-    /* Core Local Interruptor (timer and IPI) */
-    sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
-        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
-        false);
+static void spike_machine_instance_init(Object *obj)
+{
 }
 
-static void spike_machine_init(MachineClass *mc)
+static void spike_machine_class_init(ObjectClass *oc, void *data)
 {
-    mc->desc = "RISC-V Spike Board";
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "RISC-V Spike board";
     mc->init = spike_board_init;
-    mc->max_cpus = 8;
+    mc->max_cpus = SPIKE_CPUS_MAX;
     mc->is_default = true;
     mc->default_cpu_type = SPIKE_V1_10_0_CPU;
+    mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
+    mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
+    mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
+    mc->numa_mem_supported = true;
+}
+
+static const TypeInfo spike_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("spike"),
+    .parent     = TYPE_MACHINE,
+    .class_init = spike_machine_class_init,
+    .instance_init = spike_machine_instance_init,
+    .instance_size = sizeof(SpikeState),
+};
+
+static void spike_machine_init_register_types(void)
+{
+    type_register_static(&spike_machine_typeinfo);
 }
 
-DEFINE_MACHINE("spike", spike_machine_init)
+type_init(spike_machine_init_register_types)
-- 
2.28.0


