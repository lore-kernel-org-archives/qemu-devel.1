Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8ADC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 05:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087ED22267
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 05:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPlu3OCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087ED22267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXe9u-0005OB-Qa
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 01:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXe2w-0005Ry-RW; Wed, 28 Oct 2020 01:30:54 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXe2u-0000hK-WC; Wed, 28 Oct 2020 01:30:54 -0400
Received: by mail-pf1-x442.google.com with SMTP id 133so2250642pfx.11;
 Tue, 27 Oct 2020 22:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cJk2PXs3ei+fFNnPhvTIpdLrXC2ZlfbAh2JlEFUrplA=;
 b=BPlu3OCevRu9f17xYyd6mt8eCE84NjJFKPylSwJuKggX9GN1c9DYO51qqfYiJFEf2p
 v4INKjNtvbNSXo7MeJp7g1LPssw6Ib5iUOr21IoA4TxZk/NdYnO2B5CdtHodGJROfAQ3
 ynu/cRg3slSUvE8StDITc8T6sdgWy7/BfEgumKPfoIt/ps7/ZP513vn9gqW86hme5jFH
 2bpfXPymdfVQ3q7GAOa+hNhPxSxlHZwj/f9hBhS93yVcH7Q/7gt6UzzFm7JaLexFpuQc
 +RVG6TZGnTh4bXxaK+6dDYCj3PhCF8qepw+KxXb9nv+FsJWJ/B1xJcC2hhGe/MAhdDi2
 ZyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cJk2PXs3ei+fFNnPhvTIpdLrXC2ZlfbAh2JlEFUrplA=;
 b=fbSEJ4lYmUSQc6QkoBvP0i+tV5FIzMBEVQgv5Uc/2nyRjzYVxymtf4/M0QzIewBH6V
 eAA+yp2rxhyVFwp1oE6I6VA7ECTaghGAbIgu4wtJs2E7YS4HYFqpnxk9TluE3k4ChB2G
 LF3PrE1yp/etMiOO5ZlL4kOpmq/OZWVOj51EH++5umUNatGovmTXuu+HI0SWxbmrktZt
 hU3BhkUxZboeSVrryzbJSyOP5GiqVEdTVjf3rnJLPsCKcD3XMUzFomiBI4F/bAk2vJp4
 QqpEWDX94wNNsFsA+HcKBOBS4+4Vs5rDGHlTvh+/wvVVd/aW3vt0573mVxMp1H1gfq4C
 6ReA==
X-Gm-Message-State: AOAM533+dOpPgcREQmBT9OR8NusEJi0hpx3P8EyYq30F39HBl3P54ycq
 Ji/7qHy/d8VswglP6uHZTko=
X-Google-Smtp-Source: ABdhPJxSEqFLM7thyQmeD4JjWBkdcul7xB7nj5Vv0vQ9UanUgfsuJcfuhK4JLpV7Lrp8rhSH6f65Pg==
X-Received: by 2002:a62:7609:0:b029:152:b31e:6aed with SMTP id
 r9-20020a6276090000b0290152b31e6aedmr5827855pfc.10.1603863051386; 
 Tue, 27 Oct 2020 22:30:51 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id 9sm5031887pjs.1.2020.10.27.22.30.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 22:30:50 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 09/10] hw/riscv: microchip_pfsoc: Correct DDR memory map
Date: Wed, 28 Oct 2020 13:30:09 +0800
Message-Id: <1603863010-15807-10-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603863010-15807-1-git-send-email-bmeng.cn@gmail.com>
References: <1603863010-15807-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>, Atish Patra <atish.patra@wdc.com>,
 Anup Patel <anup.patel@wdc.com>, Ivan Griffin <ivan.griffin@emdalo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

When system memory is larger than 1 GiB (high memory), PolarFire SoC
maps it at address 0x10_0000_0000. Address 0xC000_0000 and above is
aliased to the same 1 GiB low memory with different cache attributes.

At present QEMU maps the system memory contiguously from 0x8000_0000.
This corrects the wrong QEMU logic. Note address 0x14_0000_0000 is
the alias to the high memory, and even physical memory is only 1 GiB,
the HSS codes still tries to probe the high memory alias address.
It seems there is no issue on the real hardware, so we will have to
take that into the consideration in our emulation. Due to this, we
we increase the default system memory size to 2 GiB so that user gets
notified an error when less than 2 GiB is specified.

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

