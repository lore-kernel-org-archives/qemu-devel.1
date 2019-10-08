Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FFBECE58C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC95217D7
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qRFXGLXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC95217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtHs-0000AP-7i
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7W-0006jA-WB
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7U-0002Hm-E1
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:58 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHt7T-0002Gk-JL
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:55 -0400
Received: by mail-wm1-x341.google.com with SMTP id r19so4028790wmh.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FS9XddmY4om6siRP8IpkPnxKBpobej+L3T9CfHmPAng=;
 b=qRFXGLXbvtyoSUzGEn+fj6yeidVCtQyNh/Q0vOwOOQVAT2XICV9O2mSbRv4HJZlmId
 me7/ylz6GbK326jqcbanI7chJnHWEjEGkDy4N6atU4IX5ywsOBjeamJ7Zz3ZxVA65lId
 tIblyRerbfmQMDTLGc06cXH2wSMgas4dUyTLrGDLnDdnE21Up/yavN7OQozCSVxVgElv
 SvXVCTYbtIkf4JPb+4dTPppoPYokScoPvqshavXeYk8MlEcGE8yhCUK38iUoSDe0dl9b
 GsO5kTN3NCTEDGgjEWlsRmfEwK4jyVZtlpJeriz25TP48YgwMQqe2rS3bBtrknyzFEo/
 A4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FS9XddmY4om6siRP8IpkPnxKBpobej+L3T9CfHmPAng=;
 b=VUyeRZK2eTO9l5jJosNpt4sPRT8fWmNyrB3d5PqAQGNSCE73sgHKF/LD/bPA13XPvI
 X4ICJc3ZlXPhbuFfhHhmLhzBKXQ3frgDXLeuVoRpZbSd3HjXzuIf0Hnyeh2BlYIwtkCa
 k1qy/elvh/8+z/BhIRDVVXgI/w5PbMW9KJ5E4shB9UJF0hmRfANNlGTep1kpaG3DNS8T
 MVr8FC/vdDqd0VKQ7A9043aPqWhBvjU6AOuMiY55viIKiIRS4LhJIUaQHkQK4p/4do++
 5WcVBFVXINl5LdKLnfgGYQbKWu1e8M2JodK1O8nZx05NMD2oty7QIBQjlkJXTg/08ra7
 3rEw==
X-Gm-Message-State: APjAAAXdnw9Zf+Zwl/mgHA+wQqdjVhgGu1jAhZ17LTAi/gs645LumMkr
 LLRT0lpsMT+bQfYCzupN9xzDUg==
X-Google-Smtp-Source: APXvYqwUzrBD+ZjtDnAb5Md/JBrYWCRoCeiZEXLpg6S3zvt629siptaW1fXinWJ+fPOYAqYZqLJ68A==
X-Received: by 2002:a1c:6a03:: with SMTP id f3mr4514443wmc.167.1570555074057; 
 Tue, 08 Oct 2019 10:17:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm19135541wrl.35.2019.10.08.10.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:17:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 08/21] hw/timer/cmsdk-apb-dualtimer.c: Switch to
 transaction-based ptimer API
Date: Tue,  8 Oct 2019 18:17:27 +0100
Message-Id: <20191008171740.9679-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008171740.9679-1-peter.maydell@linaro.org>
References: <20191008171740.9679-1-peter.maydell@linaro.org>
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the cmsdk-apb-dualtimer code away from bottom-half based
ptimers to the new transaction-based ptimer API.  This just requires
adding begin/commit calls around the various places that modify the
ptimer state, and using the new ptimer_init() function to create the
timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/cmsdk-apb-dualtimer.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/timer/cmsdk-apb-dualtimer.c b/hw/timer/cmsdk-apb-dualtimer.c
index 44d23c80364..e28ba9c90a8 100644
--- a/hw/timer/cmsdk-apb-dualtimer.c
+++ b/hw/timer/cmsdk-apb-dualtimer.c
@@ -20,7 +20,6 @@
 #include "qemu/log.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
@@ -112,6 +111,8 @@ static void cmsdk_dualtimermod_write_control(CMSDKAPBDualTimerModule *m,
     /* Handle a write to the CONTROL register */
     uint32_t changed;
 
+    ptimer_transaction_begin(m->timer);
+
     newctrl &= R_CONTROL_VALID_MASK;
 
     changed = m->control ^ newctrl;
@@ -213,6 +214,8 @@ static void cmsdk_dualtimermod_write_control(CMSDKAPBDualTimerModule *m,
     }
 
     m->control = newctrl;
+
+    ptimer_transaction_commit(m->timer);
 }
 
 static uint64_t cmsdk_apb_dualtimer_read(void *opaque, hwaddr offset,
@@ -330,6 +333,7 @@ static void cmsdk_apb_dualtimer_write(void *opaque, hwaddr offset,
             if (!(m->control & R_CONTROL_SIZE_MASK)) {
                 value &= 0xffff;
             }
+            ptimer_transaction_begin(m->timer);
             if (!(m->control & R_CONTROL_MODE_MASK)) {
                 /*
                  * In free-running mode this won't set the limit but will
@@ -346,6 +350,7 @@ static void cmsdk_apb_dualtimer_write(void *opaque, hwaddr offset,
                     ptimer_run(m->timer, 1);
                 }
             }
+            ptimer_transaction_commit(m->timer);
             break;
         case A_TIMER1BGLOAD:
             /* Set the limit, but not the current count */
@@ -357,7 +362,9 @@ static void cmsdk_apb_dualtimer_write(void *opaque, hwaddr offset,
             if (!(m->control & R_CONTROL_SIZE_MASK)) {
                 value &= 0xffff;
             }
+            ptimer_transaction_begin(m->timer);
             ptimer_set_limit(m->timer, value, 0);
+            ptimer_transaction_commit(m->timer);
             break;
         case A_TIMER1CONTROL:
             cmsdk_dualtimermod_write_control(m, value);
@@ -398,6 +405,7 @@ static void cmsdk_dualtimermod_reset(CMSDKAPBDualTimerModule *m)
     m->intstatus = 0;
     m->load = 0;
     m->value = 0xffffffff;
+    ptimer_transaction_begin(m->timer);
     ptimer_stop(m->timer);
     /*
      * We start in free-running mode, with VALUE at 0xffffffff, and
@@ -406,6 +414,7 @@ static void cmsdk_dualtimermod_reset(CMSDKAPBDualTimerModule *m)
      */
     ptimer_set_limit(m->timer, 0xffff, 1);
     ptimer_set_freq(m->timer, m->parent->pclk_frq);
+    ptimer_transaction_commit(m->timer);
 }
 
 static void cmsdk_apb_dualtimer_reset(DeviceState *dev)
@@ -450,10 +459,9 @@ static void cmsdk_apb_dualtimer_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < ARRAY_SIZE(s->timermod); i++) {
         CMSDKAPBDualTimerModule *m = &s->timermod[i];
-        QEMUBH *bh = qemu_bh_new(cmsdk_dualtimermod_tick, m);
 
         m->parent = s;
-        m->timer = ptimer_init_with_bh(bh,
+        m->timer = ptimer_init(cmsdk_dualtimermod_tick, m,
                                PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD |
                                PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT |
                                PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
-- 
2.20.1


