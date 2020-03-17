Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96403C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B9E20735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ay1LZVy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B9E20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAde-00068U-Ha
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAaX-0000PM-Q2
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAaW-0002aO-GS
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:49 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:40659)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEAaW-0002Pz-9U
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:48 -0400
Received: by mail-wm1-x332.google.com with SMTP id z12so12365555wmf.5
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 04:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jXJaCx3hbYmcNKuqEiqjFHkajTM6KcIwjOw6oo6oGk4=;
 b=ay1LZVy1BbgFQjfzwts4uKZY68k+JjH638j5tbCwtSS3YdFA/tyeNGCy/ujp1PJirr
 VNKvoIDfX4Q7wB3RyuVVOedjcH/jwrIvkQzNOIYYu8ufuHmxCnG9CDK+kLknXq8rcltU
 J+CdnO7CxyupWFUj+K5lY1RSorpZ8DSSAA8UdwtBSk3x/9sHPjojGeR9MCw/RizOymvk
 98Kr99oxAsLoxxoxbHV1NoK/EIsONKG1ePqu2r9Iu3A0hck7Bs1KbGTFuAviBnoc3gfk
 4SAQJE5B06fkmqvH0zLM3s/10sOTWOq2DOZGCgn9cEuuupBny0P2H58eKdi3W3fhay1d
 wp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jXJaCx3hbYmcNKuqEiqjFHkajTM6KcIwjOw6oo6oGk4=;
 b=VRIkTjhvEt1kXqsKFQE8WWSHMBbjqwqTXcgWGmrW1l1FvJEWbiI3LH5mZUQbXTyQFo
 RqGcHSPP+llzdbXA3zHP17fECQm+lQH3BWzDETzWvfv6KLxxHQcxHAUPbfjGNoD6a0ob
 EjA5/zlWCyI+Vt2RjSk2COJO8eNc3I5WDoqUUzR42INxuDIaW/P52IOEMd80zs6dF3Wg
 jB7XIwX4BttQCpvwEbqDWWQoq7UDJV7ANFOiWpOJB5d+//ffxQKnU0eausxrGdSiPQHk
 DLIsJeMLg8mFTSYAftAtzy3v1qf6bhkxWMI6SBh8oUS6MV2rsZYxvWJ0+pjv+OvMLyvl
 cfHg==
X-Gm-Message-State: ANhLgQ22RNP1PPBvk81S/uxO1bEhKI5KglaAOVDvoqpSwdRftgajAuI3
 2iDkAVj9gObDSNqWTpm1Wgdyfwp/FQ7ieQ==
X-Google-Smtp-Source: ADFU+vvj7cCDbg3n7bCQpUolpHdcPA39IUKztmEWnNXxS9fsXGxxi80yXMsjXgdi7rose46KRg80og==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr4636504wmj.146.1584445246910; 
 Tue, 17 Mar 2020 04:40:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a186sm3577443wmh.33.2020.03.17.04.40.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 04:40:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/11] hw/arm/fsl-imx6ul: Wire up USB controllers
Date: Tue, 17 Mar 2020 11:40:32 +0000
Message-Id: <20200317114039.26914-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317114039.26914-1-peter.maydell@linaro.org>
References: <20200317114039.26914-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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

IMX6UL USB controllers are quite similar to IMX7 USB controllers.
Wire them up the same way.

The only real difference is that wiring up phy devices is necessary
to avoid phy reset timeouts in the Linux kernel.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200313014551.12554-5-linux@roeck-us.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx6ul.h | 10 ++++++++++
 hw/arm/fsl-imx6ul.c         | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 5a420785b95..1a0bab8daaf 100644
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
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index a0bcc6f8957..99a5859a4e9 100644
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
-- 
2.20.1


