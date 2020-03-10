Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B56C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A217208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNet5MhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A217208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBmVM-0002kK-O2
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 17:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBmU5-0000b6-VV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:32:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBmU4-00086V-EV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:32:17 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38929)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jBmU4-000850-7L; Tue, 10 Mar 2020 17:32:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id r15so12717837wrx.6;
 Tue, 10 Mar 2020 14:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UIByMOMQQIv55mL19I+5dwrlTsd6XzXiE+TBLVFchfk=;
 b=bNet5MhGmcoN5L9IpoNU7BBUEEEzMDHriLFwwYxNskJGjkgGYdn4bKI9jU8Olwh22m
 cR6g2uikc5JGrGdai4v8fKMWFQJ+MS0TweW6qmKVTOCQ3PoXSEeKJf1w846hN/wfEqzk
 2C7QGNL9ONR4hykdee7nCSMwsIpmhzOgYmNiQm2hPtvDF7aPijSvLCpAmfiztqPC2i7E
 5wr1s5FeoyTr+hvuLtDNS9GADUKHqMtBTLdwNoQmmNaaAk0B2DOyesDA89NuERPtSNr+
 5A8g+O9hIKWhFoRbQcYJDvlB6NpktI892HPbJCR7AiiN0euXtwcquOu85dgU+upMLfr6
 uvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UIByMOMQQIv55mL19I+5dwrlTsd6XzXiE+TBLVFchfk=;
 b=Vt9bEmdiiP5WTQrJq8JK4zlUNblme3swNiRNmJwO5uYtgin7Ijw22LopXuNBdAEcm3
 AI36g5DRN4IYZ1gn5frDMSqmLePyH4784tZyqD8xFUvgJByHlzdci+hCVcoehRn3eU4y
 KzqNdeHisn20/Pnla0JV/WQRx1Na3ncyCUWt+OFYQ+ukioyqdQ63OZGm1MNUGdwZtcmo
 tOyxjv2htCPF3YhNTwgiEygzNh2dfjDEfOb50kGc7XEJntsWSdF1kY11eOTjDu91VsFg
 lr8QpZ9Z7NELwTHJfk9vOwXZ5qJQUuMucr8/8Sb3pmY0+3eFCiiRcIQ/gUEzypGlPHBp
 CsMw==
X-Gm-Message-State: ANhLgQ16wPHec35y1Foh1YhaWxz1gs9QYCvEAfBXiVP7FJgz2qSK0FnN
 k/KhgaEjGb7XKicnhlP+V4U3/6x2
X-Google-Smtp-Source: ADFU+vvq57J5lNryIzCmeboybW2GKrFLHsA3Euv5krKtqPM9YuqPeXVgGLd0O10CxyaRJCUJ8zp+Sg==
X-Received: by 2002:a5d:508b:: with SMTP id a11mr10324147wrt.332.1583875934736; 
 Tue, 10 Mar 2020 14:32:14 -0700 (PDT)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id 2sm32803580wrf.79.2020.03.10.14.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 14:32:14 -0700 (PDT)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 04/18] hw/arm/allwinner-h3: add USB host controller
Date: Tue, 10 Mar 2020 22:31:49 +0100
Message-Id: <20200310213203.18730-5-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310213203.18730-1-nieklinnenbank@gmail.com>
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, jasowang@redhat.com,
 b.galvani@gmail.com, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Allwinner H3 System on Chip contains multiple USB 2.0 bus
connections which provide software access using the Enhanced
Host Controller Interface (EHCI) and Open Host Controller
Interface (OHCI) interfaces. This commit adds support for
both interfaces in the Allwinner H3 System on Chip.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/usb/hcd-ehci.h             |  1 +
 include/hw/arm/allwinner-h3.h |  8 +++++++
 hw/arm/allwinner-h3.c         | 44 +++++++++++++++++++++++++++++++++++
 hw/usb/hcd-ehci-sysbus.c      | 17 ++++++++++++++
 hw/arm/Kconfig                |  2 ++
 5 files changed, 72 insertions(+)

diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 0298238f0b..edb59311c4 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -342,6 +342,7 @@ typedef struct EHCIPCIState {
 #define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
 #define TYPE_PLATFORM_EHCI "platform-ehci-usb"
 #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
+#define TYPE_AW_H3_EHCI "aw-h3-ehci-usb"
 #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
 #define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
 #define TYPE_FUSBH200_EHCI "fusbh200-ehci-usb"
diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index abdc20871a..4f4dcbcd17 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -56,6 +56,14 @@ enum {
     AW_H3_SRAM_A1,
     AW_H3_SRAM_A2,
     AW_H3_SRAM_C,
+    AW_H3_EHCI0,
+    AW_H3_OHCI0,
+    AW_H3_EHCI1,
+    AW_H3_OHCI1,
+    AW_H3_EHCI2,
+    AW_H3_OHCI2,
+    AW_H3_EHCI3,
+    AW_H3_OHCI3,
     AW_H3_CCU,
     AW_H3_PIT,
     AW_H3_UART0,
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 1fff3c317b..c205f06738 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -28,6 +28,7 @@
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
 #include "hw/misc/unimp.h"
+#include "hw/usb/hcd-ehci.h"
 #include "sysemu/sysemu.h"
 #include "hw/arm/allwinner-h3.h"
 
@@ -36,6 +37,14 @@ const hwaddr allwinner_h3_memmap[] = {
     [AW_H3_SRAM_A1]    = 0x00000000,
     [AW_H3_SRAM_A2]    = 0x00044000,
     [AW_H3_SRAM_C]     = 0x00010000,
+    [AW_H3_EHCI0]      = 0x01c1a000,
+    [AW_H3_OHCI0]      = 0x01c1a400,
+    [AW_H3_EHCI1]      = 0x01c1b000,
+    [AW_H3_OHCI1]      = 0x01c1b400,
+    [AW_H3_EHCI2]      = 0x01c1c000,
+    [AW_H3_OHCI2]      = 0x01c1c400,
+    [AW_H3_EHCI3]      = 0x01c1d000,
+    [AW_H3_OHCI3]      = 0x01c1d400,
     [AW_H3_CCU]        = 0x01c20000,
     [AW_H3_PIT]        = 0x01c20c00,
     [AW_H3_UART0]      = 0x01c28000,
@@ -144,6 +153,14 @@ enum {
     AW_H3_GIC_SPI_UART3     =  3,
     AW_H3_GIC_SPI_TIMER0    = 18,
     AW_H3_GIC_SPI_TIMER1    = 19,
+    AW_H3_GIC_SPI_EHCI0     = 72,
+    AW_H3_GIC_SPI_OHCI0     = 73,
+    AW_H3_GIC_SPI_EHCI1     = 74,
+    AW_H3_GIC_SPI_OHCI1     = 75,
+    AW_H3_GIC_SPI_EHCI2     = 76,
+    AW_H3_GIC_SPI_OHCI2     = 77,
+    AW_H3_GIC_SPI_EHCI3     = 78,
+    AW_H3_GIC_SPI_OHCI3     = 79,
 };
 
 /* Allwinner H3 general constants */
@@ -284,6 +301,33 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
     qdev_init_nofail(DEVICE(&s->ccu));
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_H3_CCU]);
 
+    /* Universal Serial Bus */
+    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
+                         qdev_get_gpio_in(DEVICE(&s->gic),
+                                          AW_H3_GIC_SPI_EHCI0));
+    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI1],
+                         qdev_get_gpio_in(DEVICE(&s->gic),
+                                          AW_H3_GIC_SPI_EHCI1));
+    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI2],
+                         qdev_get_gpio_in(DEVICE(&s->gic),
+                                          AW_H3_GIC_SPI_EHCI2));
+    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI3],
+                         qdev_get_gpio_in(DEVICE(&s->gic),
+                                          AW_H3_GIC_SPI_EHCI3));
+
+    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI0],
+                         qdev_get_gpio_in(DEVICE(&s->gic),
+                                          AW_H3_GIC_SPI_OHCI0));
+    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI1],
+                         qdev_get_gpio_in(DEVICE(&s->gic),
+                                          AW_H3_GIC_SPI_OHCI1));
+    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI2],
+                         qdev_get_gpio_in(DEVICE(&s->gic),
+                                          AW_H3_GIC_SPI_OHCI2));
+    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI3],
+                         qdev_get_gpio_in(DEVICE(&s->gic),
+                                          AW_H3_GIC_SPI_OHCI3));
+
     /* UART0. For future clocktree API: All UARTS are connected to APB2_CLK. */
     serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART0], 2,
                    qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART0),
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 5b7991cffe..3730736540 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -131,6 +131,22 @@ static const TypeInfo ehci_exynos4210_type_info = {
     .class_init    = ehci_exynos4210_class_init,
 };
 
+static void ehci_aw_h3_class_init(ObjectClass *oc, void *data)
+{
+    SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    sec->capsbase = 0x0;
+    sec->opregbase = 0x10;
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);
+}
+
+static const TypeInfo ehci_aw_h3_type_info = {
+    .name          = TYPE_AW_H3_EHCI,
+    .parent        = TYPE_SYS_BUS_EHCI,
+    .class_init    = ehci_aw_h3_class_init,
+};
+
 static void ehci_tegra2_class_init(ObjectClass *oc, void *data)
 {
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
@@ -252,6 +268,7 @@ static void ehci_sysbus_register_types(void)
     type_register_static(&ehci_type_info);
     type_register_static(&ehci_platform_type_info);
     type_register_static(&ehci_exynos4210_type_info);
+    type_register_static(&ehci_aw_h3_type_info);
     type_register_static(&ehci_tegra2_type_info);
     type_register_static(&ehci_ppc4xx_type_info);
     type_register_static(&ehci_fusbh200_type_info);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index fcdc651b73..f6422d5466 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -304,6 +304,8 @@ config ALLWINNER_H3
     select ARM_TIMER
     select ARM_GIC
     select UNIMP
+    select USB_OHCI
+    select USB_EHCI_SYSBUS
 
 config RASPI
     bool
-- 
2.17.1


