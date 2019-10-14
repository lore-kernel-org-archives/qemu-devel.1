Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9C3C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CB52133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ha5CJmjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CB52133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK36X-0000SE-4c
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pn-0003k3-5R
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pl-00076U-UU
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38101)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2pl-00075g-Nx
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:33 -0400
Received: by mail-wm1-x344.google.com with SMTP id 3so17310653wmi.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Qb5xdshPqTBNbT/caOSYJnbTFPssgwP8+ogGepQjKkY=;
 b=ha5CJmjvMEcCpSYdMWBgm5q2GfikSstR15itZ8EH6UFOuiGIST1y9qr7VqTKiQgOYT
 ZwLsRwxDhGHYq7Z2UblWzY0cOR/X00Ea2sqo0fYmhrcjS2DRAN75w/q4et0dcckvjBf6
 bz1er8o7WvgBiyTPEwlSwncF55qNNu0pUXe8y3SNqKYQLt5uc6c/34X8x5BblZxGnR67
 YVWtfeYHMIBCFXZ8cJVNZMTQRLs2+CWZBS43TD/75e/IPpNinrhDrcRhP52NJKpB7Ia1
 3LfcN+Jn3f52ZHh2Vpji17j86p3fqJ7TXRoSVkzWVhaH7nb+TI4rxtl/jVZAdePqdy/Y
 riRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qb5xdshPqTBNbT/caOSYJnbTFPssgwP8+ogGepQjKkY=;
 b=ANhlCJqgOLnXGqmBShG+3sSqIXZH9FTKj0MZ28WiUeXDBgwJiVMjCBOx8LbYgTBn9a
 B2uWKZ4e5jurC8rpOsgAHwvtyMzLjp9VZvsDCAPhNiM49wanHvmdnBiOLEWcddlkj/M3
 SAclFQJqLpRBxyRjseBbFFrbX1gxp8PvPiRzc0crO9CmhcSGdHkDfnKZm4a1lwUIx1gz
 1BMqLD3F7jamGRMSS9PoxnFCMK/OIarRwQeEBsJUKf1oajZdmte8vqi0IceB3BGaZbA1
 a9rCYyYwpJ+5Lox9WIomeeRMl9iGhbo+QS54TiOXj3X3t4rJu4o2vUmanf6/TC8rH4G4
 Sk1g==
X-Gm-Message-State: APjAAAWKERVDyvDVA+8MZUz17OnPtziUqZktm4lwkwm+iEUXzb5RWoa4
 +nJ6NPO0Lyj3HeZpGm0AMJv7fAU+Ox9Vqw==
X-Google-Smtp-Source: APXvYqwpDdZhF27yRk9vkKj9xgSLCgu3QyucHmJ90efhfihNajyQy0ae/GjJnbElEFiTPIBGSE2GeA==
X-Received: by 2002:a7b:c1d2:: with SMTP id a18mr15846708wmj.7.1571069072159; 
 Mon, 14 Oct 2019 09:04:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/68] hw/timer/cmsdk-apb-dualtimer.c: Switch to
 transaction-based ptimer API
Date: Mon, 14 Oct 2019 17:03:07 +0100
Message-Id: <20191014160404.19553-12-peter.maydell@linaro.org>
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

Switch the cmsdk-apb-dualtimer code away from bottom-half based
ptimers to the new transaction-based ptimer API.  This just requires
adding begin/commit calls around the various places that modify the
ptimer state, and using the new ptimer_init() function to create the
timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-9-peter.maydell@linaro.org
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


