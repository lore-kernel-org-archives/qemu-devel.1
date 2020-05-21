Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388D3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F133C207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qFbw3Unt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F133C207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqmq-0007rS-3X
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgI-0002gp-Bc
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:38 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgH-0000SJ-Az
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:37 -0400
Received: by mail-wr1-x433.google.com with SMTP id x14so2391322wrp.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=7HVyutZ+jChpWjaCI3psmvFBqjyzPdDDfNGC17h6AVA=;
 b=qFbw3Untmnfv7tRO+0usM6XxrlCUxMUg0b6chY+1yLx0yPHyL5SAZbM+ABHeC209wX
 vHTknaYu0bFHv+KV40+H9RSQ8hhRl7ugNFGjaGVrBMKxs1ixRhYYUMHXwlo8IjY2P7rc
 QYY36Zr9tNDwN6yxvxqcsxQTzGwUhzIxnKjHOw95v/MkxTL2nvBFYxFv/4qBJ9KX/rTg
 ifyO7UMvDifTNWruwHArgCEXS74gngVBCcIjfXga01W9wfWcKdvOq8KwpkKQOj+nN5KE
 w7j70AkNmUkzQhnDgxR1x/lNpu7k3WOaUbmXIk1uZXQjrxmZ67pFQeAAT3MqeuU3I/BO
 KeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7HVyutZ+jChpWjaCI3psmvFBqjyzPdDDfNGC17h6AVA=;
 b=ob9VKZsMyltzUtTTQHbVMDV1QDkiDlgHMkwAZnyWUuIn22MwmeER/8iXmBIdNOUn20
 q74Hn3cDZa/htizf6Fmq/5zb7B335SbZHI+K4zTjOZc4QY7uSMMfbz27qb9mHqOypZ0G
 uuONJIGVBz7NuBbvDXp7caZrgIyvZNVIJt71a0/FVUpTshkDpm0NXC2PKULaIdRbEWt6
 6V2tGtFc5vnNpaXhn2zdSZudWmOxTYsHZ40Y/1DcFe6GJwwE3S2K35cXdaBu2fVd83f8
 di0jxvGfMhF3MVB8Ecj3PiV8v17kmJCJrsVS9kBCMUC94Y3qmLXd7eF5AK/bciTyIZCu
 Xijw==
X-Gm-Message-State: AOAM532X0OnE/6jc9mAxvJmwqZc1gn+zJU9FEE0MCLB70pYhHV+LiCXs
 PurdwDlVxugnux/jHoLcwMETlMjlk0LKNg==
X-Google-Smtp-Source: ABdhPJw3KkGWki159pId6Oc5FTOIW8nbDmqX7fmh0doL+s1dJ7tUHzDgR6JBfsxqwmFE2Ik0FxOULg==
X-Received: by 2002:adf:e38e:: with SMTP id e14mr123880wrm.2.1590088595632;
 Thu, 21 May 2020 12:16:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/29] hw/arm/fsl-imx7: Connect watchdog interrupts
Date: Thu, 21 May 2020 20:16:00 +0100
Message-Id: <20200521191610.10941-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

From: Guenter Roeck <linux@roeck-us.net>

i.MX7 supports watchdog pretimeout interupts. With this commit,
the watchdog in mcimx7d-sabre is fully operational, including
pretimeout support.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200517162135.110364-9-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx7.h |  5 +++++
 hw/arm/fsl-imx7.c         | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 47826da2b7e..da977f9ffb4 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -228,6 +228,11 @@ enum FslIMX7IRQs {
     FSL_IMX7_USB2_IRQ     = 42,
     FSL_IMX7_USB3_IRQ     = 40,
 
+    FSL_IMX7_WDOG1_IRQ    = 78,
+    FSL_IMX7_WDOG2_IRQ    = 79,
+    FSL_IMX7_WDOG3_IRQ    = 10,
+    FSL_IMX7_WDOG4_IRQ    = 109,
+
     FSL_IMX7_PCI_INTA_IRQ = 125,
     FSL_IMX7_PCI_INTB_IRQ = 124,
     FSL_IMX7_PCI_INTC_IRQ = 123,
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index d6cf7c48ce8..89c3b64c066 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -447,11 +447,22 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_WDOG3_ADDR,
             FSL_IMX7_WDOG4_ADDR,
         };
+        static const int FSL_IMX7_WDOGn_IRQ[FSL_IMX7_NUM_WDTS] = {
+            FSL_IMX7_WDOG1_IRQ,
+            FSL_IMX7_WDOG2_IRQ,
+            FSL_IMX7_WDOG3_IRQ,
+            FSL_IMX7_WDOG4_IRQ,
+        };
 
+        object_property_set_bool(OBJECT(&s->wdt[i]), true, "pretimeout-support",
+                                 &error_abort);
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",
                                  &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX7_WDOGn_ADDR[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                                            FSL_IMX7_WDOGn_IRQ[i]));
     }
 
     /*
-- 
2.20.1


