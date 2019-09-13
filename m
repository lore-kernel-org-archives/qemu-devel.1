Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35531C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE9B3206BB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xiiVX9Dy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9B3206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8o5w-0007lE-Fc
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 12:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npo-0007fG-Qd
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npn-0000vL-DU
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:47001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8npn-0000uu-63
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:07 -0400
Received: by mail-wr1-x436.google.com with SMTP id o18so1372860wrv.13
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=WjpL1PRP109kykUPDDngOfZC1U7Z+AZ7bQ7XRIXZFYY=;
 b=xiiVX9Dy4Af7QhL2snOrssMy4pU7QRcppVLvoVrBbjcag+Pz8spCgNFEqPgv7VjRgg
 swAFognqNC55QAYoQ0B90IPv0EwmLKsFVuu0Tj86Fz6W+h0zSBLzCgPV4bmHA5RKb06v
 6I/9UrX0WEt3M38AZM3MHx8aWOduUH6bTUEc2w7xRsmpZU+fsmvNzIwtxgTJ2m9nzAWY
 y76RvwsAQLqEwtub1W5hSdRx1S2m6XPCENBT1qKNYaQMbzuX6zWLwG9TZWYcl2PLyJ2o
 4vBIbuFjs/rGztJ+wgvCCOEspeqTvNl5C2TCkTmVYEKnn+EZb4ZIrqQ8otxaPe/RUeiw
 u9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WjpL1PRP109kykUPDDngOfZC1U7Z+AZ7bQ7XRIXZFYY=;
 b=BjtURRHyXrXFMzW+f/6NNPgt25Axc1YKXzH7zpyGuWCfZ3Rb0FKpawzSfNVtwWIF3p
 nXtcmQQhjPUodFxNTQG754EvWxO0ainorxUlWJtOVPdHdvAEWWAW/6l2F1lvNv1uqLxH
 a0qmqh2N+5+K+5Uq7ehddCkFfktBF3rbnrcfwpU+BxKtlxAO+WEe5FYBOm3AwIQil6+V
 z+cCUtYoM4bPWUCibJsxVLF1OoqN05Es41fJRZ0zNuPEalRaFx/UJ0i9cYSPvFt3zO8L
 VQ5rclLZcQsjtTexc06ngsfGShXB66IMdefhbFbBK+wEYRBXoHDllFtyqTsSam3Fd+H5
 ol0g==
X-Gm-Message-State: APjAAAU6WRvKs//9Qi/+jJcw5JIWCoeToayGY1vKi7/ENaOI1o+rjkjx
 agQ4SfvHD8SzZOZIaiexFDVe7ZUjh30aDw==
X-Google-Smtp-Source: APXvYqzP4J7ljoWprn4A27btE61z7947r2Kffo7fUgBDIli7/tPmr7twTv9lzpMo9EFALYbtexLtIw==
X-Received: by 2002:adf:fe07:: with SMTP id n7mr13865856wrr.90.1568389805948; 
 Fri, 13 Sep 2019 08:50:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c132sm3562207wme.27.2019.09.13.08.50.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 08:50:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 16:49:50 +0100
Message-Id: <20190913154952.27724-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913154952.27724-1-peter.maydell@linaro.org>
References: <20190913154952.27724-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PULL 10/12] aspeed/scu: Introduce a
 aspeed_scu_get_apb_freq() routine
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

The APB frequency can be calculated directly when needed from the
HPLL_PARAM and CLK_SEL register values. This removes useless state in
the model.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20190904070506.1052-11-clg@kaod.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/aspeed_scu.h |  8 +++-----
 hw/misc/aspeed_scu.c         | 25 +++++++++----------------
 hw/timer/aspeed_timer.c      |  3 ++-
 3 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 90dd4dadede..239e94fe2c4 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -32,10 +32,6 @@ typedef struct AspeedSCUState {
     uint32_t hw_strap1;
     uint32_t hw_strap2;
     uint32_t hw_prot_key;
-
-    uint32_t clkin;
-    uint32_t hpll;
-    uint32_t apb_freq;
 } AspeedSCUState;
 
 #define AST2400_A0_SILICON_REV   0x02000303U
@@ -56,12 +52,14 @@ typedef struct  AspeedSCUClass {
     SysBusDeviceClass parent_class;
 
     const uint32_t *resets;
-    uint32_t (*calc_hpll)(AspeedSCUState *s);
+    uint32_t (*calc_hpll)(AspeedSCUState *s, uint32_t hpll_reg);
     uint32_t apb_divider;
 }  AspeedSCUClass;
 
 #define ASPEED_SCU_PROT_KEY      0x1688A8A8
 
