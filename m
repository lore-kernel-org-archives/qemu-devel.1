Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFCFC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6EC3215A4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klfYWUd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EC3215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBmou-0007cS-UH
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 17:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jBmn5-0005GH-QK
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jBmn4-000720-F1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:51:55 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35063)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jBmn1-0006t8-FK; Tue, 10 Mar 2020 17:51:51 -0400
Received: by mail-pg1-x543.google.com with SMTP id 7so34496pgr.2;
 Tue, 10 Mar 2020 14:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xrITzaKBDT6hlCX5NlWwCs8lcDqgdRQyc9lbFfxyrmI=;
 b=klfYWUd1DUBwvIAUoso5YGQCN2yXiXRA6a9b1cfsUg9GNpGQ6Yd5hmCSbzFexzHL/4
 mX3KRw6ejiKAdGiu8yTu71Xh/3wYj60ZqJmaKtp6yIc/83hoBzS5hZiKn3aXKF/QBBBz
 HPk6zhaL+/MyEU96qRCt1PYG/8bafvU04cETEv9SOh+bgFMtTw91NotVdQZ1eiz5th2S
 sWg64rcwliXS9yy0QW3ZW8xFZSCcvZ239L+XScy0XtGduAetPDFuk5aaQVXy4iCMOJHp
 MqHa2+SMLvzF0FIkHVbck2Fw5ui6/QSvxGgZdnxaInVr34Pr3/+545Dr8b9jiLB3lEA/
 cfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=xrITzaKBDT6hlCX5NlWwCs8lcDqgdRQyc9lbFfxyrmI=;
 b=qCwB1KgKs4PnhDSTb//+HwDL0EIeA/reOMQSFSri3f4436doTjuA0pu5NYTbgbfkUB
 GOhdwSJ+G/dCjwez+zOqaW5WRHKWUWzWQcm38eMzYifhFnFQvkOysDugE4WcmYv0rvO5
 gFpNSDgehL2xDM3aKb0sm3hBMrf70hNGGXum+IspOA5VA5VFjQvxk2nkibicVWne2BCv
 ht7h3E9UL0PPzuLSARj7gMeOZASyDO1/qmBRyRVmduQB5cqKoVnJPbuqQ/i7j7Td+MRG
 IOm6QncdWpui7rJ69RF0too7sAA3gvmFuVA3hlo8MMwvfO6hejvc4TGY6xyvHzqbyRm4
 UiUA==
X-Gm-Message-State: ANhLgQ2X2gh81ErhdvLCkeowHHFutv3KHtZ9ZS6Q6Oj3zzn0rxri6wFF
 cZJLfor6ORkmgklcCunwSXEosLqv
X-Google-Smtp-Source: ADFU+vsiXIfSCQjhL5dohN+y/C/o/3byOGoC6J1oTD+yx7nKbK1nhRKK64w8jRMdCdNJ4PksWtmqSA==
X-Received: by 2002:a62:778d:: with SMTP id s135mr3812973pfc.21.1583877110249; 
 Tue, 10 Mar 2020 14:51:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id d19sm3937865pfd.82.2020.03.10.14.51.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 10 Mar 2020 14:51:49 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/2] hw/arm: fsl-imx25: Wire up eSDHC controllers
Date: Tue, 10 Mar 2020 14:51:45 -0700
Message-Id: <20200310215146.19688-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310215146.19688-1-linux@roeck-us.net>
References: <20200310215146.19688-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

Wire up eSDHC controllers in fsl-imx25. For imx25-pdk, connect drives
provided on the command line to available eSDHC controllers.

This patch enables booting the imx25-pdk emulation from SD card.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/fsl-imx25.c         | 32 ++++++++++++++++++++++++++++++++
 hw/arm/imx25_pdk.c         | 16 ++++++++++++++++
 include/hw/arm/fsl-imx25.h |  9 +++++++++
 3 files changed, 57 insertions(+)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index da3471b395..f977c42426 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -31,6 +31,8 @@
 #include "hw/qdev-properties.h"
 #include "chardev/char.h"
 
+#define IMX25_ESDHC_CAPABILITIES     0x07e20000
+
 static void fsl_imx25_init(Object *obj)
 {
     FslIMX25State *s = FSL_IMX25(obj);
@@ -74,6 +76,11 @@ static void fsl_imx25_init(Object *obj)
         sysbus_init_child_obj(obj, "gpio[*]", &s->gpio[i], sizeof(s->gpio[i]),
                               TYPE_IMX_GPIO);
     }
+
+    for (i = 0; i < FSL_IMX25_NUM_ESDHCS; i++) {
+        sysbus_init_child_obj(obj, "sdhc[*]", &s->esdhc[i], sizeof(s->esdhc[i]),
+                              TYPE_IMX_USDHC);
+    }
 }
 
 static void fsl_imx25_realize(DeviceState *dev, Error **errp)
