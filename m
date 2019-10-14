Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC128C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C3320663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cZ8j5vPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C3320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3PA-0000jI-9p
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2q3-00049r-0Z
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2q1-0007Oi-Ju
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:50 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:42948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2q1-0007Ns-CW
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:49 -0400
Received: by mail-wr1-x429.google.com with SMTP id n14so20339432wrw.9
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5+kOs0teFFCsk+a/XyNTZMVCXSHzbGikT6RQ04d9kmY=;
 b=cZ8j5vPekk4jpgSWBw21FmVVfIvnGdEq0Cjm00E4LPMXwjCJNv8Kr5vGibxzLgYhTW
 OsFFo2K9xWapD9x2sD6EF2J7ipO6NjgfBqM46wj6QM5fTp0dubXReAWWBJenZrGNlM7M
 cJv8gGIzjnXGqZcU5sk0Inpr4Uhgfcy5/NVhbgJiNLOiBa4045AtYd3ll2gPh/fTxGdy
 FthhLqSRAw1wf7kDkOJsXkwsoa937a3/qshC00TLvnukP0jyXNWRthZEPRLt0Y4FnH22
 KISP6MJVf1Zc0UajKbfnQU774gLMOQgTnelCoF8TQhNcAkexXVbLMn5yUu9uMcd81anI
 kY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5+kOs0teFFCsk+a/XyNTZMVCXSHzbGikT6RQ04d9kmY=;
 b=cJCRHls7B3dV9K2UTi/qZAJDwh/sZknbbxZK2CalLTWGLMpz+F1J+9kZy5C5FLxrku
 +zGLUgZEOtKma1IcX/BAJTtHjKuPBF9WaX+SgKETKm43L1oPYidMCt1z3+WnRp5ObXXg
 0gcwCl/VV7GzW6gKWBvneFm3R0yTNizwtNJ3krDvvRVLgKWguQMXEk0/pwFldO36pZYW
 EDxxtvTh2zOUj0fG5s/Xi1igDmmsVaIOszIKSxfvbS23eHOEXy958rK+CS6iIFWURJCW
 SCHjsWQ7VOm3/+zjBv0rdiUTIpFw5eMZvcvOIAqcAUWy8tLmo+cTItTyJ/5cY/yT4rFy
 Wddg==
X-Gm-Message-State: APjAAAW9vRvH5KvP8/w0Fo/YFVF/N0PmPd0Zj7xIDbh3aCnjIL9V2PPU
 FvJYA0GVi1TTzn3CSzpjqR3r6hzB2Qjp/A==
X-Google-Smtp-Source: APXvYqyOohthrxWnGik5zasXDdB+uKHGD6lnwEGBmLrFdAe791fxNQP4Q3A58oSnUTXfZ4J4JDlaKw==
X-Received: by 2002:a5d:5705:: with SMTP id a5mr27499379wrv.112.1571069087773; 
 Mon, 14 Oct 2019 09:04:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/68] hw/timer/imx_gpt.c: Switch to transaction-based ptimer
 API
Date: Mon, 14 Oct 2019 17:03:17 +0100
Message-Id: <20191014160404.19553-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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

Switch the imx_epit.c code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-19-peter.maydell@linaro.org
---
 hw/timer/imx_gpt.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index c535d191292..5c0d9a269ce 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -16,7 +16,6 @@
 #include "hw/irq.h"
 #include "hw/timer/imx_gpt.h"
 #include "migration/vmstate.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
 
@@ -127,6 +126,7 @@ static const IMXClk imx7_gpt_clocks[] = {
     CLK_NONE,      /* 111 not defined */
 };
 
