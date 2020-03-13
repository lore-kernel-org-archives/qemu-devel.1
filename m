Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1022CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 01:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF73F206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 01:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCy8+h5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF73F206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCZU2-0004gl-2t
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 21:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jCZOl-0001Oe-HE
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 21:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jCZOk-00069t-Bs
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 21:46:03 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jCZOk-00067c-5a; Thu, 12 Mar 2020 21:46:02 -0400
Received: by mail-pf1-x443.google.com with SMTP id z65so4212291pfz.8;
 Thu, 12 Mar 2020 18:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=U/E6FZ2aNyj9E0hjkPWXRdlmcUxMx99Uvd9Fo55qjw0=;
 b=cCy8+h5gRwUEQxLTBFucurKZwImWEYt8KsnLbJrq0u/qPomUAEFHYqJuljdbEP4PoM
 aKq1g7wxJVTmZsCor6dP4zdiHoNFCP418GZBFj8xf7fX7BJijZWVmZP7e/IZW3iYZqk5
 tADl3qEQp3Dd13iZzNz0LQH8gv0Dqsc99Df2xEEVjssmHVMKYmrs36JH048vy0Z4PARd
 I/cJ+rdVr2+ArmajAGXW+9xGBDU4aOv2b6CpqJP1TpwbuoAQqk04Y3zdKE0tTo4AAsi6
 3ERJEI+dGMITOONrTdYLjnpWuM1jpIzaq3KhChwSbeTiEt+K+6Z1X0/vVO/tG1m84iNF
 F2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=U/E6FZ2aNyj9E0hjkPWXRdlmcUxMx99Uvd9Fo55qjw0=;
 b=K8D4qGZs8TEw9RAI4VF3kbS9CBSn1Ia4oP3z8h8BB7BlTlAj7tYdGEuRi/aYv4ILoW
 9aX24nsxHicfSfdVbb9vUVVc/mq6ZwC1QkY8wsPF8fA2KZnaJllRlSDE39mv0SMToB32
 2xCkqjNbiCnQo0AQ2iNEzozl4aVs9a0xgKBYYLZeGRjcxYHoWhF23s6X3eCevap424yQ
 qQLQD2Jc8Kiczx74kc4qvMh7YYNt5P3z6U4cH4NuAklVXVBjVEdqdsZIghZzn1uCDAAU
 rSaPpVkZd345/Jr2UoXNcAxVYmR3W0Xo07rNe+x76CizmPZcpW+Ipvc+3sYS1LOspk7q
 0gWg==
X-Gm-Message-State: ANhLgQ0uLXKc++j22vHskB8QUYXYrwEUxWgy/PLJfzh20vDl3vJOTk8j
 wDR2VimrxBIuURKipk98ESg=
X-Google-Smtp-Source: ADFU+vuMmHcK2URQJh9pm06ifhhq3qUldt2OxJb+HWpMQSuHI7ONooZayeYz23OpRFbrZuYKkq30aQ==
X-Received: by 2002:a63:7c0f:: with SMTP id x15mr10699594pgc.173.1584063961229; 
 Thu, 12 Mar 2020 18:46:01 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id g19sm55823917pfh.134.2020.03.12.18.46.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 12 Mar 2020 18:46:00 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 4/5] hw/arm/fsl-imx6ul: Wire up USB controllers
Date: Thu, 12 Mar 2020 18:45:50 -0700
Message-Id: <20200313014551.12554-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313014551.12554-1-linux@roeck-us.net>
References: <20200313014551.12554-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

IMX6UL USB controllers are quite similar to IMX7 USB controllers.
Wire them up the same way.

The only real difference is that wiring up phy devices is necessary
to avoid phy reset timeouts in the Linux kernel.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Wire up USB and USB PHY controllers in separate loops
    While the number of USB controllers matches the number of USB PHYs,
    they are logically different.
v2: Use USB PHY emulation

 hw/arm/fsl-imx6ul.c         | 35 +++++++++++++++++++++++++++++++++++
 include/hw/arm/fsl-imx6ul.h | 10 ++++++++++
 2 files changed, 45 insertions(+)

diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index a0bcc6f895..99a5859a4e 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -20,6 +20,7 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6ul.h"
 #include "hw/misc/unimp.h"
