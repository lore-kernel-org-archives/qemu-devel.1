Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F8DC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A5A208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mZlCrl/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A5A208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzwy-00067s-3P
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFP-0002Jy-3j; Fri, 23 Oct 2020 11:44:55 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:21438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFM-0003hI-TS; Fri, 23 Oct 2020 11:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603468976; x=1635004976;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WpK3XmAiAkZyO6onzUNBTt/mHHzAqf1GbEUIDuYLeGQ=;
 b=mZlCrl/+VOWGJA3foTDVHkjfiIUMhnkJGO952HkhIy6mEQLOFres1yj/
 UZpGXC+zBiEm9PIDTnwj9SkUZlvZh/ipSTqeJm6Z0tjkG06cmoVb+vBUX
 JekEYDhm80hSf/hscyJygv2LfIjgTG6pHjmBTiIgwPe7vNDwt7XZE7iH6
 1BwlvsGTWB40UYXHv3M5Ig/+aqTGEjkp8lINZExbX+qxz15yUvh9bQ4fW
 2aT0eNuIgVji2A8m3TbrfAgHgrqyk7SJSnUY5diWAuCQCiM2YHqNp/93z
 Gmx+0grJ3tIA2Du5f9999VOyjlqLeH9X8rf/JLN3hTeJV/lwGV3q7GQnU Q==;
IronPort-SDR: vt7CPJKDpFpGClGIiIOaRYQ17l1yBoUqoVuPLdS/bZjJbRJoOs25BBHewnsN5wavLwu050Bzdh
 QlVUEXNqnqjbn9i+anV2xPmCIXI9x1nsL6qKKkI/UEaRjDIej5WobCdadGfLiEzbF1Snf3qmBU
 9U4jmTOAFkL4kzhXwUtpso6KTyx0k0NwBc4/PjU8yIFCAB8J5d8CCctt15fonFrs0OxSEK18y3
 JS5RQRm/7qaj8Z+HBLbQ7tqXM12T3qNwUB1w/cjKtucd2l2qbMuQaychLfakzDmnYUHbyMTnI0
 8XM=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="254245088"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2020 00:02:52 +0800
IronPort-SDR: E+RFlg87rCDv1oiN/GGj63/jim0jLKo3+iur0k+d+JIJIlfKJZIyFpAPX37rDPzXU8ONvR22Ut
 +CuLWqClFC6XbnAwIKMiU8FF1II1hnLbyOcZoykb1VQH1sAQcclLhObQMyxoFixJWhetSO6XU1
 lqvHuBTKVAfTuh5F3UJrCUc1JtScouPzY0JNYEmtVmMPryQW2aRw3M6+UV0qbet8a6oYoXI2aA
 gaug2gEcdehbuK+U83TJgVVZpt5bUyGnbYwnTb25ENJxeFpitGyMcH0qDkRNdwFyywU7t+q9b7
 hsNL8dswUqOF7V0IsicPErJi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:31:12 -0700
IronPort-SDR: 2WRvrvRsHYbYy2KXg3Mggc1HAbaCyd4Dp9jJnAL9miVrWu6rgQVQlxak8Xg3r2By3V7rCVvmLt
 ZI+yYpQQxp5FhhmbMrRPQ8FOLHmUKuzdJrzCIQCcT4MtcsVs7ybdgiDntp5fh+xKT5bPyfyxog
 rqx9Td5jyjHgf0Y6hNuxOv9oUu+qBYmJK4Wl1FhigjMlPnRUF/zb8aCXvBQ3O8yMs1LVjHvgVg
 vJsC2caXrubBvoFaTXOvQCpj6BTt0oZbSBgMrQELUmdMW1/G45fO69ZC27RlnivRzIp/dYhLSp
 uIo=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:44:50 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 06/16] hw/riscv: spike: Remove compile time XLEN checks
Date: Fri, 23 Oct 2020 08:33:29 -0700
Message-Id: <82ea05de42d429e1bf572cc134d4571d87a4cfc7.1603467169.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603467169.git.alistair.francis@wdc.com>
References: <cover.1603467169.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:44:50
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/spike.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 875f371f0f..3e47e4579d 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -43,17 +43,6 @@
 #include "sysemu/qtest.h"
 #include "sysemu/sysemu.h"
 
-/*
- * Not like other RISC-V machines that use plain binary bios images,
- * keeping ELF files here was intentional because BIN files don't work
- * for the Spike machine as HTIF emulation depends on ELF parsing.
- */
-#if defined(TARGET_RISCV32)
-# define BIOS_FILENAME "opensbi-riscv32-generic-fw_dynamic.elf"
-#else
-# define BIOS_FILENAME "opensbi-riscv64-generic-fw_dynamic.elf"
-#endif
-
 static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
@@ -64,7 +53,7 @@ static const struct MemmapEntry {
 };
 
 static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
-    uint64_t mem_size, const char *cmdline)
+                       uint64_t mem_size, const char *cmdline, bool is_32_bit)
 {
     void *fdt;
     uint64_t addr, size;
@@ -115,11 +104,11 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
             cpu_name = g_strdup_printf("/cpus/cpu@%d",
                 s->soc[socket].hartid_base + cpu);
             qemu_fdt_add_subnode(fdt, cpu_name);
-#if defined(TARGET_RISCV32)
-            qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv32");
-#else
-            qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv48");
-#endif
+            if (is_32_bit) {
+                qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv32");
+            } else {
+                qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv48");
+            }
             name = riscv_isa_string(&s->soc[socket].harts[cpu]);
             qemu_fdt_setprop_string(fdt, cpu_name, "riscv,isa", name);
             g_free(name);
@@ -254,7 +243,8 @@ static void spike_board_init(MachineState *machine)
         main_mem);
 
     /* create device tree */
-    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
+    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline,
+               riscv_is_32_bit(machine));
 
     /* boot rom */
     memory_region_init_rom(mask_rom, NULL, "riscv.spike.mrom",
@@ -262,9 +252,22 @@ static void spike_board_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[SPIKE_MROM].base,
                                 mask_rom);
 
-    firmware_end_addr = riscv_find_and_load_firmware(machine, BIOS_FILENAME,
-                                                     memmap[SPIKE_DRAM].base,
-                                                     htif_symbol_callback);
+    /*
+     * Not like other RISC-V machines that use plain binary bios images,
+     * keeping ELF files here was intentional because BIN files don't work
+     * for the Spike machine as HTIF emulation depends on ELF parsing.
+     */
+    if (riscv_is_32_bit(machine)) {
+        firmware_end_addr = riscv_find_and_load_firmware(machine,
+                                    "opensbi-riscv32-generic-fw_dynamic.elf",
+                                    memmap[SPIKE_DRAM].base,
+                                    htif_symbol_callback);
+    } else {
+        firmware_end_addr = riscv_find_and_load_firmware(machine,
+                                    "opensbi-riscv64-generic-fw_dynamic.elf",
+                                    memmap[SPIKE_DRAM].base,
+                                    htif_symbol_callback);
+    }
 
     if (machine->kernel_filename) {
         kernel_start_addr = riscv_calc_kernel_start_addr(machine,
-- 
2.28.0


