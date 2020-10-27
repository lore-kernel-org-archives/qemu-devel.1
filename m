Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6ACC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A96420709
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDze2Aeu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A96420709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQHj-0006kW-1v
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXPoA-0002uY-Fm; Tue, 27 Oct 2020 10:18:42 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:39068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXPo8-0007ii-61; Tue, 27 Oct 2020 10:18:42 -0400
Received: by mail-pj1-x1044.google.com with SMTP id m3so819578pjf.4;
 Tue, 27 Oct 2020 07:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iq4fBkdmnFw40PBVHCkwyOMx5pnxfYeeV6N4bdh55pM=;
 b=lDze2Aeu9v1NSzxHTTKYP9M3AnHHXSKJ9uqQBCZ4r+QycrY9wa+cVLA2wBFtsmy5W8
 Tp7bVZE2WnaT3cFdbVPj5okvR4j866crbTc+EklBOdciXsI1enTqPwgQcJHtVlC05XPY
 GOVH+jG4spLVdNr5XRGvO+dQHsMzQf3F6W4Mi2Yt0nXr0oS9e7/ygO/nqNdI+OuTeK2U
 ZPaj2flh1cQpeK4hVz0+T4PO0UTIZSVcGQvpx7cxJrMd/9buHdLovwKmqHkU484Cp/oS
 Da1QadiCB7nZT8YVRIWxZGXMVM1KoS2UD91zfKj35Owxhx+8BtoU+2guEjhnD9bqtRHX
 6+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iq4fBkdmnFw40PBVHCkwyOMx5pnxfYeeV6N4bdh55pM=;
 b=FGns156b7dDruBO2ttvznkkFF9DsEUfS+CHmYV/oZk/Dhu8EFxZVblv8X94VVTUSLo
 B3IVscFiSPiJzAg8+p8M0SUorbwyPE0VMQRPfo5o+A/qLsSjMvPYRRug29UcIzHEHHAt
 Uym4KW+8QX7dXNkBlBnqicE/c+uMxQJBasq2eCmsgt7en7h0G/FoB78RCiH5uewRn78/
 6smepF08fqpRNq2ob4YZqRMkwDu54Fu/3J4Xb0WSC48FWYLfMOoRCtrHJKBxT/M65wC+
 d/adMFvDGdNyVuojDMLDvW2fhiaeEV9MUdvpnR7+YcsopcrctvIJjWM6uRZc3VUTTsnt
 VW/Q==
X-Gm-Message-State: AOAM530fNenc6ozq+O1sAz5zkKYO9UTLVJ78urP4LRnzoyjOVreZ7MaZ
 M62O62Bx136ghYh0OngCiKM=
X-Google-Smtp-Source: ABdhPJx4hIIiKNAyx+RVr5kZkqSpb1TE/PznO6reMiCX56DtgkJhR/wmYGCwTTWSqE5ouBvT9EQNpA==
X-Received: by 2002:a17:902:8207:b029:d6:1f51:e2db with SMTP id
 x7-20020a1709028207b02900d61f51e2dbmr2558654pln.51.1603808318076; 
 Tue, 27 Oct 2020 07:18:38 -0700 (PDT)
Received: from i9-aorus-gtx1080.localdomain (144.168.56.201.16clouds.com.
 [144.168.56.201])
 by smtp.gmail.com with ESMTPSA id mn15sm1600297pjb.21.2020.10.27.07.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 07:18:37 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [RESEND PATCH 8/9] hw/riscv: microchip_pfsoc: Correct DDR memory map
Date: Tue, 27 Oct 2020 22:17:39 +0800
Message-Id: <20201027141740.18336-9-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027141740.18336-1-bmeng.cn@gmail.com>
References: <20201027141740.18336-1-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1044.google.com
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
take that into the consideration in our emulation.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/microchip_pfsoc.c         | 49 +++++++++++++++++++++++++++---
 include/hw/riscv/microchip_pfsoc.h |  5 ++-
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index b9c2f73e7c..c595c9c967 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -102,7 +102,10 @@ static const struct MemmapEntry {
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
@@ -405,7 +408,11 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
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
@@ -422,10 +429,42 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
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
+    if (mem_high_size < 1 * GiB) {
+        mem_high_size = 1 * GiB;
+    }
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
diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 245c82db61..dc05688d94 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -104,7 +104,10 @@ enum {
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
2.25.1


