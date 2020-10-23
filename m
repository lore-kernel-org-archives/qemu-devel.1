Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFFDC55179
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 115D2208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fqoWgvND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115D2208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzxy-0007IT-TK
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFQ-0002No-Ii; Fri, 23 Oct 2020 11:44:56 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFO-0003gw-Fz; Fri, 23 Oct 2020 11:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467894; x=1635003894;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8IJlnM52JuNc6/yoyV6TcAJmVKmUjdDk983+CGD0WTM=;
 b=fqoWgvNDM/EQEzFXIGCV/LmO4u6wviP1ui5B1/I7jcOKwVlLqfyIj5cz
 iMXN9FdgD+USPPof92mJglKW47sFmYqnae4VAFronB84ig+O03mjcX67W
 3zG5s57g+HBQ0PtAofYyMbyJXOxDxzT5EeYDnwCCmnwecDZkvNKQCERib
 yds026B5f4HPD3IXkVmxms2+cmEhKEj7I9y48E7xnHgk84UBf7ec0lAu+
 ubHNybsicx0Uy7oTBTvzsaxUFQH3B0TpZ9bmhVDArPFlFLps1aUOIAara
 SW8n0bhQzRrBYlPlFcmZY6/83EUWDCy8uIP0sSrrEL22AlJfUF9w97dRd A==;
IronPort-SDR: Q967hIHxj72/6oJxVyCqA2mCoOocpIi29X7LYA4jzJ4/fK1sVvI+wdVSD3lSv/gdpgFUv2t+Bh
 lte6cpzNWuQPBMtGVsO/Z2OIC/4ityAIu9TFiFw9SNVw+m3AJkAmqPqudmGmdGETzpORhZO8vx
 +spB3MMo2Eq/7fjDmGmA8LvRr8UOJEJ9BsmMQP0ptrMTo70xERd2iKpSPxF5TQWw41rJwCbuLM
 2cZAQXWzdX/fh/THcM/du5u52WEtedxgm3clwu60m23spC/SC+y4Eegq2Xk96FQSZbNTIBU7TN
 Rck=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="260636800"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:44:52 +0800
IronPort-SDR: UDOOwRxj8Gl/dAPrB24t+ds5J0OQQu3jfIE6p0M0XWNVqar7yPe79BhFLeQ9CzGolx7BLuWcG7
 mwbGYXAyfRmaGx07ti6b/DtwGSPzxpNECTHHc2TVYuA+noQmRrMaEM3n+4ZILV7npAy+NjpUJP
 Mp70gjw3XQOxWIcaBfvJNc+u3bYHCg+WqqsuROb0J9WstYv4G+QO/1dxxteIMhvIMTWhmcBO07
 em9uyfv1MHyF3/6xj76J4/6h2ntnt1jEhLEXtUXEpa2raMqJ2XYdLVYfDho9QljO9w/8cZVkso
 cMSYS1c46cIOcl+SknJVY8jY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:30:08 -0700
IronPort-SDR: LEtKkO73QYNwZl5tkmtc6sKhduAthn8hiBiQ2ESMmKvtUk86nQwnjoMsEd5TuXNZZRzKJVSf0d
 Z6VzXUdKR3JjgX/JEjElMKN+NAmKJjJY8/85ZtPQM9NKa585j5osaEgmOaLglYjeNrkZPxuMGZ
 i8Vq2djPz/EJGHvJ8I+eTDjlYOR6vxiRVeDNDtOK2xBmkon6cZOVc3lK1hk5M7LUAOhaaYGcFP
 LB9k+81LmDE3Jou3Wh5IEMnSTbhga+GnKW+m/ZNb0jNaxr9kMGzDORztZPZaR7R0dwvfTXkNZu
 OWY=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2020 08:44:53 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 07/16] hw/riscv: sifive_u: Remove compile time XLEN checks
Date: Fri, 23 Oct 2020 08:33:32 -0700
Message-Id: <7ce5ff70057b2fad2d455887d048c419a7e42746.1603467169.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603467169.git.alistair.francis@wdc.com>
References: <cover.1603467169.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:37:20
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
 hw/riscv/sifive_u.c | 57 ++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 978cfedd24..3bc32c9225 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -60,12 +60,6 @@
 
 #include <libfdt.h>
 
-#if defined(TARGET_RISCV32)
-# define BIOS_FILENAME "opensbi-riscv32-generic-fw_dynamic.bin"
-#else
-# define BIOS_FILENAME "opensbi-riscv64-generic-fw_dynamic.bin"
-#endif
-
 static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
