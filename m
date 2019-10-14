Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54955C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA722067B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tVNVg4xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA722067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3d9-0001MJ-VA
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qg-00059U-As
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qe-000871-Q0
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:38267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qe-00086T-J8
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id 3so17313307wmi.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=BJMpg027/jfUn1ObzXXMPD/Qwlerbw16EgxLfnuCrsE=;
 b=tVNVg4xvER2OPVmVMSzhEdBcJbhijJSpRU0gph4SQFPs7mBS04W8+NzIONzws33FpZ
 uNbnFEsy+mgXf1B+PgSgxpO0H4taFiJrIRbFs5uzvm6CedMGD6M2snZ/XIvx190BJJa6
 Kw3ecGK6KqhuXXk2XOn1rpNAA2U8vfQnVMCxhxnH5a5+AifO3Gg/gADwltx600osmy/h
 s774WOZsbPBtlgibbV+Ok7x8Z6Jyui1/n9+RDa+ekcUnU24Z4aKpCNT67OdQDoXxErJC
 ISRghSyxXxZMJX+yU4mTME51DveMDzY4cO9ez/lr59ssqEk+lxgI3/a/ZEYBTif0b3ad
 HUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BJMpg027/jfUn1ObzXXMPD/Qwlerbw16EgxLfnuCrsE=;
 b=JT3yUF+AHsQ1/dS00Y5/s+QQMWTdDQagyF7G62AVaqPSII7rwQn/nietQauMVSMtrk
 ar6zOCDiCkZA22bsrjY8U3OFQ94EtzLi75XFB7WVU6FEsXb3e5RqEZWnmao3OCplTybU
 fMftLOBuY17NN/AfO0F92pAsUYRJv82aijZkT6SVngX0acusuIy/ueQ61YuhXUDL3m8Z
 gHQ6Lou+NCbKYbQuVE7L/TQlgYGda9i4im67Rd9dCgqSxFPR5xbgwl9Q+Paq59we0ukK
 n3oRRm+1Zc4UCalBIJWpooR0+thGF9+O3QLq+pZ+RDe1v35lDvdvCc7/tKUnugdPHoqs
 zSPQ==
X-Gm-Message-State: APjAAAUSloGN46CdarCIxRpNyau+kUllOMUFFglS1rYBFEUGTMyANqbr
 yZTDvPdtcgYXl5C6NW3PJZKhvez4Z+PjAQ==
X-Google-Smtp-Source: APXvYqzj7MeoIR3cSZ0soUe2rbi4hlybjnrunMDNM3M2U5UjVaKWlfdStT8czXHivpAT4rK5O9QYWw==
X-Received: by 2002:a7b:caa9:: with SMTP id r9mr14871805wml.133.1571069127265; 
 Mon, 14 Oct 2019 09:05:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/68] aspeed/smc: Introduce segment operations
Date: Mon, 14 Oct 2019 17:03:47 +0100
Message-Id: <20191014160404.19553-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