+#include "hw/usb/imx-usb-phy.h"
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
@@ -133,6 +134,18 @@ static void fsl_imx6ul_init(Object *obj)
                               TYPE_IMX_ENET);
     }
 
+    /* USB */
+    for (i = 0; i < FSL_IMX6UL_NUM_USB_PHYS; i++) {
+        snprintf(name, NAME_SIZE, "usbphy%d", i);
+        sysbus_init_child_obj(obj, name, &s->usbphy[i], sizeof(s->usbphy[i]),
+                              TYPE_IMX_USBPHY);
+    }
+    for (i = 0; i < FSL_IMX6UL_NUM_USBS; i++) {
+        snprintf(name, NAME_SIZE, "usb%d", i);
+        sysbus_init_child_obj(obj, name, &s->usb[i], sizeof(s->usb[i]),
+                              TYPE_CHIPIDEA);
+    }
+
     /*
      * SDHCI
      */
@@ -456,6 +469,28 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                                             FSL_IMX6UL_ENETn_TIMER_IRQ[i]));
     }
 
+    /* USB */
+    for (i = 0; i < FSL_IMX6UL_NUM_USB_PHYS; i++) {
+        object_property_set_bool(OBJECT(&s->usbphy[i]), true, "realized",
+                                 &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usbphy[i]), 0,
+                        FSL_IMX6UL_USBPHY1_ADDR + i * 0x1000);
+    }
+
+    for (i = 0; i < FSL_IMX6UL_NUM_USBS; i++) {
+        static const int FSL_IMX6UL_USBn_IRQ[] = {
+            FSL_IMX6UL_USB1_IRQ,
+            FSL_IMX6UL_USB2_IRQ,
+        };
+        object_property_set_bool(OBJECT(&s->usb[i]), true, "realized",
+                                 &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0,
+                        FSL_IMX6UL_USBO2_USB_ADDR + i * 0x200);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                                            FSL_IMX6UL_USBn_IRQ[i]));
+    }
+
     /*
      * USDHC
      */
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 5a420785b9..1a0bab8daa 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -34,6 +34,8 @@
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
 #include "hw/net/imx_fec.h"
+#include "hw/usb/chipidea.h"
+#include "hw/usb/imx-usb-phy.h"
 #include "exec/memory.h"
 #include "cpu.h"
 
@@ -54,6 +56,8 @@ enum FslIMX6ULConfiguration {
     FSL_IMX6UL_NUM_I2CS         = 4,
     FSL_IMX6UL_NUM_ECSPIS       = 4,
     FSL_IMX6UL_NUM_ADCS         = 2,
+    FSL_IMX6UL_NUM_USB_PHYS     = 2,
+    FSL_IMX6UL_NUM_USBS         = 2,
 };
 
 typedef struct FslIMX6ULState {
@@ -77,6 +81,8 @@ typedef struct FslIMX6ULState {
     IMXFECState        eth[FSL_IMX6UL_NUM_ETHS];
     SDHCIState         usdhc[FSL_IMX6UL_NUM_USDHCS];
     IMX2WdtState       wdt[FSL_IMX6UL_NUM_WDTS];
+    IMXUSBPHYState     usbphy[FSL_IMX6UL_NUM_USB_PHYS];
+    ChipideaState      usb[FSL_IMX6UL_NUM_USBS];
     MemoryRegion       rom;
     MemoryRegion       caam;
     MemoryRegion       ocram;
@@ -145,6 +151,10 @@ enum FslIMX6ULMemoryMap {
     FSL_IMX6UL_EPIT2_ADDR           = 0x020D4000,
     FSL_IMX6UL_EPIT1_ADDR           = 0x020D0000,
     FSL_IMX6UL_SNVS_HP_ADDR         = 0x020CC000,
+    FSL_IMX6UL_USBPHY2_ADDR         = 0x020CA000,
+    FSL_IMX6UL_USBPHY2_SIZE         = (4 * 1024),
+    FSL_IMX6UL_USBPHY1_ADDR         = 0x020C9000,
+    FSL_IMX6UL_USBPHY1_SIZE         = (4 * 1024),
     FSL_IMX6UL_ANALOG_ADDR          = 0x020C8000,
     FSL_IMX6UL_CCM_ADDR             = 0x020C4000,
     FSL_IMX6UL_WDOG2_ADDR           = 0x020C0000,
-- 
2.17.1


