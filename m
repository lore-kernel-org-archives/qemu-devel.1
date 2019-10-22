Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D0ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0CD32064B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xRrPIVPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CD32064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuOB-0003vL-QC
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGZ-0002QE-6t
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGX-0001EM-SC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:03 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuGX-0001E5-MJ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:01 -0400
Received: by mail-wm1-x344.google.com with SMTP id q70so10126193wme.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=S/QCyLDKmYi4qFNoLejQGFlQ6w8d+jjMc7szR08wghI=;
 b=xRrPIVPZ492raVhjOCqPdOZNBB/RY8d64YbKQqsI629hGWLCQWpb8W4TZ8gz/PG0pS
 3gPZySL0YJxTfJ+OMxEmjEZI8xi4vZVKuIYZ6ABssfJ9l5jKwhC/Iwik59mCf28yQYb/
 fQx8ElmIIQA9EE8e3BPpEBouW2kN1NPgN+CRpOuSb/gaBkFw04u60H9X5CAuFIUxqmu5
 SQ4XvFeRuXoeG32e3FGtc64Q4+33WV6AW9bmJI7KA/5N6253uz56a7i5qH+poDfRpao5
 SxhOKnLXEA22oN969Kh6jX5fhuVWbdcoROfZVtDOljlzs8uMTNRwOkfafgqyS8FT4U6W
 os7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S/QCyLDKmYi4qFNoLejQGFlQ6w8d+jjMc7szR08wghI=;
 b=HBI0vTXPN9Z/2I1nAoyCqI4cjplfNPeTWyj6hKV28YvNxkSlZ8ZGAkkm5Kdm1jyp+/
 eTSu1dB9nLC6uoeylKxZBVl+1+ryt9XJYpz+1neZipXbnkWtriaVG5J4wMyfw3ahk2dL
 6J/A67gHgtoX0un8P5oxsqSFr+R2smQHb53hA95os132zE51TIAZTmWYzGYLVf+pJEnJ
 gR9ia0WdEqwlFnSGNyoROwtKl4bA16JJP1Ly5b91qmxrJAbBHfaecVmx+bju2yKh7ZzQ
 enuHeWMhwphBRrEitnr8CwJWigu49Tms02IL6Cpi2dpoL7/pXJoLSaOVfDn3FcHJz7Up
 1iMQ==
X-Gm-Message-State: APjAAAVFz2Uz9YTkCzC4VKJcNL8gx70Ct9lJA2CD7FIgggGmVK/SheCS
 ZdKlYcd2gOSu4PosqCdirIXvov4N+mc=
X-Google-Smtp-Source: APXvYqxkNNaDQuxYfNlqOi/fKGugdAK6m2Xono5C8gVB4Nn/7itB+etuw1JruDEhhgc/+Ms8ef220g==
X-Received: by 2002:a05:600c:225a:: with SMTP id
 a26mr3110214wmm.73.1571751120082; 
 Tue, 22 Oct 2019 06:32:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.31.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:31:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/41] hw/timer/altera_timer.c: Switch to transaction-based
 ptimer API
Date: Tue, 22 Oct 2019 14:31:01 +0100
Message-Id: <20191022133134.14487-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Switch the altera_timer code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20191017132905.5604-6-peter.maydell@linaro.org
---
 hw/timer/altera_timer.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/timer/altera_timer.c b/hw/timer/altera_timer.c
index ee32e0ec1ff..79fc381252d 100644
--- a/hw/timer/altera_timer.c
+++ b/hw/timer/altera_timer.c
@@ -19,7 +19,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
 
@@ -53,7 +52,6 @@ typedef struct AlteraTimer {
     MemoryRegion  mmio;
     qemu_irq      irq;
     uint32_t      freq_hz;
-    QEMUBH       *bh;
     ptimer_state *ptimer;
     uint32_t      regs[R_MAX];
 } AlteraTimer;
@@ -105,6 +103,7 @@ static void timer_write(void *opaque, hwaddr addr,
         break;
 
     case R_CONTROL:
+        ptimer_transaction_begin(t->ptimer);
         t->regs[R_CONTROL] = value & (CONTROL_ITO | CONTROL_CONT);
         if ((value & CONTROL_START) &&
             !(t->regs[R_STATUS] & STATUS_RUN)) {
@@ -115,10 +114,12 @@ static void timer_write(void *opaque, hwaddr addr,
             ptimer_stop(t->ptimer);
             t->regs[R_STATUS] &= ~STATUS_RUN;
         }
+        ptimer_transaction_commit(t->ptimer);
         break;
 
     case R_PERIODL:
     case R_PERIODH:
+        ptimer_transaction_begin(t->ptimer);
         t->regs[addr] = value & 0xFFFF;
         if (t->regs[R_STATUS] & STATUS_RUN) {
             ptimer_stop(t->ptimer);
@@ -126,6 +127,7 @@ static void timer_write(void *opaque, hwaddr addr,
         }
         tvalue = (t->regs[R_PERIODH] << 16) | t->regs[R_PERIODL];
         ptimer_set_limit(t->ptimer, tvalue + 1, 1);
+        ptimer_transaction_commit(t->ptimer);
         break;
 
     case R_SNAPL:
@@ -183,9 +185,10 @@ static void altera_timer_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    t->bh = qemu_bh_new(timer_hit, t);
-    t->ptimer = ptimer_init_with_bh(t->bh, PTIMER_POLICY_DEFAULT);
+    t->ptimer = ptimer_init(timer_hit, t, PTIMER_POLICY_DEFAULT);
+    ptimer_transaction_begin(t->ptimer);
     ptimer_set_freq(t->ptimer, t->freq_hz);
+    ptimer_transaction_commit(t->ptimer);
 
     memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t,
                           TYPE_ALTERA_TIMER, R_MAX * sizeof(uint32_t));
@@ -204,8 +207,10 @@ static void altera_timer_reset(DeviceState *dev)
 {
     AlteraTimer *t = ALTERA_TIMER(dev);
 
+    ptimer_transaction_begin(t->ptimer);
     ptimer_stop(t->ptimer);
     ptimer_set_limit(t->ptimer, 0xffffffff, 1);
+    ptimer_transaction_commit(t->ptimer);
     memset(t->regs, 0, sizeof(t->regs));
 }
 
-- 
2.20.1


