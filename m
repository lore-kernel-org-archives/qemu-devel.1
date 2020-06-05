Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847A8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502172077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKXigGze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502172077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFgt-0004YS-Im
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFYD-0001z0-4N
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:54295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFYB-0001ho-PW
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:36 -0400
Received: by mail-wm1-x32a.google.com with SMTP id g10so9049880wmh.4
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=h+cs/dbYYlYfUunXToQM41Sl4OQe3x5+V7cpaaBqUqY=;
 b=zKXigGzen5s1E8x3VuW4NFFYrXoAlOorXwdFBSFrtkdrQfNV7FvYkAQc6hDdT6M3gU
 9JrVj+bT67AIBvs8AewJTYq8ejUij0QJmaUltGPWBQeNl1rKztBt6QKLv0wIKajtAktN
 UpyMA97HZIS/hFopp6wWtIDupnraT1zjIGgffRSOPKgkatbbhOIFhq8sncOfxIR7ajLU
 ChTA8N10RchqDNK6t+iF5P6xhjK9dVaSCfNxYj4eEsO1nm/ZUE/ACNRUy2AvRENBUTkt
 IESlMOaQUERTxcYdBleuawKmrkrsanDA5nhdFKtRVmaTv/TZ13vqqMyNuG7kb9ltsdLs
 PUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h+cs/dbYYlYfUunXToQM41Sl4OQe3x5+V7cpaaBqUqY=;
 b=uB+cDB0/piIe38GnJqmzMTzcTmGt56DXYYNu1LZalwwBt3Znw4r632PyXX2x3oSNbe
 Uefovfoy6MV2ewKHZp/GszzQYSC6cmF9gNxhowmFG4s4w7PfbES4DySD7jNc3piA5QVT
 8NlNmICzLQQsId0iHjuQ9pS1gceLGpxJfMwz5/OJzh3uBUVT6jTBxomlwm5kK+1b0NwN
 9HKR0dJ1GIA78pUJXHWl004z0Qgz5h1DVb9O3E/qtVQU5DsHw/BxdNVOwffpr14rerH0
 9C4qpZ5jbKlfywlLK3lJKDjb2GkknAg8Q53qBzo2HLU9bfnGCppRpqbyPPvUFuV9nw66
 fZjA==
X-Gm-Message-State: AOAM532oRDpvnCuvrLU6JwpOLc05EYEQpjuPpMo+ukPAbx3UWogPj9K4
 ZCCzQ26Gbvgmtc42u0l6IFeUqVjpTVLjNw==
X-Google-Smtp-Source: ABdhPJysSySWxEurnI84mnJjeRHsbERNIiFVl7NnAuR1VCz1aeEcO8ypl/tE+K2+8HQzrsv9HBaMkQ==
X-Received: by 2002:a05:600c:24c:: with SMTP id
 12mr3738479wmj.28.1591375831055; 
 Fri, 05 Jun 2020 09:50:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/29] wire in the dwc-hsotg (dwc2) USB host controller
 emulation
Date: Fri,  5 Jun 2020 17:49:57 +0100
Message-Id: <20200605165007.12095-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paul Zimmerman <pauldzim@gmail.com>

Wire the dwc-hsotg (dwc2) emulation into Qemu

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
Reviewed-by: Philippe Mathieu-Daude <f4bug@amsat.org>
Message-id: 20200520235349.21215-7-pauldzim@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2835_peripherals.h |  3 ++-
 hw/arm/bcm2835_peripherals.c         | 21 ++++++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 7a7a8f61414..48a0ad16335 100644
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
 
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index b3e0495040d..cca5b5ad04f 100644
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
@@ -377,6 +384,19 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
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
@@ -390,7 +410,6 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
     create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
     create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
-    create_unimp(s, &s->dwc2, "dwc-usb2", USB_OTG_OFFSET, 0x1000);
     create_unimp(s, &s->sdramc, "bcm2835-sdramc", SDRAMC_OFFSET, 0x100);
 }
 
-- 
2.20.1


