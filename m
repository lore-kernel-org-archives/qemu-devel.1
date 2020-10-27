Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A45C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5634A20760
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bs1nIZdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5634A20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOCJ-00077a-Af
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPb-0001QK-Ni
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:11 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:36764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPV-0004XM-62
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id e2so1112579wme.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=X7uOSaT4+NEmGsS3Sa10/nxLRLmxvsH4P3hJjeSn+vY=;
 b=Bs1nIZdGzQ8bSxRCZ1o3vsxg1dmZxFDqpuEfzu3Jh7sHPmzSldB5/aUUEMNN4vT0oX
 YRwf7+Df7Nq7CdfsCCJTSbdTqIbxEQ6ISNtUIwU0DHWcQTX4AU3uHmR7ONAqz5L9bc8E
 vBG3S9mHh8FysUoffj5sWLWDyQBOpJPceCfiNKlOzoTqUvYVWBEVbB3hgcyDin7p91hy
 6Tvs7gz9RFYcKfM/rCyzWdxsT9CWoBkFrPYa8xKMFV7E4eQ+u9FYHkndXOspooTJSBnA
 y/EdaIhMPelun3klBtQDM3HSlhpymMb2/8UYYf8RfbnxNeboHi/6pvdShlYzjTTc7eug
 H2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X7uOSaT4+NEmGsS3Sa10/nxLRLmxvsH4P3hJjeSn+vY=;
 b=ZFTDlvex/E5ypBpl1lJ8Tye9mWzeET3ko/+YF95vQlK7fFXv7LleoK5O+GcvPfnKT2
 E1f99CGF7LwlufZTfDtF7ZISWRa9GncbI+viSaDyf/C7xutfxqp9mgB0MMOcEVPGxmua
 XxHAnGaT+C5nreyneunCbxJ+jtvbOcbjGSudty0rJP4DLZdKI+sb7RVvrlMkImFJTb2m
 yYMRNFmG5UotWMSQi8nQBMUiE1AGUdBTIpiuA/yOzZnoFaMM+/DFFmX/MOv+ctGjgQCn
 zOTgF/fDq/Q6D8NYqchxgKZJflO9P2Oz6OgPw6iPN2Q9DNn4lu9R7kJlCSovjS7Gvq5x
 rR9Q==
X-Gm-Message-State: AOAM5313Eq00RQEwS+PV3Bawv/98D/8d2tGk9Dp9a3Xb4iy/pB9aMXJu
 12PSG2VP9uvz1uJJ6p+AiuHHcWsrxrfk3w==
X-Google-Smtp-Source: ABdhPJzt13iOWpwAbXp99ayOTq7hNW+XHoRT3CqK7KPIHponzAA+fpi5Q9wom0ixCodO2nyjHs/WcQ==
X-Received: by 2002:a7b:c015:: with SMTP id c21mr2286257wmb.22.1603799103404; 
 Tue, 27 Oct 2020 04:45:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/48] hw/arm/npcm7xx: Add EHCI and OHCI controllers
Date: Tue, 27 Oct 2020 11:44:08 +0000
Message-Id: <20201027114438.17662-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Havard Skinnemoen <hskinnemoen@google.com>

The NPCM730 and NPCM750 chips have a single USB host port shared between
a USB 2.0 EHCI host controller and a USB 1.1 OHCI host controller. This
adds support for both of them.

Testing notes:
  * With -device usb-kbd, qemu will automatically insert a full-speed
    hub, and the keyboard becomes controlled by the OHCI controller.
  * With -device usb-kbd,bus=usb-bus.0,port=1, the keyboard is directly
    attached to the port without any hubs, and the device becomes
    controlled by the EHCI controller since it's high speed capable.
  * With -device usb-kbd,bus=usb-bus.0,port=1,usb_version=1, the
    keyboard is directly attached to the port, but it only advertises
    itself as full-speed capable, so it becomes controlled by the OHCI
    controller.

In all cases, the keyboard device enumerates correctly.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/nuvoton.rst |  2 +-
 hw/usb/hcd-ehci.h           |  1 +
 include/hw/arm/npcm7xx.h    |  4 ++++
 hw/arm/npcm7xx.c            | 27 +++++++++++++++++++++++++--
 hw/usb/hcd-ehci-sysbus.c    | 19 +++++++++++++++++++
 5 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index 4342434df4a..99fc61c740c 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -39,6 +39,7 @@ Supported devices
  * OTP controllers (no protection features)
  * Flash Interface Unit (FIU; no protection features)
  * Random Number Generator (RNG)
+ * USB host (USBH)
 
 Missing devices
 ---------------
@@ -54,7 +55,6 @@ Missing devices
    * eSPI slave interface
 
  * Ethernet controllers (GMAC and EMC)
