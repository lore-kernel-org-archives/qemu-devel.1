Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0637BC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C307D2133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAsPp9cW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C307D2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3Cp-0000bd-K7
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pv-0003wJ-8l
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pt-0007GZ-Qi
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:43 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2pt-0007Fz-K2
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:41 -0400
Received: by mail-wr1-x444.google.com with SMTP id y19so20399567wrd.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=D1T0sRshIfauupw08gYj0ltIR4hTWZeyzFS6T8DV5wA=;
 b=DAsPp9cW9JxxsjwbxVGbBS1018ipzNVUQu5R66E7LoCUS0Lqs/GAOSIm+BXtm04eUP
 DaWym72i3cOr/qWbRJ82g7rpDSyZwfX8lG1KxZmOdUgrHUI+dTd7M2k3FzYYEfDCvybj
 bqvuPo07ZTC/aD1FNYcLMgvsp+pqTMakmz8ZKA6ksTIIPveCNhB1q8eQatYChimNDZg5
 aFVwTlZoeyhrcGLJAGAKqaQAi1TBbEc4ZAugGBm7OdmqmG6ft3fwJxApDtnnlfbt+XaR
 7VFtnJfMFaYmp6FVo+v6nmJX6NoauG7muKXXulTnhrfpxFhouw/ycztYHqWNvLPbgexS
 7sIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D1T0sRshIfauupw08gYj0ltIR4hTWZeyzFS6T8DV5wA=;
 b=V/ieE/LUJ7VVMtaHJmCTgBtPn/q+tGZ4I1jaevoMg3DaY3NLtCQLakcA3tvdGRlPgW
 qU/pSr2Wp43/APM+2xUojkHuUas36oDLIp/oM/oByZBaKpV/uvA1q0bzsE54unvNREEt
 blERm8SSdxGmzC1gGBsPC1juCoxUs/qiVI3eQqofVGYqOcj/k6O2lg08XsrOLVT7tc3O
 MNkkAfJz0FY+F1Xxn4AnIdhZtsXprzJpnsjuyGzMlW305I25L0O15wZFRWy4GgfCLsRL
 ryOu3GHBRtpqPCcaw+wVD8kBWFgJe2ipNHsRfeLi/0A+w5sg6vyiXmOosS1H/5M9ucoG
 WcpQ==
X-Gm-Message-State: APjAAAW7t0Xkz5BZJ9/zO0TNvc2ODr3S3MVlGfUUynHzTb4mEHh9ZNy7
 zedXO4JQiSsJ0YLZd/3zE9QwIAkJh4WMLA==
X-Google-Smtp-Source: APXvYqyz0dlQR/9z5rh4I78d1P4217yw1e32Xu55L70vugcZ/DTQrigVUgHRBY8JwO9lSV3uKqkwig==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr12602152wrj.283.1571069079977; 
 Mon, 14 Oct 2019 09:04:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/68] hw/timer/exynos4210_mct.c: Switch ltick to
 transaction-based ptimer API
Date: Mon, 14 Oct 2019 17:03:12 +0100
Message-Id: <20191014160404.19553-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

Switch the ltick ptimer over to the ptimer transaction API.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-14-peter.maydell@linaro.org
---
 hw/timer/exynos4210_mct.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 82803ef9a02..72257584145 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -58,7 +58,6 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/ptimer.h"
 
@@ -735,6 +734,7 @@ static uint32_t exynos4210_ltick_int_get_cnto(struct tick_timer *s)
 
 /*
  * Start local tick cnt timer.
+ * Must be called within exynos4210_ltick_tx_begin/commit block.
  */
 static void exynos4210_ltick_cnt_start(struct tick_timer *s)
 {
@@ -750,6 +750,7 @@ static void exynos4210_ltick_cnt_start(struct tick_timer *s)
 
 /*
  * Stop local tick cnt timer.
+ * Must be called within exynos4210_ltick_tx_begin/commit block.
  */
 static void exynos4210_ltick_cnt_stop(struct tick_timer *s)
 {
@@ -767,6 +768,18 @@ static void exynos4210_ltick_cnt_stop(struct tick_timer *s)
     }
 }
 
+/* Start ptimer transaction for local tick timer */
+static void exynos4210_ltick_tx_begin(struct tick_timer *s)
+{
+    ptimer_transaction_begin(s->ptimer_tick);
+}
+
+/* Commit ptimer transaction for local tick timer */
+static void exynos4210_ltick_tx_commit(struct tick_timer *s)
+{
+    ptimer_transaction_commit(s->ptimer_tick);
+}
+
 /*
  * Get counter for CNT timer
  */
