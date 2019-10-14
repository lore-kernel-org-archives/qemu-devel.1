Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4ABC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA7C20663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IvP5rw++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA7C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3TE-0005Li-Lu
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qh-0005BT-DA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qf-00087W-Sy
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:31 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:36569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qf-00087B-Ln
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id m18so17318880wmc.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=mw6+Wr/pIx5nSkikgnpBOotMcP/UREJEgwoaswzOmgE=;
 b=IvP5rw++mV7qtapL4NeDIp5tSQpEXCnfdgfdb9OAcTEMAZCRH+YPuijJ2ylYkZ4d7Y
 oXcAfHy/UCCP5UbSXe4Ctwz28ZqbirXleDB0Nu6xokBglXA/T6JyyL3zYdTwlK+X4nHa
 csKAc/l9RpqTDDHCgOiwUnX7WEjOctv88FsZu9nGfOy361lyocZESS7SFmgY6pH4uf2a
 xzjdSc0PZ1WNWU0kovPB0lGuYkGMSiSwrP8gEBBTo9de3gyj+dIalOcYfga2iIHKizir
 MqOhzcFyA7Lu66DZfLRJP+5igMLDNxpi53QOqoSyiFColKeWCWY41guQiAiFw5hoWLtr
 rtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mw6+Wr/pIx5nSkikgnpBOotMcP/UREJEgwoaswzOmgE=;
 b=rV/5n/33iyh+n2qc4f0nba1K79cgkzOY/od3aOOfSjPGtbPJiZUfPB5kYNrn2aL7Yz
 QVf7DxdkTsPEecdE9xK3DqpPcR+ls6BSUdBgIMB+wLFTr51T9/Cnq6pFc5sWXib0YXJJ
 5OBuXFfcpl92Inivjjsk6EmT9B1yMFD9o4fpjZGr4r1NfJwG5IpiaQxj22r7TDJfRk0+
 ZP6l5YaNIL23i+7QLrFNlh8ibeLSioGswxIjRNlutmVgW107fCs9X6Akwx4geW/rX3vT
 FsdXrWjU0zuLCQans38jqteL7DKZkbCI+egL8LjzLT4CBL2fukTCyIa/hFiaaHfR9beX
 9naw==
X-Gm-Message-State: APjAAAW/RAqoDIBOPD6n2lHVBiv8VJ3I765LDTNs4PMWNJHuGyiQ7xGn
 hoi6OVrnRTrQHC59VQyLvE9DhBvz7cyVxA==
X-Google-Smtp-Source: APXvYqwtnMckpHhzjKHWKI4p8bcNRJ/1wvDLXVs5ecfR/GDtVwucxmKaj3PQNcpx0P0g1Z3SASXkIA==
X-Received: by 2002:a7b:c5c9:: with SMTP id n9mr16568092wmk.28.1571069128356; 
 Mon, 14 Oct 2019 09:05:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/68] aspeed/smc: Add AST2600 support
Date: Mon, 14 Oct 2019 17:03:48 +0100
Message-Id: <20191014160404.19553-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

The AST2600 SoC SMC controller is a SPI only controller now and has a
few extensions which we will need to take into account when SW
requires it. This is enough to support u-boot and Linux.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190925143248.10000-14-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 132 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 128 insertions(+), 4 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 9909135a2cf..f0c7bbbad30 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -30,6 +30,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
+#include "qemu/units.h"
 
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
@@ -50,7 +51,7 @@
 #define   CONF_FLASH_TYPE0     0
 #define      CONF_FLASH_TYPE_NOR   0x0
 #define      CONF_FLASH_TYPE_NAND  0x1
-#define      CONF_FLASH_TYPE_SPI   0x2
+#define      CONF_FLASH_TYPE_SPI   0x2 /* AST2600 is SPI only */
 
 /* CE Control Register */
 #define R_CE_CTRL            (0x04 / 4)
@@ -71,8 +72,11 @@
 
 /* CEx Control Register */
 #define R_CTRL0           (0x10 / 4)
+#define   CTRL_IO_QPI              (1 << 31)
+#define   CTRL_IO_QUAD_DATA        (1 << 30)
 #define   CTRL_IO_DUAL_DATA        (1 << 29)
 #define   CTRL_IO_DUAL_ADDR_DATA   (1 << 28) /* Includes dummies */
