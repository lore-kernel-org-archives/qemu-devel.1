Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F6EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 16:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6BE02224E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 16:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9Q3QF9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BE02224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZGRy-0006VS-Sh
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 11:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kZGR9-0005zE-Qe; Sun, 01 Nov 2020 11:42:35 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:32805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kZGR7-0007Nx-JZ; Sun, 01 Nov 2020 11:42:35 -0500
Received: by mail-pl1-x643.google.com with SMTP id b19so5602162pld.0;
 Sun, 01 Nov 2020 08:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=S+OdcsScsp7sLg20FjyYbPIi3IRBUHmKyRTUfc7Hnn8=;
 b=D9Q3QF9kdsgNfnvMwktkhY3z+eNO3InqQO6wpjnD2AM1fbhccnls4RYWnatLWjAiAv
 l1YTuWf9imnAjeMzlfDherYeWTAb748ycb5eTDct6EHDTYL1Q/qlXY3dglfXP2bYfwp1
 /rkCdwDEJmRlLREUC+69fvx9xLQWeXofjI1uvdPTpVQgTJye4V7ETIj6B4qLF4QNB1DD
 lgjN7PZ6e1S1YPDS/QeZshknuqRR2ZYaYdtscTKEEK28udvLIi7pi21JOPzmox7yho2G
 7EaHFSNWPIqFWEI+Da7dI6jOKVRxtGE4jtAKa8PY3HtObztYqYVjbMW/ENrKL59JpSRA
 fcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=S+OdcsScsp7sLg20FjyYbPIi3IRBUHmKyRTUfc7Hnn8=;
 b=CdBSfbCUksIAyPDwLIsvFuZSPOlMD5Y6cYkyEKgiEudD94EpuNgGBOhrsCWcw0uTuv
 +hRayzOKvnhEHquRwHUI98iqXRmh8T/hdosw+e7q7oXK7W6nNFAybx68CJxHePjdw7xl
 K2iwrXrt4XILjEcH9MJ7I+LxPh7VdkKA6n5w1RZJ2rhGZgTFnHvsoNI8iQiCN0wbNEsq
 MW/A3svUxdQ8OrTb049zzuUShqF3h2RSrc7YuhZuVcFsV5PwT+VNcJ27SNYkOZtdL4OZ
 VQZ+dOf7OWL1vayRRsYLDkT5Al34KENl2dK25eIZAhkP9h+H5UpZ2YzyX9zcBaa7JBSs
 3KJQ==
X-Gm-Message-State: AOAM531fSOPJBbQMvFoTKQvo+xwHFgjjFznYFPGxKzPjkYozYqh4iPvH
 hinxOkFw7AIuJ+APRxPs2CM=
X-Google-Smtp-Source: ABdhPJw2dw4beBwsmBf3LXklLyxuqnFGTlN1Cilgf/7WFbSnJsV2OhUOdm5eHfs+1Rqqwtn9U4vTkQ==
X-Received: by 2002:a17:902:9f86:b029:d6:d25f:7ad8 with SMTP id
 g6-20020a1709029f86b02900d6d25f7ad8mr3414plq.4.1604248951757; 
 Sun, 01 Nov 2020 08:42:31 -0800 (PST)
Received: from i9-aorus-gtx1080.localdomain (144.168.56.201.16clouds.com.
 [144.168.56.201])
 by smtp.gmail.com with ESMTPSA id t17sm10821495pfg.169.2020.11.01.08.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2020 08:42:31 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3] hw/riscv: microchip_pfsoc: Correct DDR memory map
Date: Mon,  2 Nov 2020 00:37:53 +0800
Message-Id: <20201101163753.15059-1-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x643.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>
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
we increase the default system memory size to 2047 MiB (the largest
ram size allowed when running on a 32-bit host) so that user gets
notified an error when less than 2047 MiB is specified.

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---
This patch should replace the following commit in Alistair's
riscv-to-apply.next tree:
https://github.com/alistair23/qemu/commit/8c47c1e9df850a928b4b230240a950feabe6152f

Changes in v3:
- Change default ram size to 2047 MiB for 32-bit host

 hw/riscv/microchip_pfsoc.c         | 48 ++++++++++++++++++++++++++----
 include/hw/riscv/microchip_pfsoc.h |  5 +++-
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 44a84732ac..0bc17b3955 100644
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
+    mc->default_ram_size = 2047 * MiB;
 }
 
 static const TypeInfo microchip_icicle_kit_machine_typeinfo = {
diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index f34a6b3fd7..db77e9c84a 100644
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
2.25.1


