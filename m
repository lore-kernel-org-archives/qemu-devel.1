Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C85AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 17:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17390222C4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 17:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXi1ezuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17390222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8S3w-0000kV-9e
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 12:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j8S1U-0005wg-FQ
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j8S1T-0001kp-An
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 12:05:00 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j8S1Q-0001iw-LJ; Sun, 01 Mar 2020 12:04:56 -0500
Received: by mail-pf1-x441.google.com with SMTP id p14so4349600pfn.4;
 Sun, 01 Mar 2020 09:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QEy/YbxuN9ExfK/xFDdpubtS3+osTfUK1jjz+reipig=;
 b=VXi1ezuQ/PPlX85evva/J6TxdlyAsQBrj69menMokBY5Gov6MN0+LrJOEulNrIJZWw
 oA83ez+f75CJBPjXjp0NZieOqzVpgXG9AwL4N4Lmnde+3DaiISnOR2eYGz+4aog0/vtn
 a7hZbXuekR2cm6wwR7pclJp4SZTvbhuCxYcT/yP92p8Wl3XRdBehAHRon3QPNVll9lVd
 wjQ7fx+BOQchOt9jCUd/703eabfvZRyQGJdFSnlqSxWyfSVSRa1BpS1fHEqdt4/SH1jX
 meqCIz6L1q0K96NCsdbuzcnSiblNm34UBJP2vQmhiJEX45Y+nuIVwyidq/L9xGiJyrzm
 XFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=QEy/YbxuN9ExfK/xFDdpubtS3+osTfUK1jjz+reipig=;
 b=immPCEbKq09AXUh+ugf/PzxDfWwWAdSfMg+zAY1GY9W2lJ6l6oFbmbecAR063RhOTO
 jNSHw6B+LN2VmIVjGSgd8SZ+mk80TSaerseexJNeaqBFQclHMMPFxdaiVUBzYFKaM+FQ
 pd9omNbZjNbz7bDieJyoDli/JaGvds/MDEossLgYyggSEwphyyDDpuE07ibqEsTvmYXQ
 UIfCTJSbUXRHoi9RYujLchqg09aex4pSIh1D30IG4rOrqGsBz1wuCOOC2fK6h/mFnOeN
 Uzdqa9KNP1uzn5Zj0oRUj/d4EDL1dDqfZIXBbAcZFb/P2gpB5W98qgURdQblRtQkbEmN
 D2Rw==
X-Gm-Message-State: APjAAAV2TlZhpbDAoZ90Yj3HHYzqD89aQ3IINS3c2EofLv6uFNBNWV95
 FUjIsfvSDWBxkIk8viTpPa4=
X-Google-Smtp-Source: APXvYqyPtT4m+Sc6AHu9NugftN8oG/1umBtHvxMtixQJlWU8UsiVhPq3TbizxmfEVCmVXRl2ttk2sg==
X-Received: by 2002:a63:e044:: with SMTP id n4mr14806594pgj.338.1583082295670; 
 Sun, 01 Mar 2020 09:04:55 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id e2sm9081742pjs.25.2020.03.01.09.04.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 01 Mar 2020 09:04:55 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 3/3] hw/arm/fsl-imx6: Wire up USB controllers
Date: Sun,  1 Mar 2020 09:04:43 -0800
Message-Id: <20200301170443.12904-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200301170443.12904-1-linux@roeck-us.net>
References: <20200301170443.12904-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

With this patch, the USB controllers on 'sabrelite' are detected
and can be used to boot the system.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/Kconfig            |  2 ++
 hw/arm/fsl-imx6.c         | 36 ++++++++++++++++++++++++++++++++++++
 include/hw/arm/fsl-imx6.h |  3 +++
 3 files changed, 41 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index d09b012c5a..5d12b0f686 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -361,6 +361,8 @@ config FSL_IMX6
     select IMX_FEC
     select IMX_I2C
     select SDHCI
+    select STMP
+    select UNIMP
 
 config ASPEED_SOC
     bool
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index ecc62855f2..9a4a0eb35e 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -22,6 +22,8 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6.h"
+#include "hw/misc/stmp.h"
+#include "hw/misc/unimp.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
@@ -86,6 +88,12 @@ static void fsl_imx6_init(Object *obj)
                               TYPE_IMX_USDHC);
     }
 
+    for (i = 0; i < FSL_IMX6_NUM_USBS; i++) {
+        snprintf(name, NAME_SIZE, "usb%d", i);
+        sysbus_init_child_obj(obj, name, &s->usb[i], sizeof(s->usb[i]),
+                              TYPE_CHIPIDEA);
+    }
+
     for (i = 0; i < FSL_IMX6_NUM_ECSPIS; i++) {
         snprintf(name, NAME_SIZE, "spi%d", i + 1);
         sysbus_init_child_obj(obj, name, &s->spi[i], sizeof(s->spi[i]),
@@ -349,6 +357,34 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                             esdhc_table[i].irq));
     }
 
+    /* USB */
+    for (i = 0; i < FSL_IMX6_NUM_USBS; i++) {
+        static const int FSL_IMX6_USBn_IRQ[] = {
+            FSL_IMX6_USB_OTG_IRQ,
+            FSL_IMX6_USB_HOST1_IRQ,
+            FSL_IMX6_USB_HOST2_IRQ,
+            FSL_IMX6_USB_HOST3_IRQ,
+        };
+
+        object_property_set_bool(OBJECT(&s->usb[i]), true, "realized",
+                                 &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0,
+                        FSL_IMX6_USBOH3_USB_ADDR + i * 0x200);
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
+                                            FSL_IMX6_USBn_IRQ[i]));
+
+    }
+    create_unimplemented_device("usbmisc", FSL_IMX6_USBOH3_USB_ADDR + 0x800,
+                                0x200);
+    create_unimplemented_device("usbphy1", FSL_IMX6_USBPHY1_ADDR,
+                                FSL_IMX6_USBPHY1_SIZE);
+    create_stmp_device("usbphy1-stmp", true, FSL_IMX6_USBPHY1_ADDR + 0x30);
+    create_unimplemented_device("usbphy2", FSL_IMX6_USBPHY2_ADDR,
+                                FSL_IMX6_USBPHY2_SIZE);
+    create_stmp_device("usbphy2-stmp", true, FSL_IMX6_USBPHY2_ADDR + 0x30);
+
     /* Initialize all ECSPI */
     for (i = 0; i < FSL_IMX6_NUM_ECSPIS; i++) {
         static const struct {
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 60eadccb42..a3d1f34598 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -30,6 +30,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
 #include "hw/net/imx_fec.h"
+#include "hw/usb/chipidea.h"
 #include "exec/memory.h"
 #include "cpu.h"
 
@@ -44,6 +45,7 @@
 #define FSL_IMX6_NUM_ESDHCS 4
 #define FSL_IMX6_NUM_ECSPIS 5
 #define FSL_IMX6_NUM_WDTS 2
+#define FSL_IMX6_NUM_USBS 4
 
 typedef struct FslIMX6State {
     /*< private >*/
@@ -62,6 +64,7 @@ typedef struct FslIMX6State {
     SDHCIState     esdhc[FSL_IMX6_NUM_ESDHCS];
     IMXSPIState    spi[FSL_IMX6_NUM_ECSPIS];
     IMX2WdtState   wdt[FSL_IMX6_NUM_WDTS];
+    ChipideaState  usb[FSL_IMX6_NUM_USBS];
     IMXFECState    eth;
     MemoryRegion   rom;
     MemoryRegion   caam;
-- 
2.17.1


