Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C52EECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB6D92133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cj+8MGeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6D92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3AV-0006KK-Rg
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2q5-0004EL-Hk
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2q4-0007Rt-8L
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:53 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2q4-0007R6-1w
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:52 -0400
Received: by mail-wm1-x344.google.com with SMTP id p7so17866872wmp.4
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9b9GZNMAUz56Mm9M7+arYCaaqvYl4kdVBrW1fhBiXYU=;
 b=cj+8MGehiWCGG0/ZnCZ6JiJ3yvcf1zGNM6sphJa21TiEjdeGlv5j2jeOCzZLwpGXg/
 9+uE/gU5PrgwLc+es4O/s+MaCQXUENVlWJ6Jzz+CHl95Wd/LonSsZhnvtR73cnWT0X5a
 E/CVVNjIx1C40sm7/hX2gWRejkmuViKombllwUkaDU43ToozQtjGZbah0R12zk8AjUZT
 5SVdCVCAw6cjTZWtjYZDEkSAwrFnxE6IqnnLnxYhGWxKzyQaJLEckD5sNzId9ihBjE2y
 7TDfvYDCQsKWVd8yWQH2Ip5LRoqKcYhyFoBrlk4ezBoVP1HAkGU+pp/+QkyIgyMoZ1J7
 YLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9b9GZNMAUz56Mm9M7+arYCaaqvYl4kdVBrW1fhBiXYU=;
 b=gJb2bMpxeAxM8c7iuv5+B+5V65xw8kcyDmF7S8kMmhIe/mVb5KDAg46ahyxMaip7aS
 NzvH+fWWwbuMmmIuonRzZtawaU0/gAGqOGw/p3Nb+KVd3RKApT1YK2q9lyQIK0pvXAvr
 HqS60WTmwp36F9eBzRijtVdU232F5u3LrKj3ttPMJqWvCxO8W2k+Y8XWnXhIwqzVZkBB
 X08qKzebpW03abUKpr2ZEglKSAHJNpxbvkNoZfr92/XrVlBm6c6lKP0iVndgEMykBy2C
 rtMmbiGKuCVT2PJDPmhqZ8GXuzmMNAI2C0D9mSVYs/Fo4quO7clhOEUFa1RNPJ12GHga
 QhkA==
X-Gm-Message-State: APjAAAUn+V1aSbjqJVP0Sb5jxYYkJlRwrN895cJhJ7uz62tC3ZmL4cCn
 DkCEnrScg50qBD5ZqrTjsd+cDJYhVy1S+w==
X-Google-Smtp-Source: APXvYqwXCmQdfVvBPGNlGwPVtHNej8zIJxaKzIncsEMEYQJaGZPV2BFVCCLCx0ViDFch56BxLQs65A==
X-Received: by 2002:a1c:e10a:: with SMTP id y10mr15661170wmg.29.1571069090725; 
 Mon, 14 Oct 2019 09:04:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/68] hw/watchdog/cmsdk-apb-watchdog.c: Switch to
 transaction-based ptimer API
Date: Mon, 14 Oct 2019 17:03:19 +0100
Message-Id: <20191014160404.19553-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

Switch the cmsdk-apb-watchdog code away from bottom-half based
ptimers to the new transaction-based ptimer API.  This just requires
adding begin/commit calls around the various places that modify the
ptimer state, and using the new ptimer_init() function to create the
timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-21-peter.maydell@linaro.org
---
 hw/watchdog/cmsdk-apb-watchdog.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index e42c3ebd29d..e6f3b93c44e 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -24,7 +24,6 @@
 #include "qemu/log.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "sysemu/watchdog.h"
 #include "hw/sysbus.h"
@@ -200,8 +199,10 @@ static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
          * Reset the load value and the current count, and make sure
          * we're counting.
          */
+        ptimer_transaction_begin(s->timer);
         ptimer_set_limit(s->timer, value, 1);
         ptimer_run(s->timer, 0);
+        ptimer_transaction_commit(s->timer);
         break;
     case A_WDOGCONTROL:
         if (s->is_luminary && 0 != (R_WDOGCONTROL_INTEN_MASK & s->control)) {
@@ -217,7 +218,9 @@ static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
         break;
     case A_WDOGINTCLR:
         s->intstatus = 0;
+        ptimer_transaction_begin(s->timer);
         ptimer_set_count(s->timer, ptimer_get_limit(s->timer));
+        ptimer_transaction_commit(s->timer);
         cmsdk_apb_watchdog_update(s);
         break;
     case A_WDOGLOCK:
@@ -299,8 +302,10 @@ static void cmsdk_apb_watchdog_reset(DeviceState *dev)
     s->itop = 0;
     s->resetstatus = 0;
     /* Set the limit and the count */
+    ptimer_transaction_begin(s->timer);
     ptimer_set_limit(s->timer, 0xffffffff, 1);
     ptimer_run(s->timer, 0);
+    ptimer_transaction_commit(s->timer);
 }
 
 static void cmsdk_apb_watchdog_init(Object *obj)
@@ -320,7 +325,6 @@ static void cmsdk_apb_watchdog_init(Object *obj)
 static void cmsdk_apb_watchdog_realize(DeviceState *dev, Error **errp)
 {
     CMSDKAPBWatchdog *s = CMSDK_APB_WATCHDOG(dev);
-    QEMUBH *bh;
 
     if (s->wdogclk_frq == 0) {
         error_setg(errp,
@@ -328,14 +332,15 @@ static void cmsdk_apb_watchdog_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    bh = qemu_bh_new(cmsdk_apb_watchdog_tick, s);
-    s->timer = ptimer_init_with_bh(bh,
+    s->timer = ptimer_init(cmsdk_apb_watchdog_tick, s,
                            PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD |
                            PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT |
                            PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
                            PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
 
+    ptimer_transaction_begin(s->timer);
     ptimer_set_freq(s->timer, s->wdogclk_frq);
+    ptimer_transaction_commit(s->timer);
 }
 
 static const VMStateDescription cmsdk_apb_watchdog_vmstate = {
-- 
2.20.1


