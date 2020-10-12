Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6FFC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA06321BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8EcFetF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA06321BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRxO7-0003Wh-Ox
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRxHE-0002Pj-Ft; Mon, 12 Oct 2020 08:50:08 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:39598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRxHC-0000ja-9W; Mon, 12 Oct 2020 08:50:08 -0400
Received: by mail-wr1-x42f.google.com with SMTP id y12so13677247wrp.6;
 Mon, 12 Oct 2020 05:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0250QExOVe/In99QEQ0PDIduK5kaNaCaVSYuG7OqEpA=;
 b=q8EcFetFUA/6owF2hzRE1q/FIcv+wvTA0nNhutJSsUMUNzWq3/U4DYLdYmTq2h85zk
 5SvkW3R8ZMZ/DembbLiD57C0neCIOLYae0qt/A1wxc3F0TBDoX1JUr8J3e2z+FA5GGdS
 A3MBU0N8aW6L07Aiu1o0kandiugME6fpfWOUhWK5abXW6JoiRQUwmFysGmaawui6zRL1
 plHOl2aId3ynn8/93nFi0SPumYe+3JuQL3GuA1W/HCIBs3Ra+gBonLURiIICes7a4o0C
 ytvraLfn0WZ+KEWn36htgjKUq1tag9/uFHX3o9GrWJlPX+XsvoXyMkItVRxII6zcrg26
 IZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0250QExOVe/In99QEQ0PDIduK5kaNaCaVSYuG7OqEpA=;
 b=dQq1DR56dxlXLxscng/mWcSbKvHJsPrdvNKu0w23QK8MXB2fMOh0BGUfsQ7/qQ2mJW
 eIenLW7rlw/FQ7B067crR2CCLOPb8fl3KsZMToqULEZH/BeVJaiGvOuVeueeQpuYj0ID
 ckHSlzjCKnFOWYnDiByiGq/6Ffvchrt7KwzU6w3hhW74DbBOZUXC2JRSSEwtqZRvuMcy
 xsscZJfRGbXe570CbZKeR25TDUJGOj7WyOy+2jGHHknhdbTUJ3JNE8AXzsYaWyRpL23d
 38dkK3NihBMqei62tz/aCsRcM0GaFmlIjmrk55/ZS9++NXSAvXKnJcqtDpEUktINPwJN
 zdVA==
X-Gm-Message-State: AOAM532MtWN44OKLOQd+fev2sviS6pomoXQXGLY7TLF8R4ZEF7SLXAH+
 sXuhFaeJ+7e6/pTlYQH7hDFdYDufR6w=
X-Google-Smtp-Source: ABdhPJyta/0zKFTg2tzo8TewXqG3uDAwC7h0B+PUzzDwhoBS06NWtBnYb1DPYKbDIpta9jRHU1bpRQ==
X-Received: by 2002:adf:dcc7:: with SMTP id x7mr30520480wrm.203.1602507002486; 
 Mon, 12 Oct 2020 05:50:02 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id o3sm21486631wru.15.2020.10.12.05.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 05:50:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 1/3] hw/ssi/aspeed_smc: Rename 'max_slaves' variable as
 'max_peripherals'
Date: Mon, 12 Oct 2020 14:49:53 +0200
Message-Id: <20201012124955.3409127-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012124955.3409127-1-f4bug@amsat.org>
References: <20201012124955.3409127-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

In order to use inclusive terminology, rename max_slaves
as max_peripherals.

Patch generated using:

  $ sed -i s/slave/peripheral/ \
        hw/ssi/aspeed_smc.c include/hw/ssi/aspeed_smc.h

