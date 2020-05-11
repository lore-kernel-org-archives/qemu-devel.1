Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D45FC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F35DA207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35DA207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY7U1-00031p-24
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 08:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.brenken@efs-auto.org>)
 id 1jY7Sw-0001mo-SG
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:23:26 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:51669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <david.brenken@efs-auto.org>)
 id 1jY7Sv-0004We-6s
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:23:26 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MsrV2-1jEOir2Hu4-00tCcg; Mon, 11 May 2020 14:23:17 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] tricore: added AURIX TC277 D-Step TriBoard
Date: Mon, 11 May 2020 14:21:59 +0200
Message-Id: <20200511122159.7260-2-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
In-Reply-To: <20200511122159.7260-1-david.brenken@efs-auto.org>
References: <20200511122159.7260-1-david.brenken@efs-auto.org>
X-Provags-ID: V03:K1:hGokJr6X2oU7kHctVZQ6fw8dldZ2XXUU7Wd3qurMIii5TXLEgoi
 tu882W6q1bte+hKGc+Jyp6pxSUqNDUxlbGihHfUUjyZpzJab3/NA0/ZSSxsUqyMl/BjklK3
 47fivsaBUdflCH+MbJ2twZNQfFgrfZPfMMIsAsoC3c4mW0xKle0MBUlOkbQNJuIXE5R7zAy
 1Uz1QZt/oZY7XuVXwsXQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kdXFn/irNIE=:xHoEHAQKIWturR3gPRxiSo
 mAWdCvaEXNvLvjL686gU+T6Mmaia8spmx4FS4u8k4DdD00MCCULoEmgfOQ9LzQFkcYyXozlTa
 l/gpd3b/OhiVNZlM/4NwOHLIs/vu49Lrgtlv2Zmcr1eTheEF5PcTIPbiF+lltlClrxdPhV2zf
 nwphWp1Y8Xgsf55sp7TWd5/0htMJdbiKDqDLk/MAHYhYLtnLASFOlyaxqb2BLZn8f8N2dpYCz
 WCB3ifZ8wsBpyZAT8IDM+F4tff78d61dIZF3BKZI5D81SgZN39O7oIFEV3z31HXKNKykHH/sb
 ECo1PI/idDz+o3SZkj/gcz0FpsB+I3G6uhFyMEYDONg5Effq4ty0o7mzJmqREj9z5vy9XFGQg
 ooNdzPbN3hfKeMYFcS3HzZOLQfI32CNroAJABSHm6k73zKb6LXHh/140uSkDkebK23HibvmYb
 hZ3Rn3TzNxp3WtP1vLfiX1q9vjR1cNdnn3Y+qs5iHOYT5A4+VX+vppNBlX9OVk+ytzG3UwO1s
 2s0RjJ3SP6+tN87aY/POdQRdR/mFwnL/tG0HO/Sp1WPPHRvFITIeth/WKYx7Q/D9qL2961Xlh
 eA5SYFiXt07W8VUVqdxOK/N9VS3h+MclCMvQJOcOYpfPX9XxqWGrm/gPcq0BpVNDI8QJMO8u3
 t66HEd0/VD2yGXfJPjDTxC+eG9bMD4xXxCa2dm4CpP8gHP9tSiNeQeZaeK1WHYMFQpsHcTn6E
 XHPzrNaD0cuXo3Xv3fjUM1wXDUzIW6sa1F5S+BLaMofQouyq43pemKIyPXUYgf1Ak6hClocA9
 gZF2A5n5z3p/OIS3JR7KPndWJKMwH5bK5giwbmKH74KKKVjb9hy/aE3nrtZFPRzMP+YNqdV
Received-SPF: none client-ip=212.227.126.133;
 envelope-from=david.brenken@efs-auto.org; helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 08:23:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kbastian@mail.uni-paderborn.de,
 Lars Biermanski <lars.biermanski@efs-auto.de>,
 Georg Hofstetter <georg.hofstetter@efs-auto.de>,
 David Brenken <david.brenken@efs-auto.de>,
 Robert Rasche <robert.rasche@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andreas Konopik <andreas.konopik@efs-auto.de>

Signed-off-by: Andreas Konopik <andreas.konopik@efs-auto.de>
Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>
---
 hw/tricore/Makefile.objs           |   1 +
 hw/tricore/aurix_triboard_tc277d.c | 240 +++++++++++++++++++++++++++++
 2 files changed, 241 insertions(+)
 create mode 100644 hw/tricore/aurix_triboard_tc277d.c

