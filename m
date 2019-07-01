Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1591AC5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D679A20881
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qyWU7bY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D679A20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi840-0004qG-Rq
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60729)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4hQ-0002dm-UQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4hP-0006Is-FB
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:23:00 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:38483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4hP-0006Ig-81
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:22:59 -0400
Received: by mail-wr1-f44.google.com with SMTP id p11so4277358wro.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=j+8CvV6xVOR9giO4NQvCrXsJxw5VIv1X7DZKMX4Y4WU=;
 b=qyWU7bY0HECSPd1xHpHsFE5FEPm/XHyAq7jD7+alKGSSbN6DaXK1KbBmrfY21MnTzI
 xXnuAU3zdLRlWRVwzIKoePY2FoqUWeelY+dp/wBVvj91LEaW7296IlRv26a2xwoys8+K
 jtM89qTkU8lZCY/UNqJQ8I2GEhtWvE2q5HxovYKXl9RfRUWkWi2qptqSvWa58JFxPfwj
 r5HrJitDTzAsaneP20tAvy938fsfq39eTm40//ogLjERXMCCSdoSgwqVfD9dy379gyQN
 ollrMHmINcEMZsd6iw8N4kyyAmyWjfC45Sq9/WXCjxQF7fkFd/dJjLubyQbSWhfpEeQV
 Ivxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j+8CvV6xVOR9giO4NQvCrXsJxw5VIv1X7DZKMX4Y4WU=;
 b=g5i9mpsGwG5uDdokBwCq4xjQ3b+d1fNutUiMetj4n54cLjOF9r0vdEpvbdGXoRnc2u
 LLp4Pu964FCU5a1bSzak3FhMkBK8A43eJZeR+pvxylFvm9eIw7tLo+sVmSQDLohQaSMT
 FQkvk6KUu13OafpX/+GfQK85afRfiAlPRuOUIL0TkOoWNUoF6Cb0QOcEt9nY8B6VORBd
 ttJhq5i6rzkpOyIyiZozpw4+knh9cfzS7K5Cdfnrc3KEPNXaTGygA+eSaLLVlG/n9SxT
 p7qrGdnCmKbdr+Clj2zXPMcEUs6vZluzYmtmKEfXEKDvFCHbjif+viu3qlqOc+MPs3zX
 R3ww==
X-Gm-Message-State: APjAAAW7H+fKxwMCDgAplXKMMfS3ujefQI8CfjI+7mhvegj/EZr872iW
 NzOh2jZRAli4GhbbVH/eR22YN60IDMHVnQ==
X-Google-Smtp-Source: APXvYqyreM1V3fx9LjgFNxgju3wCWCeWZ1ah+AKjH3WJxZOjfbdZs+0m6glmG7Vo1au72l5uuIyKgw==
X-Received: by 2002:a5d:4941:: with SMTP id r1mr19002855wrs.225.1561999198558; 
 Mon, 01 Jul 2019 09:39:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.39.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:39:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:09 +0100
Message-Id: <20190701163943.22313-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.44
Subject: [Qemu-devel] [PULL 12/46] hw/arm/aspeed: Add RTC to SoC
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

From: Joel Stanley <joel@jms.id.au>

All systems have an RTC.

The IRQ is hooked up but the model does not use it at this stage. There
is no guest code that uses it, so this limitation is acceptable.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190618165311.27066-5-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed_soc.h |  2 ++
 hw/arm/aspeed_soc.c         | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 88b901d5dfa..fa0ba957a61 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -16,6 +16,7 @@
 #include "hw/misc/aspeed_scu.h"
 #include "hw/misc/aspeed_sdmc.h"
 #include "hw/timer/aspeed_timer.h"
+#include "hw/timer/aspeed_rtc.h"
 #include "hw/i2c/aspeed_i2c.h"
 #include "hw/ssi/aspeed_smc.h"
 #include "hw/watchdog/wdt_aspeed.h"
@@ -32,6 +33,7 @@ typedef struct AspeedSoCState {
     ARMCPU cpu;
     MemoryRegion sram;
     AspeedVICState vic;
+    AspeedRtcState rtc;
     AspeedTimerCtrlState timerctrl;
     AspeedI2CState i2c;
     AspeedSCUState scu;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 1cc98b9f404..5faa78d81fd 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -189,6 +189,9 @@ static void aspeed_soc_init(Object *obj)
     sysbus_init_child_obj(obj, "vic", OBJECT(&s->vic), sizeof(s->vic),
                           TYPE_ASPEED_VIC);
 
+    sysbus_init_child_obj(obj, "rtc", OBJECT(&s->rtc), sizeof(s->rtc),
+                          TYPE_ASPEED_RTC);
+
     sysbus_init_child_obj(obj, "timerctrl", OBJECT(&s->timerctrl),
                           sizeof(s->timerctrl), TYPE_ASPEED_TIMER);
     object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
@@ -275,6 +278,16 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->vic), 1,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
+    /* RTC */
+    object_property_set_bool(OBJECT(&s->rtc), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, sc->info->memmap[ASPEED_RTC]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
+                       aspeed_soc_get_irq(s, ASPEED_RTC));
+
     /* Timer */
     object_property_set_bool(OBJECT(&s->timerctrl), true, "realized", &err);
     if (err) {
-- 
2.20.1


