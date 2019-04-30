Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB737C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 04:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80ECF2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 04:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMNy+O1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80ECF2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39029 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLKcd-0008UH-PT
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 00:44:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hLKZv-0006sC-Fx
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 00:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hLKZu-0002jp-8P
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 00:41:15 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joel.stan@gmail.com>)
	id 1hLKZo-0002fr-38; Tue, 30 Apr 2019 00:41:08 -0400
Received: by mail-pl1-x641.google.com with SMTP id z8so6152932pln.4;
	Mon, 29 Apr 2019 21:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=MI5nCh4/5B0Sz0tu7042172x5DdKFcjyfCPFDvMLqR4=;
	b=FMNy+O1qySsuJAVz3CQRoGWAKXFpdv1X6ytiDGe1oy245bXcMChEys5ecET2cQ6eTp
	GHDtrUhncGDOBvC6sVtmueEh5oM05SrWB1qcMH1/2e/vFJDyTnwx/9iBYWZhCQ+X3GJS
	1rJ0o8iR8gcSenxcUNpUgUxUy60nbQLJ75yOleCBfLjOB5e71lf708wN4nOvCXttLrTv
	XW9LHhe493v+6wgOBinKa4HPv4HU/D4bSqofOcK154suuqNcdYZgYWp/xt8hnLb5Qor+
	PsU1SOyv0S0xFyUzaO/cw9Y6zgy1z8WQd1Q/ldMvk7iP6G4wV9e4X+eMCKil1TJpXb1T
	TSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=MI5nCh4/5B0Sz0tu7042172x5DdKFcjyfCPFDvMLqR4=;
	b=B5AA3kfI3+GIvyWpk056m49+izV28gft6Bz0iARdfwN/TAWkFC/BFObQ6uzU9TzSKX
	2EvR6YHelqxuACXJ76lvLXOLpnmVHIgOykEVVhb33n3luOpYnaKT3+C1HUxpKSOMOdpA
	9ARdzb+v2VUGsjISNAIeQITtJmRA4/VkaBEaGywitbUuOPanFkEifIhEOoDrJmjknFua
	CypyLK1jIftSlE8Tah8EYlJXhb4ty54bYk6n8hwqOn3QnaJ6+QsEBc25G6AOUhw4aDXj
	uIN8yKB+gJNJsJ7O2JVU2g/1DFT7thpqqQ+wpzUI9Ux8w++j/049zaCCg9NXAJwK/thj
	pj3Q==
X-Gm-Message-State: APjAAAVqtcb4fAwr9rQZudLOxKA9daGNh1Nv86Evvc0FCYz30b4ABMG5
	u831VaV5zkW2UFo3kza6rgo=
X-Google-Smtp-Source: APXvYqy+5++HsMw8idbOTW220U56XlyhPT0wX79jVHhkri1PVOZVeIMk41gbMRFKr0pZd02u7M8Wog==
X-Received: by 2002:a17:902:822:: with SMTP id
	31mr65976607plk.41.1556599266736; 
	Mon, 29 Apr 2019 21:41:06 -0700 (PDT)
Received: from voyager.jms.id.au ([45.124.203.18])
	by smtp.gmail.com with ESMTPSA id
	d5sm14411227pgb.33.2019.04.29.21.41.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 29 Apr 2019 21:41:06 -0700 (PDT)
Received: by voyager.jms.id.au (sSMTP sendmail emulation);
	Tue, 30 Apr 2019 14:10:59 +0930
From: Joel Stanley <joel@jms.id.au>
To: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 30 Apr 2019 14:10:35 +0930
Message-Id: <20190430044036.1144-3-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430044036.1144-1-joel@jms.id.au>
References: <20190430044036.1144-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v3 2/2] hw/arm/aspeed: Add RTC to SoC
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430044035.BHxlLOCBza8iKxRAajuYjZdQvtESdmWv0sYhFvwMlgk@z>

All systems have an RTC.

The IRQ is hooked up but the model does not use it at this stage. There
is no guest code that uses it, so this limitation is acceptable.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3: Add commit message
v2: Rebase on Cedric's patches (20190411161013.4514-4-clg@kaod.org)
---
 hw/arm/aspeed_soc.c         | 13 +++++++++++++
 include/hw/arm/aspeed_soc.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 110956828c44..ea9700c35bc4 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -229,6 +229,9 @@ static void aspeed_soc_init(Object *obj)
     sysbus_init_child_obj(obj, "vic", OBJECT(&s->vic), sizeof(s->vic),
                           TYPE_ASPEED_VIC);
 
+    sysbus_init_child_obj(obj, "rtc", OBJECT(&s->rtc), sizeof(s->rtc),
+                          TYPE_ASPEED_RTC);
+
     sysbus_init_child_obj(obj, "timerctrl", OBJECT(&s->timerctrl),
                           sizeof(s->timerctrl), TYPE_ASPEED_TIMER);
     object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
@@ -315,6 +318,16 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
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
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index eda9094660b5..d124674f25d8 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -17,6 +17,7 @@
 #include "hw/misc/aspeed_scu.h"
 #include "hw/misc/aspeed_sdmc.h"
 #include "hw/timer/aspeed_timer.h"
+#include "hw/timer/aspeed_rtc.h"
 #include "hw/i2c/aspeed_i2c.h"
 #include "hw/ssi/aspeed_smc.h"
 #include "hw/watchdog/wdt_aspeed.h"
@@ -33,6 +34,7 @@ typedef struct AspeedSoCState {
     ARMCPU cpu;
     MemoryRegion sram;
     AspeedVICState vic;
+    AspeedRtcState rtc;
     AspeedTimerCtrlState timerctrl;
     AspeedI2CState i2c;
     AspeedSCUState scu;
-- 
2.20.1


