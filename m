Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E438C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 23:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA15B20708
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 23:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz1AIFDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA15B20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbYb2-0007tA-W3
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 19:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jbYYX-0003Xa-2c
 for qemu-devel@nongnu.org; Wed, 20 May 2020 19:55:25 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36955)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jbYYW-0000F2-4Y
 for qemu-devel@nongnu.org; Wed, 20 May 2020 19:55:24 -0400
Received: by mail-pf1-x442.google.com with SMTP id y198so2391441pfb.4
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 16:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tWJOSmiTRfI4KdhADfm5vfRQyW71rOWu6g85Di1SYW8=;
 b=Oz1AIFDoG2BkG70Z5yv7st/R9yhnHPmLVtI/cr7ruQ9wiCO54/uYI3liXhuJfLobmM
 Zng6jbN31lkUCjagjhoeq8Y7Yk44bYxMTT3Ctvx/bbh8zIwL4ifL1ZFC6BizNYgtvIWo
 oaedmy5k5+UHEMTKPg+zeVRNlgw5bPZvk7WWRvWy8JBPbqMkG3/rxlku+c5H4YPe+N22
 pknYSkxS/ZCumpdRm7D9p3mHcDEzUEcEl3YniaQjjWwD2U7BiQSAqaD1ADC/V+wRCitJ
 MSaelKWCh/oM2CCfPE7Eryim57QxtunkA/vinyOe7nN9GgYuq04+ap0B4BG81yGg7aZz
 Sb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tWJOSmiTRfI4KdhADfm5vfRQyW71rOWu6g85Di1SYW8=;
 b=BpoCtGTh7/GMZypPoBvRAFhUk491LYKeA8oyENy52w1NSApMpTfm74rVAx8bddTo1V
 3mqCw/1emJ8ZJ3DGfaskOVmCOJT6/PifRRNDmi2F8U1uCIQD/Jfe+x0KoRtsB23j7wE3
 C68pbMAsitODZ8D8kyC8P7GJBMb6GyOMEIgMhpZ8UaZP3nOJyeLM+w4g2ZrdTBchS8s4
 ZzZHHXLNtWt7Xpfa0wEHXIHbMVd6Y1s5Htdo8oBfduC0jEyk5h5Cv/aX4amsD6uApVvZ
 ztZrhD/9HTlITytGzL5CQmTXH7FrfyEO2YMAEGcnSr/b8l3hjUsB6gBbOjP/3VthI7Hh
 lP1g==
X-Gm-Message-State: AOAM532TOE6GIYtLmZ5/Gxxx8hGHeAm3cmng9xIyB0AyK1KKsFwkVzCX
 RNH+9wDlppnqh9eAQu0vwLE=
X-Google-Smtp-Source: ABdhPJxIJ3v+ThxLDKyJCbADcryrWSRWUFaNpno1dzZoJzSizBf26q9IuX9mV1De5HSDzyz41F3n6g==
X-Received: by 2002:a63:381c:: with SMTP id f28mr6013197pga.361.1590018922642; 
 Wed, 20 May 2020 16:55:22 -0700 (PDT)
Received: from localhost.localdomain ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id d20sm2761882pjs.12.2020.05.20.16.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 16:55:22 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v6 6/7] wire in the dwc-hsotg (dwc2) USB host controller
 emulation
Date: Wed, 20 May 2020 16:53:48 -0700
Message-Id: <20200520235349.21215-7-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520235349.21215-1-pauldzim@gmail.com>
References: <20200520235349.21215-1-pauldzim@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=pauldzim@gmail.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wire the dwc-hsotg (dwc2) emulation into Qemu

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
Reviewed-by: Philippe Mathieu-Daude <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c         | 21 ++++++++++++++++++++-
 include/hw/arm/bcm2835_peripherals.h |  3 ++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 5e2c832d95..3b554cfac0 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -129,6 +129,13 @@ static void bcm2835_peripherals_init(Object *obj)
     /* Mphi */
     sysbus_init_child_obj(obj, "mphi", &s->mphi, sizeof(s->mphi),
                           TYPE_BCM2835_MPHI);
+
+    /* DWC2 */
+    sysbus_init_child_obj(obj, "dwc2", &s->dwc2, sizeof(s->dwc2),
+                          TYPE_DWC2_USB);
+
+    object_property_add_const_link(OBJECT(&s->dwc2), "dma-mr",
+                                   OBJECT(&s->gpu_bus_mr));
 }
 
 static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
@@ -386,6 +393,19 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
                                INTERRUPT_HOSTPORT));
 
+    /* DWC2 */
+    object_property_set_bool(OBJECT(&s->dwc2), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    memory_region_add_subregion(&s->peri_mr, USB_OTG_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->dwc2), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->dwc2), 0,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_USB));
+
     create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
     create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
     create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
@@ -399,7 +419,6 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
     create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
     create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
-    create_unimp(s, &s->dwc2, "dwc-usb2", USB_OTG_OFFSET, 0x1000);
     create_unimp(s, &s->sdramc, "bcm2835-sdramc", SDRAMC_OFFSET, 0x100);
 }
 
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 7a7a8f6141..48a0ad1633 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -27,6 +27,7 @@
 #include "hw/sd/bcm2835_sdhost.h"
 #include "hw/gpio/bcm2835_gpio.h"
 #include "hw/timer/bcm2835_systmr.h"
+#include "hw/usb/hcd-dwc2.h"
 #include "hw/misc/unimp.h"
 
 #define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
@@ -67,7 +68,7 @@ typedef struct BCM2835PeripheralState {
     UnimplementedDeviceState ave0;
     UnimplementedDeviceState bscsl;
     UnimplementedDeviceState smi;
-    UnimplementedDeviceState dwc2;
+    DWC2State dwc2;
     UnimplementedDeviceState sdramc;
 } BCM2835PeripheralState;
 
-- 
2.17.1


