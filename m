Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D32C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 17:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BD92072A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 17:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHL1LiwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BD92072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDAdr-0006wB-8o
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 13:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jDAZh-0007yw-SE
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 13:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jDAZg-00060x-VY
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 13:27:49 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jDAZg-0005xe-Q2; Sat, 14 Mar 2020 13:27:48 -0400
Received: by mail-pf1-x444.google.com with SMTP id z5so7234199pfn.5;
 Sat, 14 Mar 2020 10:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uMwnmEuF5Y8jPd9tVsNDLLbIXVTOBvYkJ9PsjsTPLY4=;
 b=ZHL1LiwTHs6mJZrtUcuXit7WZZkpwd2l3Yg0GvM22XqDdFmELwaMh1Pk2Nr+lCqzSZ
 DinyRKKOL3AFqIQJyr8wovp8LqsBqIoHtz/D2ER8zoDkWNcDTjR92WAmvOMZtgriRni/
 Zd9na3E8Emu0Ebj+FAhTnnmDiYKYlqkVsEcyiYK6B/0zTBhc/Q/WPugeuARRrTmPtHlL
 LJcP8qZOOSJ/H2ujf1fi5TM/bxbUmKP33Fc3/fyhR4OuPusq5Z+UDc5QeRRRnR05IwU9
 VAQ7audGgdd+d/xVanun6FlG3GdG4DtNHgBnSljVxgTjL+TZRb+/IaXbm1dEip33a3N7
 79/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=uMwnmEuF5Y8jPd9tVsNDLLbIXVTOBvYkJ9PsjsTPLY4=;
 b=iYFc9xUN8XAXiH2NCo8CFaMxh25Ubs7165bossG1AtrQbyID96hT7r7lNysC1gWx7V
 cORpBuxZxOl4xuXLJBlDV570pHAWuabkmH4YgFwZC58A8M7S3wt9kKnvkuDIpYs+ue7+
 1fbTlchXnmze4EnLTqCT/mEtTpmZYFWmScf18XGFsAGswrShntVCO7QQdTyJwfP1WyFA
 C32Iz2pcirmFRogX82X16vAR3EfOiGngNC7dJjhXfQsAJ36I0U8oVt/bkgVY7GgkWacY
 YPP+CG3BhG3ieXrCmZwpWirw38Pio7Vfr1RjkMAh7al9qMj4jV0w7XD2/yeYIbohkXAA
 lB6w==
X-Gm-Message-State: ANhLgQ2nWe7Ks/Rn1EBDU+F5iDg05R04mlgVqoB+r0v+X0YzH/3VCbQF
 LBsUroqrs8obiGjAxjtf7y4=
X-Google-Smtp-Source: ADFU+vsneYpS+YnmNqsU6ljnbrjTAEoPywgsK56hwOBBeNT0l7PpY+NE+fJJNasG0GryvwnrZgEc4Q==
X-Received: by 2002:a63:770d:: with SMTP id s13mr18575417pgc.7.1584206867782; 
 Sat, 14 Mar 2020 10:27:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id p14sm57780824pgm.49.2020.03.14.10.27.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 14 Mar 2020 10:27:47 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 6/8] hw/arm/fsl-imx6ul: Connect watchdog interrupts
Date: Sat, 14 Mar 2020 10:27:34 -0700
Message-Id: <20200314172736.24528-7-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314172736.24528-1-linux@roeck-us.net>
References: <20200314172736.24528-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this commit, the watchdog on mcimx6ul-evk is fully operational,
including pretimeout support.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/fsl-imx6ul.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index c405b68d1d..8d3b91dd85 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -496,12 +496,22 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_WDOG2_ADDR,
             FSL_IMX6UL_WDOG3_ADDR,
         };
+        static const int FSL_IMX6UL_WDOGn_IRQ[FSL_IMX6UL_NUM_WDTS] = {
+            FSL_IMX6UL_WDOG1_IRQ,
+            FSL_IMX6UL_WDOG2_IRQ,
+            FSL_IMX6UL_WDOG3_IRQ,
+        };
 
+        object_property_set_bool(OBJECT(&s->wdt[i]), true, "pretimeout-support",
+                                 &error_abort);
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",
                                  &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
                         FSL_IMX6UL_WDOGn_ADDR[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                                            FSL_IMX6UL_WDOGn_IRQ[i]));
     }
 
     /*
-- 
2.17.1


