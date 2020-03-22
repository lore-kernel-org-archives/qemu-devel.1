Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B825FC1975A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6965A206F9
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOLjVnHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6965A206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG887-0003d1-L7
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 17:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jG80U-0002vj-3x
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jG80S-0002nm-86
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:19:42 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35974)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jG80S-0002mK-0A; Sun, 22 Mar 2020 17:19:40 -0400
Received: by mail-pl1-x641.google.com with SMTP id g2so5002316plo.3;
 Sun, 22 Mar 2020 14:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RjKWvLSfme9/CvcRWOHB/MHVHAgog5y4v9UlHjSka88=;
 b=KOLjVnHk1+FvrdaM95vLN6WPWJER60T+K8FtowdkzJOd+E4DsXLjdImJT9X+0kGxwO
 hLGLi7crGemAyCoyWu+nniHlDEQbhuDo4NZtUAvoMxiKZMdn7jVJVyjy1ikM7d41kab2
 YIf2BuQ0E99PCZ4HkfTFUuJM01nIPJ1LDGGWE4dzlFyrmZXe49t51M96CKgJp00upaS/
 e5IBwjWVs9ncGmtk6o9TauQq+pdkfcn0W3ZVhNklShFgz3yZaktgMyAAwTo7Roj04NZf
 /3s2rKeXFTiN1mbZFbPTxdt0dVzmEyET27teyS5YZ9pLufsaT2Mm6Q2XWDT2EqVthVUp
 +t+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=RjKWvLSfme9/CvcRWOHB/MHVHAgog5y4v9UlHjSka88=;
 b=XpZrtwVxa0u8Jqnf6+seq5VUGHNZ8M2b7BeW9B5jriraX0627/l7GKoiwE+KEUxLfS
 QPbjtICyTzKK7nLUCgt78gOjgJd2b+U2+mBdR0WJD275t6jVnZJSt3iq6eF6QA5ZaP9l
 FIKJIpbXtt5x6V8on1EUL9K375twInMkznKFrKWUAed7uf3DSKRIHnbMQBdWvVaWGGZE
 ALU7FiowuTUmXA6pZPhAXH6TaI5tZX5oTzFTFXtFZmOnCl4qpbeoFFKl4bP3+tpbU44V
 m+wZTl5qZFTPPxOgH2oVQZr8EUbd7BjedAQc90JUbp9plDqCSa4rkozVaSCBJDZSDxg/
 35yQ==
X-Gm-Message-State: ANhLgQ2BKaoNsxdgOOTQyspbLS0tSuE3BawftJek/Ye4+yPFqSb7A9Bg
 7fHjgk1zK8aqq7VXZXy5GkQ=
X-Google-Smtp-Source: ADFU+vvdGRUERgGzQ3GIJjAzU1bdfIyBMLNiRPaWoxFeNdodFny+wPNCtHv6nzaR/KRDSoo+RCKK6g==
X-Received: by 2002:a17:902:9f95:: with SMTP id
 g21mr18297457plq.66.1584911977824; 
 Sun, 22 Mar 2020 14:19:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id i6sm11604887pfe.62.2020.03.22.14.19.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 22 Mar 2020 14:19:37 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 8/8] hw/arm/fsl-imx7: Connect watchdog interrupts
Date: Sun, 22 Mar 2020 14:19:19 -0700
Message-Id: <20200322211919.11335-9-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322211919.11335-1-linux@roeck-us.net>
References: <20200322211919.11335-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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

i.MX7 supports watchdog pretimeout interupts. With this commit,
the watchdog in mcimx7d-sabre is fully operational, including
pretimeout support.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: No change

 hw/arm/fsl-imx7.c         | 11 +++++++++++
 include/hw/arm/fsl-imx7.h |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index d6cf7c48ce..89c3b64c06 100644
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
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 47826da2b7..da977f9ffb 100644
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
-- 
2.17.1


