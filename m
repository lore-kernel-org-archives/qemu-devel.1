Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04359ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4C52133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ui60dvwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4C52133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK35b-0007bL-A8
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pj-0003eJ-Bm
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2ph-00072a-Sa
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:31 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55324)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2ph-00071e-M4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:29 -0400
Received: by mail-wm1-x344.google.com with SMTP id a6so17832028wma.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=WoP+uct2VOIlOQ3JIHwSGsCYzFXX99DfA0ZtmFs+mDo=;
 b=Ui60dvwJWEZFIAUqNHJnSKgTUH/hiDPH3XC4lOP1zcyMzxTC1lHVXlH5zHcFgtZ98e
 LEn0i9z1kFcjf0OZOFlAeeaKuPnvYOyhWv4aldLGV/zyCXoR8omy+a6xBPx0h1pblDmX
 XM9Y8dnGlFrwplaPD8F5qerPO3+EJaAqcHlJOk4KqkMnkSWHYJ1kcknwbYoWr/xWC+FQ
 IY7mqV2/f1zAP5g8DU5BpQKWnhqW4kRhK0ADcjTYE4HtiKSih5rtGoPaIWDZt001BHQn
 IVJq1VrIdT/RzVsLnd43fy9JVdTbT4mcrHcidWYmXmjpMo/LEtP+BcSiiDC3QcBMrstO
 owjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WoP+uct2VOIlOQ3JIHwSGsCYzFXX99DfA0ZtmFs+mDo=;
 b=i7B3Wg1VsVxOI2f3QZOPaYqirNwhq8iq83h3ziz4xSILm6Jz5mqadJ0OXIvzuny1oR
 PbxV+G+A7i5t4Rq0xkyidbCE2K2wbBVLr1ztXp+o6TqzoIjF6BAnStFbD37JjyLcTnUr
 svoTzC4QO2CraNl6BLeHTSRHGB6J0ojwy6Ivx/ivCZLZ9kvWG473vNVazC+JxD52DDWF
 zaPTJXLo953W4ExIv07SMhrnVVNPKb91FvSOSQgiNPfGmQ29baVYPhag07huTX5LP2RS
 jzcu7mFTb4UNQqhsKDk0kQVQzZ5FMQ5UcvbFghGUci3bPYIeM8MrMUh0Z+j+eat46MER
 tRtw==
X-Gm-Message-State: APjAAAXksqswhZa18vbRkc0Vg5AFU/iAGkcHGVo7Wo0LMCmiWtNqGAsZ
 LkPQzznzc75lK8QSy4BJQYNQKDp+idLAAQ==
X-Google-Smtp-Source: APXvYqyGlaEDIOmYt07EA5DxQ1WVBM01cB8ojp+i4KF3aQ0k80udQC5aKEfDdY5t251skj6UWcgQAQ==
X-Received: by 2002:a1c:99cd:: with SMTP id
 b196mr15746182wme.105.1571069068238; 
 Mon, 14 Oct 2019 09:04:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/68] hw/timer/allwinner-a10-pit.c: Switch to
 transaction-based ptimer API
Date: Mon, 14 Oct 2019 17:03:05 +0100
Message-Id: <20191014160404.19553-10-peter.maydell@linaro.org>
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

Switch the allwinner-a10-pit code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-7-peter.maydell@linaro.org
---
 hw/timer/allwinner-a10-pit.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index 28d055e42f3..aae880f5b35 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -22,7 +22,6 @@
 #include "hw/timer/allwinner-a10-pit.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 
 static void a10_pit_update_irq(AwA10PITState *s)
@@ -80,6 +79,7 @@ static uint64_t a10_pit_read(void *opaque, hwaddr offset, unsigned size)
     return 0;
 }
 
+/* Must be called inside a ptimer transaction block for s->timer[index] */
 static void a10_pit_set_freq(AwA10PITState *s, int index)
 {
     uint32_t prescaler, source, source_freq;
@@ -118,6 +118,7 @@ static void a10_pit_write(void *opaque, hwaddr offset, uint64_t value,
         switch (offset & 0x0f) {
         case AW_A10_PIT_TIMER_CONTROL:
             s->control[index] = value;
+            ptimer_transaction_begin(s->timer[index]);
             a10_pit_set_freq(s, index);
             if (s->control[index] & AW_A10_PIT_TIMER_RELOAD) {
                 ptimer_set_count(s->timer[index], s->interval[index]);
@@ -131,10 +132,13 @@ static void a10_pit_write(void *opaque, hwaddr offset, uint64_t value,
             } else {
                 ptimer_stop(s->timer[index]);
             }
+            ptimer_transaction_commit(s->timer[index]);
             break;
         case AW_A10_PIT_TIMER_INTERVAL:
             s->interval[index] = value;
+            ptimer_transaction_begin(s->timer[index]);
             ptimer_set_limit(s->timer[index], s->interval[index], 1);
+            ptimer_transaction_commit(s->timer[index]);
             break;
         case AW_A10_PIT_TIMER_COUNT:
             s->count[index] = value;
@@ -225,8 +229,10 @@ static void a10_pit_reset(DeviceState *dev)
         s->control[i] = AW_A10_PIT_DEFAULT_CLOCK;
         s->interval[i] = 0;
         s->count[i] = 0;
+        ptimer_transaction_begin(s->timer[i]);
         ptimer_stop(s->timer[i]);
         a10_pit_set_freq(s, i);
+        ptimer_transaction_commit(s->timer[i]);
     }
     s->watch_dog_mode = 0;
     s->watch_dog_control = 0;
@@ -255,7 +261,6 @@ static void a10_pit_init(Object *obj)
 {
     AwA10PITState *s = AW_A10_PIT(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    QEMUBH * bh[AW_A10_PIT_TIMER_NR];
     uint8_t i;
 
     for (i = 0; i < AW_A10_PIT_TIMER_NR; i++) {
@@ -270,8 +275,7 @@ static void a10_pit_init(Object *obj)
 
         tc->container = s;
         tc->index = i;
-        bh[i] = qemu_bh_new(a10_pit_timer_cb, tc);
-        s->timer[i] = ptimer_init_with_bh(bh[i], PTIMER_POLICY_DEFAULT);
+        s->timer[i] = ptimer_init(a10_pit_timer_cb, tc, PTIMER_POLICY_DEFAULT);
     }
 }
 
-- 
2.20.1


