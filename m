Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BB5C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEAE8208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d0EW/cB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAE8208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4ze-0006SM-PB
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vB-0001Er-QJ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vA-0004xj-G7
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:29:05 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53803)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vA-0004xC-8L; Thu, 19 Sep 2019 18:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1568932157; x=1600468157;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yNUL7xtGlgw7S27kdybWXnVGqx3EuJ+YrwHnlswUzJg=;
 b=d0EW/cB+yE10/NsLVLiA4oPsgWBbSjMu5ILne2kI4ZmT+BwXQuLUKNaq
 OO0zAdtnuP9amLX7KM8F9jv/SFueKjB1HbusFIXNTZhIX9TgkFz1rYBlx
 Xzk82aQdhgeMIzj3U2L2ArhiQVq2cBR7X9QGym8mxVL0TShat8pbW4NM2
 OEZtyRTVbSa7zftpsoADroFnaL6moyE7Vf3+XA8+Jbc6MLJ9rYs8BTwch
 MfFuEssUh/1PoTYBPJkYef1cPMkxk0FzHbjuey0sdtklRJIlxziZ5uz/7
 jjL7dT3JjuuJiPMVble8dJwoCZ/9hIu0nw/5oyW0rI6f+XWXV5xoOB+S0 w==;
IronPort-SDR: yhTU8r1SKrBuvYrWeH0rwAgNo0hPhaLq/tTt3PSBLejVM0zSseupOviwQGRUZiJvxC52eF0hs1
 aW3jhKsu9IvOJj4lxrFGpGdUAGUxNKdy6wck73LFD8iQ/Lh3BiJWri7uPXx7R6ziBGJkZyJPn2
 MiRa/RLY+xLA6aQiTRqVxroUB0uwfGnnA9EYnWMAXaQPOICbv5CynTF39pUGZ+hNKgIfUOh7GK
 g1VaPVbsPqNpJsYhNNZDVyYAUKu89cM/N9Ln1nEisazel3bNTwgieIsy/SAnIyw0gYBgvtdHrF
 pRk=
X-IronPort-AV: E=Sophos;i="5.64,526,1559491200"; d="scan'208";a="219490586"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2019 06:29:15 +0800
IronPort-SDR: Vvy29JKEKOPUfZGkf9zN8MbZYYn5FTk4leqIH9gTphbMP+s+bz+KqxBTv1zuULYF7DW0IOTdmE
 mh10CCzXagAzPB7lOG6y7q5A6dhO7s0C61J8ZBkkqQOlcInh1i/2g/cqL5EJKlP47mATaX75nh
 Ga7pAdx1Rh2S+6YL5/6AGeaAjUMrxEBLJ/MEWTn6fTn0nrZ+reje/4dw0/HFsG5UxOHPv+KN8Z
 V3+lW2HS6YvxrRPw7a6yajVjZeQJnn30+u3hF818bt9pOCEJ+C+5QsZqcFh9kMRemNHdBkQkSo
 Vvy1JD/Br2HCFyRZAwmFCfbC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2019 15:25:35 -0700
IronPort-SDR: 5SFOtpZTqLgl/GqiYUgWlwHA0SjJnH77/OxcoFrt41ZSkBRMyA0QTDISbXuc+TqLmqcQOKpA8P
 x0lN2TLPQknyRHBl6KZgTxrys+qeG87pYDcFEmDoQ0UsttqRgSQLUWwgU7T3QZE37Xyok/dHqE
 KCFUjZJFzaXxMxf0IbbfqNOyjoOc7TALwpEBVUYY3j0BeBHhjkCIjegPt2Aop/e1YzA9OjQfiQ
 KJWBMlNyAhaGVePSqkeJiejiNjWqOpdXP+b8KosaRQnTY63P7LbWnaqaGXnFU7TcGWJTbRC9l4
 1jk=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Sep 2019 15:29:03 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 1/6] riscv/sifive_u: Add L2-LIM cache memory
Date: Thu, 19 Sep 2019 15:24:54 -0700
Message-Id: <24c15737b6e2b065d43955c1877ecb0e6e747351.1568931866.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568931866.git.alistair.francis@wdc.com>
References: <cover.1568931866.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
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
 hw/riscv/sifive_u.c         | 15 +++++++++++++++
 include/hw/riscv/sifive_u.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9f8e84bf2e..de6e197882 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -65,6 +65,7 @@ static const struct MemmapEntry {
     [SIFIVE_U_DEBUG] =    {        0x0,      0x100 },
     [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
+    [SIFIVE_U_L2LIM] =    {  0x8000000,  0x1e00000 },
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
@@ -459,6 +461,19 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
                                 mask_rom);
 
+    /* Add L2-LIM at reset size.
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


