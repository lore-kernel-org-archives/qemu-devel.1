Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB918C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 23:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9693321721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 23:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oEZBnDKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9693321721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHz3z-00026J-Ku
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 19:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz21-0000NX-9r
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 19:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz20-0006NK-3r
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 19:36:41 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:32918)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz1z-0006Mq-SD; Tue, 08 Oct 2019 19:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1570577800; x=1602113800;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TLCgi6VqXQMc9CLMQXN3Ix/4vw03OTnjdwR+JtHWZJc=;
 b=oEZBnDKKMuZXTZu+iIom2plFAAcKDpT3C2YUcP6r//ivjliW0AlTG79m
 J7FNWMeM1rO3OrrPGNYR+RimBT+C3iqh8TDryZDOTwCECt65xx0911i7X
 7GqtwlVOhk0Zpr9Qkt9g92mey/2ETUNt+kjmo6nB/quCq38Ng5pEA1x8O
 7znYZStKjEPFnKbM9NGHulZFg6yPmHtsS+j/lR9ma/z2Dlrl205ppPhJn
 ZNzJ9hGngEkoL4LW3+mOvkAZELLhAQtW+/Rnpy0rD3UjCq2LXeOB0VBXC
 Xndv/J4bMjqwgrqL4PwpekmUGVS2kA9oykhlvUPZ+Qpvxv7N5sXa3WFje A==;
IronPort-SDR: UyE3FW+XFV7IFQ39Gm2bIaTCPLPNUylAG9eOChpVMLpAF5VWkuXIQeLAeYtK9594+ASzPOj5mW
 5dj62ziX86+yJYu9UJ0TY0wFdZxCN9SCEfYQIAhwP6Coeb9F1/vAjacGXKsQ49UKokpxVDqJqZ
 b2ayFYa6OiA7+r1zPFb/qmJeIJ80lX12Gqg2lVPX5q11zj8GXcVd1SJcncJlKu27wgWh24ZvrO
 /x4tpIOJaWwHNW4HlfY09RsKFIMU9J21tFY9yTcKWE3TrZwZksPanqNqijypMsB94BExJkCFCC
 whc=
X-IronPort-AV: E=Sophos;i="5.67,273,1566835200"; d="scan'208";a="124519167"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2019 07:36:38 +0800
IronPort-SDR: rWpg7uHnNSQc4h1JK8KGf0EdKTGmUPtnurcR3ncA/+YXJsBHAKFyvJ5PmZe6ULu6DNIGFUGW2k
 enkIDUR8g5qZpCOEVOm+CdR/aGA9k6LoOGAa/jRAHjLHgS2ciAsZbi60APhd3KEzPMu8QwNdWp
 9fcll+DBkyKLnh+y6m4bi5JEI80sbkTW/v7cY72v4kgGRlHjhyHrbI0uJ0VzmMN1Zcb+dW9s7A
 jeXvGQKZJU+pBUKVS0eHwkZjk6SMJFYCC0BB1wqYDPpagGZ80XLUrY6Mb62tb9QQWs076DkStz
 dKP2YG2Z2gqKCvkmXMQtp52v
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2019 16:32:32 -0700
IronPort-SDR: ZgfVOJaX3rU9tS0AcuZH1BxHw+tVnD20K6hs3gUlu4L298vjnQxBfh4kSQuKJzUU3kTptSKV5N
 zd6PXYKKl7YXY0IJcUhL0s2fOamdLY9S+XkglQl39GewN4pCiFtI9fIRbu3tgJnC30DWI8HKh0
 yyatso1hJYEOxUt3A8qYrdZ01dFEZn7+vsQVMoVL1ajmfc1xpi0eig0SoLyfVYBh/zzqGloNQS
 lNxaplN2HCQA7SEG3ZJNDvZPHXYPAmdjSEzsXnSvPmd+87QhMdxGElzM6Oxjow8p9fUyG2uivp
 6Y4=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Oct 2019 16:36:39 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 1/7] riscv/sifive_u: Add L2-LIM cache memory
Date: Tue,  8 Oct 2019 16:32:07 -0700
Message-Id: <1fd82cdaac374fb8b72dad907c039da3abfb62cc.1570577500.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570577500.git.alistair.francis@wdc.com>
References: <cover.1570577500.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.141
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
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
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


