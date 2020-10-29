Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3AFC56201
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09BBA20732
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rlQzO6v/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BBA20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY993-0008I8-QT
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8sk-0002KG-95
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:26:27 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8sf-0005fG-8q
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603981581; x=1635517581;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VBTYAcLWoXWk8osLN7pUdBmVJXnyQNmIf/lGTVJHrkg=;
 b=rlQzO6v/xDVanvDx2a1cWlGUVwItRgF05HDWC8RqxPG2NhKPndjWJEVK
 opnHPSbfNPa4DKy+6sJ7Bw2cKQ0xlMPo4PxTfbsWJpBMqlOYk7pMZgufP
 U4jil4b1wEjTFdQ8NNaCv67nhM2XOhhshNLOp/SwyF6RgCT/HF7eg+7Z2
 lNHlps9PcQgt0N1iL4PxFX4pEVCLJngzh2UvZ2p5YYMVlQXPPFfBxZUTJ
 TyjDIziLenBRxMfxvZy91Vbdnn5O6+0GuKMqAwKel0tt+tU5Lzn+/DPZ8
 QlR1hHEDUww12VLHbv2mN8Qwb8wRTKYU1vQhbsTYkzhnhx6bzfZ+J4Hf2 A==;
IronPort-SDR: 4Azk7jPEAoUmBdKb1QyGcodkEzaN7cXumVzVL/pAnMbxkiVFLkmegH6spy95k39ITxzbiA1B46
 k0xSh1fViNrRd9FP0/gKxtl7AqVAaYQ+qH1ymhFJ8qEZvoi9feZfVLSbV+rvER0hR16ZuKCnjE
 sAW/VxB5ZKx87sRvGbv1YSJJyCdmhX+NGML3cYFyUnZic6q3Z/iIlFh7yEywQ/uxAPqef3ZRAR
 2EGc53NxMD+nwlueFM8mCKXQiHvNQ+gPTkD/ConvTAjwp1e6z4KCQiucre7UglfYkPDakf7jgy
 Sqk=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; d="scan'208";a="151317903"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:25:30 +0800
IronPort-SDR: YxIaOk+Mnwa72UNK5VCrX+2OPLtsQ8X1ksqIpCONoEnW/AtiF/qv1ZwlNs+upsNsPw34XADaEX
 MJnAxJP4X3oDkojSR12gJ0UFsChA/PooifVT5ylxx7c7HfAvoJV1+Di/srW8k1T2Nd0ZP+p2fn
 H38IBWFczny9liR8tq+/TaZyXU6uZCVwplpLtW8wv5brDqO0O3FM8xhVjVIR8pO0PMYIssVzRs
 pKbupXPRdcHQrJ12tkJ9yXKDNGuXZ/UhjK+SiGMuPUJwalfKK4IQLkxBY74J3HT4XVJYy+PZhq
 8IFBzUtrv5t8hCZWEOoBxDtD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 07:11:45 -0700
IronPort-SDR: R7/LVh88oCBgW8prHK8Lb4B3N0aNFHOOx5RHV5O6zzw73TKldxFUhs/1cNb3JgkzwABL8NwFki
 gxQG9/WHazzW0X1iQ4DDM27wcwJtTEkosf1zh0rNNULtARcmrZvp9qOH+3i91WAWw5IUG+NXHx
 PUC4BRI+03gFKjxcCxQxcWmiMEqrAkc1HOgrfRQfTFsa2UHtZxqcHymjdjiMWm21bXbrLq/t+T
 8PST+eZoroWNRzIMjMdGBxFmfi6sKmPEHRTGeaATPfEItOlehGLlV+tFLpX6w38m02tUQI65gO
 OB4=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 07:25:31 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 17/18] hw/riscv: microchip_pfsoc: Correct DDR memory map
Date: Thu, 29 Oct 2020 07:13:57 -0700
Message-Id: <20201029141358.3102636-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029141358.3102636-1-alistair.francis@wdc.com>
References: <20201029141358.3102636-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=56447669b=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 10:25:26
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1603863010-15807-10-git-send-email-bmeng.cn@gmail.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/microchip_pfsoc.h |  5 +++-
 hw/riscv/microchip_pfsoc.c         | 48 ++++++++++++++++++++++++++----
 2 files changed, 46 insertions(+), 7 deletions(-)

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
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 44a84732ac..5e31b84817 100644
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
-- 
2.28.0


