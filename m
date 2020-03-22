Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16DDC1975A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 22:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9156E2070A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 22:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYRHktbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9156E2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG96Y-00070y-LD
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 18:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jG95X-0005nk-P5
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 18:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pauldzim@gmail.com>) id 1jG95W-0001oH-DG
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 18:28:59 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pauldzim@gmail.com>) id 1jG95W-0001o3-7d
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 18:28:58 -0400
Received: by mail-pj1-x1041.google.com with SMTP id np9so5214759pjb.4
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 15:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Vxb2BeSPk/Bmh9uLAezVoaXmCjxCb8Nm9qZIiQVVzXg=;
 b=cYRHktbvu9aziuY2NZyOwbi0CsyJUs8pVAF94hXRn1e4PUlpY3m7iirg5Bg6hOtbE4
 U+/7GGjRS2sgWlBwNWAWF5y365NRDnNO8H2GB704pESYMgpFdUaYLYIcXcK0gaB0p1Z8
 3Wn+HT2TcPgYgU4f/KURM84JFuLMhAvnR0ySCJkZHyiLXdd5TpG5Psf6Y4p94CY4isp4
 iznKKPB8G2W5kTlbfDmd4MOYtl8MPrOl7WNszH//yYTzBQvoVcCojm+SUHzaSXb5nhPV
 4aVN0JN45oIjtihWMCcbAvLSuuv27tcp3vR7WEbs/S8sjhe1HzpcVpuqg/tjLK9qjJYs
 4xRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Vxb2BeSPk/Bmh9uLAezVoaXmCjxCb8Nm9qZIiQVVzXg=;
 b=qn/y3vfyQnYgMGnjKTCLypO0NpPtXBfvd/pNLDFEKOfM5T/XL+tv8xhJeh+a/o+XDx
 79yId2eEj8FaifvWhmSSrBdKL/H79yvgDksQAKhTrbrO8Uex3KaoUmMiJV/o7dq8gzEX
 JkVXOR5Web1PqTdcpsUqxEJ3I3k8G87sYvcvbGKltXDVY/IMQSLzjeLu6tblgxHRamFf
 /EdvA4EPlH2+/gro9iEEzeBvG++ixeKVdK2ugZZOW5P3E/zSSjW6TSp7XA/QetHINdD9
 V+8jNOusJDzIBMghIi/pYoogIiYisRjYzka2uefWhOYvpwhM7y2Zu7FXKPSCxyLafgEi
 cEBQ==
X-Gm-Message-State: ANhLgQ2L2pf+7TMwVWTWIk0NXhWLKqlEQ7jn1J6BpZgPZcgWqkfwnYxz
 kV2GkpuNRsfdok0gh0+SPeQ=
X-Google-Smtp-Source: ADFU+vsB7eziAwR7qguk7cXZKccP0DuxMDYBea7rbRjjulP2wfM8+ochWUKMtj0oXX+i7x/B+ptEig==
X-Received: by 2002:a17:90b:3683:: with SMTP id
 mj3mr21426132pjb.153.1584916137232; 
 Sun, 22 Mar 2020 15:28:57 -0700 (PDT)
Received: from localhost.localdomain ([75.167.220.149])
 by smtp.gmail.com with ESMTPSA id e10sm11440315pfm.121.2020.03.22.15.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 15:28:56 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: kraxel@redhat.com
Subject: [PATCH 6/6] Wire in the dwc-hsotg USB host controller emulation
Date: Sun, 22 Mar 2020 15:27:26 -0700
Message-Id: <20200322222726.10244-7-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322222726.10244-1-pauldzim@gmail.com>
References: <20200322222726.10244-1-pauldzim@gmail.com>
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
Cc: peter.maydell@linaro.org, stefanha@gmail.com, qemu-devel@nongnu.org,
 Paul Zimmerman <pauldzim@gmail.com>, jsnow@redhat.com, f4bug@amsat.org
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