One line in aspeed_smc_read() has been manually tweaked
to pass checkpatch.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/ssi/aspeed_smc.h |  2 +-
 hw/ssi/aspeed_smc.c         | 53 +++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 3dd354b52ec..16c03fe64f3 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -43,7 +43,7 @@ typedef struct AspeedSMCController {
     uint8_t r_timings;
     uint8_t nregs_timings;
     uint8_t conf_enable_w0;
-    uint8_t max_slaves;
+    uint8_t max_peripherals;
     const AspeedSegments *segments;
     hwaddr flash_window_base;
     uint32_t flash_window_size;
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 795784e5f36..2780cac71d2 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -181,7 +181,7 @@
 #define SNOOP_START       0x0
 
 /*
- * Default segments mapping addresses and size for each slave per
+ * Default segments mapping addresses and size for each peripheral per
  * controller. These can be changed when board is initialized with the
  * Segment Address Registers.
  */
@@ -259,7 +259,7 @@ static const AspeedSMCController controllers[] = {
         .r_timings         = R_TIMINGS,
         .nregs_timings     = 1,
         .conf_enable_w0    = CONF_ENABLE_W0,
-        .max_slaves        = 1,
+        .max_peripherals   = 1,
         .segments          = aspeed_segments_legacy,
         .flash_window_base = ASPEED_SOC_SMC_FLASH_BASE,
         .flash_window_size = 0x6000000,
@@ -275,7 +275,7 @@ static const AspeedSMCController controllers[] = {
         .r_timings         = R_TIMINGS,
         .nregs_timings     = 1,
         .conf_enable_w0    = CONF_ENABLE_W0,
-        .max_slaves        = 5,
+        .max_peripherals   = 5,
         .segments          = aspeed_segments_fmc,
         .flash_window_base = ASPEED_SOC_FMC_FLASH_BASE,
         .flash_window_size = 0x10000000,
@@ -293,7 +293,7 @@ static const AspeedSMCController controllers[] = {
         .r_timings         = R_SPI_TIMINGS,
         .nregs_timings     = 1,
         .conf_enable_w0    = SPI_CONF_ENABLE_W0,
-        .max_slaves        = 1,
+        .max_peripherals   = 1,
         .segments          = aspeed_segments_spi,
         .flash_window_base = ASPEED_SOC_SPI_FLASH_BASE,
         .flash_window_size = 0x10000000,
@@ -309,7 +309,7 @@ static const AspeedSMCController controllers[] = {
         .r_timings         = R_TIMINGS,
         .nregs_timings     = 1,
         .conf_enable_w0    = CONF_ENABLE_W0,
-        .max_slaves        = 3,
+        .max_peripherals   = 3,
         .segments          = aspeed_segments_ast2500_fmc,
         .flash_window_base = ASPEED_SOC_FMC_FLASH_BASE,
         .flash_window_size = 0x10000000,
@@ -327,7 +327,7 @@ static const AspeedSMCController controllers[] = {
         .r_timings         = R_TIMINGS,
         .nregs_timings     = 1,
         .conf_enable_w0    = CONF_ENABLE_W0,
-        .max_slaves        = 2,
+        .max_peripherals   = 2,
         .segments          = aspeed_segments_ast2500_spi1,
         .flash_window_base = ASPEED_SOC_SPI_FLASH_BASE,
         .flash_window_size = 0x8000000,
@@ -343,7 +343,7 @@ static const AspeedSMCController controllers[] = {
         .r_timings         = R_TIMINGS,
         .nregs_timings     = 1,
         .conf_enable_w0    = CONF_ENABLE_W0,
-        .max_slaves        = 2,
+        .max_peripherals   = 2,
         .segments          = aspeed_segments_ast2500_spi2,
         .flash_window_base = ASPEED_SOC_SPI2_FLASH_BASE,
         .flash_window_size = 0x8000000,
@@ -359,7 +359,7 @@ static const AspeedSMCController controllers[] = {
         .r_timings         = R_TIMINGS,
         .nregs_timings     = 1,
         .conf_enable_w0    = CONF_ENABLE_W0,
-        .max_slaves        = 3,
+        .max_peripherals   = 3,
         .segments          = aspeed_segments_ast2600_fmc,
         .flash_window_base = ASPEED26_SOC_FMC_FLASH_BASE,
         .flash_window_size = 0x10000000,
@@ -377,7 +377,7 @@ static const AspeedSMCController controllers[] = {
         .r_timings         = R_TIMINGS,
         .nregs_timings     = 2,
         .conf_enable_w0    = CONF_ENABLE_W0,
-        .max_slaves        = 2,
+        .max_peripherals   = 2,
         .segments          = aspeed_segments_ast2600_spi1,
         .flash_window_base = ASPEED26_SOC_SPI_FLASH_BASE,
         .flash_window_size = 0x10000000,
@@ -395,7 +395,7 @@ static const AspeedSMCController controllers[] = {
         .r_timings         = R_TIMINGS,
         .nregs_timings     = 3,
         .conf_enable_w0    = CONF_ENABLE_W0,
-        .max_slaves        = 3,
+        .max_peripherals   = 3,
         .segments          = aspeed_segments_ast2600_spi2,
         .flash_window_base = ASPEED26_SOC_SPI2_FLASH_BASE,
         .flash_window_size = 0x10000000,
@@ -410,7 +410,7 @@ static const AspeedSMCController controllers[] = {
 
 /*
  * The Segment Registers of the AST2400 and AST2500 have a 8MB
- * unit. The address range of a flash SPI slave is encoded with
+ * unit. The address range of a flash SPI peripheral is encoded with
  * absolute addresses which should be part of the overall controller
  * window.
  */
@@ -432,7 +432,7 @@ static void aspeed_smc_reg_to_segment(const AspeedSMCState *s,
 
 /*
  * The Segment Registers of the AST2600 have a 1MB unit. The address
- * range of a flash SPI slave is encoded with offsets in the overall
+ * range of a flash SPI peripheral is encoded with offsets in the overall
  * controller window. The previous SoC AST2400 and AST2500 used
  * absolute addresses. Only bits [27:20] are relevant and the end
  * address is an upper bound limit.
@@ -476,7 +476,7 @@ static bool aspeed_smc_flash_overlap(const AspeedSMCState *s,
     AspeedSegments seg;
     int i;
 
-    for (i = 0; i < s->ctrl->max_slaves; i++) {
+    for (i = 0; i < s->ctrl->max_peripherals; i++) {
         if (i == cs) {
             continue;
         }
@@ -537,7 +537,7 @@ static void aspeed_smc_flash_set_segment(AspeedSMCState *s, int cs,
      */
     if ((s->ctrl->segments == aspeed_segments_ast2500_spi1 ||
          s->ctrl->segments == aspeed_segments_ast2500_spi2) &&
-        cs == s->ctrl->max_slaves &&
+        cs == s->ctrl->max_peripherals &&
         seg.addr + seg.size != s->ctrl->segments[cs].addr +
         s->ctrl->segments[cs].size) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -941,14 +941,14 @@ static void aspeed_smc_reset(DeviceState *d)
 
     memset(s->regs, 0, sizeof s->regs);
 
-    /* Unselect all slaves */
+    /* Unselect all peripherals */
     for (i = 0; i < s->num_cs; ++i) {
         s->regs[s->r_ctrl0 + i] |= CTRL_CE_STOP_ACTIVE;
         qemu_set_irq(s->cs_lines[i], true);
     }
 
     /* setup the default segment register values and regions for all */
-    for (i = 0; i < s->ctrl->max_slaves; ++i) {
+    for (i = 0; i < s->ctrl->max_peripherals; ++i) {
         aspeed_smc_flash_set_segment_region(s, i,
                     s->ctrl->segment_to_reg(s, &s->ctrl->segments[i]));
     }
@@ -995,8 +995,9 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
         (s->ctrl->has_dma && addr == R_DMA_DRAM_ADDR) ||
         (s->ctrl->has_dma && addr == R_DMA_LEN) ||
         (s->ctrl->has_dma && addr == R_DMA_CHECKSUM) ||
-        (addr >= R_SEG_ADDR0 && addr < R_SEG_ADDR0 + s->ctrl->max_slaves) ||
-        (addr >= s->r_ctrl0 && addr < s->r_ctrl0 + s->ctrl->max_slaves)) {
+        (addr >= R_SEG_ADDR0 &&
+         addr < R_SEG_ADDR0 + s->ctrl->max_peripherals) ||
+        (addr >= s->r_ctrl0 && addr < s->r_ctrl0 + s->ctrl->max_peripherals)) {
 
         trace_aspeed_smc_read(addr, size, s->regs[addr]);
 
@@ -1270,7 +1271,7 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
         int cs = addr - s->r_ctrl0;
         aspeed_smc_flash_update_ctrl(&s->flashes[cs], value);
     } else if (addr >= R_SEG_ADDR0 &&
-               addr < R_SEG_ADDR0 + s->ctrl->max_slaves) {
+               addr < R_SEG_ADDR0 + s->ctrl->max_peripherals) {
         int cs = addr - R_SEG_ADDR0;
 
         if (value != s->regs[R_SEG_ADDR0 + cs]) {
@@ -1341,10 +1342,10 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
     s->conf_enable_w0 = s->ctrl->conf_enable_w0;
 
     /* Enforce some real HW limits */
-    if (s->num_cs > s->ctrl->max_slaves) {
+    if (s->num_cs > s->ctrl->max_peripherals) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: num_cs cannot exceed: %d\n",
-                      __func__, s->ctrl->max_slaves);
-        s->num_cs = s->ctrl->max_slaves;
+                      __func__, s->ctrl->max_peripherals);
+        s->num_cs = s->ctrl->max_peripherals;
     }
 
     /* DMA irq. Keep it first for the initialization in the SoC */
@@ -1352,7 +1353,7 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
 
     s->spi = ssi_create_bus(dev, "spi");
 
-    /* Setup cs_lines for slaves */
+    /* Setup cs_lines for peripherals */
     s->cs_lines = g_new0(qemu_irq, s->num_cs);
 
     for (i = 0; i < s->num_cs; ++i) {
@@ -1376,16 +1377,16 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
                           s->ctrl->flash_window_size);
     sysbus_init_mmio(sbd, &s->mmio_flash);
 
-    s->flashes = g_new0(AspeedSMCFlash, s->ctrl->max_slaves);
+    s->flashes = g_new0(AspeedSMCFlash, s->ctrl->max_peripherals);
 
     /*
-     * Let's create a sub memory region for each possible slave. All
+     * Let's create a sub memory region for each possible peripheral. All
      * have a configurable memory segment in the overall flash mapping
      * window of the controller but, there is not necessarily a flash
      * module behind to handle the memory accesses. This depends on
      * the board configuration.
      */
-    for (i = 0; i < s->ctrl->max_slaves; ++i) {
+    for (i = 0; i < s->ctrl->max_peripherals; ++i) {
         AspeedSMCFlash *fl = &s->flashes[i];
 
         snprintf(name, sizeof(name), "%s.%d", s->ctrl->name, i);
-- 
2.26.2


