Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188FBC3F2CD
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 17:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77782087F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 17:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tc+5BfO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77782087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8S2h-0007C4-3L
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 12:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j8S1S-0005sY-BS
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:04:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j8S1R-0001jG-55
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:04:58 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38633)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j8S1O-0001gS-OF; Sun, 01 Mar 2020 12:04:54 -0500
Received: by mail-pl1-x642.google.com with SMTP id p7so3225016pli.5;
 Sun, 01 Mar 2020 09:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8OfojPF0SOlwZ2hNqQRCRwhc/fBNHQ5w6WoG81OWGnE=;
 b=tc+5BfO9WPQFfEtF0CrMIaM6VZzMTmoRCmErQytF1XIeKbVcAIvF/40PGKjA8Bh/m9
 uX/FwKNbkxQmmbV6ZvrQmWNdefkcCJpjbY8c5HgbUzyUvdirLPak/lHp/MPC0JXOF9WP
 q81Y027vwPA4LUyZIYnDFazyyGDXTnJs7jeZDm0sKuoaNi+zi6TYgNQYVg4QXaktXopW
 7/cj1cLRwDpBDQyMMB1HrtK9AQRI5gLeZ+bYNrsdulL476BEKsdGqdVYi2eIZ67w7si6
 aGxzPkaCpVqv+qBMmW8bYzcOKGYz73jJXoHgi9hiq5LEitL83dpX61TLYKsA53ttJRnz
 s/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=8OfojPF0SOlwZ2hNqQRCRwhc/fBNHQ5w6WoG81OWGnE=;
 b=ueYFu9LpvWhCKhp3IWTGvsprz3IdnFJruzShAo5/dfokbM15ejS2E3rl2c9NqeWykg
 zbZjlyUS+tfkKIeRefhgX2NUqUKrxwXbZcfY5BwCbI554b21Vbth2qGsDUs2yM0e4i0H
 PkA73e1GYwUkmcYNFZbyAdcTNq6Ywxnm2Hw5rbV6Kf7b5Jcv6k1ZFFjID0zJGr+RxCTq
 Yamg42OaSZMDVScrL1YDY4DPD/vDvfjCd4btYMLV6x3MmnaGzwBcbriuyWx6wxlxcYWW
 ASlvQ+yp5Wk99DV9ELwcI5N6xexaR7pehQ4mKlpwDdJq1V1JTqfLDyax5dL3rIeASOi1
 C6Zw==
X-Gm-Message-State: APjAAAUJ9W/Y+YXvs5mdenEAbJ9FaziAypLUNguBR0sBG68xHnaepATM
 cmAEgQk+gHwAts8I29ISgkg=
X-Google-Smtp-Source: APXvYqz/1pVslDwjhurM/PjKFR3U8uiECLX1350daSkWdIHKNrkFr6c6vLo1cZDX9R+Hcwmx++HaMg==
X-Received: by 2002:a17:902:8642:: with SMTP id
 y2mr13751287plt.306.1583082293833; 
 Sun, 01 Mar 2020 09:04:53 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id f3sm17116739pga.38.2020.03.01.09.04.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 01 Mar 2020 09:04:53 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/3] arm: fsl-imx6ul: Wire up USB controllers
Date: Sun,  1 Mar 2020 09:04:42 -0800
Message-Id: <20200301170443.12904-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200301170443.12904-1-linux@roeck-us.net>
References: <20200301170443.12904-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

IMX6UL USB controllers are quite similar to IMX7 USB controllers.
Wire them up the same way.

The only real difference is that wiring up dummy phy devices is necessary
to avoid phy reset timeouts in the Linux kernel.

With this patch, the USB controllers on 'mcimx6ul-evk' are detected
and can be used to boot the system.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/fsl-imx6ul.c         | 35 +++++++++++++++++++++++++++++++++++
 include/hw/arm/fsl-imx6ul.h |  7 +++++++
 3 files changed, 43 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 61635f52c4..d09b012c5a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -411,6 +411,7 @@ config FSL_IMX6UL
     select IMX_FEC
     select IMX_I2C
     select SDHCI
+    select STMP
     select UNIMP
 
 config MICROBIT
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index c405b68d1d..d2ee4cc846 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6ul.h"
+#include "hw/misc/stmp.h"
 #include "hw/misc/unimp.h"
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
@@ -133,6 +134,14 @@ static void fsl_imx6ul_init(Object *obj)
                               TYPE_IMX_ENET);
     }
 
+    /* USB */
+    for (i = 0; i < FSL_IMX6UL_NUM_USBS; i++) {
+        snprintf(name, NAME_SIZE, "usb%d", i);
+        sysbus_init_child_obj(obj, name, &s->usb[i], sizeof(s->usb[i]),
+                              TYPE_CHIPIDEA);
+    }
+
+
     /*
      * SDHCI
      */
@@ -456,6 +465,32 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                                             FSL_IMX6UL_ENETn_TIMER_IRQ[i]));
     }
 
+    /* USB */
+    for (i = 0; i < FSL_IMX6UL_NUM_USBS; i++) {
+        static const int FSL_IMX6UL_USBn_IRQ[] = {
+            FSL_IMX6UL_USB2_IRQ,
+            FSL_IMX6UL_USB1_IRQ,
+        };
+
+        object_property_set_bool(OBJECT(&s->usb[i]), true, "realized",
+                                 &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0,
+                        FSL_IMX6UL_USBO2_USB_ADDR + i * 0x200);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                                            FSL_IMX6UL_USBn_IRQ[i]));
+
+    }
+    create_unimplemented_device("usbmisc", FSL_IMX6UL_USBO2_USBMISC_ADDR,
+                                0x200);
+    create_unimplemented_device("usbphy1", FSL_IMX6UL_USBPHY1_ADDR,
+                                FSL_IMX6UL_USBPHY1_SIZE);
+    create_stmp_device("usbphy1-stmp", true, FSL_IMX6UL_USBPHY1_ADDR + 0x30);
+    create_unimplemented_device("usbphy2", FSL_IMX6UL_USBPHY2_ADDR,
+                                FSL_IMX6UL_USBPHY2_SIZE);
+    create_stmp_device("usbphy2-stmp", true, FSL_IMX6UL_USBPHY2_ADDR + 0x30);
+
     /*
      * USDHC
      */
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index eda389aec7..ae738bd5ea 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -34,6 +34,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
 #include "hw/net/imx_fec.h"
+#include "hw/usb/chipidea.h"
 #include "exec/memory.h"
 #include "cpu.h"
 
@@ -54,6 +55,7 @@ enum FslIMX6ULConfiguration {
     FSL_IMX6UL_NUM_I2CS         = 4,
     FSL_IMX6UL_NUM_ECSPIS       = 4,
     FSL_IMX6UL_NUM_ADCS         = 2,
+    FSL_IMX6UL_NUM_USBS         = 2,
 };
 
 typedef struct FslIMX6ULState {
@@ -77,6 +79,7 @@ typedef struct FslIMX6ULState {
     IMXFECState        eth[FSL_IMX6UL_NUM_ETHS];
     SDHCIState         usdhc[FSL_IMX6UL_NUM_USDHCS];
     IMX2WdtState       wdt[FSL_IMX6UL_NUM_WDTS];
+    ChipideaState      usb[FSL_IMX6UL_NUM_USBS];
     MemoryRegion       rom;
     MemoryRegion       caam;
     MemoryRegion       ocram;
@@ -145,6 +148,10 @@ enum FslIMX6ULMemoryMap {
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


