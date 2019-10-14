Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB4EC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:25:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4202133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zv1cEVIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4202133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK39p-0005NE-JN
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pu-0003uZ-Bv
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pt-0007Fp-0z
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:42 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2ps-0007FE-Qt
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id j18so20368510wrq.10
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=XztpDdqm9Po0sAJXUNM0F/wIrobkc8nBWqHQKQVJHg8=;
 b=Zv1cEVIokJbosWXeOopOUneuxpQyAJ5/XZmBtfjIiZIvtynD0vU6eahPrF7ZEbCVl/
 8sWHtoMBDJWiD3AUEKEAxysc0KX6odd/0MRUMgteNGpAIQU36WrWrfY0KLrCI+gc46hs
 MuzxFjQvO8iHutn7QKDVFczYhNU4UqyuF8MgfHi4/ajjjuB4fjHGOruX83X/TaJxTJRW
 G7aC7/hyO+cpZtDx74EOXjpmI3kflesN8xe8jrekYgDF/HMuwNJ9kfgXho8ivYbi7mMS
 XLGCspHz3VAjIBfKsmlaR1ht4GXBNaNCKkK2AqMbhJi6WJWTQmgEBwD47S81oTGZQyPi
 BLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XztpDdqm9Po0sAJXUNM0F/wIrobkc8nBWqHQKQVJHg8=;
 b=iN0Wlf8lN63hqnVdJHXol+uE+bsQ8mKkx2tz2OWcXZzBRhdTepML2KqKE1CtrqiwO3
 UtZc/xldzlJWor+owz3bFhEBh34rBvtEhn4vE5AolylZiKomsB+oDNyi+SPpXlxPQmVK
 EdBW3kS8va/6k1ZjfPiQI/kLCmSez0UyRUt6laoEYCd3E5YiWge5qsN/s8nX2O9wdmHy
 yhMA7BVoGW/+6uM5WcAZLj6QoNMlaeka94vn4MHmgnGfCfUtvVVg/h7pDOGfkvWuFlUg
 5aec5yODkq9FnoYr48khwNZ5lDpRDCub53y8Mx81jgukwdXmV3LPxAIs7jrTGj98FRFJ
 ZFZw==
X-Gm-Message-State: APjAAAW5bUSbuyAfpaDsZoWSFMqI+JmAN/b814wMB3tDh3fzIS6ajJZ3
 5H1XSLxMbfixHSRteAHdQgbz6Jf7mulYxA==
X-Google-Smtp-Source: APXvYqyy/jH8w0lbtLB47Os71vOD7o+aLqjaleJ8WabIhI890zYw+/uo3kz2xsMvW9RwbYtefnM87Q==
X-Received: by 2002:adf:d845:: with SMTP id k5mr13672425wrl.141.1571069078659; 
 Mon, 14 Oct 2019 09:04:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/68] hw/timer/exynos4210_mct.c: Switch LFRC to
 transaction-based ptimer API
Date: Mon, 14 Oct 2019 17:03:11 +0100
Message-Id: <20191014160404.19553-16-peter.maydell@linaro.org>
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