+uint32_t aspeed_scu_get_apb_freq(AspeedSCUState *s);
+
 /*
  * Extracted from Aspeed SDK v00.03.21. Fixes and extra definitions
  * were added.
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index d284458b9b3..620b25c2047 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -164,11 +164,12 @@ static uint32_t aspeed_scu_get_random(void)
     return num;
 }
 
-static void aspeed_scu_set_apb_freq(AspeedSCUState *s)
+uint32_t aspeed_scu_get_apb_freq(AspeedSCUState *s)
 {
     AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(s);
+    uint32_t hpll = asc->calc_hpll(s, s->regs[HPLL_PARAM]);
 
-    s->apb_freq = s->hpll / (SCU_CLK_GET_PCLK_DIV(s->regs[CLK_SEL]) + 1)
+    return hpll / (SCU_CLK_GET_PCLK_DIV(s->regs[CLK_SEL]) + 1)
         / asc->apb_divider;
 }
 
@@ -228,7 +229,6 @@ static void aspeed_scu_write(void *opaque, hwaddr offset, uint64_t data,
         return;
     case CLK_SEL:
         s->regs[reg] = data;
-        aspeed_scu_set_apb_freq(s);
         break;
     case HW_STRAP1:
         if (ASPEED_IS_AST2500(s->regs[SILICON_REV])) {
@@ -290,11 +290,11 @@ static const uint32_t hpll_ast2400_freqs[][4] = {
     { 400, 375, 350, 425 }, /* 25MHz */
 };
 
-static uint32_t aspeed_2400_scu_calc_hpll(AspeedSCUState *s)
+static uint32_t aspeed_2400_scu_calc_hpll(AspeedSCUState *s, uint32_t hpll_reg)
 {
-    uint32_t hpll_reg = s->regs[HPLL_PARAM];
     uint8_t freq_select;
     bool clk_25m_in;
+    uint32_t clkin = aspeed_scu_get_clkin(s);
 
     if (hpll_reg & SCU_AST2400_H_PLL_OFF) {
         return 0;
@@ -311,7 +311,7 @@ static uint32_t aspeed_2400_scu_calc_hpll(AspeedSCUState *s)
             multiplier = (2 - od) * ((n + 2) / (d + 1));
         }
 
-        return s->clkin * multiplier;
+        return clkin * multiplier;
     }
 
     /* HW strapping */
@@ -321,10 +321,10 @@ static uint32_t aspeed_2400_scu_calc_hpll(AspeedSCUState *s)
     return hpll_ast2400_freqs[clk_25m_in][freq_select] * 1000000;
 }
 
-static uint32_t aspeed_2500_scu_calc_hpll(AspeedSCUState *s)
+static uint32_t aspeed_2500_scu_calc_hpll(AspeedSCUState *s, uint32_t hpll_reg)
 {
-    uint32_t hpll_reg   = s->regs[HPLL_PARAM];
     uint32_t multiplier = 1;
+    uint32_t clkin = aspeed_scu_get_clkin(s);
 
     if (hpll_reg & SCU_H_PLL_OFF) {
         return 0;
@@ -338,7 +338,7 @@ static uint32_t aspeed_2500_scu_calc_hpll(AspeedSCUState *s)
         multiplier = ((m + 1) / (n + 1)) / (p + 1);
     }
 
-    return s->clkin * multiplier;
+    return clkin * multiplier;
 }
 
 static void aspeed_scu_reset(DeviceState *dev)
@@ -351,13 +351,6 @@ static void aspeed_scu_reset(DeviceState *dev)
     s->regs[HW_STRAP1] = s->hw_strap1;
     s->regs[HW_STRAP2] = s->hw_strap2;
     s->regs[PROT_KEY] = s->hw_prot_key;
-
-    /*
-     * All registers are set. Now compute the frequencies of the main clocks
-     */
-    s->clkin = aspeed_scu_get_clkin(s);
-    s->hpll = asc->calc_hpll(s);
-    aspeed_scu_set_apb_freq(s);
 }
 
 static uint32_t aspeed_silicon_revs[] = {
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 59c2bbeee60..2bda826882d 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -93,7 +93,8 @@ static inline uint32_t calculate_rate(struct AspeedTimer *t)
 {
     AspeedTimerCtrlState *s = timer_to_ctrl(t);
 
-    return timer_external_clock(t) ? TIMER_CLOCK_EXT_HZ : s->scu->apb_freq;
+    return timer_external_clock(t) ? TIMER_CLOCK_EXT_HZ :
+        aspeed_scu_get_apb_freq(s->scu);
 }
 
 static inline uint32_t calculate_ticks(struct AspeedTimer *t, uint64_t now_ns)
-- 
2.20.1