+/* Must be called from within ptimer_transaction_begin/commit block */
 static void imx_gpt_set_freq(IMXGPTState *s)
 {
     uint32_t clksrc = extract32(s->cr, GPT_CR_CLKSRC_SHIFT, 3);
@@ -167,6 +167,7 @@ static inline uint32_t imx_gpt_find_limit(uint32_t count, uint32_t reg,
     return timeout;
 }
 
+/* Must be called from within ptimer_transaction_begin/commit block */
 static void imx_gpt_compute_next_timeout(IMXGPTState *s, bool event)
 {
     uint32_t timeout = GPT_TIMER_MAX;
@@ -313,6 +314,7 @@ static uint64_t imx_gpt_read(void *opaque, hwaddr offset, unsigned size)
 
 static void imx_gpt_reset_common(IMXGPTState *s, bool is_soft_reset)
 {
+    ptimer_transaction_begin(s->timer);
     /* stop timer */
     ptimer_stop(s->timer);
 
@@ -350,6 +352,7 @@ static void imx_gpt_reset_common(IMXGPTState *s, bool is_soft_reset)
     if (s->freq && (s->cr & GPT_CR_EN)) {
         ptimer_run(s->timer, 1);
     }
+    ptimer_transaction_commit(s->timer);
 }
 
 static void imx_gpt_soft_reset(DeviceState *dev)
@@ -382,6 +385,7 @@ static void imx_gpt_write(void *opaque, hwaddr offset, uint64_t value,
             imx_gpt_soft_reset(DEVICE(s));
         } else {
             /* set our freq, as the source might have changed */
+            ptimer_transaction_begin(s->timer);
             imx_gpt_set_freq(s);
 
             if ((oldreg ^ s->cr) & GPT_CR_EN) {
@@ -397,12 +401,15 @@ static void imx_gpt_write(void *opaque, hwaddr offset, uint64_t value,
                     ptimer_stop(s->timer);
                 }
             }
+            ptimer_transaction_commit(s->timer);
         }
         break;
 
     case 1: /* Prescaler */
         s->pr = value & 0xfff;
+        ptimer_transaction_begin(s->timer);
         imx_gpt_set_freq(s);
+        ptimer_transaction_commit(s->timer);
         break;
 
     case 2: /* SR */
@@ -414,13 +421,16 @@ static void imx_gpt_write(void *opaque, hwaddr offset, uint64_t value,
         s->ir = value & 0x3f;
         imx_gpt_update_int(s);
 
+        ptimer_transaction_begin(s->timer);
         imx_gpt_compute_next_timeout(s, false);
+        ptimer_transaction_commit(s->timer);
 
         break;
 
     case 4: /* OCR1 -- output compare register */
         s->ocr1 = value;
 
+        ptimer_transaction_begin(s->timer);
         /* In non-freerun mode, reset count when this register is written */
         if (!(s->cr & GPT_CR_FRR)) {
             s->next_timeout = GPT_TIMER_MAX;
@@ -429,6 +439,7 @@ static void imx_gpt_write(void *opaque, hwaddr offset, uint64_t value,
 
         /* compute the new timeout */
         imx_gpt_compute_next_timeout(s, false);
+        ptimer_transaction_commit(s->timer);
 
         break;
 
@@ -436,7 +447,9 @@ static void imx_gpt_write(void *opaque, hwaddr offset, uint64_t value,
         s->ocr2 = value;
 
         /* compute the new timeout */
+        ptimer_transaction_begin(s->timer);
         imx_gpt_compute_next_timeout(s, false);
+        ptimer_transaction_commit(s->timer);
 
         break;
 
@@ -444,7 +457,9 @@ static void imx_gpt_write(void *opaque, hwaddr offset, uint64_t value,
         s->ocr3 = value;
 
         /* compute the new timeout */
+        ptimer_transaction_begin(s->timer);
         imx_gpt_compute_next_timeout(s, false);
+        ptimer_transaction_commit(s->timer);
 
         break;
 
@@ -484,15 +499,13 @@ static void imx_gpt_realize(DeviceState *dev, Error **errp)
 {
     IMXGPTState *s = IMX_GPT(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    QEMUBH *bh;
 
     sysbus_init_irq(sbd, &s->irq);
     memory_region_init_io(&s->iomem, OBJECT(s), &imx_gpt_ops, s, TYPE_IMX_GPT,
                           0x00001000);
     sysbus_init_mmio(sbd, &s->iomem);
 
-    bh = qemu_bh_new(imx_gpt_timeout, s);
-    s->timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+    s->timer = ptimer_init(imx_gpt_timeout, s, PTIMER_POLICY_DEFAULT);
 }
 
 static void imx_gpt_class_init(ObjectClass *klass, void *data)
-- 
2.20.1