Switch the exynos MCT LFRC timers over to the ptimer transaction API.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-13-peter.maydell@linaro.org
---
 hw/timer/exynos4210_mct.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index fcf91c75cc5..82803ef9a02 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -608,6 +608,7 @@ static uint64_t exynos4210_lfrc_get_count(Exynos4210MCTLT *s)
 
 /*
  * Set counter of FRC local timer.
+ * Must be called from within exynos4210_lfrc_tx_begin/commit block.
  */
 static void exynos4210_lfrc_update_count(Exynos4210MCTLT *s)
 {
@@ -620,6 +621,7 @@ static void exynos4210_lfrc_update_count(Exynos4210MCTLT *s)
 
 /*
  * Start local FRC timer
+ * Must be called from within exynos4210_lfrc_tx_begin/commit block.
  */
 static void exynos4210_lfrc_start(Exynos4210MCTLT *s)
 {
@@ -628,12 +630,25 @@ static void exynos4210_lfrc_start(Exynos4210MCTLT *s)
 
 /*
  * Stop local FRC timer
+ * Must be called from within exynos4210_lfrc_tx_begin/commit block.
  */
 static void exynos4210_lfrc_stop(Exynos4210MCTLT *s)
 {
     ptimer_stop(s->ptimer_frc);
 }
 
+/* Start ptimer transaction for local FRC timer */
+static void exynos4210_lfrc_tx_begin(Exynos4210MCTLT *s)
+{
+    ptimer_transaction_begin(s->ptimer_frc);
+}
+
+/* Commit ptimer transaction for local FRC timer */
+static void exynos4210_lfrc_tx_commit(Exynos4210MCTLT *s)
+{
+    ptimer_transaction_commit(s->ptimer_frc);
+}
+
 /*
  * Local timer free running counter tick handler
  */
@@ -981,9 +996,9 @@ static void exynos4210_mct_update_freq(Exynos4210MCTState *s)
 
         /* local timer */
         ptimer_set_freq(s->l_timer[0].tick_timer.ptimer_tick, s->freq);
-        ptimer_set_freq(s->l_timer[0].ptimer_frc, s->freq);
+        tx_ptimer_set_freq(s->l_timer[0].ptimer_frc, s->freq);
         ptimer_set_freq(s->l_timer[1].tick_timer.ptimer_tick, s->freq);
-        ptimer_set_freq(s->l_timer[1].ptimer_frc, s->freq);
+        tx_ptimer_set_freq(s->l_timer[1].ptimer_frc, s->freq);
     }
 }
 
@@ -1012,7 +1027,9 @@ static void exynos4210_mct_reset(DeviceState *d)
         s->l_timer[i].tick_timer.count = 0;
         s->l_timer[i].tick_timer.distance = 0;
         s->l_timer[i].tick_timer.progress = 0;
+        exynos4210_lfrc_tx_begin(&s->l_timer[i]);
         ptimer_stop(s->l_timer[i].ptimer_frc);
+        exynos4210_lfrc_tx_commit(&s->l_timer[i]);
 
         exynos4210_ltick_timer_init(&s->l_timer[i].tick_timer);
     }
@@ -1316,6 +1333,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
         }
 
         /* Start or Stop local FRC if TCON changed */
+        exynos4210_lfrc_tx_begin(&s->l_timer[lt_i]);
         if ((value & L_TCON_FRC_START) >
         (s->l_timer[lt_i].reg.tcon & L_TCON_FRC_START)) {
             DPRINTF("local timer[%d] start frc\n", lt_i);
@@ -1326,6 +1344,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
             DPRINTF("local timer[%d] stop frc\n", lt_i);
             exynos4210_lfrc_stop(&s->l_timer[lt_i]);
         }
+        exynos4210_lfrc_tx_commit(&s->l_timer[lt_i]);
         break;
 
     case L0_TCNTB: case L1_TCNTB:
@@ -1477,11 +1496,11 @@ static void exynos4210_mct_init(Object *obj)
     /* Local timers */
     for (i = 0; i < 2; i++) {
         bh[0] = qemu_bh_new(exynos4210_ltick_event, &s->l_timer[i]);
-        bh[1] = qemu_bh_new(exynos4210_lfrc_event, &s->l_timer[i]);
         s->l_timer[i].tick_timer.ptimer_tick =
             ptimer_init_with_bh(bh[0], PTIMER_POLICY_DEFAULT);
         s->l_timer[i].ptimer_frc =
-            ptimer_init_with_bh(bh[1], PTIMER_POLICY_DEFAULT);
+            ptimer_init(exynos4210_lfrc_event, &s->l_timer[i],
+                        PTIMER_POLICY_DEFAULT);
         s->l_timer[i].id = i;
     }
 
-- 
2.20.1


