Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A837C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4832133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLwOUK0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4832133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK38s-0003vF-05
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pq-0003pE-Kp
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pp-00079v-F2
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:38 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36788)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2pp-00079A-95
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:37 -0400
Received: by mail-wr1-x442.google.com with SMTP id y19so20399321wrd.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=MPwTcMBQ1S4get8cdHWOjMJ/U+e/1QSjXd8MI5RrTyI=;
 b=XLwOUK0CXj/Uk79M6/LLCLvERS+d7J2KlvqW8V37nNN0knqUK7Flc/gPYL7fyiqQtM
 Ud11Xl5j/XKEO2/dJI1OtL4ZM3cIUj04XUt+7b/QAUzrpenc79gmvvGPvXzDD6HP/gz+
 hDvSgGue6lMpvuEATeWJohjYaGVOg8uGY1Sl7YSNw75DcDrZmMuW54KIghyf4TWpb+Ux
 7s+A305Rz/itLJhmrTOEFd+r41DLIK6LliwmuljJmq18QyWe2TfpntgjrJ1z3LV5sgQf
 gdvfzMf3SYS1ltB3gux/49+u4ZHl6gte00Xux/2P3Id9eWAFcTKldaa3OY7Vk5gR4018
 diGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MPwTcMBQ1S4get8cdHWOjMJ/U+e/1QSjXd8MI5RrTyI=;
 b=UFzkhPhGr173hJZlm8BH69ryBAqdzBy7zx/hhP2vWoBaJOHC2gLnc4yWN3nKGXYWCC
 55QGciGR6yvc1fFKQqc/mRcvC8LqGrJ64ysgqpkq1NoKKlg47kOWZXdJ98zqOnlj61Hf
 2hH0c7aFu3tbrkQZUapAcFQ7Hrfl2jbTYw5uklDwfoXrQa4Or7kjVfvIi5w1lVRIGmCW
 KqJmcjntGKi5hZEcSz0GdXCdFK07nSEd32+31ADLZ6W9eEVkOofaV7Xf1EZb1ERZVxdk
 45nx1AbqD6ra1u0gAJxE2hNdhsVJYohRC8YAL+sQD0clNn5zEQtbhSfIBgWhZNGoiaPU
 t64A==
X-Gm-Message-State: APjAAAU0aeGeDns98HYZ2MF9I9ANVT+0T7IsDAALnSlt1vhSFpaDSZKG
 RJAd27berT2x9W+iRNhhbPEz073hlZ5ejg==
X-Google-Smtp-Source: APXvYqwDecBIHwOecOb+5Z560v3/xWU5i4tEMiWGTI3zxL6y5SfVnr78SUCUFhJj+Nn5Ef7mIo8F4g==
X-Received: by 2002:a05:6000:18d:: with SMTP id
 p13mr3932123wrx.396.1571069075866; 
 Mon, 14 Oct 2019 09:04:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/68] hw/timer/digic-timer.c: Switch to transaction-based
 ptimer API
Date: Mon, 14 Oct 2019 17:03:09 +0100
Message-Id: <20191014160404.19553-14-peter.maydell@linaro.org>
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

Switch the digic-timer.c code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-11-peter.maydell@linaro.org
---
 hw/timer/digic-timer.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/timer/digic-timer.c b/hw/timer/digic-timer.c
index b111e1fe643..32612228daf 100644
--- a/hw/timer/digic-timer.c
+++ b/hw/timer/digic-timer.c
@@ -29,7 +29,6 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/ptimer.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
 
@@ -52,7 +51,9 @@ static void digic_timer_reset(DeviceState *dev)
 {
     DigicTimerState *s = DIGIC_TIMER(dev);
 
+    ptimer_transaction_begin(s->ptimer);
     ptimer_stop(s->ptimer);
+    ptimer_transaction_commit(s->ptimer);
     s->control = 0;
     s->relvalue = 0;
 }
@@ -93,16 +94,20 @@ static void digic_timer_write(void *opaque, hwaddr offset,
             break;
         }
 
+        ptimer_transaction_begin(s->ptimer);
         if (value & DIGIC_TIMER_CONTROL_EN) {
             ptimer_run(s->ptimer, 0);
         }
 
         s->control = (uint32_t)value;
+        ptimer_transaction_commit(s->ptimer);
         break;
 
     case DIGIC_TIMER_RELVALUE:
         s->relvalue = extract32(value, 0, 16);
+        ptimer_transaction_begin(s->ptimer);
         ptimer_set_limit(s->ptimer, s->relvalue, 1);
+        ptimer_transaction_commit(s->ptimer);
         break;
 
     case DIGIC_TIMER_VALUE:
@@ -125,17 +130,24 @@ static const MemoryRegionOps digic_timer_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static void digic_timer_tick(void *opaque)
+{
+    /* Nothing to do on timer rollover */
+}
+
 static void digic_timer_init(Object *obj)
 {
     DigicTimerState *s = DIGIC_TIMER(obj);
 
-    s->ptimer = ptimer_init_with_bh(NULL, PTIMER_POLICY_DEFAULT);
+    s->ptimer = ptimer_init(digic_timer_tick, NULL, PTIMER_POLICY_DEFAULT);
 
     /*
      * FIXME: there is no documentation on Digic timer
      * frequency setup so let it always run at 1 MHz
      */
+    ptimer_transaction_begin(s->ptimer);
     ptimer_set_freq(s->ptimer, 1 * 1000 * 1000);
+    ptimer_transaction_commit(s->ptimer);
 
     memory_region_init_io(&s->iomem, OBJECT(s), &digic_timer_ops, s,
                           TYPE_DIGIC_TIMER, 0x100);
-- 
2.20.1


