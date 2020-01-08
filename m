Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1E9C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995512072A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9wIpcHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995512072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipHeZ-0003xm-DY
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 15:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ipHVV-0001IS-52
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ipHVT-0002XI-30
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:00:44 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44699)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ipHVR-0002V9-9R; Wed, 08 Jan 2020 15:00:42 -0500
Received: by mail-wr1-x441.google.com with SMTP id q10so4722844wrm.11;
 Wed, 08 Jan 2020 12:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fHH6DgmLJkiSaZwTfEnCvDBqi+9qRJn0N0Z2l2a/qS4=;
 b=Y9wIpcHFF7lzGNAtPVv1J5pzctmoIcFJvub9HPskz4zHpmBatGsrwZB7I1RS7U5suS
 53kvI/qadmH+pSSPOqrRdKEbONBYx4c0m28XytnTUJrdOFhbExreWSDEwaSZvXy+VRRD
 iRoLa72D0Cuo/bnUL2zCBT9Kd2yLge9D83RDktRaSLz/cxCm/DGl90oeG4jdaWtPGUqk
 iRujNdhWbiGq16Mj4VAZ2Bn/WHnkq85gUiVOVM932BRyNMqJ4AR0KtuqAoTZUYEZo6jU
 uCLigF26Xp2iXuLrLC3MuPjaI0ZhjwkRDMqo2IPDsnEUbaWEEGLl/c7f/1fT3wQv/uoM
 tEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fHH6DgmLJkiSaZwTfEnCvDBqi+9qRJn0N0Z2l2a/qS4=;
 b=ucujr+gGIetigt7GKjh6Ye01OujteukC9/GmcaMXHOUzPyjSU/zoGKSUbofMR5I0d3
 /gbakrlugnEILTnnv6BidDNEUy9Xp0GbsW2i0VRlxnr7559MRAN9WyXAOsIy8sE8qZLL
 RhM+niIZBM8ioB5x9vuiAzdzeoocIDB/8gLLbwXtDWMn289N06Obm2z3YYOrkSyIwdYn
 bTsbPL0bryCblUH3+CNJjo9yKHWdPSS2tyeBRAz3bx6m5KzegjLH6dSm4jUoc5LPGG5A
 CX4DARdRuSkNDBnubtop/ob+V/vNBMQ+/NN5sxgbJQ6RgzUxWl3KgeyG7AYl0S8Ow9AG
 1eSg==
X-Gm-Message-State: APjAAAXRJbRdlWU5E/yCuNnpWoMLpfeSVJfYHXnsiO7fdHdCxWypAs7/
 AXQP6GA/lkSO+w+NGaIrqFh7LzT/
X-Google-Smtp-Source: APXvYqxJBTucIGkTWVYPiQeznA6Wf6Mjqand58cnh+86LEOwmXzK932OtiKFKb1gf3jHkGY3qsM9ig==
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr6416050wrn.214.1578513639948; 
 Wed, 08 Jan 2020 12:00:39 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id u18sm4970099wrt.26.2020.01.08.12.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 12:00:39 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/17] hw/arm/allwinner-h3: add USB host controller
Date: Wed,  8 Jan 2020 21:00:07 +0100
Message-Id: <20200108200020.4745-5-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108200020.4745-1-nieklinnenbank@gmail.com>
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: peter.maydell@linaro.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, philmd@redhat.com
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
---
 hw/usb/hcd-ehci.h             |  1 +
 include/hw/arm/allwinner-h3.h |  8 ++++++
 hw/arm/allwinner-h3.c         | 52 ++++++++++++++++++++++++++++++++---
 hw/usb/hcd-ehci-sysbus.c      | 17 ++++++++++++
 4 files changed, 74 insertions(+), 4 deletions(-)

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
index 0dc18b927a..e03d3f318f 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -60,6 +60,14 @@ enum {
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
index b85edaea85..1dc3209c03 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
 #include "hw/misc/unimp.h"
+#include "hw/usb/hcd-ehci.h"
 #include "sysemu/sysemu.h"
 #include "hw/arm/allwinner-h3.h"
 
@@ -34,6 +35,14 @@ const hwaddr allwinner_h3_memmap[] = {
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
@@ -71,10 +80,10 @@ struct AwH3Unimplemented {
     { "msgbox",    0x01c17000, 4 * KiB },
     { "spinlock",  0x01c18000, 4 * KiB },
     { "usb0-otg",  0x01c19000, 4 * KiB },
-    { "usb0",      0x01c1a000, 4 * KiB },
-    { "usb1",      0x01c1b000, 4 * KiB },
-    { "usb2",      0x01c1c000, 4 * KiB },
-    { "usb3",      0x01c1d000, 4 * KiB },
+    { "usb0-phy",  0x01c1a000, 4 * KiB },
+    { "usb1-phy",  0x01c1b000, 4 * KiB },
+    { "usb2-phy",  0x01c1c000, 4 * KiB },
+    { "usb3-phy",  0x01c1d000, 4 * KiB },
     { "smc",       0x01c1e000, 4 * KiB },
     { "pio",       0x01c20800, 1 * KiB },
     { "owa",       0x01c21000, 1 * KiB },
@@ -142,6 +151,14 @@ enum {
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
 
 /* Allwinner H3 constants */
@@ -285,6 +302,33 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
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
     /* UART0 */
     serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART0], 2,
                    qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART0),
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 020211fd10..174c3446ef 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -145,6 +145,22 @@ static const TypeInfo ehci_exynos4210_type_info = {
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
@@ -267,6 +283,7 @@ static void ehci_sysbus_register_types(void)
     type_register_static(&ehci_platform_type_info);
     type_register_static(&ehci_xlnx_type_info);
     type_register_static(&ehci_exynos4210_type_info);
+    type_register_static(&ehci_aw_h3_type_info);
     type_register_static(&ehci_tegra2_type_info);
     type_register_static(&ehci_ppc4xx_type_info);
     type_register_static(&ehci_fusbh200_type_info);
-- 
2.17.1