Changes in v2:
- Increase the default memory size to 2 GiB

 hw/riscv/microchip_pfsoc.c         | 48 +++++++++++++++++++++++++++++++++-----
 include/hw/riscv/microchip_pfsoc.h |  5 +++-
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 44a8473..5e31b84 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -121,7 +121,10 @@ static const struct MemmapEntry {
     [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
     [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
     [MICROCHIP_PFSOC_IOSCB] =           { 0x30000000, 0x10000000 },
-    [MICROCHIP_PFSOC_DRAM] =            { 0x80000000,        0x0 },
+    [MICROCHIP_PFSOC_DRAM_LO] =         { 0x80000000, 0x40000000 },
+    [MICROCHIP_PFSOC_DRAM_LO_ALIAS] =   { 0xc0000000, 0x40000000 },
+    [MICROCHIP_PFSOC_DRAM_HI] =       { 0x1000000000,        0x0 },
+    [MICROCHIP_PFSOC_DRAM_HI_ALIAS] = { 0x1400000000,        0x0 },
 };
 
 static void microchip_pfsoc_soc_instance_init(Object *obj)
@@ -424,7 +427,11 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     const struct MemmapEntry *memmap = microchip_pfsoc_memmap;
     MicrochipIcicleKitState *s = MICROCHIP_ICICLE_KIT_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
-    MemoryRegion *main_mem = g_new(MemoryRegion, 1);
+    MemoryRegion *mem_low = g_new(MemoryRegion, 1);
+    MemoryRegion *mem_low_alias = g_new(MemoryRegion, 1);
+    MemoryRegion *mem_high = g_new(MemoryRegion, 1);
+    MemoryRegion *mem_high_alias = g_new(MemoryRegion, 1);
+    uint64_t mem_high_size;
     DriveInfo *dinfo = drive_get_next(IF_SD);
 
     /* Sanity check on RAM size */
@@ -441,10 +448,39 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     qdev_realize(DEVICE(&s->soc), NULL, &error_abort);
 
     /* Register RAM */
-    memory_region_init_ram(main_mem, NULL, "microchip.icicle.kit.ram",
-                           machine->ram_size, &error_fatal);
+    memory_region_init_ram(mem_low, NULL, "microchip.icicle.kit.ram_low",
+                           memmap[MICROCHIP_PFSOC_DRAM_LO].size,
+                           &error_fatal);
+    memory_region_init_alias(mem_low_alias, NULL,
+                             "microchip.icicle.kit.ram_low.alias",
+                             mem_low, 0,
+                             memmap[MICROCHIP_PFSOC_DRAM_LO_ALIAS].size);
+    memory_region_add_subregion(system_memory,
+                                memmap[MICROCHIP_PFSOC_DRAM_LO].base,
+                                mem_low);
+    memory_region_add_subregion(system_memory,
+                                memmap[MICROCHIP_PFSOC_DRAM_LO_ALIAS].base,
+                                mem_low_alias);
+
+    /*
+     * Map 1 GiB high memory because HSS will do memory test against the high
+     * memory address range regardless of physical memory installed.
+     *
+     * See memory_tests() in mss_ddr.c in the HSS source code.
+     */
+    mem_high_size = machine->ram_size - 1 * GiB;
+
+    memory_region_init_ram(mem_high, NULL, "microchip.icicle.kit.ram_high",
+                           mem_high_size, &error_fatal);
+    memory_region_init_alias(mem_high_alias, NULL,
+                             "microchip.icicle.kit.ram_high.alias",
+                             mem_high, 0, mem_high_size);
+    memory_region_add_subregion(system_memory,
+                                memmap[MICROCHIP_PFSOC_DRAM_HI].base,
+                                mem_high);
     memory_region_add_subregion(system_memory,
-                                memmap[MICROCHIP_PFSOC_DRAM].base, main_mem);
+                                memmap[MICROCHIP_PFSOC_DRAM_HI_ALIAS].base,
+                                mem_high_alias);
 
     /* Load the firmware */
     riscv_find_and_load_firmware(machine, BIOS_FILENAME, RESET_VECTOR, NULL);
@@ -470,7 +506,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
                    MICROCHIP_PFSOC_COMPUTE_CPU_COUNT;
     mc->min_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT + 1;
     mc->default_cpus = mc->min_cpus;
-    mc->default_ram_size = 1 * GiB;
+    mc->default_ram_size = 2 * GiB;
 }
 
 static const TypeInfo microchip_icicle_kit_machine_typeinfo = {
diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index f34a6b3..db77e9c 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -105,7 +105,10 @@ enum {
     MICROCHIP_PFSOC_ENVM_CFG,
     MICROCHIP_PFSOC_ENVM_DATA,
     MICROCHIP_PFSOC_IOSCB,
-    MICROCHIP_PFSOC_DRAM,
+    MICROCHIP_PFSOC_DRAM_LO,
+    MICROCHIP_PFSOC_DRAM_LO_ALIAS,
+    MICROCHIP_PFSOC_DRAM_HI,
+    MICROCHIP_PFSOC_DRAM_HI_ALIAS
 };
 
 enum {
-- 
2.7.4


