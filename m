Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B2AC43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 00:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009C720732
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 00:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvchd/Ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009C720732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jILhc-0007Ln-5k
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 20:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jILf1-0002i2-Rz
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 20:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pauldzim@gmail.com>) id 1jILf0-0007YG-DB
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 20:18:43 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pauldzim@gmail.com>) id 1jILf0-0007XY-7F
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 20:18:42 -0400
Received: by mail-pg1-x542.google.com with SMTP id o26so6737677pgc.12
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2020 17:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Vxb2BeSPk/Bmh9uLAezVoaXmCjxCb8Nm9qZIiQVVzXg=;
 b=lvchd/CaLbLiYJ61sSXiQcwkegIwd68IvTFEfwpzTLafmh6Ydu1NbgTQb38NvB0VxX
 oqxyzciMHDppTTnwBZZoJyulcMC6M9Z4odtAkPAtluI34UCkQXK2pTtFYbYuZeeXbpKL
 b5t436u0liD7F4rZowhPvUdggBrmyOnZ1lQGkALG+z2zJO4SyZb1Z1f0E03L2vbA/0/q
 BNyV01db/vVyMNn/O1LghOKjGcbhoQ0HwHJnFrTwGS3G503d5SMssIyGtky5i4fjxw9g
 zb3tuBf4/lAVeOY618HsNT5lOjSIeBYk8jvDV6AfYrAlnrrShCUJCHwmiFjc8nXJf5mf
 6zoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Vxb2BeSPk/Bmh9uLAezVoaXmCjxCb8Nm9qZIiQVVzXg=;
 b=Z43LRJmb0NLJAaCtzfsZ2iANCF8Sg8xHEQm8ad7Br1AOTtMM9/NsTOk26s/MursRFq
 WelJv1i6i5KgTGgRRpH5Mtm7EbiUObmiWna3yPqIdKd9oWQ/rh6WVNiWWm8wtnMlFxs0
 SbGl0BKaE4PPWRcZ2FF/CPSyZULliN87t2zvDVICE7VMec28GjoVRJBAE3JenE0Jy11M
 MbUmo6YdW6E8nTX5vWnfcZEZDo9tv0BHRONDxxD0HdmuZejWkGB5aYv3XLnhZdZGhOux
 EESmMEnlJaUWBYdiDmwllGqt6CDVJ0rhqBJpy+aFKRu5HSSmtRhlZLuqTh0MaYzynf4f
 nrPA==
X-Gm-Message-State: ANhLgQ0NXRMz2TLI7U3JNGO6cVCK1l2Aq75vjxk4A9f7d47qMJRvwRjY
 LZK42hsYuQ6tDCLFUNpft6E=
X-Google-Smtp-Source: ADFU+vuEUFBBhozXQYI8pkmMbI8wJ3+AccG7hRlkIT3/yrIKFPIN9F/GtdJYR9ZsTNoiLqckfYLCQw==
X-Received: by 2002:aa7:9844:: with SMTP id n4mr5979063pfq.98.1585441119630;
 Sat, 28 Mar 2020 17:18:39 -0700 (PDT)
Received: from paulz-G33T-M.Home ([75.167.220.149])
 by smtp.gmail.com with ESMTPSA id u14sm6626890pgg.67.2020.03.28.17.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2020 17:18:39 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 6/6] Wire in the dwc-hsotg USB host controller emulation
Date: Sat, 28 Mar 2020 17:17:05 -0700
Message-Id: <20200329001705.15966-7-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200329001705.15966-1-pauldzim@gmail.com>
References: <20200329001705.15966-1-pauldzim@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Paul Zimmerman <pauldzim@gmail.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wire the dwc-hsotg (dwc2) emulation into Qemu

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
---
 hw/arm/bcm2835_peripherals.c         | 21 ++++++++++++++++++++-
 hw/usb/Kconfig                       |  5 +++++
 hw/usb/Makefile.objs                 |  1 +
 include/hw/arm/bcm2835_peripherals.h |  3 ++-
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index dd7e6883cb..932d084a50 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -127,6 +127,13 @@ static void bcm2835_peripherals_init(Object *obj)
     sysbus_init_child_obj(obj, "mphi", &s->mphi, sizeof(s->mphi),
                           TYPE_BCM2835_MPHI);
 
+    /* DWC2 */
+    sysbus_init_child_obj(obj, "dwc2", &s->dwc2, sizeof(s->dwc2),
+                          TYPE_DWC2_USB);
+
+    object_property_add_const_link(OBJECT(&s->dwc2), "dma-mr",
+                                   OBJECT(&s->gpu_bus_mr), &error_abort);
+
     object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
                                    OBJECT(&s->sdhci.sdbus), &error_abort);
     object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
@@ -384,6 +391,19 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
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
@@ -397,7 +417,6 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
     create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
     create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
-    create_unimp(s, &s->dwc2, "dwc-usb2", USB_OTG_OFFSET, 0x1000);
     create_unimp(s, &s->sdramc, "bcm2835-sdramc", SDRAMC_OFFSET, 0x100);
 }
 
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 464348ba14..d4d8c37c28 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -46,6 +46,11 @@ config USB_MUSB
     bool
     select USB
 
+config USB_DWC2
+    bool
+    default y
+    select USB
+
 config TUSB6010
     bool
     select USB_MUSB
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 66835e5bf7..fa5c3fa1b8 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -12,6 +12,7 @@ common-obj-$(CONFIG_USB_EHCI_SYSBUS) += hcd-ehci-sysbus.o
 common-obj-$(CONFIG_USB_XHCI) += hcd-xhci.o
 common-obj-$(CONFIG_USB_XHCI_NEC) += hcd-xhci-nec.o
 common-obj-$(CONFIG_USB_MUSB) += hcd-musb.o
+common-obj-$(CONFIG_USB_DWC2) += hcd-dwc2.o
 
 common-obj-$(CONFIG_TUSB6010) += tusb6010.o
 common-obj-$(CONFIG_IMX)      += chipidea.o
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 77958ca60e..0841d54614 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -26,6 +26,7 @@
 #include "hw/sd/bcm2835_sdhost.h"
 #include "hw/gpio/bcm2835_gpio.h"
 #include "hw/timer/bcm2835_systmr.h"
+#include "hw/usb/hcd-dwc2.h"
 #include "hw/misc/unimp.h"
 
 #define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
@@ -66,7 +67,7 @@ typedef struct BCM2835PeripheralState {
     UnimplementedDeviceState ave0;
     UnimplementedDeviceState bscsl;
     UnimplementedDeviceState smi;
-    UnimplementedDeviceState dwc2;
+    DWC2State dwc2;
     UnimplementedDeviceState sdramc;
 } BCM2835PeripheralState;
 
-- 
2.17.1


