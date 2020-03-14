Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98D7C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 17:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DE32072A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 17:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI3wVZCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DE32072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDAc2-0004eS-H8
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 13:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jDAZf-0007uK-8R
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 13:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jDAZe-0005fe-0r
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 13:27:47 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jDAZd-0005bN-RT; Sat, 14 Mar 2020 13:27:45 -0400
Received: by mail-pl1-x644.google.com with SMTP id g6so5823204plt.2;
 Sat, 14 Mar 2020 10:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=subG/z3bNILDIEvYewk5eSNFesd3qE7G7IFPvac0eEI=;
 b=NI3wVZCblmZ2Xq7P/3SbzDIFFrpFEZPoLDLihtIsO8fF9+E5br8dg+2PSuNlN4hdxM
 cPmD6Tp43fwsFayfn87VB0Vr3VuWfKNDUbIymOCzueuv5CXu72AA59SxLIr6VqMJu3Th
 vVQX2ko4QE5Ye+8nimEnswtoGoRcdi5/+B24DRRtgb4KCziVI+Hh+RGbZTLNL0mdERII
 JHkHlmC3mLWRINdSft8y+pBu+xmkKi8ZOKNk3w926ZLXZ4GdfIM3obTxU4wDYCmql1Yo
 SbIvbXZyOCE3dQy+tUGh869Df5Np/7WIp1y2IWUIocwxWkUFut4qyrt5cc62dRQYLBPd
 RH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=subG/z3bNILDIEvYewk5eSNFesd3qE7G7IFPvac0eEI=;
 b=dYb8EB97V2fTT+2MU63B8X6JdqszHS6ZuVp+mVoA1DK5SkzYVSp2F9r9YFiCNKhAIu
 plQYL3xsoAKAJzSWnFcRYi8dXR79KK8xt6y92JB8diiLaxJCed7gIVf+LJYHEKMLGCSw
 vxIp16DH+lz8CZVM6VbRdaoUt+T5lIAaOw3emKLwVCr6VoTshk4DkSJZDV7qqcwfrwri
 MpFQvuNfEEBjAaoGVxXvjv43OhcKqmP45DyarSSDB61vZ0EZc+ekwBDDf/DKSFHXFAs3
 Qg63+eV/18x//QP53DRTDlFP8eI2fCJ4ZuHl8Cvg1E6YOnG2Me1X+nMnUF2wcaxv6X7w
 PPmA==
X-Gm-Message-State: ANhLgQ0pr9X1EWNN0YECyO4eSZG02IfO+/PRKfHRf377rf79W6WmPDVd
 TOJ3Ei0EAQelxzhytro+z8A=
X-Google-Smtp-Source: ADFU+vu5kx8vBZXKOpz4inqal6ve8z3KD7WNh3fFc8ZdROVKASHMa5g7lTzl5dgJ0W2YpkYlGl7L7g==
X-Received: by 2002:a17:90a:1f0b:: with SMTP id
 u11mr2578087pja.18.1584206864938; 
 Sat, 14 Mar 2020 10:27:44 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id f3sm52268026pgg.46.2020.03.14.10.27.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 14 Mar 2020 10:27:44 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 4/8] hw/arm/fsl-imx31: Wire up watchdog
Date: Sat, 14 Mar 2020 10:27:32 -0700
Message-Id: <20200314172736.24528-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314172736.24528-1-linux@roeck-us.net>
References: <20200314172736.24528-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

With this patch, the watchdog on i.MX31 emulations is fully operational.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/fsl-imx31.c         | 6 ++++++
 include/hw/arm/fsl-imx31.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 55e90d104b..cec7d0dd1b 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -63,6 +63,8 @@ static void fsl_imx31_init(Object *obj)
         sysbus_init_child_obj(obj, "gpio[*]", &s->gpio[i], sizeof(s->gpio[i]),
                               TYPE_IMX_GPIO);
     }
+
+    sysbus_init_child_obj(obj, "wdt", &s->wdt, sizeof(s->wdt), TYPE_IMX2_WDT);
 }
 
 static void fsl_imx31_realize(DeviceState *dev, Error **errp)
@@ -205,6 +207,10 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
                                             gpio_table[i].irq));
     }
 
+    /* Watchdog */
+    object_property_set_bool(OBJECT(&s->wdt), true, "realized", &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt), 0, FSL_IMX31_WDT_ADDR);
+
     /* On a real system, the first 16k is a `secure boot rom' */
     memory_region_init_rom(&s->secure_rom, NULL, "imx31.secure_rom",
                            FSL_IMX31_SECURE_ROM_SIZE, &err);
diff --git a/include/hw/arm/fsl-imx31.h b/include/hw/arm/fsl-imx31.h
index ac5ca9826a..dd8561b309 100644
--- a/include/hw/arm/fsl-imx31.h
+++ b/include/hw/arm/fsl-imx31.h
@@ -25,6 +25,7 @@
 #include "hw/timer/imx_epit.h"
 #include "hw/i2c/imx_i2c.h"
 #include "hw/gpio/imx_gpio.h"
+#include "hw/watchdog/wdt_imx2.h"
 #include "exec/memory.h"
 #include "target/arm/cpu.h"
 
@@ -49,6 +50,7 @@ typedef struct FslIMX31State {
     IMXEPITState   epit[FSL_IMX31_NUM_EPITS];
     IMXI2CState    i2c[FSL_IMX31_NUM_I2CS];
     IMXGPIOState   gpio[FSL_IMX31_NUM_GPIOS];
+    IMX2WdtState   wdt;
     MemoryRegion   secure_rom;
     MemoryRegion   rom;
     MemoryRegion   iram;
@@ -87,6 +89,8 @@ typedef struct FslIMX31State {
 #define FSL_IMX31_GPIO1_SIZE            0x4000
 #define FSL_IMX31_GPIO2_ADDR            0x53FD0000
 #define FSL_IMX31_GPIO2_SIZE            0x4000
+#define FSL_IMX31_WDT_ADDR              0x53FDC000
+#define FSL_IMX31_WDT_SIZE              0x4000
 #define FSL_IMX31_AVIC_ADDR             0x68000000
 #define FSL_IMX31_AVIC_SIZE             0x100
 #define FSL_IMX31_SDRAM0_ADDR           0x80000000
-- 
2.17.1


