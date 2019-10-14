Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FD0C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB3B2133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOyrMNCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB3B2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK37u-0002jq-F3
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pz-00044C-OL
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2py-0007LK-De
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2py-0007KX-6l
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:46 -0400
Received: by mail-wr1-x442.google.com with SMTP id z9so20366802wrl.11
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8Qb3uEtVa31jjwSH7w0tbpjKxkHdEIWFnSCioRvfNgw=;
 b=VOyrMNCs5Pay3VWaK+Rf2iiElrS9R9XmE4R2TvYJmHPR2BVxEeGC+aCHc3ofOArxQY
 oqqSks6b1mWsvyGTl+y6awIe83o/3pHM/HEssoWPJWy/Km/hnGwH2Sb8yr/akIrEBiP3
 U2eIfZ7qAOKHUixwDm6waOyeDpYED/4IRncJSfOhxlmGgMynMDIOj+2JotCIbxNlMip0
 zBV4ReOZtyaB0HjiC9NkqOHeWd0cB6nQypf1soJIR3k+ZfNQN0F4+u4dx0MWRrHoH5mO
 Ee6W2ecsGBAe6dpzqZkr52kO+zbzRyuLyuxpsIZo4IfdOzJ7+3bn/nqfNroREIexmpd5
 xiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8Qb3uEtVa31jjwSH7w0tbpjKxkHdEIWFnSCioRvfNgw=;
 b=pC7dchcaot4KRGo6Y2juIawYkb0VnwERyKq5scZJS74wKor4twF4W99XqBaOC0KE07
 6w7ui99QUx8t9h3poG4ZSjPkMLckKSbBbn0goOEtEjYHVx7Yz7lCYQ6PsIa8QGczLVUr
 TM/Y3aOOlG0+7lD1AJZAh1sC/kD7Tfvxd/CwjG+ymp6WeuAiJF+rpRSmcydWhIcd22w6
 c18XmEozy7LXcfoyhWAnNeh+808my3ZkLUGzle7TmVSGWMSwMmWAGMjb+dM45g83CEtK
 6AXshcbbpaN4irKR+zMCCyFQfjSyEHgB9ri/HmjGCBq1yKJRU7iSjOR1vziLXLHFjM/k
 PljQ==
X-Gm-Message-State: APjAAAX7QHEVBlAFoMy6Vv9B8RXUV+x/ey3o1S+qSnCQdJ77Gb28/Hic
 lrVI43D5ZFvaZ/cQt/q0zloYTo3hsrbDOw==
X-Google-Smtp-Source: APXvYqyh6ay2p2pxiV9E1mA79Sz+yKZRtrzEzTsufZ6w4G2uQOHfSsrOk/BP9dS20w5+JRPMfZPH0g==
X-Received: by 2002:adf:8123:: with SMTP id 32mr27727218wrm.300.1571069084799; 
 Mon, 14 Oct 2019 09:04:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/68] hw/timer/exynos4210_rtc.c: Switch main ptimer to
 transaction-based API
Date: Mon, 14 Oct 2019 17:03:15 +0100
Message-Id: <20191014160404.19553-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

Switch the exynos41210_rtc main ptimer over to the transaction-based
API, completing the transition for this device.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-17-peter.maydell@linaro.org
---
 hw/timer/exynos4210_rtc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/timer/exynos4210_rtc.c b/hw/timer/exynos4210_rtc.c
index b7ae99e9aa7..f85483a07f8 100644
--- a/hw/timer/exynos4210_rtc.c
+++ b/hw/timer/exynos4210_rtc.c
@@ -28,7 +28,6 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
@@ -195,6 +194,7 @@ static void check_alarm_raise(Exynos4210RTCState *s)
  * RTC update frequency
  * Parameters:
  *     reg_value - current RTCCON register or his new value
+ * Must be called within a ptimer_transaction_begin/commit block for s->ptimer.
  */
 static void exynos4210_rtc_update_freq(Exynos4210RTCState *s,
                                        uint32_t reg_value)
@@ -402,6 +402,7 @@ static void exynos4210_rtc_write(void *opaque, hwaddr offset,
         break;
     case RTCCON:
         ptimer_transaction_begin(s->ptimer_1Hz);
+        ptimer_transaction_begin(s->ptimer);
         if (value & RTC_ENABLE) {
             exynos4210_rtc_update_freq(s, value);
         }
@@ -432,6 +433,7 @@ static void exynos4210_rtc_write(void *opaque, hwaddr offset,
             }
         }
         ptimer_transaction_commit(s->ptimer_1Hz);
+        ptimer_transaction_commit(s->ptimer);
         s->reg_rtccon = value;
         break;
     case TICCNT:
@@ -539,8 +541,10 @@ static void exynos4210_rtc_reset(DeviceState *d)
 
     s->reg_curticcnt = 0;
 
+    ptimer_transaction_begin(s->ptimer);
     exynos4210_rtc_update_freq(s, s->reg_rtccon);
     ptimer_stop(s->ptimer);
+    ptimer_transaction_commit(s->ptimer);
     ptimer_transaction_begin(s->ptimer_1Hz);
     ptimer_stop(s->ptimer_1Hz);
     ptimer_transaction_commit(s->ptimer_1Hz);
@@ -559,12 +563,12 @@ static void exynos4210_rtc_init(Object *obj)
 {
     Exynos4210RTCState *s = EXYNOS4210_RTC(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
-    QEMUBH *bh;
 
-    bh = qemu_bh_new(exynos4210_rtc_tick, s);
-    s->ptimer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+    s->ptimer = ptimer_init(exynos4210_rtc_tick, s, PTIMER_POLICY_DEFAULT);
+    ptimer_transaction_begin(s->ptimer);
     ptimer_set_freq(s->ptimer, RTC_BASE_FREQ);
     exynos4210_rtc_update_freq(s, 0);
+    ptimer_transaction_commit(s->ptimer);
 
     s->ptimer_1Hz = ptimer_init(exynos4210_rtc_1Hz_tick,
                                 s, PTIMER_POLICY_DEFAULT);
-- 
2.20.1