@@ -246,6 +253,31 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                             gpio_table[i].irq));
     }
 
+    /* Initialize all SDHC */
+    for (i = 0; i < FSL_IMX25_NUM_ESDHCS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } esdhc_table[FSL_IMX25_NUM_ESDHCS] = {
+            { FSL_IMX25_ESDHC1_ADDR, FSL_IMX25_ESDHC1_IRQ },
+            { FSL_IMX25_ESDHC2_ADDR, FSL_IMX25_ESDHC2_IRQ },
+        };
+
+        object_property_set_uint(OBJECT(&s->esdhc[i]), 2, "sd-spec-version",
+                                 &err);
+        object_property_set_uint(OBJECT(&s->esdhc[i]), IMX25_ESDHC_CAPABILITIES,
+                                 "capareg", &err);
+        object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->esdhc[i]), 0, esdhc_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->esdhc[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->avic),
+                                            esdhc_table[i].irq));
+    }
+
     /* initialize 2 x 16 KB ROM */
     memory_region_init_rom(&s->rom[0], NULL,
                            "imx25.rom0", FSL_IMX25_ROM0_SIZE, &err);
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 26713d9a7e..b3ca82bafa 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "hw/qdev-properties.h"
 #include "hw/arm/fsl-imx25.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
@@ -120,6 +121,21 @@ static void imx25_pdk_init(MachineState *machine)
     imx25_pdk_binfo.board_id = 1771,
     imx25_pdk_binfo.nb_cpus = 1;
 
+    for (i = 0; i < FSL_IMX25_NUM_ESDHCS; i++) {
+        BusState *bus;
+        DeviceState *carddev;
+        DriveInfo *di;
+        BlockBackend *blk;
+
+        di = drive_get_next(IF_SD);
+        blk = di ? blk_by_legacy_dinfo(di) : NULL;
+        bus = qdev_get_child_bus(DEVICE(&s->soc.esdhc[i]), "sd-bus");
+        carddev = qdev_create(bus, TYPE_SD_CARD);
+        qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
+        object_property_set_bool(OBJECT(carddev), true,
+                                 "realized", &error_fatal);
+    }
+
     /*
      * We test explicitly for qtest here as it is not done (yet?) in
      * arm_load_kernel(). Without this the "make check" command would
diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index 1c86bb55fb..4e2d4868cd 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -27,6 +27,7 @@
 #include "hw/misc/imx_rngc.h"
 #include "hw/i2c/imx_i2c.h"
 #include "hw/gpio/imx_gpio.h"
+#include "hw/sd/sdhci.h"
 #include "exec/memory.h"
 #include "target/arm/cpu.h"
 
@@ -38,6 +39,7 @@
 #define FSL_IMX25_NUM_EPITS 2
 #define FSL_IMX25_NUM_I2CS 3
 #define FSL_IMX25_NUM_GPIOS 4
+#define FSL_IMX25_NUM_ESDHCS 2
 
 typedef struct FslIMX25State {
     /*< private >*/
@@ -54,6 +56,7 @@ typedef struct FslIMX25State {
     IMXRNGCState   rngc;
     IMXI2CState    i2c[FSL_IMX25_NUM_I2CS];
     IMXGPIOState   gpio[FSL_IMX25_NUM_GPIOS];
+    SDHCIState     esdhc[FSL_IMX25_NUM_ESDHCS];
     MemoryRegion   rom[2];
     MemoryRegion   iram;
     MemoryRegion   iram_alias;
@@ -215,6 +218,10 @@ typedef struct FslIMX25State {
 #define FSL_IMX25_GPIO3_SIZE    0x4000
 #define FSL_IMX25_RNGC_ADDR     0x53FB0000
 #define FSL_IMX25_RNGC_SIZE     0x4000
+#define FSL_IMX25_ESDHC1_ADDR   0x53FB4000
+#define FSL_IMX25_ESDHC1_SIZE   0x4000
+#define FSL_IMX25_ESDHC2_ADDR   0x53FB8000
+#define FSL_IMX25_ESDHC2_SIZE   0x4000
 #define FSL_IMX25_GPIO1_ADDR    0x53FCC000
 #define FSL_IMX25_GPIO1_SIZE    0x4000
 #define FSL_IMX25_GPIO2_ADDR    0x53FD0000
@@ -250,5 +257,7 @@ typedef struct FslIMX25State {
 #define FSL_IMX25_GPIO2_IRQ     51
 #define FSL_IMX25_GPIO3_IRQ     16
 #define FSL_IMX25_GPIO4_IRQ     23
+#define FSL_IMX25_ESDHC1_IRQ    9
+#define FSL_IMX25_ESDHC2_IRQ    8
 
 #endif /* FSL_IMX25_H */
-- 
2.17.1