@@ -93,7 +87,7 @@ static const struct MemmapEntry {
 #define GEM_REVISION        0x10070109
 
 static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
-    uint64_t mem_size, const char *cmdline)
+                       uint64_t mem_size, const char *cmdline, bool is_32_bit)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     void *fdt;
@@ -167,11 +161,11 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         qemu_fdt_add_subnode(fdt, nodename);
         /* cpu 0 is the management hart that does not have mmu */
         if (cpu != 0) {
-#if defined(TARGET_RISCV32)
-            qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
-#else
-            qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
-#endif
+            if (is_32_bit) {
+                qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
+            } else {
+                qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+            }
             isa = riscv_isa_string(&s->soc.u_cpus.harts[cpu - 1]);
         } else {
             isa = riscv_isa_string(&s->soc.e_cpus.harts[0]);
@@ -414,7 +408,7 @@ static void sifive_u_machine_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
-    target_ulong start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
+    uint64_t start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
     target_ulong firmware_end_addr, kernel_start_addr;
     uint32_t start_addr_hi32 = 0x00000000;
     int i;
@@ -446,7 +440,8 @@ static void sifive_u_machine_init(MachineState *machine)
                           qemu_allocate_irq(sifive_u_machine_reset, NULL, 0));
 
     /* create device tree */
-    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
+    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline,
+               riscv_is_32_bit(machine));
 
     if (s->start_in_flash) {
         /*
@@ -475,8 +470,15 @@ static void sifive_u_machine_init(MachineState *machine)
         break;
     }
 
-    firmware_end_addr = riscv_find_and_load_firmware(machine, BIOS_FILENAME,
-                                                     start_addr, NULL);
+    if (riscv_is_32_bit(machine)) {
+        firmware_end_addr = riscv_find_and_load_firmware(machine,
+                                    "opensbi-riscv32-generic-fw_dynamic.bin",
+                                    start_addr, NULL);
+    } else {
+        firmware_end_addr = riscv_find_and_load_firmware(machine,
+                                    "opensbi-riscv64-generic-fw_dynamic.bin",
+                                    start_addr, NULL);
+    }
 
     if (machine->kernel_filename) {
         kernel_start_addr = riscv_calc_kernel_start_addr(machine,
@@ -506,9 +508,9 @@ static void sifive_u_machine_init(MachineState *machine)
     /* Compute the fdt load address in dram */
     fdt_load_addr = riscv_load_fdt(memmap[SIFIVE_U_DEV_DRAM].base,
                                    machine->ram_size, s->fdt);
-    #if defined(TARGET_RISCV64)
-    start_addr_hi32 = start_addr >> 32;
-    #endif
+    if (!riscv_is_32_bit(machine)) {
+        start_addr_hi32 = start_addr >> 32;
+    }
 
     /* reset vector */
     uint32_t reset_vec[11] = {
@@ -516,13 +518,8 @@ static void sifive_u_machine_init(MachineState *machine)
         0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
         0x02828613,                    /*     addi   a2, t0, %pcrel_lo(1b) */
         0xf1402573,                    /*     csrr   a0, mhartid  */
-#if defined(TARGET_RISCV32)
-        0x0202a583,                    /*     lw     a1, 32(t0) */
-        0x0182a283,                    /*     lw     t0, 24(t0) */
-#elif defined(TARGET_RISCV64)
-        0x0202b583,                    /*     ld     a1, 32(t0) */
-        0x0182b283,                    /*     ld     t0, 24(t0) */
-#endif
+        0,
+        0,
         0x00028067,                    /*     jr     t0 */
         start_addr,                    /* start: .dword */
         start_addr_hi32,
@@ -530,6 +527,14 @@ static void sifive_u_machine_init(MachineState *machine)
         0x00000000,
                                        /* fw_dyn: */
     };
+    if (riscv_is_32_bit(machine)) {
+        reset_vec[4] = 0x0202a583;     /*     lw     a1, 32(t0) */
+        reset_vec[5] = 0x0182a283;     /*     lw     t0, 24(t0) */
+    } else {
+        reset_vec[4] = 0x0202b583;     /*     ld     a1, 32(t0) */
+        reset_vec[5] = 0x0182b283;     /*     ld     t0, 24(t0) */
+    }
+
 
     /* copy in the reset vector in little_endian byte order */
     for (i = 0; i < ARRAY_SIZE(reset_vec); i++) {
-- 
2.28.0


