Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B58DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E08207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SbMhz/Lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E08207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tQz-0005s9-DC
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tP4-0003QE-KB
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tP2-0002ER-O5
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:18 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:53657)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tP2-0002Cz-Gm
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:16 -0500
Received: by mail-wm1-x329.google.com with SMTP id g134so7043542wme.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GAoBKDlZfxCwYkYrGHnP4g29Dujg66/yINbEGmDpBFY=;
 b=SbMhz/LzQEGinciFRS2RibMCmnMpc4yM1hwoVDo43pfN81w9hLjnpkeUNxReEo9Ak7
 AT4TW8z6bPKTjTNva0zP+rrfnocyj0B7fH6Qq+NHm6qoobl1xpd0U8KphzZZWSFeHacs
 6OQxYtfKzjhLMvBkkrbWAv16iD7I6i+nmlZzrslAZ1BtbbnSDI7TEIsO3nRksMjeFai7
 WJs4IFxcj4bTtevlli84HopAojPbCj9rtGtm09QfUmqI9raZXxFtJFdUMznQS7oc2DsN
 1H7g9ZUaxEAKUcz6c0OE6d4BZNjS+nn3lW0lN7TzVoSgmwtlfQ+umyIfw3hJful/GW3N
 Ca6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GAoBKDlZfxCwYkYrGHnP4g29Dujg66/yINbEGmDpBFY=;
 b=iltEX3YABWaJi0p8r3/L4aM0ElTmb5hnQlBUVua+ISS8rEr2VzxdsVgzZXr0O4W3Us
 H2ORi36yD53vGqHuGW40IMkz6HQ3dz4ght7A8sNgujQpX4lR6mjppsKXCABcKmRJyxzV
 Euhg65OVkGYX37TRe4T+PwDtccMXfxmqsYAIWVgHBq9HlYyQyZAyQjPPzSaBV1dR+pIc
 9iNEBl8SGhMXmjAr/8/fvaLDtMGQrZy7fMqqK5/u7Y39NlWJgCVwwb6MqYOQbGxrQ8Gr
 JwRqfVp5oHo0D6rIWUNSrUoQ1Tl0P9DX0XUIwsECvhHiM+v2GD8FA9UJ11o4cJGo/BED
 TKWg==
X-Gm-Message-State: ANhLgQ0N00lHTjiMGP+Xayy7wt/m/7VPgfLmpXEeWeMGL8VZqCQDcOm3
 HvSlECW+c0FdCCA2bSU5Vyah3tJMgYUMNQ==
X-Google-Smtp-Source: ADFU+vtgKIc5ohNp4lmALMiD1zOHW42Ht0TolAghhv1943wqZZ+uj3jwKDMIJsBRyvRrOH9z4Phg1Q==
X-Received: by 2002:a1c:a1c2:: with SMTP id k185mr1541615wme.164.1583425874807; 
 Thu, 05 Mar 2020 08:31:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/37] hw/arm/pxa2xx: move timer_new from init() into realize()
 to avoid memleaks
Date: Thu,  5 Mar 2020 16:30:34 +0000
Message-Id: <20200305163100.22912-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Message-id: 20200227025055.14341-3-pannengyuan@huawei.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/pxa2xx.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index b33f8f1351f..56a36202d71 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1134,18 +1134,22 @@ static void pxa2xx_rtc_init(Object *obj)
     s->last_rtcpicr = 0;
     s->last_hz = s->last_sw = s->last_pi = qemu_clock_get_ms(rtc_clock);
 
+    sysbus_init_irq(dev, &s->rtc_irq);
+
+    memory_region_init_io(&s->iomem, obj, &pxa2xx_rtc_ops, s,
+                          "pxa2xx-rtc", 0x10000);
+    sysbus_init_mmio(dev, &s->iomem);
+}
+
+static void pxa2xx_rtc_realize(DeviceState *dev, Error **errp)
+{
+    PXA2xxRTCState *s = PXA2XX_RTC(dev);
     s->rtc_hz    = timer_new_ms(rtc_clock, pxa2xx_rtc_hz_tick,    s);
     s->rtc_rdal1 = timer_new_ms(rtc_clock, pxa2xx_rtc_rdal1_tick, s);
     s->rtc_rdal2 = timer_new_ms(rtc_clock, pxa2xx_rtc_rdal2_tick, s);
     s->rtc_swal1 = timer_new_ms(rtc_clock, pxa2xx_rtc_swal1_tick, s);
     s->rtc_swal2 = timer_new_ms(rtc_clock, pxa2xx_rtc_swal2_tick, s);
     s->rtc_pi    = timer_new_ms(rtc_clock, pxa2xx_rtc_pi_tick,    s);
-
-    sysbus_init_irq(dev, &s->rtc_irq);
-
-    memory_region_init_io(&s->iomem, obj, &pxa2xx_rtc_ops, s,
-                          "pxa2xx-rtc", 0x10000);
-    sysbus_init_mmio(dev, &s->iomem);
 }
 
 static int pxa2xx_rtc_pre_save(void *opaque)
@@ -1203,6 +1207,7 @@ static void pxa2xx_rtc_sysbus_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "PXA2xx RTC Controller";
     dc->vmsd = &vmstate_pxa2xx_rtc_regs;
+    dc->realize = pxa2xx_rtc_realize;
 }
 
 static const TypeInfo pxa2xx_rtc_sysbus_info = {
-- 
2.20.1


