Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D81FC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240BC2133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y+s8HoN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240BC2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK37P-0001t3-RD
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pk-0003gl-To
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pj-00074E-M4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45246)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2pj-00073Q-Fl
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id r5so20329595wrm.12
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/9+N4KRIkIC7AplGQHDw+bqwPBeiJl0AKn35kS9i8E4=;
 b=y+s8HoN5IHuYd1Fha2waiFu7ngg0IG3H+wRp8GL8llYmUDbfyEqWlkXez+9/t2/9VI
 SbKdpl/ziPT9jsXcEvJJ84u6Ifz+snDuPAErIqMqAbAOVhX6DHL6k1Aqx5vJq5oUWd8Q
 Us/BsPSaGC44GkMeEiCt7CIPjRj8Hm9y/19qcF6eTmP6XoQ6emGU3twsiNv/nVXXlgTu
 DD1P6TSJ+clOJf4NwZAsTmBgNYxY8TJyVG1ZabFMuXcppIf7Bu0bzgvbVMn1P13MYLLZ
 WzuEcYUElApUU96Nq41WpTp3bG5t+Y7zmofYP7jLxdUssumx1ZG80e5AK5uN0vpNmFdf
 qHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/9+N4KRIkIC7AplGQHDw+bqwPBeiJl0AKn35kS9i8E4=;
 b=Qjluhcl7AHzEKZBv4A0QSODuxCoWK5EZYHLkYMStEP/aGylYb3jSy0cNDURngkVb4j
 VZM1zhGWWOLVkFrlKfWylw6HzxCmtZ3nLFeV/KOTgNatBNT+/KyqqUjSjMUT9CSVQMOh
 zXG3Kt1sWqe4d2bZUNMrkGhnevKJtJePr9AC/9DC6TTVtjZbyBbKlqIa8jOV5G348ePm
 Shz1qPNggJ+A7u+v5F4TBSkLOKKaHYWPnZW5PP+ANSz8kMVEAVZEbsMi/TUBP6ffiY3g
 Ye9DkjKefnZk6FTkGyWssNk6MdZa1/3Y9yQNVt8CIz86R258POE6oipK761KjBCjpLQd
 4bHA==
X-Gm-Message-State: APjAAAVPUcEMrWfnfJ2M4UGUMzpVqX4jSf1aIddgufL6ncTB22ZGZ3iS
 WZsx3yh3Po0ACA5if7pxtzmJFwZu7NlqSA==
X-Google-Smtp-Source: APXvYqyBkUcpHnWWKrk4oESQ45nFTt+VhFESwe3aiv51fb9U3IONQFqLSbLS+z0KqPIypjBhusODSQ==
X-Received: by 2002:a5d:6709:: with SMTP id o9mr26271482wru.116.1571069069952; 
 Mon, 14 Oct 2019 09:04:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/68] hw/timer/arm_mptimer.c: Switch to transaction-based
 ptimer API
Date: Mon, 14 Oct 2019 17:03:06 +0100
Message-Id: <20191014160404.19553-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

Switch the arm_mptimer.c code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-8-peter.maydell@linaro.org
---
 hw/timer/arm_mptimer.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index 2a54a011431..fdf97d1800f 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -27,7 +27,6 @@
 #include "hw/timer/arm_mptimer.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/core/cpu.h"
 
@@ -65,6 +64,7 @@ static inline uint32_t timerblock_scale(uint32_t control)
     return (((control >> 8) & 0xff) + 1) * 10;
 }
 
+/* Must be called within a ptimer transaction block */
 static inline void timerblock_set_count(struct ptimer_state *timer,
                                         uint32_t control, uint64_t *count)
 {
@@ -77,6 +77,7 @@ static inline void timerblock_set_count(struct ptimer_state *timer,
     ptimer_set_count(timer, *count);
 }
 
+/* Must be called within a ptimer transaction block */
 static inline void timerblock_run(struct ptimer_state *timer,
                                   uint32_t control, uint32_t load)
 {
@@ -124,6 +125,7 @@ static void timerblock_write(void *opaque, hwaddr addr,
     uint32_t control = tb->control;
     switch (addr) {
     case 0: /* Load */
+        ptimer_transaction_begin(tb->timer);
         /* Setting load to 0 stops the timer without doing the tick if
          * prescaler = 0.
          */
@@ -132,8 +134,10 @@ static void timerblock_write(void *opaque, hwaddr addr,
         }
         ptimer_set_limit(tb->timer, value, 1);
         timerblock_run(tb->timer, control, value);
+        ptimer_transaction_commit(tb->timer);
         break;
     case 4: /* Counter.  */
+        ptimer_transaction_begin(tb->timer);
         /* Setting counter to 0 stops the one-shot timer, or periodic with
          * load = 0, without doing the tick if prescaler = 0.
          */
@@ -143,8 +147,10 @@ static void timerblock_write(void *opaque, hwaddr addr,
         }
         timerblock_set_count(tb->timer, control, &value);
         timerblock_run(tb->timer, control, value);
+        ptimer_transaction_commit(tb->timer);
         break;
     case 8: /* Control.  */
+        ptimer_transaction_begin(tb->timer);
         if ((control & 3) != (value & 3)) {
             ptimer_stop(tb->timer);
         }
@@ -160,6 +166,7 @@ static void timerblock_write(void *opaque, hwaddr addr,
             timerblock_run(tb->timer, value, count);
         }
         tb->control = value;
+        ptimer_transaction_commit(tb->timer);
         break;
     case 12: /* Interrupt status.  */
         tb->status &= ~value;
@@ -212,9 +219,11 @@ static void timerblock_reset(TimerBlock *tb)
     tb->control = 0;
     tb->status = 0;
     if (tb->timer) {
+        ptimer_transaction_begin(tb->timer);
         ptimer_stop(tb->timer);
         ptimer_set_limit(tb->timer, 0, 1);
         ptimer_set_period(tb->timer, timerblock_scale(0));
+        ptimer_transaction_commit(tb->timer);
     }
 }
 
@@ -260,8 +269,7 @@ static void arm_mptimer_realize(DeviceState *dev, Error **errp)
      */
     for (i = 0; i < s->num_cpu; i++) {
         TimerBlock *tb = &s->timerblock[i];
-        QEMUBH *bh = qemu_bh_new(timerblock_tick, tb);
-        tb->timer = ptimer_init_with_bh(bh, PTIMER_POLICY);
+        tb->timer = ptimer_init(timerblock_tick, tb, PTIMER_POLICY);
         sysbus_init_irq(sbd, &tb->irq);
         memory_region_init_io(&tb->iomem, OBJECT(s), &timerblock_ops, tb,
                               "arm_mptimer_timerblock", 0x20);
-- 
2.20.1