diff --git a/hw/tricore/Makefile.objs b/hw/tricore/Makefile.objs
index 5501f6c1a8..e4a2106dd9 100644
--- a/hw/tricore/Makefile.objs
+++ b/hw/tricore/Makefile.objs
@@ -1 +1,2 @@
 obj-$(CONFIG_TRICORE) += tricore_testboard.o
+obj-$(CONFIG_TRICORE) += aurix_triboard_tc277d.o
diff --git a/hw/tricore/aurix_triboard_tc277d.c b/hw/tricore/aurix_triboard_tc277d.c
new file mode 100644
index 0000000000..86deff9a50
--- /dev/null
+++ b/hw/tricore/aurix_triboard_tc277d.c
@@ -0,0 +1,240 @@
+/*
+ * Infineon AURIX TC277 D-Step TriBoard System emulation.
+ *
+ * Copyright (c) 2019 Andreas Konopik <andreas.konopik@efs-auto.de>
+ * Copyright (c) 2019 David Brenken <david.brenken@efs-auto.de>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "cpu.h"
+#include "net/net.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "exec/address-spaces.h"
+#include "elf.h"
+#include "hw/tricore/tricore.h"
+#include "qemu/error-report.h"
+
+/*
+ * The TriCore processor architecture defines their respective on-chip memory
+ * layout. Therefore, in contrast to other common architectures, the QEMU
+ * TriCore machine and cpu are closely coupled.
+ *
+ * Memory maps are aligned with the TC27x D-Step Microcontroller layout.
+ */
+
+#define TC27XD_MEMMAP_DSPR2        0x50000000
+#define TC27XD_MEMMAP_DCACHE2      0x5001E000
+#define TC27XD_MEMMAP_DTAG2        0x500C0000
+#define TC27XD_MEMMAP_PSPR2        0x50100000
+#define TC27XD_MEMMAP_PCACHE2      0x50108000
+#define TC27XD_MEMMAP_PTAG2        0x501C0000
+#define TC27XD_MEMMAP_DSPR1        0x60000000
+#define TC27XD_MEMMAP_DCACHE1      0x6001E000
+#define TC27XD_MEMMAP_DTAG1        0x600C0000
+#define TC27XD_MEMMAP_PSPR1        0x60100000
+#define TC27XD_MEMMAP_PCACHE1      0x60108000
+#define TC27XD_MEMMAP_PTAG1        0x601C0000
+#define TC27XD_MEMMAP_DSPR0        0x70000000
+#define TC27XD_MEMMAP_PSPR0        0x70100000
+#define TC27XD_MEMMAP_PCACHE0      0x70106000
+#define TC27XD_MEMMAP_PTAG0        0x701C0000
+#define TC27XD_MEMMAP_PFLASH0_C    0x80000000
+#define TC27XD_MEMMAP_PFLASH1_C    0x80200000
+#define TC27XD_MEMMAP_OLDA_C       0x8FE70000
+#define TC27XD_MEMMAP_BROM_C       0x8FFF8000
+#define TC27XD_MEMMAP_LMURAM_C     0x90000000
+#define TC27XD_MEMMAP_EMEM_C       0x9F000000
+#define TC27XD_MEMMAP_PFLASH0_U    0xA0000000
+#define TC27XD_MEMMAP_PFLASH1_U    0xA0200000
+#define TC27XD_MEMMAP_DFLASH0      0xAF000000
+#define TC27XD_MEMMAP_DFLASH1      0xAF110000
+#define TC27XD_MEMMAP_OLDA_U       0xAFE70000
+#define TC27XD_MEMMAP_BROM_U       0xAFFF8000
+#define TC27XD_MEMMAP_LMURAM_U     0xB0000000
+#define TC27XD_MEMMAP_EMEM_U       0xBF000000
+#define TC27XD_MEMMAP_PSPRX        0xC0000000
+#define TC27XD_MEMMAP_DSPRX        0xD0000000
+
+static struct tricore_boot_info tc27xd_db_binfo;
+
+static void tricore_load_kernel(CPUTriCoreState *env)
+{
+    uint64_t entry;
+    long kernel_size;
+
+    kernel_size = load_elf(tc27xd_db_binfo.kernel_filename, NULL,
+                           NULL, NULL, &entry, NULL,
+                           NULL, NULL, 0,
+                           EM_TRICORE, 1, 0);
+    if (kernel_size <= 0) {
+        error_report("no kernel file '%s'",
+                tc27xd_db_binfo.kernel_filename);
+        exit(1);
+    }
+    env->PC = entry;
+
+}
+
+/*
+ * Initialize the auxiliary ROM region @mr and map it into
+ * the memory map at @base.
+ */
+static void make_rom(MemoryRegion *mr, const char *name,
+                     hwaddr base, hwaddr size)
+{
+    memory_region_init_rom(mr, NULL, name, size, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), base, mr);
+}
+
+/*
+ * Initialize the auxiliary RAM region @mr and map it into
+ * the memory map at @base.
+ */
+static void make_ram(MemoryRegion *mr, const char *name,
+                     hwaddr base, hwaddr size)
+{
+    memory_region_init_ram(mr, NULL, name, size, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), base, mr);
+}
+
+/*
+ * Create an alias of an entire original MemoryRegion @orig
+ * located at @base in the memory map.
+ */
+static void make_alias(MemoryRegion *mr, const char *name,
+                           MemoryRegion *orig, hwaddr base)
+{
+    memory_region_init_alias(mr, NULL, name, orig, 0,
+                             memory_region_size(orig));
+    memory_region_add_subregion(get_system_memory(), base, mr);
+}
+
+static void tc27xd_memory_maps_init(void)
+{
+    MemoryRegion *dspr0 = g_new(MemoryRegion, 1);
+    MemoryRegion *dspr1 = g_new(MemoryRegion, 1);
+    MemoryRegion *dspr2 = g_new(MemoryRegion, 1);
+    MemoryRegion *dsprX = g_new(MemoryRegion, 1);
+    MemoryRegion *pspr0 = g_new(MemoryRegion, 1);
+    MemoryRegion *pspr1 = g_new(MemoryRegion, 1);
+    MemoryRegion *pspr2 = g_new(MemoryRegion, 1);
+    MemoryRegion *psprX = g_new(MemoryRegion, 1);
+
+    MemoryRegion *pflash0_c = g_new(MemoryRegion, 1);
+    MemoryRegion *pflash1_c = g_new(MemoryRegion, 1);
+    MemoryRegion *pflash0_u = g_new(MemoryRegion, 1);
+    MemoryRegion *pflash1_u = g_new(MemoryRegion, 1);
+    MemoryRegion *dflash0 = g_new(MemoryRegion, 1);
+    MemoryRegion *dflash1 = g_new(MemoryRegion, 1);
+    MemoryRegion *olda_c = g_new(MemoryRegion, 1);
+    MemoryRegion *olda_u = g_new(MemoryRegion, 1);
+    MemoryRegion *brom_c = g_new(MemoryRegion, 1);
+    MemoryRegion *brom_u = g_new(MemoryRegion, 1);
+    MemoryRegion *lmuram_c = g_new(MemoryRegion, 1);
+    MemoryRegion *lmuram_u = g_new(MemoryRegion, 1);
+    MemoryRegion *emem_c = g_new(MemoryRegion, 1);
+    MemoryRegion *emem_u = g_new(MemoryRegion, 1);
+
+    MemoryRegion *pcache0 = g_new(MemoryRegion, 1);
+    MemoryRegion *ptag0 = g_new(MemoryRegion, 1);
+
+    MemoryRegion *dcache1 = g_new(MemoryRegion, 1);
+    MemoryRegion *dtag1 = g_new(MemoryRegion, 1);
+    MemoryRegion *pcache1 = g_new(MemoryRegion, 1);
+    MemoryRegion *ptag1 = g_new(MemoryRegion, 1);
+
+    MemoryRegion *dcache2 = g_new(MemoryRegion, 1);
+    MemoryRegion *dtag2 = g_new(MemoryRegion, 1);
+    MemoryRegion *pcache2 = g_new(MemoryRegion, 1);
+    MemoryRegion *ptag2 = g_new(MemoryRegion, 1);
+
+    make_ram(dspr2, "CPU2.DSPR", TC27XD_MEMMAP_DSPR2, 120 * KiB);
+    make_ram(pspr2, "CPU2.PSPR", TC27XD_MEMMAP_PSPR2,  32 * KiB);
+    make_ram(dspr1, "CPU1.DSPR", TC27XD_MEMMAP_DSPR1, 120 * KiB);
+    make_ram(pspr1, "CPU1.PSPR", TC27XD_MEMMAP_PSPR1,  32 * KiB);
+    make_ram(dspr0, "CPU0.DSPR", TC27XD_MEMMAP_DSPR0, 112 * KiB);
+    make_ram(pspr0, "CPU0.PSPR", TC27XD_MEMMAP_PSPR0,  24 * KiB);
+
+    /*
+     * TriCore QEMU executes CPU0 only, thus it is sufficient to map
+     * LOCAL.PSPR/LOCAL.DSPR exclusively onto PSPR0/DSPR0.
+     */
+    make_alias(psprX, "LOCAL.PSPR", pspr0,
+            TC27XD_MEMMAP_PSPRX);
+    make_alias(dsprX, "LOCAL.DSPR", dspr0,
+            TC27XD_MEMMAP_DSPRX);
+
+    make_ram(pflash0_c, "PF0",    TC27XD_MEMMAP_PFLASH0_C,  2 * MiB);
+    make_ram(pflash1_c, "PF1",    TC27XD_MEMMAP_PFLASH1_C,  2 * MiB);
+    make_ram(dflash0,   "DF0",    TC27XD_MEMMAP_DFLASH0,   1 * MiB + 16 * KiB);
+    make_ram(dflash1,   "DF1",    TC27XD_MEMMAP_DFLASH1,   64 * KiB);
+    make_ram(olda_c,    "OLDA",   TC27XD_MEMMAP_OLDA_C,    32 * KiB);
+    make_rom(brom_c,    "BROM",   TC27XD_MEMMAP_BROM_C,    32 * KiB);
+    make_ram(lmuram_c,  "LMURAM", TC27XD_MEMMAP_LMURAM_C,  32 * KiB);
+    make_ram(emem_c,    "EMEM",   TC27XD_MEMMAP_EMEM_C,     1 * MiB);
+
+    make_alias(pflash0_u, "PF0.U",    pflash0_c, TC27XD_MEMMAP_PFLASH0_U);
+    make_alias(pflash1_u, "PF1.U",    pflash1_c, TC27XD_MEMMAP_PFLASH1_U);
+    make_alias(olda_u,    "OLDA.U",   olda_c,    TC27XD_MEMMAP_OLDA_U);
+    make_alias(brom_u,    "BROM.U",   brom_c,    TC27XD_MEMMAP_BROM_U);
+    make_alias(lmuram_u,  "LMURAM.U", lmuram_c,  TC27XD_MEMMAP_LMURAM_U);
+    make_alias(emem_u,    "EMEM.U",   emem_c,    TC27XD_MEMMAP_EMEM_U);
+
+    /* TODO: Control Cache mapping with Memory Test Unit (MTU) */
+    make_ram(dcache2, "CPU2.DCACHE", TC27XD_MEMMAP_DCACHE2,  8 * KiB);
+    make_ram(dtag2,   "CPU2.DTAG",   TC27XD_MEMMAP_DTAG2,       2560);
+    make_ram(pcache2, "CPU2.PCACHE", TC27XD_MEMMAP_PCACHE2, 16 * KiB);
+    make_ram(ptag2,   "CPU2.PTAG",   TC27XD_MEMMAP_PTAG2,       6144);
+
+    make_ram(dcache1, "CPU1.DCACHE", TC27XD_MEMMAP_DCACHE1,  8 * KiB);
+    make_ram(dtag1,   "CPU1.DTAG",   TC27XD_MEMMAP_DTAG1,       2560);
+    make_ram(pcache1, "CPU1.PCACHE", TC27XD_MEMMAP_PCACHE1, 16 * KiB);
+    make_ram(ptag1,   "CPU1.PTAG",   TC27XD_MEMMAP_PTAG1,       6144);
+
+    make_ram(pcache0, "CPU0.PCACHE", TC27XD_MEMMAP_PCACHE0,  8 * KiB);
+    make_ram(ptag0,   "CPU0.PTAG",   TC27XD_MEMMAP_PTAG0,       2560);
+}
+
+static void tc27xd_tb_init(MachineState *machine)
+{
+    TriCoreCPU *cpu;
+    CPUTriCoreState *env;
+
+    cpu = TRICORE_CPU(cpu_create(machine->cpu_type));
+    env = &cpu->env;
+
+    tc27xd_memory_maps_init();
+
+    tc27xd_db_binfo.ram_size = machine->ram_size;
+    tc27xd_db_binfo.kernel_filename = machine->kernel_filename;
+
+    if (machine->kernel_filename) {
+        tricore_load_kernel(env);
+    }
+}
+
+static void tc27xd_tb_machine_init(MachineClass *mc)
+{
+    mc->desc = "Infineon AURIX TC277 D-Step TriBoard";
+    mc->init = tc27xd_tb_init;
+    mc->is_default = 0;
+    mc->default_cpu_type = TRICORE_CPU_TYPE_NAME("tc27x");
+}
+DEFINE_MACHINE("AURIX_TriBoard_TC277D", tc27xd_tb_machine_init)
-- 
2.26.0


