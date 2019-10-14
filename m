Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B02C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33207217D9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yxjr+S1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33207217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3KQ-0001Hs-Rh
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pz-00043C-6L
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2py-0007Kr-1T
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:46 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50665)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2px-0007J9-Rn
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:45 -0400
Received: by mail-wm1-x341.google.com with SMTP id 5so17884456wmg.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=EZLtfGMXTjj+sthcq5+/4z7Vx2ErB03slfiG372deAg=;
 b=yxjr+S1G5YwANIsqLKeor7OfA7H0Lq2CVI2MrZGxpUBOk1NbhiV/1mfHWgcWjfE6h7
 cxlcUb4tMbPth4+ZqBcoew1GJcvxi/VlZS7H4hrPKGzdCCKvdM0+u3FI356UgdMUjOUi
 q+6K7RlC+XLqYksU+KnX9ReZAppBiP2pKGBLaCRyHt58eCNih0PehTX+Xl7y6Q+wQ/dV
 nGhCp5ebYq4xogKyXau8qSlaFZKSkgvVzkVj9x6QDnRtVLYEZkYfqxsDa5HUsmREPEpW
 NL+4CWH4udbiP4cxj863IC5weYd9I9lNz1zLPJezStQPW+qYeAEHzKscqx8O5wruDyWl
 vO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EZLtfGMXTjj+sthcq5+/4z7Vx2ErB03slfiG372deAg=;
 b=n6DIrYTAnr3t+7gOIrvezV/fFuTSq2vbawp3mc6Qr7Nyz2IW0vHJb9gTEwBnc3Qa8q
 InKWMJJBapNg0wXArXMuocBi4E0zG6bl/18mXDLpUwQBN9tLpzLy9e/g1LIn/ZObSsD7
 cUWQ8DmXp/OcwzWNFh/2QUzvp7oAs4Z42BWBBKkqUnbGA76QKHpeklYc+FzlClHXUBrh
 +W0hHof8YTN21g3/Ncyc7a16kuZ0khHoEEk8X9AZc0KVZ7ar6YmCe2KvWvfYoEfE567j
 H18E61YM+lCtIEL1H4PDj0h//rduGaRpEatFPWdqS/XErsTr2SbM06Bi+4+IuDnXgs3X
 FXGg==
X-Gm-Message-State: APjAAAV2gBgskezllN91+ceP7gdMvxuBwjRRvawh4C2S9ySC2Kz/xbnV
 iUtSBcjAFQKCjhLS6PMPYaB7H94ltnae6w==
X-Google-Smtp-Source: APXvYqwjuAXEnArPpOfTIfykJSowtoi7TYAvRzj/wECMF2y3BbX9gKzVHRfxkCubNQhEPgH9OT3WMg==
X-Received: by 2002:a7b:c3cf:: with SMTP id t15mr15233850wmj.85.1571069083463; 
 Mon, 14 Oct 2019 09:04:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/68] hw/timer/exynos4210_rtc.c: Switch 1Hz ptimer to
 transaction-based API
Date: Mon, 14 Oct 2019 17:03:14 +0100
Message-Id: <20191014160404.19553-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

Switch the exynos41210_rtc 1Hz ptimer over to the transaction-based
API. (We will switch the other ptimer used by this device in a
separate commit.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-16-peter.maydell@linaro.org
---
 hw/timer/exynos4210_rtc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/timer/exynos4210_rtc.c b/hw/timer/exynos4210_rtc.c
index d5d7c91fb15..b7ae99e9aa7 100644
--- a/hw/timer/exynos4210_rtc.c
+++ b/hw/timer/exynos4210_rtc.c
@@ -401,6 +401,7 @@ static void exynos4210_rtc_write(void *opaque, hwaddr offset,
         }
         break;
     case RTCCON:
+        ptimer_transaction_begin(s->ptimer_1Hz);
         if (value & RTC_ENABLE) {
             exynos4210_rtc_update_freq(s, value);
         }
@@ -430,6 +431,7 @@ static void exynos4210_rtc_write(void *opaque, hwaddr offset,
                 ptimer_stop(s->ptimer);
             }
         }
+        ptimer_transaction_commit(s->ptimer_1Hz);
         s->reg_rtccon = value;
         break;
     case TICCNT:
@@ -539,7 +541,9 @@ static void exynos4210_rtc_reset(DeviceState *d)
 
     exynos4210_rtc_update_freq(s, s->reg_rtccon);
     ptimer_stop(s->ptimer);
+    ptimer_transaction_begin(s->ptimer_1Hz);
     ptimer_stop(s->ptimer_1Hz);
+    ptimer_transaction_commit(s->ptimer_1Hz);
 }
 
 static const MemoryRegionOps exynos4210_rtc_ops = {
@@ -562,9 +566,11 @@ static void exynos4210_rtc_init(Object *obj)
     ptimer_set_freq(s->ptimer, RTC_BASE_FREQ);
     exynos4210_rtc_update_freq(s, 0);
 
-    bh = qemu_bh_new(exynos4210_rtc_1Hz_tick, s);
-    s->ptimer_1Hz = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+    s->ptimer_1Hz = ptimer_init(exynos4210_rtc_1Hz_tick,
+                                s, PTIMER_POLICY_DEFAULT);
+    ptimer_transaction_begin(s->ptimer_1Hz);
     ptimer_set_freq(s->ptimer_1Hz, RTC_BASE_FREQ);
+    ptimer_transaction_commit(s->ptimer_1Hz);
 
     sysbus_init_irq(dev, &s->alm_irq);
     sysbus_init_irq(dev, &s->tick_irq);
-- 
2.20.1


