Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D4CC83002
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 02:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5931420728
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 02:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFsmWQ6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5931420728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39297 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTFwa-0008F1-F8
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 22:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jTFvO-0005y5-JK
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jTFvN-00031k-UB
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:24:42 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jTFvN-00031a-GB
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:24:41 -0400
Received: by mail-pl1-x644.google.com with SMTP id d24so7738303pll.8
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 19:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Tf8EQAF+ZTc1N/HfYHCJ8rIYW0hUBmd3JmFY5ozCfSg=;
 b=VFsmWQ6FyGFp3NXO59v+nbz/p0k9SwqWzX8kwRWZNICmvtREzEOEOyeuauQ87Ij5Ro
 ZtsZbP+AHfjQIgo5ZuX/OfeU/hktyHwdcmUDOb3cza88r2rERubEPjCvB74KSoxEr3ul
 xOEAVI9LJeY94/9073zAEbB4X3OTf/54azhT96rqeYwOow3E/Q5NG2zahXrGC7YcJamN
 v8R2UZjAYlBFJsnpkrFWKG07mbQQVLi/Vx1DOli1eRh53iDIGLa0GB0/Rjv7ux1BtiQj
 6GAzMxeTu6ULB76wBe7OSvLaGNLKiNh7uE0fPMvTx2TXzK7tioDHuNg/jyOjh3aUQGw+
 /OPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Tf8EQAF+ZTc1N/HfYHCJ8rIYW0hUBmd3JmFY5ozCfSg=;
 b=GoBFPMzLWJQ32aoulaHQ8nRggxAn3XtTtT4GNwUtp7p986pajPXIgw4igYRlcgQBUI
 UvVbqhAIiDHkvPM0pI5TnhWfeklTvRWk6GxLn+/g5iIGVkMiW/0m4RrkSh+ZUdIr8INs
 Rwv5Fj7WNYsSVLTNPnYO8dAIwHLIEFyA7JWWgJUT+rEdK06UVgRAP0IAbVuqFkaelqrG
 lcl3NhaFoC1SHMBpzU3OG8HDX/WpDaDEa1PECVb6OiGiczn7a48I3Duulgb/K69/z6x5
 xv2q/PBxTlA/5+OCc8KS3k/VBEoFnKKclHQo+R4hVOaoaxc2pVMXakUqjt4gDtYxP+BS
 Aeaw==
X-Gm-Message-State: AGi0PuYaAy56f68F/YbHvFn9ucg7oFJd+IvBlGAEyj7ArKzjUAJy7/ce
 oOfCz9pByh/q0VMpY9He+os=
X-Google-Smtp-Source: APiQypIq0vLsayXoVGNRlzomZxT6kXqvWevcxcbN5Feu2ZZYgsDltCvMB8rGBMlXVnjkh7nIKFXP8A==
X-Received: by 2002:a17:902:9a8a:: with SMTP id
 w10mr27408174plp.259.1588040680168; 
 Mon, 27 Apr 2020 19:24:40 -0700 (PDT)
Received: from localhost.localdomain ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id z190sm11695649pgz.73.2020.04.27.19.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 19:24:39 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 6/7] wire in the dwc-hsotg (dwc2) USB host controller
 emulation
Date: Mon, 27 Apr 2020 19:22:31 -0700
Message-Id: <20200428022232.18875-7-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428022232.18875-1-pauldzim@gmail.com>
References: <20200428022232.18875-1-pauldzim@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=pauldzim@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wire the dwc-hsotg (dwc2) emulation into Qemu

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
---
 hw/arm/bcm2835_peripherals.c         | 21 ++++++++++++++++++++-
 include/hw/arm/bcm2835_peripherals.h |  3 ++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 5e2c832d95..3b554cfac0 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -128,6 +128,13 @@ static void bcm2835_peripherals_init(Object *obj)
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
@@ -385,6 +392,19 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
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
@@ -398,7 +418,6 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
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


