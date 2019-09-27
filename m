Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D34C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1582146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="prYUzvkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1582146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDeWU-0003r9-WE
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 20:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRB-0006wa-Kk
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRA-0008IG-6W
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:48:45 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12529)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeR9-0008DJ-9b; Thu, 26 Sep 2019 20:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569545323; x=1601081323;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ggDV9bhhIBrddaIOEiUcTS+TZwSqEAtDgfLE9jehKbk=;
 b=prYUzvkKetfCy1qEbiwuanUUkS7E4TfNy2VXk41w4naZ5VyDdzN8Q6R8
 9egyW7RXuaAg0a9IMMzX/E9VvkFH9cfIXF0+CsqvFEo9+b5d5YyMltW8+
 JCpRIb2LJXuTgaGIXGNKMNKIGGG5/1cKlorvGXCcS6jq1SbGupUAJ6Dkv
 9+f/8YF7Y+/oDFG+4M9fSIm6v9tyGykHJ9GYn8FJg4oogMG8ZC08gYyhG
 pvNDs1DI8uznqoDGU4XYWeUR1ThC0ka2Q+6PKrKUFS9aX7oTUckeDsGsO
 4HRDHOXvVQVxYu4CztXZ++vh+LFx+myz2NY/rooG0kF1Gb17/cVBq0igD Q==;
IronPort-SDR: 15ac9S3SXe3Fko7wmzy5uj5zWO8su29JM2ZvH22L9XAm4qF+gHKa5GlXkiBAaplGjwL/6R8jJV
 wyI/5O8IpMfYLD8XoZrl7DMARgi+w+/Jg2B/BTqYG5pCkTxjfkZ7ymu3bhO3dfwA6j8spmGcXN
 iCpb1aRLknSN79mOVVRF7wNHKsdwhTX1y/S+XYlhiBEYAgij9VvTgqJrDCMTDITkDqX9f15UZM
 OqYvswvY8hHQFpXtiEoshRmNiSWa8Jlgi3Pz9Kos5m/1G0SGZKuzXR7mQQ1JkUFXDl4tfLTFUP
 kiI=
X-IronPort-AV: E=Sophos;i="5.64,553,1559491200"; d="scan'208";a="119225537"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2019 08:48:39 +0800
IronPort-SDR: K7zZO+m8yh498U/ye80Y4ehGTF4UmtDj/4oP7/Hxk41ubSSMv1Uiw+RkbPq7gvHiGy6Bi/qRbK
 XONWgx+AYsZMsRrgc03toiOHJYXrjHpDTYQeG6n7M2+tynqJqr/oA8YNLKVeCv0xSxsicmG2Kz
 OkbFh4Io/1hEiCYiMLvQFZ82eaEXGaSkqVUDvIAIC82AL9zOJQjmcFhXqMIA1RhXsawX0jQWyd
 jb24p8gADfzHFCspX86XdCuFaPGfsGaNVEOvkh5VkJOAQtOuwdbWdz4hiZfmcvfdzG5zp3w8sm
 Vu0QXbLwLxELN91sQrakimvo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2019 17:44:54 -0700
IronPort-SDR: iS9dpf0zpmmLSlwC4FT2TmBsUjl30ZvupR6hr3+T2PPo82edg9kBD+UupbV766QUN3ns0bAJ3m
 +tWDt88ekgBuW54FGeacaS4tz28QlrO0Y5rRMA7/7/Enw75CPbY4kTZ1ce9kHVeu4KXDsg/Wol
 21brSq1vLFONUneQolKjMD9JA88kEqo4OhDCfx8Jt14HxQ4FJ/NPEY893rXUBkE5xy2RHDBFsY
 fsqObKAsM0VDhTOHOGrCVeh+HyP+wjYiHJ4Rm6XKZfzZ7XWnkcRer53zYMAR3yfSfciVWC7MGY
 /5k=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Sep 2019 17:48:39 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 1/7] riscv/sifive_u: Add L2-LIM cache memory
Date: Thu, 26 Sep 2019 17:44:20 -0700
Message-Id: <bf4f869cab915364855a1c9ffadfeac16b151e4b.1569545046.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569545046.git.alistair.francis@wdc.com>
References: <cover.1569545046.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On reset only a single L2 cache way is enabled, the others are exposed
as memory that can be used by early boot firmware. This L2 region is
generally disabled using the WayEnable register at a later stage in the
boot process. To allow firmware to target QEMU and the HiFive Unleashed
let's add the L2 LIM (LooselyIntegrated Memory).

Ideally we would want to adjust the size of this chunk of memory as the
L2 Cache Controller WayEnable register is incremented. Unfortunately I
don't see a nice way to handle reducing or blocking out the L2 LIM while
still allowing it be re returned to all enabled from a reset.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c         | 16 ++++++++++++++++
 include/hw/riscv/sifive_u.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9f8e84bf2e..1d255ad13e 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -65,6 +65,7 @@ static const struct MemmapEntry {
     [SIFIVE_U_DEBUG] =    {        0x0,      0x100 },
     [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
+    [SIFIVE_U_L2LIM] =    {  0x8000000,  0x2000000 },
     [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
     [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
     [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
@@ -431,6 +432,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     const struct MemmapEntry *memmap = sifive_u_memmap;
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
+    MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
     qemu_irq plic_gpios[SIFIVE_U_PLIC_NUM_SOURCES];
     char *plic_hart_config;
     size_t plic_hart_config_len;
@@ -459,6 +461,20 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
                                 mask_rom);
 
+    /*
+     * Add L2-LIM at reset size.
+     * This should be reduced in size as the L2 Cache Controller WayEnable
+     * register is incremented. Unfortunately I don't see a nice (or any) way
+     * to handle reducing or blocking out the L2 LIM while still allowing it
+     * be re returned to all enabled after a reset. For the time being, just
+     * leave it enabled all the time. This won't break anything, but will be
+     * too generous to misbehaving guests.
+     */
+    memory_region_init_ram(l2lim_mem, NULL, "riscv.sifive.u.l2lim",
+                           memmap[SIFIVE_U_L2LIM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_L2LIM].base,
+                                l2lim_mem);
+
     /* create PLIC hart topology configuration string */
     plic_hart_config_len = (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) *
                            ms->smp.cpus;
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index e4df298c23..50e3620c02 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -58,6 +58,7 @@ enum {
     SIFIVE_U_DEBUG,
     SIFIVE_U_MROM,
     SIFIVE_U_CLINT,
+    SIFIVE_U_L2LIM,
     SIFIVE_U_PLIC,
     SIFIVE_U_PRCI,
     SIFIVE_U_UART0,
-- 
2.23.0