- * USB host (USBH)
  * USB device (USBD)
  * SMBus controller (SMBF)
  * Peripheral SPI controller (PSPI)
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index fd122dd4cdd..a173707d9bf 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -344,6 +344,7 @@ struct EHCIPCIState {
 #define TYPE_PLATFORM_EHCI "platform-ehci-usb"
 #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
 #define TYPE_AW_H3_EHCI "aw-h3-ehci-usb"
+#define TYPE_NPCM7XX_EHCI "npcm7xx-ehci-usb"
 #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
 #define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
 #define TYPE_FUSBH200_EHCI "fusbh200-ehci-usb"
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 761f9b987ed..aeee1beaaa4 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -25,6 +25,8 @@
 #include "hw/nvram/npcm7xx_otp.h"
 #include "hw/timer/npcm7xx_timer.h"
 #include "hw/ssi/npcm7xx_fiu.h"
+#include "hw/usb/hcd-ehci.h"
+#include "hw/usb/hcd-ohci.h"
 #include "target/arm/cpu.h"
 
 #define NPCM7XX_MAX_NUM_CPUS    (2)
@@ -77,6 +79,8 @@ typedef struct NPCM7xxState {
     NPCM7xxOTPState     fuse_array;
     NPCM7xxMCState      mc;
     NPCM7xxRNGState     rng;
+    EHCISysBusState     ehci;
+    OHCISysBusState     ohci;
     NPCM7xxFIUState     fiu[2];
 } NPCM7xxState;
 
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index cb4db41c542..c1d122576b7 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -46,6 +46,10 @@
 #define NPCM7XX_MC_BA           (0xf0824000)
 #define NPCM7XX_RNG_BA          (0xf000b000)
 
+/* USB Host modules */
+#define NPCM7XX_EHCI_BA         (0xf0806000)
+#define NPCM7XX_OHCI_BA         (0xf0807000)
+
 /* Internal AHB SRAM */
 #define NPCM7XX_RAM3_BA         (0xc0008000)
 #define NPCM7XX_RAM3_SZ         (4 * KiB)
@@ -90,6 +94,8 @@ enum NPCM7xxInterrupt {
     NPCM7XX_WDG0_IRQ            = 47,   /* Timer Module 0 Watchdog */
     NPCM7XX_WDG1_IRQ,                   /* Timer Module 1 Watchdog */
     NPCM7XX_WDG2_IRQ,                   /* Timer Module 2 Watchdog */
+    NPCM7XX_EHCI_IRQ            = 61,
+    NPCM7XX_OHCI_IRQ            = 62,
 };
 
 /* Total number of GIC interrupts, including internal Cortex-A9 interrupts. */
@@ -263,6 +269,9 @@ static void npcm7xx_init(Object *obj)
         object_initialize_child(obj, "tim[*]", &s->tim[i], TYPE_NPCM7XX_TIMER);
     }
 
+    object_initialize_child(obj, "ehci", &s->ehci, TYPE_NPCM7XX_EHCI);
+    object_initialize_child(obj, "ohci", &s->ohci, TYPE_SYSBUS_OHCI);
+
     QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_fiu) != ARRAY_SIZE(s->fiu));
     for (i = 0; i < ARRAY_SIZE(s->fiu); i++) {
         object_initialize_child(obj, npcm7xx_fiu[i].name, &s->fiu[i],
@@ -380,6 +389,22 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->rng), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->rng), 0, NPCM7XX_RNG_BA);
 
+    /* USB Host */
+    object_property_set_bool(OBJECT(&s->ehci), "companion-enable", true,
+                             &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->ehci), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci), 0, NPCM7XX_EHCI_BA);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci), 0,
+                       npcm7xx_irq(s, NPCM7XX_EHCI_IRQ));
+
+    object_property_set_str(OBJECT(&s->ohci), "masterbus", "usb-bus.0",
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->ohci), "num-ports", 1, &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->ohci), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ohci), 0, NPCM7XX_OHCI_BA);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ohci), 0,
+                       npcm7xx_irq(s, NPCM7XX_OHCI_IRQ));
+
     /*
      * Flash Interface Unit (FIU). Can fail if incorrect number of chip selects
      * specified, but this is a programming error.
@@ -464,8 +489,6 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("npcm7xx.mcphy",        0xf05f0000,  64 * KiB);
     create_unimplemented_device("npcm7xx.gmac1",        0xf0802000,   8 * KiB);
     create_unimplemented_device("npcm7xx.gmac2",        0xf0804000,   8 * KiB);
-    create_unimplemented_device("npcm7xx.ehci",         0xf0806000,   4 * KiB);
-    create_unimplemented_device("npcm7xx.ohci",         0xf0807000,   4 * KiB);
     create_unimplemented_device("npcm7xx.vcd",          0xf0810000,  64 * KiB);
     create_unimplemented_device("npcm7xx.ece",          0xf0820000,   8 * KiB);
     create_unimplemented_device("npcm7xx.vdma",         0xf0822000,   8 * KiB);
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 3730736540f..e3758db1b18 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -147,6 +147,24 @@ static const TypeInfo ehci_aw_h3_type_info = {
     .class_init    = ehci_aw_h3_class_init,
 };
 
+static void ehci_npcm7xx_class_init(ObjectClass *oc, void *data)
+{
+    SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    sec->capsbase = 0x0;
+    sec->opregbase = 0x10;
+    sec->portscbase = 0x44;
+    sec->portnr = 1;
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);
+}
+
+static const TypeInfo ehci_npcm7xx_type_info = {
+    .name          = TYPE_NPCM7XX_EHCI,
+    .parent        = TYPE_SYS_BUS_EHCI,
+    .class_init    = ehci_npcm7xx_class_init,
+};
+
 static void ehci_tegra2_class_init(ObjectClass *oc, void *data)
 {
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
@@ -269,6 +287,7 @@ static void ehci_sysbus_register_types(void)
     type_register_static(&ehci_platform_type_info);
     type_register_static(&ehci_exynos4210_type_info);
     type_register_static(&ehci_aw_h3_type_info);
+    type_register_static(&ehci_npcm7xx_type_info);
     type_register_static(&ehci_tegra2_type_info);
     type_register_static(&ehci_ppc4xx_type_info);
     type_register_static(&ehci_fusbh200_type_info);
-- 
2.20.1


