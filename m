Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713F4C3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF3420842
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N0vaTMbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF3420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isShC-0003FP-Ks
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbw-0006MF-HX
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbv-00076u-Bf
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:32 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44006)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isSbv-00075o-4t
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:31 -0500
Received: by mail-wr1-x443.google.com with SMTP id d16so22922164wre.10
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9ihMRZaqTi8wqlyYAIMxsLPUqHE0JADm0wdNtQRrCbs=;
 b=N0vaTMbWxUDE/fgqtC3RnZEDFQsCKZ/RXUH+WBhECfYTOtwGiLuEAxq2kp/8Y75X/C
 OhTHmk93ZLUTMXM6x3DGG8C/C6983ERmlNxt8wNeJuEi6oECBh3lO7pcoo7qdjlHEDmn
 WDtaHhXZLoqEFcxQ7FIwVXSEjWt2NvxNj4z7fZixg+HSe5a9Ecf9StaG9+AT3sxjK672
 ERZuhL/JdzBRKC7Iv5Yh5qjna+ZwLsUnP+yPPVnrw3PpU8utBjHE+FO81k2WLHGSHa+I
 DOBrakbFKreSVBJDA3eYHZohpmXJNU4P9Yq3yygqfv/tw+p2NMXa5kpWD7yVfg4aINJI
 HzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9ihMRZaqTi8wqlyYAIMxsLPUqHE0JADm0wdNtQRrCbs=;
 b=WiBZRhP6csRaoAdnCRU5QLAfvXOQDflg8AMBhB2u1og9nu6RpTUmxzJVMWCA0pDWG5
 TYh1X9kzT7UsbkQ4u62JRzrQVtgfR4cDnG751ZoQz4CISfRVIx/BCQfGn14s8WmjTVi8
 JatLN2+1/MQJjZt5d5FfcPmUNO8yMjnN07/hkdF5IAJy05O7xWQ4V96qhbexUhAv40tl
 8u6Z5+cwfJmn/FkUWL2ylXYIW9aCcRfIF0EWdCxQjAZY4xOUOFn6oD3z9MWqqmqSnTeK
 qBNHI17FjkbOnSo/Nx2Sa1tMkbgED0m0sjbckf5qEY+M86hBj9H+lH4fogUoIBvA3FLu
 2TOA==
X-Gm-Message-State: APjAAAXw2WAuVIM4WxMjJ5rXl6IS7vtaaniDw/k+qNa7IPhevxg1vJmc
 K3gKoml9hzOeCvy9kZMY+cFt/T8VvsmNUg==
X-Google-Smtp-Source: APXvYqwv8nzOO3bkLkivAKXPKwe4Ue/J5QbihhHQ1dglM3GENIAeTlPDvllA/8/wwZyRVDofBNAcUA==
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr3381084wrj.225.1579271309878; 
 Fri, 17 Jan 2020 06:28:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e18sm33811146wrw.70.2020.01.17.06.28.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 06:28:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/15] hw/arm/allwinner-a10: Remove local qemu_irq variables
Date: Fri, 17 Jan 2020 14:28:10 +0000
Message-Id: <20200117142816.15110-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117142816.15110-1-peter.maydell@linaro.org>
References: <20200117142816.15110-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We won't reuse the CPU IRQ/FIQ variables. Simplify by calling
qdev_get_gpio_in() in place.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20191230110953.25496-6-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/allwinner-a10.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 966fbd4a6e5..1cde1656116 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -55,7 +55,6 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
 {
     AwA10State *s = AW_A10(dev);
     SysBusDevice *sysbusdev;
-    qemu_irq fiq, irq;
     Error *err = NULL;
 
     object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
@@ -63,8 +62,6 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    irq = qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_IRQ);
-    fiq = qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ);
 
     object_property_set_bool(OBJECT(&s->intc), true, "realized", &err);
     if (err != NULL) {
@@ -73,8 +70,10 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     }
     sysbusdev = SYS_BUS_DEVICE(&s->intc);
     sysbus_mmio_map(sysbusdev, 0, AW_A10_PIC_REG_BASE);
-    sysbus_connect_irq(sysbusdev, 0, irq);
-    sysbus_connect_irq(sysbusdev, 1, fiq);
+    sysbus_connect_irq(sysbusdev, 0,
+                       qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_IRQ));
+    sysbus_connect_irq(sysbusdev, 1,
+                       qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
     qdev_pass_gpios(DEVICE(&s->intc), dev, NULL);
 
     object_property_set_bool(OBJECT(&s->timer), true, "realized", &err);
-- 
2.20.1