+#define   CTRL_IO_QUAD_ADDR_DATA   (1 << 28) /* Includes dummies */
 #define   CTRL_CMD_SHIFT           16
 #define   CTRL_CMD_MASK            0xff
 #define   CTRL_DUMMY_HIGH_SHIFT    14
@@ -136,7 +140,7 @@
 /* Misc Control Register #2 */
 #define R_TIMINGS         (0x94 / 4)
 
-/* SPI controller registers and bits */
+/* SPI controller registers and bits (AST2400) */
 #define R_SPI_CONF        (0x00 / 4)
 #define   SPI_CONF_ENABLE_W0   0
 #define R_SPI_CTRL0       (0x4 / 4)
@@ -216,6 +220,35 @@ static uint32_t aspeed_smc_segment_to_reg(const AspeedSMCState *s,
 static void aspeed_smc_reg_to_segment(const AspeedSMCState *s, uint32_t reg,
                                       AspeedSegments *seg);
 
+/*
+ * AST2600 definitions
+ */
+#define ASPEED26_SOC_FMC_FLASH_BASE   0x20000000
+#define ASPEED26_SOC_SPI_FLASH_BASE   0x30000000
+#define ASPEED26_SOC_SPI2_FLASH_BASE  0x50000000
+
+static const AspeedSegments aspeed_segments_ast2600_fmc[] = {
+    { 0x0, 128 * MiB }, /* start address is readonly */
+    { 0x0, 0 }, /* disabled */
+    { 0x0, 0 }, /* disabled */
+};
+
+static const AspeedSegments aspeed_segments_ast2600_spi1[] = {
+    { 0x0, 128 * MiB }, /* start address is readonly */
+    { 0x0, 0 }, /* disabled */
+};
+
+static const AspeedSegments aspeed_segments_ast2600_spi2[] = {
+    { 0x0, 128 * MiB }, /* start address is readonly */
+    { 0x0, 0 }, /* disabled */
+    { 0x0, 0 }, /* disabled */
+};
+
+static uint32_t aspeed_2600_smc_segment_to_reg(const AspeedSMCState *s,
+                                               const AspeedSegments *seg);
+static void aspeed_2600_smc_reg_to_segment(const AspeedSMCState *s,
+                                           uint32_t reg, AspeedSegments *seg);
+
 static const AspeedSMCController controllers[] = {
     {
         .name              = "aspeed.smc-ast2400",
@@ -311,6 +344,51 @@ static const AspeedSMCController controllers[] = {
         .nregs             = ASPEED_SMC_R_MAX,
         .segment_to_reg    = aspeed_smc_segment_to_reg,
         .reg_to_segment    = aspeed_smc_reg_to_segment,
+    }, {
+        .name              = "aspeed.fmc-ast2600",
+        .r_conf            = R_CONF,
+        .r_ce_ctrl         = R_CE_CTRL,
+        .r_ctrl0           = R_CTRL0,
+        .r_timings         = R_TIMINGS,
+        .conf_enable_w0    = CONF_ENABLE_W0,
+        .max_slaves        = 3,
+        .segments          = aspeed_segments_ast2600_fmc,
+        .flash_window_base = ASPEED26_SOC_FMC_FLASH_BASE,
+        .flash_window_size = 0x10000000,
+        .has_dma           = true,
+        .nregs             = ASPEED_SMC_R_MAX,
+        .segment_to_reg    = aspeed_2600_smc_segment_to_reg,
+        .reg_to_segment    = aspeed_2600_smc_reg_to_segment,
+    }, {
+        .name              = "aspeed.spi1-ast2600",
+        .r_conf            = R_CONF,
+        .r_ce_ctrl         = R_CE_CTRL,
+        .r_ctrl0           = R_CTRL0,
+        .r_timings         = R_TIMINGS,
+        .conf_enable_w0    = CONF_ENABLE_W0,
+        .max_slaves        = 2,
+        .segments          = aspeed_segments_ast2600_spi1,
+        .flash_window_base = ASPEED26_SOC_SPI_FLASH_BASE,
+        .flash_window_size = 0x10000000,
+        .has_dma           = false,
+        .nregs             = ASPEED_SMC_R_MAX,
+        .segment_to_reg    = aspeed_2600_smc_segment_to_reg,
+        .reg_to_segment    = aspeed_2600_smc_reg_to_segment,
+    }, {
+        .name              = "aspeed.spi2-ast2600",
+        .r_conf            = R_CONF,
+        .r_ce_ctrl         = R_CE_CTRL,
+        .r_ctrl0           = R_CTRL0,
+        .r_timings         = R_TIMINGS,
+        .conf_enable_w0    = CONF_ENABLE_W0,
+        .max_slaves        = 3,
+        .segments          = aspeed_segments_ast2600_spi2,
+        .flash_window_base = ASPEED26_SOC_SPI2_FLASH_BASE,
+        .flash_window_size = 0x10000000,
+        .has_dma           = false,
+        .nregs             = ASPEED_SMC_R_MAX,
+        .segment_to_reg    = aspeed_2600_smc_segment_to_reg,
+        .reg_to_segment    = aspeed_2600_smc_reg_to_segment,
     },
 };
 
@@ -336,6 +414,40 @@ static void aspeed_smc_reg_to_segment(const AspeedSMCState *s,
     seg->size = (((reg >> SEG_END_SHIFT) & SEG_END_MASK) << 23) - seg->addr;
 }
 
+/*
+ * The Segment Registers of the AST2600 have a 1MB unit. The address
+ * range of a flash SPI slave is encoded with offsets in the overall
+ * controller window. The previous SoC AST2400 and AST2500 used
+ * absolute addresses. Only bits [27:20] are relevant and the end
+ * address is an upper bound limit.
+ */
+#define AST2600_SEG_ADDR_MASK 0x0ff00000
+
+static uint32_t aspeed_2600_smc_segment_to_reg(const AspeedSMCState *s,
+                                               const AspeedSegments *seg)
+{
+    uint32_t reg = 0;
+
+    /* Disabled segments have a nil register */
+    if (!seg->size) {
+        return 0;
+    }
+
+    reg |= (seg->addr & AST2600_SEG_ADDR_MASK) >> 16; /* start offset */
+    reg |= (seg->addr + seg->size - 1) & AST2600_SEG_ADDR_MASK; /* end offset */
+    return reg;
+}
+
+static void aspeed_2600_smc_reg_to_segment(const AspeedSMCState *s,
+                                           uint32_t reg, AspeedSegments *seg)
+{
+    uint32_t start_offset = (reg << 16) & AST2600_SEG_ADDR_MASK;
+    uint32_t end_offset = reg & AST2600_SEG_ADDR_MASK;
+
+    seg->addr = s->ctrl->flash_window_base + start_offset;
+    seg->size = end_offset + MiB - start_offset;
+}
+
 static bool aspeed_smc_flash_overlap(const AspeedSMCState *s,
                                      const AspeedSegments *new,
                                      int cs)
@@ -470,8 +582,12 @@ static inline int aspeed_smc_flash_cmd(const AspeedSMCFlash *fl)
     const AspeedSMCState *s = fl->controller;
     int cmd = (s->regs[s->r_ctrl0 + fl->id] >> CTRL_CMD_SHIFT) & CTRL_CMD_MASK;
 
-    /* In read mode, the default SPI command is READ (0x3). In other
-     * modes, the command should necessarily be defined */
+    /*
+     * In read mode, the default SPI command is READ (0x3). In other
+     * modes, the command should necessarily be defined
+     *
+     * TODO: add support for READ4 (0x13) on AST2600
+     */
     if (aspeed_smc_flash_mode(fl) == CTRL_READMODE) {
         cmd = SPI_OP_READ;
     }
@@ -787,6 +903,14 @@ static void aspeed_smc_reset(DeviceState *d)
             s->ctrl->segment_to_reg(s, &s->ctrl->segments[i]);
     }
 
+    /* HW strapping flash type for the AST2600 controllers  */
+    if (s->ctrl->segments == aspeed_segments_ast2600_fmc) {
+        /* flash type is fixed to SPI for all */
+        s->regs[s->r_conf] |= (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0);
+        s->regs[s->r_conf] |= (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1);
+        s->regs[s->r_conf] |= (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE2);
+    }
+
     /* HW strapping flash type for FMC controllers  */
     if (s->ctrl->segments == aspeed_segments_ast2500_fmc) {
         /* flash type is fixed to SPI for CE0 and CE1 */
-- 
2.20.1


