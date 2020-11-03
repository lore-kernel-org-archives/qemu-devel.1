Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD23AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:40:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADF520756
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f04RQgJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADF520756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyPu-0002JQ-4t
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyKN-0002TF-3R
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:34:31 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyKD-0001EJ-Gb
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604417662; x=1635953662;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GQeiFHPgNUNLdTN/HqvHjPj+kySyVyfKiMFndpNHjIA=;
 b=f04RQgJ74XBNl6U2iry4QwjYaSxE+hz0o4J2DlbzDA+lRgWj7N9nuabk
 ucZn62px1kIO47w+6pwjG49Vge/hjcGeG+w+AXTCfB7N185oZvIwJJTXU
 QPbaUirqNnl1BBm/gHY0ARlMpnIbifZuPHUTnBl9e9SqoyMGkd8RUAxM4
 k/rHYsO9s8LReCBLyNNrTdrsJ3zeVQS8c9TvFzpZlHA5MbOgNB6nAS3AP
 yuofTT/lZaMQBGIQkX0F4AioGOJY5EGPhLvsM3tZqmjFzbBiFlGDiyvcF
 wvC0bIGbPa2e/N/exANtRiIjcus3D7cmg0/MC4OCsJXVpHKa8RyjxS11v Q==;
IronPort-SDR: fGS/xKaVKE5Df6JnlX6WkC/ql4xgocfKt2mT93Y0kx7/5/YB74RYub5+5xvhqdyje1zgFA6lZQ
 pEUikK8GH5Tv/Vgc/NSTPVI5LBehwEh7DEAOdIy2xwJJN4163+26rpcY5VvZU8aLB3t5n1YQg1
 sW9eBLqP90luPKEjRp2jfV6iyMvactGbCdiQ6POPlBWwpL86EMxaYLKHOvLDSevEZf1MTsDsoc
 b/1L8mG4lgktN4eg5924S7PjQDgqMbyjsSioozZjfN/NeX4XR9+miyUbe/lyvU3uzMSOwYctYD
 g7c=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152867486"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 23:33:28 +0800
IronPort-SDR: 1N1gy6M4UNWGHMRGUVt1s3XjPxCJhH9k89eiUZ4mK0IdQLaIdyk0gYqzJYpsWGfFTpJlFGwMML
 +BK161Vv9HlVRbN58W+gI7NVmVxRaHZn1H480Sf2XEYDwrpzir28/0iFokM/gR0GbydFq3sip0
 Sna/CgOBIymR23VVzY9M9rgzhsVjx7HnNG4uIpJQ/5i34siKs3uNEpv+f6ZItG5ay14WLnK3TX
 nO6/0qiItmAO/3y+jdL/Fxon2MXtnAtRrZhEj31WB6i+VIge63Z5wqZnZOpJ9eHX6jmBZSq3+/
 Bdi15QI53u5q2SVBf657uFmV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 07:19:36 -0800
IronPort-SDR: IFjrgivLKDs+cCbvx/BWBuFplMxvaMR5lfXMflFfmyLvMa8El9KWo/fo9iEKMk+txjJrSc6/FP
 AgmxCi1v+v5qWbnzsvuNvbqj6QTaP8F6ytqAJSxj3BefxX4wqjbGZ9pjOgVgNE3IBUl3zCwaCK
 gmwYuZmiHbbvTfIAwf9Z6OFN0PgbyQb9PNBVXdJyOF5Vk83TfxrhAe1E1Pv0G8n/6wCji8qtrq
 n6QvyRzJjMR1tOvb63WCmU2nJsY9O8F2g2Mgvxhj/CAFNzD2Efv34bb89Ez+qVL9be0xk2Qx44
 6LU=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 07:33:28 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL v2 17/19] hw/riscv: microchip_pfsoc: Correct DDR memory map
Date: Tue,  3 Nov 2020 07:21:48 -0800
Message-Id: <20201103152150.2677566-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103152150.2677566-1-alistair.francis@wdc.com>
References: <20201103152150.2677566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 10:33:23
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
we increase the default system memory size to 1537 MiB (the minimum
required high memory size by HSS) so that user gets notified an error
when less than 1537 MiB is specified.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20201101170538.3732-1-bmeng.cn@gmail.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/microchip_pfsoc.h |  5 ++-
 hw/riscv/microchip_pfsoc.c         | 50 ++++++++++++++++++++++++++----
 2 files changed, 48 insertions(+), 7 deletions(-)

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
index 44a84732ac..96cb8b983a 100644
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
@@ -441,10 +448,33 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
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
     memory_region_add_subregion(system_memory,
-                                memmap[MICROCHIP_PFSOC_DRAM].base, main_mem);
+                                memmap[MICROCHIP_PFSOC_DRAM_LO_ALIAS].base,
+                                mem_low_alias);
+
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
+    memory_region_add_subregion(system_memory,
+                                memmap[MICROCHIP_PFSOC_DRAM_HI_ALIAS].base,
+                                mem_high_alias);
 
     /* Load the firmware */
     riscv_find_and_load_firmware(machine, BIOS_FILENAME, RESET_VECTOR, NULL);
@@ -470,7 +500,15 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
                    MICROCHIP_PFSOC_COMPUTE_CPU_COUNT;
     mc->min_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT + 1;
     mc->default_cpus = mc->min_cpus;
-    mc->default_ram_size = 1 * GiB;
+
+    /*
+     * Map 513 MiB high memory, the mimimum required high memory size, because
+     * HSS will do memory test against the high memory address range regardless
+     * of physical memory installed.
+     *
+     * See memory_tests() in mss_ddr.c in the HSS source code.
+     */
+    mc->default_ram_size = 1537 * MiB;
 }
 
 static const TypeInfo microchip_icicle_kit_machine_typeinfo = {
-- 
2.28.0


