Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C34C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D864F20640
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xf96vk9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D864F20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nyX-0000MS-Lc
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npk-0007bM-Ud
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npj-0000rs-Ju
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:04 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8npj-0000pz-Ds
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id l3so9862157wru.7
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 08:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=x9pAvs1vBwT98tToIZ3WwAg5y5izTGLjnHfR9GCnGxg=;
 b=xf96vk9dQKmtzzbaJ78VvErD+rfA6O8xgELgF9a5lKSDHg/Cf3IseMjOT1k3MQ4zjG
 5U6J1ncnRzJwuZaHbjwqHadpw17Kzmt2tTEFdBzIc/WyG+YRuxeltCSDSUDjKztCUMyp
 l2TfnEIND0hGr95tK7yJJ2iBVjd4DkkZNG4ivcnnyOIaOGQJa87rk5+no9Q0iGmSdF8T
 +iiFcnzrSNJ28E0eMvJCAtbBLzGqgkHPLciMWIGP2Pdl7ofyS57ikcU1qThNQfrBi0+W
 1mAaXo3wr4YLBicTNnQfrogTtVkdljjJQdEtdcdh4Jt9UrP70CjZkDjg7LYfalNQ1Yi2
 QCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x9pAvs1vBwT98tToIZ3WwAg5y5izTGLjnHfR9GCnGxg=;
 b=YM1x1ildSF5gyAsaVdujND9PoBbjq4GsrgW1I196gKDd21DZw+5eqo6gVEZNbBpgm6
 Pycq2TbEQ1/Wp0ZPe12lwkv97wfpH91IuIfNvAYxIhrrLGuRmEL5ZpmE6VvFuTLF8Ztn
 CalIrZm+g/KIEoK86EuPmMHsUMxG/xg1P5oIq+XM79nCn0UOadnGbd2Rzl+sfPh9Tizj
 MK+Hm0VO1/9CIpwaWb5QFO4W338n4Lpvddb+uWlJEYOTpfTbCfLSUI+meDVuKaf1SqJ/
 zP4w5WGjqGA42N4spAEuD62kgAFkaf6NqzLGWIn3xFSvBVnb4+RrlOrLktOdMW7iqV70
 5UvQ==
X-Gm-Message-State: APjAAAU3FVSSP7P78oiHFsGluAvKA1WOa679TV/wbJpV8WfYrUcNT+Qy
 3w/Apehe7UhsUkIFywJMNxv9Bgvmi0k/Mg==
X-Google-Smtp-Source: APXvYqwOrbaH7yvjzxqBdp7SSDXeQL6SZVj1/3+RF4EvTKLu94Zexwm6RVvzT5M8vD6bZXdBBLi/bA==
X-Received: by 2002:a5d:61ca:: with SMTP id q10mr20644606wrv.274.1568389802174; 
 Fri, 13 Sep 2019 08:50:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c132sm3562207wme.27.2019.09.13.08.50.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 08:50:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 16:49:46 +0100
Message-Id: <20190913154952.27724-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913154952.27724-1-peter.maydell@linaro.org>
References: <20190913154952.27724-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 06/12] aspeed/smc: Add DMA calibration settings
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

When doing calibration, the SPI clock rate in the CE0 Control Register
and the read delay cycles in the Read Timing Compensation Register are
set using bit[11:4] of the DMA Control Register.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190904070506.1052-7-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 64 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index c1a45c10dc1..7a0cd7607fd 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -77,6 +77,10 @@
 #define   CTRL_CMD_MASK            0xff
 #define   CTRL_DUMMY_HIGH_SHIFT    14
 #define   CTRL_AST2400_SPI_4BYTE   (1 << 13)
