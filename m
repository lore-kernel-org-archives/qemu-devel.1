Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263A8C1975A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 17:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3C72073C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 17:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG6rV90o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3C72073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDAae-0001So-1A
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 13:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jDAZd-0007qu-Hc
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 13:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jDAZc-0005WS-GX
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 13:27:45 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jDAZc-0005UR-B4; Sat, 14 Mar 2020 13:27:44 -0400
Received: by mail-pj1-x1041.google.com with SMTP id np16so5743931pjb.4;
 Sat, 14 Mar 2020 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HN3zdF18nSNliLofSN6voNm+WsQM7L0BuBkedKHtwLw=;
 b=IG6rV90oUXWJdqJ0XEbdo7jHS9d6bVQL1fzUYLrebniIy0GJzLjoC70OJnXJxDxd6n
 rqtfWD39u2Fa8Vk97Wri4iv8kOZJtmRefzsyDr8Ga6zvh7z/1DnZSkkuJLC67IE/afOe
 agR/N0AT8TN5wUl6/wvdDX524zK4uxJ5oh4gHByOw5msFFQB/GFELg0uxBC9XRkvNGpK
 uCGlodNBGK1gGqEd38R/nS1OKdWeJIbQl3kFTge3EonSzbn3uMzESwtKqTE7YQBHobYE
 aqOv9rUt7Szhr6av3PRS76aAVhktUOgLayDxdaLVEtxtSTFq8+p1x0+pYWsoz2yHMp2Z
 p2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=HN3zdF18nSNliLofSN6voNm+WsQM7L0BuBkedKHtwLw=;
 b=GjUWnLj397ouS21JwOUCi8gOpycHPnzpU4MrQ8deOeoTLCPQYf8i3E9rgW2G9mSSGQ
 dWNFZ0czKR7nEAkIedgzGgxFbmrw0Q55osjmTU1hvcGUy6jZLXjnKcpFhViAiV5Udnc0
 yGgoZcaAbiKbw+DwfvHfd0DSBpRjdlHZKcDVcL8XcHNQ6GpPNN39/ON+bl9lGD771kVR
 /DqAL9K9S8//QssD5vgrvQmExYTTKXlol2ltfU4MefhlsdB7h7K+ilMxzYxm0ZtZy++x
 bGoPQmXB+drrl2YLisDg3EIftQQ4ZzNhPyZ33AZFpxMkt2CFzDSU4YDpb3L77Kb3E0a/
 k6iw==
X-Gm-Message-State: ANhLgQ0xo5OyluMw6qIkXM3crkPxqUlNY800TcceucBiaPkoB82SEPUr
 iaRdSd8yjYHlOu+w08ogQLE=
X-Google-Smtp-Source: ADFU+vsu+av9RdSYDBFXK+8UyOQNdUZNH7x1AIOvTTP1sdiqC26U4SNpkLWBUZNYJ6/vqBCakuIoOw==
X-Received: by 2002:a17:902:864c:: with SMTP id
 y12mr18700120plt.8.1584206863308; 
 Sat, 14 Mar 2020 10:27:43 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id z15sm27100787pfg.152.2020.03.14.10.27.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 14 Mar 2020 10:27:42 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 3/8] hw/arm/fsl-imx25: Wire up watchdog
Date: Sat, 14 Mar 2020 10:27:31 -0700
Message-Id: <20200314172736.24528-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314172736.24528-1-linux@roeck-us.net>
References: <20200314172736.24528-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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

With this commit, the watchdog on imx25-pdk is fully operational,
including pretimeout support.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/fsl-imx25.c         | 10 ++++++++++
 include/hw/arm/fsl-imx25.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index a3f829f436..7d5aab562d 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -87,6 +87,7 @@ static void fsl_imx25_init(Object *obj)
                               TYPE_CHIPIDEA);
     }
 
+    sysbus_init_child_obj(obj, "wdt", &s->wdt, sizeof(s->wdt), TYPE_IMX2_WDT);
 }
 
 static void fsl_imx25_realize(DeviceState *dev, Error **errp)
@@ -302,6 +303,15 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                             usb_table[i].irq));
     }
 
+    /* Watchdog */
+    object_property_set_bool(OBJECT(&s->wdt), true, "pretimeout-support",
+                             &error_abort);
+    object_property_set_bool(OBJECT(&s->wdt), true, "realized", &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt), 0, FSL_IMX25_WDT_ADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt), 0,
+                                      qdev_get_gpio_in(DEVICE(&s->avic),
+                                                       FSL_IMX25_WDT_IRQ));
+
     /* initialize 2 x 16 KB ROM */
     memory_region_init_rom(&s->rom[0], NULL,
                            "imx25.rom0", FSL_IMX25_ROM0_SIZE, &err);
diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index 5e196bbf05..9e228dacea 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -29,6 +29,7 @@
 #include "hw/gpio/imx_gpio.h"
 #include "hw/sd/sdhci.h"
 #include "hw/usb/chipidea.h"
+#include "hw/watchdog/wdt_imx2.h"
 #include "exec/memory.h"
 #include "target/arm/cpu.h"
 
@@ -60,6 +61,7 @@ typedef struct FslIMX25State {
     IMXGPIOState   gpio[FSL_IMX25_NUM_GPIOS];
     SDHCIState     esdhc[FSL_IMX25_NUM_ESDHCS];
     ChipideaState  usb[FSL_IMX25_NUM_USBS];
+    IMX2WdtState   wdt;
     MemoryRegion   rom[2];
     MemoryRegion   iram;
     MemoryRegion   iram_alias;
@@ -229,6 +231,8 @@ typedef struct FslIMX25State {
 #define FSL_IMX25_GPIO1_SIZE    0x4000
 #define FSL_IMX25_GPIO2_ADDR    0x53FD0000
 #define FSL_IMX25_GPIO2_SIZE    0x4000
+#define FSL_IMX25_WDT_ADDR      0x53FDC000
+#define FSL_IMX25_WDT_SIZE      0x4000
 #define FSL_IMX25_USB1_ADDR     0x53FF4000
 #define FSL_IMX25_USB1_SIZE     0x0200
 #define FSL_IMX25_USB2_ADDR     0x53FF4400
@@ -268,5 +272,6 @@ typedef struct FslIMX25State {
 #define FSL_IMX25_ESDHC2_IRQ    8
 #define FSL_IMX25_USB1_IRQ      37
 #define FSL_IMX25_USB2_IRQ      35
+#define FSL_IMX25_WDT_IRQ       55
 
 #endif /* FSL_IMX25_H */
-- 
2.17.1