@@ -812,6 +825,7 @@ static uint32_t exynos4210_ltick_cnt_get_cnto(struct tick_timer *s)
 
 /*
  * Set new values of counters for CNT and INT timers
+ * Must be called within exynos4210_ltick_tx_begin/commit block.
  */
 static void exynos4210_ltick_set_cntb(struct tick_timer *s, uint32_t new_cnt,
         uint32_t new_int)
@@ -885,7 +899,9 @@ static void exynos4210_ltick_recalc_count(struct tick_timer *s)
 static void exynos4210_ltick_timer_init(struct tick_timer *s)
 {
     exynos4210_ltick_int_stop(s);
+    exynos4210_ltick_tx_begin(s);
     exynos4210_ltick_cnt_stop(s);
+    exynos4210_ltick_tx_commit(s);
 
     s->count = 0;
     s->distance = 0;
@@ -995,9 +1011,9 @@ static void exynos4210_mct_update_freq(Exynos4210MCTState *s)
         tx_ptimer_set_freq(s->g_timer.ptimer_frc, s->freq);
 
         /* local timer */
-        ptimer_set_freq(s->l_timer[0].tick_timer.ptimer_tick, s->freq);
+        tx_ptimer_set_freq(s->l_timer[0].tick_timer.ptimer_tick, s->freq);
         tx_ptimer_set_freq(s->l_timer[0].ptimer_frc, s->freq);
-        ptimer_set_freq(s->l_timer[1].tick_timer.ptimer_tick, s->freq);
+        tx_ptimer_set_freq(s->l_timer[1].tick_timer.ptimer_tick, s->freq);
         tx_ptimer_set_freq(s->l_timer[1].ptimer_frc, s->freq);
     }
 }
@@ -1304,6 +1320,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
         s->l_timer[lt_i].reg.wstat |= L_WSTAT_TCON_WRITE;
         s->l_timer[lt_i].reg.tcon = value;
 
+        exynos4210_ltick_tx_begin(&s->l_timer[lt_i].tick_timer);
         /* Stop local CNT */
         if ((value & L_TCON_TICK_START) <
                 (old_val & L_TCON_TICK_START)) {
@@ -1331,6 +1348,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
             DPRINTF("local timer[%d] start int\n", lt_i);
             exynos4210_ltick_int_start(&s->l_timer[lt_i].tick_timer);
         }
+        exynos4210_ltick_tx_commit(&s->l_timer[lt_i].tick_timer);
 
         /* Start or Stop local FRC if TCON changed */
         exynos4210_lfrc_tx_begin(&s->l_timer[lt_i]);
@@ -1356,8 +1374,10 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
          * Due to this we should reload timer to nearest moment when CNT is
          * expired and then in event handler update tcntb to new TCNTB value.
          */
+        exynos4210_ltick_tx_begin(&s->l_timer[lt_i].tick_timer);
         exynos4210_ltick_set_cntb(&s->l_timer[lt_i].tick_timer, value,
                 s->l_timer[lt_i].tick_timer.icntb);
+        exynos4210_ltick_tx_commit(&s->l_timer[lt_i].tick_timer);
 
         s->l_timer[lt_i].reg.wstat |= L_WSTAT_TCNTB_WRITE;
         s->l_timer[lt_i].reg.cnt[L_REG_CNT_TCNTB] = value;
@@ -1486,7 +1506,6 @@ static void exynos4210_mct_init(Object *obj)
     int i;
     Exynos4210MCTState *s = EXYNOS4210_MCT(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
-    QEMUBH *bh[2];
 
     /* Global timer */
     s->g_timer.ptimer_frc = ptimer_init(exynos4210_gfrc_event, s,
@@ -1495,9 +1514,9 @@ static void exynos4210_mct_init(Object *obj)
 
     /* Local timers */
     for (i = 0; i < 2; i++) {
-        bh[0] = qemu_bh_new(exynos4210_ltick_event, &s->l_timer[i]);
         s->l_timer[i].tick_timer.ptimer_tick =
-            ptimer_init_with_bh(bh[0], PTIMER_POLICY_DEFAULT);
+            ptimer_init(exynos4210_ltick_event, &s->l_timer[i],
+                        PTIMER_POLICY_DEFAULT);
         s->l_timer[i].ptimer_frc =
             ptimer_init(exynos4210_lfrc_event, &s->l_timer[i],
                         PTIMER_POLICY_DEFAULT);
-- 
2.20.1


