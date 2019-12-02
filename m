Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F52C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8419120722
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zzf9Oofc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8419120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44961 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibtcZ-000746-Dr
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 16:52:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ibsxc-0002e4-R8
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ibsxQ-0000h7-QA
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:10:19 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ibsxM-0000Yv-M5; Mon, 02 Dec 2019 16:10:09 -0500
Received: by mail-wm1-x343.google.com with SMTP id p17so1104368wmi.3;
 Mon, 02 Dec 2019 13:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KLiQATngYVxKEhubgojMgx0rCFF3IHtRu91h6RNCkKo=;
 b=Zzf9OofcZJUPgAFukp7W3plQeSrCvtZlB3w08FQWUlrvc1cOJJKd/V9lfWDnvp/uvB
 DU4nmVsjqPdvbdW30q4RQwg386IMMyvgbSpZqqCaeouPfeRmaZWQQHEaOxa2frHitFE5
 may7cKBTmnAu38A6Xp2ckW/dpHBWoRxtfEKwoNpIuBn+4duzdvgeiIRjjiMvhMHnCCl1
 5Uaf53f6a9iyXnzff8IwqUanYIcGePlR8FHTm8rtBlNdWcRyMJhDIHBea1PGTmw4NxKK
 JH6ANxMWIS9yltWaRz/v4lal6C2zIktWISXu9fTbmdBxnIjwWdNK0R66Du5IG0M6DgrR
 aKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KLiQATngYVxKEhubgojMgx0rCFF3IHtRu91h6RNCkKo=;
 b=j093eMlVXD5wl+sgDiYn6qaf9VWAMIacJdNtuqHaqYflM/XRVlQkkgV3v4/zzhlOju
 nEnpZ/pVQalKea3X4vHixlmo5io5gO2hn1tWhwVtgat05RUAOWw1xzoCy1kvlN3CkkTp
 Oc7nPnmo+hoOI6ywtzZBy5PtAhssuzuNUyECzqZLSo+Pfi8OzCre9ccBt1T297dLcQpy
 P20fSJ3C1nXpxO3ewDEOyU1yIaCaWWQnuK3+sIZH41O81Qzdwo538XWD6FDg0uKcPO9r
 7UUBD4E8dlnwwScjx5dEkiKMPrWs8UToglzr1jsguGf3f/oLTcmmB6RnhtbUOrmzvJm4
 Vxbg==
X-Gm-Message-State: APjAAAUgnkGsGTodg9eIAVkjx6UolJT6P00MlVxFwD95X5Sd+Mrq5qvR
 0xzHzugb39cHppMYIGhuKB4Ke0Rs
X-Google-Smtp-Source: APXvYqzsCs/54zu5WwvX5AIRGqqFYZ/xh6JgPfmACi7UrEIyvtFQ2f81q5C4DBUfolCRWIjdzP6UGg==
X-Received: by 2002:a1c:f610:: with SMTP id w16mr12606830wmc.34.1575321000343; 
 Mon, 02 Dec 2019 13:10:00 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id f1sm770859wrp.93.2019.12.02.13.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 13:09:59 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/10] arm: allwinner-h3: add USB host controller
Date: Mon,  2 Dec 2019 22:09:41 +0100
Message-Id: <20191202210947.3603-5-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202210947.3603-1-nieklinnenbank@gmail.com>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
X-Mailman-Approved-At: Mon, 02 Dec 2019 16:38:22 -0500
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Allwinner H3 System on Chip contains multiple USB 2.0 bus
connections which provide software access using the Enhanced
Host Controller Interface (EHCI) and Open Host Controller
Interface (OHCI) interfaces. This commit adds support for
both interfaces in the Allwinner H3 System on Chip.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 hw/arm/allwinner-h3.c    | 20 ++++++++++++++++++++
 hw/usb/hcd-ehci-sysbus.c | 17 +++++++++++++++++
 hw/usb/hcd-ehci.h        |  1 +
 3 files changed, 38 insertions(+)

diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 5566e979ec..afeb49c0ac 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/allwinner-h3.h"
 #include "hw/misc/unimp.h"
+#include "hw/usb/hcd-ehci.h"
 #include "sysemu/sysemu.h"
 
 static void aw_h3_init(Object *obj)
@@ -183,6 +184,25 @@ static void aw_h3_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, AW_H3_CCU_BASE);
 
+    /* Universal Serial Bus */
+    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI0_BASE,
+                         s->irq[AW_H3_GIC_SPI_EHCI0]);
+    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI1_BASE,
+                         s->irq[AW_H3_GIC_SPI_EHCI1]);
+    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI2_BASE,
+                         s->irq[AW_H3_GIC_SPI_EHCI2]);
+    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI3_BASE,
+                         s->irq[AW_H3_GIC_SPI_EHCI3]);
+
+    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI0_BASE,
+                         s->irq[AW_H3_GIC_SPI_OHCI0]);
+    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI1_BASE,
+                         s->irq[AW_H3_GIC_SPI_OHCI1]);
+    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI2_BASE,
+                         s->irq[AW_H3_GIC_SPI_OHCI2]);
+    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI3_BASE,
+                         s->irq[AW_H3_GIC_SPI_OHCI3]);
+
     /* UART */
     if (serial_hd(0)) {
         serial_mm_init(get_system_memory(), AW_H3_UART0_REG_BASE, 2,
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
-- 
2.17.1