+#define CE_CTRL_CLOCK_FREQ_SHIFT   8
+#define CE_CTRL_CLOCK_FREQ_MASK    0xf
+#define CE_CTRL_CLOCK_FREQ(div)                                         \
+    (((div) & CE_CTRL_CLOCK_FREQ_MASK) << CE_CTRL_CLOCK_FREQ_SHIFT)
 #define   CTRL_DUMMY_LOW_SHIFT     6 /* 2 bits [7:6] */
 #define   CTRL_CE_STOP_ACTIVE      (1 << 2)
 #define   CTRL_CMD_MODE_MASK       0x3
@@ -112,7 +116,7 @@
 #define   DMA_CTRL_DELAY_SHIFT  8
 #define   DMA_CTRL_FREQ_MASK    0xf
 #define   DMA_CTRL_FREQ_SHIFT   4
-#define   DMA_CTRL_MODE         (1 << 3)
+#define   DMA_CTRL_CALIB        (1 << 3)
 #define   DMA_CTRL_CKSUM        (1 << 2)
 #define   DMA_CTRL_WRITE        (1 << 1)
 #define   DMA_CTRL_ENABLE       (1 << 0)
@@ -811,6 +815,60 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
     }
 }
 
+static uint8_t aspeed_smc_hclk_divisor(uint8_t hclk_mask)
+{
+    /* HCLK/1 .. HCLK/16 */
+    const uint8_t hclk_divisors[] = {
+        15, 7, 14, 6, 13, 5, 12, 4, 11, 3, 10, 2, 9, 1, 8, 0
+    };
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(hclk_divisors); i++) {
+        if (hclk_mask == hclk_divisors[i]) {
+            return i + 1;
+        }
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR, "invalid HCLK mask %x", hclk_mask);
+    return 0;
+}
+
+/*
+ * When doing calibration, the SPI clock rate in the CE0 Control
+ * Register and the read delay cycles in the Read Timing Compensation
+ * Register are set using bit[11:4] of the DMA Control Register.
+ */
+static void aspeed_smc_dma_calibration(AspeedSMCState *s)
+{
+    uint8_t delay =
+        (s->regs[R_DMA_CTRL] >> DMA_CTRL_DELAY_SHIFT) & DMA_CTRL_DELAY_MASK;
+    uint8_t hclk_mask =
+        (s->regs[R_DMA_CTRL] >> DMA_CTRL_FREQ_SHIFT) & DMA_CTRL_FREQ_MASK;
+    uint8_t hclk_div = aspeed_smc_hclk_divisor(hclk_mask);
+    uint32_t hclk_shift = (hclk_div - 1) << 2;
+    uint8_t cs;
+
+    /*
+     * The Read Timing Compensation Register values apply to all CS on
+     * the SPI bus and only HCLK/1 - HCLK/5 can have tunable delays
+     */
+    if (hclk_div && hclk_div < 6) {
+        s->regs[s->r_timings] &= ~(0xf << hclk_shift);
+        s->regs[s->r_timings] |= delay << hclk_shift;
+    }
+
+    /*
+     * TODO: compute the CS from the DMA address and the segment
+     * registers. This is not really a problem for now because the
+     * Timing Register values apply to all CS and software uses CS0 to
+     * do calibration.
+     */
+    cs = 0;
+    s->regs[s->r_ctrl0 + cs] &=
+        ~(CE_CTRL_CLOCK_FREQ_MASK << CE_CTRL_CLOCK_FREQ_SHIFT);
+    s->regs[s->r_ctrl0 + cs] |= CE_CTRL_CLOCK_FREQ(hclk_div);
+}
+
 /*
  * Accumulate the result of the reads to provide a checksum that will
  * be used to validate the read timing settings.
@@ -826,6 +884,10 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
         return;
     }
 
+    if (s->regs[R_DMA_CTRL] & DMA_CTRL_CALIB) {
+        aspeed_smc_dma_calibration(s);
+    }
+
     while (s->regs[R_DMA_LEN]) {
         data = address_space_ldl_le(&s->flash_as, s->regs[R_DMA_FLASH_ADDR],
                                     MEMTXATTRS_UNSPECIFIED, &result);
-- 
2.20.1


