Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16F8C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE2620637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N0a1uH7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE2620637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tbd-0007em-SE
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tP6-0003Ru-1p
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tP4-0002Ge-Ob
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:19 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:38032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tP4-0002F7-Hf
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:18 -0500
Received: by mail-wm1-x331.google.com with SMTP id u9so6432649wml.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=WBubcm43hZcBFxzyb7e4AboA5LBFrKCvg3PbaEHjM5U=;
 b=N0a1uH7Y2UzJakzCzlzWALcLXVi7TOQhgU/Ojxs0yB/A2UKDXyD+TnMhNp+Z1WoAR/
 P00rHiPFL5XHauhlBbVTRLCamnyXlFWVo2O4E2IfZOnxhxhh9dqD/Hv2yhI0T/CoY8Z4
 oPU6hAauS3NYvAIm+cWShrWRZhzMbRXtkxJfO9nr/4rmrgJJXqBNNeUo0it5kU2vMwvg
 /1boaYjFjCUKNPAl09CJy3Ku/iEuvCQ5FZRzdQxTPv1+TWd9bUre9gtK/Tv3CBi26ETR
 ualmbs0aDzCqoZzwGCr1uaYUl7Njyyx49SOoCbX/xELMb/jaDpq2pkrPTWRHuJyWjxX1
 n5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WBubcm43hZcBFxzyb7e4AboA5LBFrKCvg3PbaEHjM5U=;
 b=kW2wGqTF8nK+jtqwKsgUYXEd8xLX14dpq9mgEgGb2Hc6ZhlCwVpUhNqTSSfJ4otHEA
 rS7MLCKgg9yWmyFNXEEMEbyfUHEkZpD+yFv2Y0dwhODcX8sINlkJ6mqir9TiKRoOsbxl
 oHYwBzmEjqHuJ9f3NRyHYnNyGVtYx8/XOLYPwHWwlrJTxF7oC6o5TcCkU6VtQUJ7jKQb
 3da/3KVMCX3neOOySUD6ueD9n3/fGo8bJ0c3m/SEZLjoMKcGGPX5A7GgBeR2Sf+4br/G
 Qls4/BC57kxiNwVcWO9GEegfSbMjMKUkKAegT0LC/PjP4Z37dFf+jS2tcO2vZasL02/4
 7YpQ==
X-Gm-Message-State: ANhLgQ2tDJDYAOHQa93ysj0eF8GS0UXdrh6991l8me6iu0fpA/7bm9Cz
 h7udbNhgfRPHjK4ws86HSOvLXz4jv/oeHA==
X-Google-Smtp-Source: ADFU+vsFkDCCNv8FBWpbIXcTB9AD6o+4pIUSR+N/D6PT7jlsrB9CIlhIOod+G9IiW+h4MpH9ujGBcg==
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr6282568wmm.91.1583425876750; 
 Thu, 05 Mar 2020 08:31:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/37] hw/arm/strongarm: move timer_new from init() into
 realize() to avoid memleaks
Date: Thu,  5 Mar 2020 16:30:36 +0000
Message-Id: <20200305163100.22912-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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

From: Pan Nengyuan <pannengyuan@huawei.com>

There are some memleaks when we call 'device_list_properties'. This patch move timer_new from init into realize to fix it.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-id: 20200227025055.14341-5-pannengyuan@huawei.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/strongarm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index cd8a99aaf2e..3010d765bb7 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -399,9 +399,6 @@ static void strongarm_rtc_init(Object *obj)
     s->last_rcnr = (uint32_t) mktimegm(&tm);
     s->last_hz = qemu_clock_get_ms(rtc_clock);
 
-    s->rtc_alarm = timer_new_ms(rtc_clock, strongarm_rtc_alarm_tick, s);
-    s->rtc_hz = timer_new_ms(rtc_clock, strongarm_rtc_hz_tick, s);
-
     sysbus_init_irq(dev, &s->rtc_irq);
     sysbus_init_irq(dev, &s->rtc_hz_irq);
 
@@ -410,6 +407,13 @@ static void strongarm_rtc_init(Object *obj)
     sysbus_init_mmio(dev, &s->iomem);
 }
 
+static void strongarm_rtc_realize(DeviceState *dev, Error **errp)
+{
+    StrongARMRTCState *s = STRONGARM_RTC(dev);
+    s->rtc_alarm = timer_new_ms(rtc_clock, strongarm_rtc_alarm_tick, s);
+    s->rtc_hz = timer_new_ms(rtc_clock, strongarm_rtc_hz_tick, s);
+}
+
 static int strongarm_rtc_pre_save(void *opaque)
 {
     StrongARMRTCState *s = opaque;
@@ -451,6 +455,7 @@ static void strongarm_rtc_sysbus_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "StrongARM RTC Controller";
     dc->vmsd = &vmstate_strongarm_rtc_regs;
+    dc->realize = strongarm_rtc_realize;
 }
 
 static const TypeInfo strongarm_rtc_sysbus_info = {
@@ -1240,15 +1245,16 @@ static void strongarm_uart_init(Object *obj)
                           "uart", 0x10000);
     sysbus_init_mmio(dev, &s->iomem);
     sysbus_init_irq(dev, &s->irq);
-
-    s->rx_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, strongarm_uart_rx_to, s);
-    s->tx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, strongarm_uart_tx, s);
 }
 
 static void strongarm_uart_realize(DeviceState *dev, Error **errp)
 {
     StrongARMUARTState *s = STRONGARM_UART(dev);
 
+    s->rx_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                       strongarm_uart_rx_to,
+                                       s);
+    s->tx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, strongarm_uart_tx, s);
     qemu_chr_fe_set_handlers(&s->chr,
                              strongarm_uart_can_receive,
                              strongarm_uart_receive,
-- 
2.20.1


