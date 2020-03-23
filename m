Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BF8C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FC420722
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNa9iJOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FC420722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGR6h-00012y-At
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 13:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGR3i-0004Oo-2I
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGR3g-0003hk-JH
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:40:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:40530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGR3g-0003fN-6G
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:40:16 -0400
Received: by mail-wm1-x331.google.com with SMTP id a81so359327wmf.5
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 10:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Blca2M8WsWfCbkoVy34ezoOEGpYFuC8v0ZvsUkwATQw=;
 b=cNa9iJOHXRN3TsQN6ZdGDMLijkPX5US+Sy8j9En5JdOqdLGJ0gIdF3eO9Dhe74QY7U
 F8IwNBxz/PZcHK4nr5tDcYQVYMEoqvcOz+5C34blzVnuGQkUDhMbdIsKegj7B6JOkkBU
 oo7yIkoIqLkAJzfEiCX5/lN9CgIonLZ27soNIiPd6QCDJIfPhSTxUPx2pzCuvkp9DfRw
 iJJbFa0h//Wt/oMJMNN5jIjQnD/dMsGh72Q0UIp80bpuLwCp0WDNOcmd2oswXbKyUhF0
 6gtZblm29t6EGneFskH8BbVIPvchedGzcL8ctl4EwsZaFMRhZhK9cLYOYWBuvmTMkgN5
 7J2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Blca2M8WsWfCbkoVy34ezoOEGpYFuC8v0ZvsUkwATQw=;
 b=LC0yMAj1FJ8rg2xOfURen0iB+bFEdHkJPkzUECZFFzuqKqiBKx4jqrlQ5mGHNFEj11
 twG1E+JX0JNWs6BtcTX7I6BVXlT89Z7YNpMCsLFQuwl4d7o9wnvfJgTALUtrVMn4zaeK
 6iZM3m1vkdz5f3cXViMjmyA6MJcj2S07gd5vUevRMGA/ZX6A/SkqwnFBd0VVpDrrlvJS
 QQzliPx0yQdIA/0WA3AeXWf4QK1kz1WE7cwigR7Z83HUxQSBVZtBmNVVgEt4UUtdqI7D
 4tz1Jfi/cYAfEBknBedG/hKYrZkdCo4OGZ0yiS0ud2xIyrJB2uv9CmfbZWe5/dKzH1Up
 v2DQ==
X-Gm-Message-State: ANhLgQ02DoanUrvaE1KEucNkE3UGR6jD+xWQJK+MiOFRhGByiT7W7r4U
 aW776+baHv5lCMoQRnEo5n0zIOxdu17UYQ==
X-Google-Smtp-Source: ADFU+vuSq3sh4a5EowREAtMW75K3DDLcZshYHQP3J/XXGU1LTJcAXrnOHJ5SA9Cd12TTpOyTVinzPA==
X-Received: by 2002:a1c:e109:: with SMTP id y9mr441847wmg.62.1584985211923;
 Mon, 23 Mar 2020 10:40:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o9sm25145282wrw.20.2020.03.23.10.40.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 10:40:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] aspeed/smc: Fix DMA support for AST2600
Date: Mon, 23 Mar 2020 17:40:03 +0000
Message-Id: <20200323174006.8468-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323174006.8468-1-peter.maydell@linaro.org>
References: <20200323174006.8468-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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

Recent firmwares uses SPI DMA transfers in U-Boot to load the
different images (kernel, initrd, dtb) in the SoC DRAM. The AST2600
FMC model is missing the masks to be applied on the DMA registers
which resulted in incorrect values. Fix that and wire the SPI
controllers which have DMA support on the AST2600.

Fixes: bcaa8ddd081c ("aspeed/smc: Add AST2600 support")
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20200320053923.20565-1-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed_ast2600.c |  6 ++++++
 hw/ssi/aspeed_smc.c     | 15 +++++++++++++--
 hw/ssi/trace-events     |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 446b44d31cf..1a869e09b96 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -411,6 +411,12 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
     /* SPI */
     for (i = 0; i < sc->spis_num; i++) {
+        object_property_set_link(OBJECT(&s->spi[i]), OBJECT(s->dram_mr),
+                                 "dram", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
         object_property_set_bool(OBJECT(&s->spi[i]), true, "realized",
                                  &local_err);
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 9d5c696d5a1..2edccef2d54 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -364,6 +364,8 @@ static const AspeedSMCController controllers[] = {
         .flash_window_base = ASPEED26_SOC_FMC_FLASH_BASE,
         .flash_window_size = 0x10000000,
         .has_dma           = true,
+        .dma_flash_mask    = 0x0FFFFFFC,
+        .dma_dram_mask     = 0x3FFFFFFC,
         .nregs             = ASPEED_SMC_R_MAX,
         .segment_to_reg    = aspeed_2600_smc_segment_to_reg,
         .reg_to_segment    = aspeed_2600_smc_reg_to_segment,
@@ -379,7 +381,9 @@ static const AspeedSMCController controllers[] = {
         .segments          = aspeed_segments_ast2600_spi1,
         .flash_window_base = ASPEED26_SOC_SPI_FLASH_BASE,
         .flash_window_size = 0x10000000,
-        .has_dma           = false,
+        .has_dma           = true,
+        .dma_flash_mask    = 0x0FFFFFFC,
+        .dma_dram_mask     = 0x3FFFFFFC,
         .nregs             = ASPEED_SMC_R_MAX,
         .segment_to_reg    = aspeed_2600_smc_segment_to_reg,
         .reg_to_segment    = aspeed_2600_smc_reg_to_segment,
@@ -395,7 +399,9 @@ static const AspeedSMCController controllers[] = {
         .segments          = aspeed_segments_ast2600_spi2,
         .flash_window_base = ASPEED26_SOC_SPI2_FLASH_BASE,
         .flash_window_size = 0x10000000,
-        .has_dma           = false,
+        .has_dma           = true,
+        .dma_flash_mask    = 0x0FFFFFFC,
+        .dma_dram_mask     = 0x3FFFFFFC,
         .nregs             = ASPEED_SMC_R_MAX,
         .segment_to_reg    = aspeed_2600_smc_segment_to_reg,
         .reg_to_segment    = aspeed_2600_smc_reg_to_segment,
@@ -1135,6 +1141,11 @@ static void aspeed_smc_dma_rw(AspeedSMCState *s)
     MemTxResult result;
     uint32_t data;
 
+    trace_aspeed_smc_dma_rw(s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE ?
+                            "write" : "read",
+                            s->regs[R_DMA_FLASH_ADDR],
+                            s->regs[R_DMA_DRAM_ADDR],
+                            s->regs[R_DMA_LEN]);
     while (s->regs[R_DMA_LEN]) {
         if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
             data = address_space_ldl_le(&s->dram_as, s->regs[R_DMA_DRAM_ADDR],
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index 0a70629801a..0ea498de910 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -6,5 +6,6 @@ aspeed_smc_do_snoop(int cs, int index, int dummies, int data) "CS%d index:0x%x d
 aspeed_smc_flash_write(int cs, uint64_t addr,  uint32_t size, uint64_t data, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
 aspeed_smc_read(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
 aspeed_smc_dma_checksum(uint32_t addr, uint32_t data) "0x%08x: 0x%08x"
+aspeed_smc_dma_rw(const char *dir, uint32_t flash_addr, uint32_t dram_addr, uint32_t size) "%s flash:@0x%08x dram:@0x%08x size:0x%08x"
 aspeed_smc_write(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
 aspeed_smc_flash_select(int cs, const char *prefix) "CS%d %sselect"
-- 
2.20.1