AST2600 will use a different encoding for the addresses defined in the
Segment Register.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190925143248.10000-13-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/ssi/aspeed_smc.h |  4 ++++
 hw/ssi/aspeed_smc.c         | 45 ++++++++++++++++++++++++-------------
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 5176ff6bf95..684d16e3361 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -49,6 +49,10 @@ typedef struct AspeedSMCController {
     hwaddr dma_flash_mask;
     hwaddr dma_dram_mask;
     uint32_t nregs;
+    uint32_t (*segment_to_reg)(const struct AspeedSMCState *s,
+                               const AspeedSegments *seg);
+    void (*reg_to_segment)(const struct AspeedSMCState *s, uint32_t reg,
+                           AspeedSegments *seg);
 } AspeedSMCController;
 
 typedef struct AspeedSMCFlash {
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 9ffc7e01179..9909135a2cf 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -211,6 +211,10 @@ static const AspeedSegments aspeed_segments_ast2500_spi2[] = {
     { 0x38000000, 32 * 1024 * 1024 }, /* start address is readonly */
     { 0x3A000000, 96 * 1024 * 1024 }, /* end address is readonly */
 };
+static uint32_t aspeed_smc_segment_to_reg(const AspeedSMCState *s,
+                                          const AspeedSegments *seg);
+static void aspeed_smc_reg_to_segment(const AspeedSMCState *s, uint32_t reg,
+                                      AspeedSegments *seg);
 
 static const AspeedSMCController controllers[] = {
     {
@@ -226,6 +230,8 @@ static const AspeedSMCController controllers[] = {
         .flash_window_size = 0x6000000,
         .has_dma           = false,
         .nregs             = ASPEED_SMC_R_SMC_MAX,
+        .segment_to_reg    = aspeed_smc_segment_to_reg,
+        .reg_to_segment    = aspeed_smc_reg_to_segment,
     }, {
         .name              = "aspeed.fmc-ast2400",
         .r_conf            = R_CONF,
@@ -241,6 +247,8 @@ static const AspeedSMCController controllers[] = {
         .dma_flash_mask    = 0x0FFFFFFC,
         .dma_dram_mask     = 0x1FFFFFFC,
         .nregs             = ASPEED_SMC_R_MAX,
+        .segment_to_reg    = aspeed_smc_segment_to_reg,
+        .reg_to_segment    = aspeed_smc_reg_to_segment,
     }, {
         .name              = "aspeed.spi1-ast2400",
         .r_conf            = R_SPI_CONF,
@@ -254,6 +262,8 @@ static const AspeedSMCController controllers[] = {
         .flash_window_size = 0x10000000,
         .has_dma           = false,
         .nregs             = ASPEED_SMC_R_SPI_MAX,
+        .segment_to_reg    = aspeed_smc_segment_to_reg,
+        .reg_to_segment    = aspeed_smc_reg_to_segment,
     }, {
         .name              = "aspeed.fmc-ast2500",
         .r_conf            = R_CONF,
@@ -269,6 +279,8 @@ static const AspeedSMCController controllers[] = {
         .dma_flash_mask    = 0x0FFFFFFC,
         .dma_dram_mask     = 0x3FFFFFFC,
         .nregs             = ASPEED_SMC_R_MAX,
+        .segment_to_reg    = aspeed_smc_segment_to_reg,
+        .reg_to_segment    = aspeed_smc_reg_to_segment,
     }, {
         .name              = "aspeed.spi1-ast2500",
         .r_conf            = R_CONF,
@@ -282,6 +294,8 @@ static const AspeedSMCController controllers[] = {
         .flash_window_size = 0x8000000,
         .has_dma           = false,
         .nregs             = ASPEED_SMC_R_MAX,
+        .segment_to_reg    = aspeed_smc_segment_to_reg,
+        .reg_to_segment    = aspeed_smc_reg_to_segment,
     }, {
         .name              = "aspeed.spi2-ast2500",
         .r_conf            = R_CONF,
@@ -295,19 +309,19 @@ static const AspeedSMCController controllers[] = {
         .flash_window_size = 0x8000000,
         .has_dma           = false,
         .nregs             = ASPEED_SMC_R_MAX,
+        .segment_to_reg    = aspeed_smc_segment_to_reg,
+        .reg_to_segment    = aspeed_smc_reg_to_segment,
     },
 };
 
 /*
- * The Segment Register uses a 8MB unit to encode the start address
- * and the end address of the mapping window of a flash SPI slave :
- *
- *        | byte 1 | byte 2 | byte 3 | byte 4 |
- *        +--------+--------+--------+--------+
- *        |  end   |  start |   0    |   0    |
- *
+ * The Segment Registers of the AST2400 and AST2500 have a 8MB
+ * unit. The address range of a flash SPI slave is encoded with
+ * absolute addresses which should be part of the overall controller
+ * window.
  */
-static inline uint32_t aspeed_smc_segment_to_reg(const AspeedSegments *seg)
+static uint32_t aspeed_smc_segment_to_reg(const AspeedSMCState *s,
+                                          const AspeedSegments *seg)
 {
     uint32_t reg = 0;
     reg |= ((seg->addr >> 23) & SEG_START_MASK) << SEG_START_SHIFT;
@@ -315,7 +329,8 @@ static inline uint32_t aspeed_smc_segment_to_reg(const AspeedSegments *seg)
     return reg;
 }
 
-static inline void aspeed_smc_reg_to_segment(uint32_t reg, AspeedSegments *seg)
+static void aspeed_smc_reg_to_segment(const AspeedSMCState *s,
+                                      uint32_t reg, AspeedSegments *seg)
 {
     seg->addr = ((reg >> SEG_START_SHIFT) & SEG_START_MASK) << 23;
     seg->size = (((reg >> SEG_END_SHIFT) & SEG_END_MASK) << 23) - seg->addr;
@@ -333,7 +348,7 @@ static bool aspeed_smc_flash_overlap(const AspeedSMCState *s,
             continue;
         }
 
-        aspeed_smc_reg_to_segment(s->regs[R_SEG_ADDR0 + i], &seg);
+        s->ctrl->reg_to_segment(s, s->regs[R_SEG_ADDR0 + i], &seg);
 
         if (new->addr + new->size > seg.addr &&
             new->addr < seg.addr + seg.size) {
@@ -354,7 +369,7 @@ static void aspeed_smc_flash_set_segment(AspeedSMCState *s, int cs,
     AspeedSMCFlash *fl = &s->flashes[cs];
     AspeedSegments seg;
 
-    aspeed_smc_reg_to_segment(new, &seg);
+    s->ctrl->reg_to_segment(s, new, &seg);
 
     /* The start address of CS0 is read-only */
     if (cs == 0 && seg.addr != s->ctrl->flash_window_base) {
@@ -362,7 +377,7 @@ static void aspeed_smc_flash_set_segment(AspeedSMCState *s, int cs,
                       "%s: Tried to change CS0 start address to 0x%"
                       HWADDR_PRIx "\n", s->ctrl->name, seg.addr);
         seg.addr = s->ctrl->flash_window_base;
-        new = aspeed_smc_segment_to_reg(&seg);
+        new = s->ctrl->segment_to_reg(s, &seg);
     }
 
     /*
@@ -379,7 +394,7 @@ static void aspeed_smc_flash_set_segment(AspeedSMCState *s, int cs,
                       HWADDR_PRIx "\n", s->ctrl->name, cs, seg.addr + seg.size);
         seg.size = s->ctrl->segments[cs].addr + s->ctrl->segments[cs].size -
             seg.addr;
-        new = aspeed_smc_segment_to_reg(&seg);
+        new = s->ctrl->segment_to_reg(s, &seg);
     }
 
     /* Keep the segment in the overall flash window */
@@ -509,7 +524,7 @@ static uint32_t aspeed_smc_check_segment_addr(const AspeedSMCFlash *fl,
     const AspeedSMCState *s = fl->controller;
     AspeedSegments seg;
 
-    aspeed_smc_reg_to_segment(s->regs[R_SEG_ADDR0 + fl->id], &seg);
+    s->ctrl->reg_to_segment(s, s->regs[R_SEG_ADDR0 + fl->id], &seg);
     if ((addr % seg.size) != addr) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: invalid address 0x%08x for CS%d segment : "
@@ -769,7 +784,7 @@ static void aspeed_smc_reset(DeviceState *d)
     /* setup default segment register values for all */
     for (i = 0; i < s->ctrl->max_slaves; ++i) {
         s->regs[R_SEG_ADDR0 + i] =
-            aspeed_smc_segment_to_reg(&s->ctrl->segments[i]);
+            s->ctrl->segment_to_reg(s, &s->ctrl->segments[i]);
     }
 
     /* HW strapping flash type for FMC controllers  */
-- 
2.20.1


