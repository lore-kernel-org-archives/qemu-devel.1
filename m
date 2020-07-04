Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE185C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 967C62070C
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB1S25DG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967C62070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjjE-0003JC-Q2
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjV1-0002aA-N6; Sat, 04 Jul 2020 10:50:39 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUz-0003vy-QK; Sat, 04 Jul 2020 10:50:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id o2so37045435wmh.2;
 Sat, 04 Jul 2020 07:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f29/MIGKjiVCXNbXb7QXhmc4KA4eor+Mhn/A2jA2iWs=;
 b=aB1S25DGnSIIYyLepd0/DAdWudVgoTXK9tCwzyeK195D7VcOpmizNyVX6hZ+Hw2qEs
 azVFVrdxwL3VuODlB4q4QqZfMjPTxFOKhd3QaNoTlI3BCwrwaIJCdaN/9hDuogPt7S1W
 uMkSVz50tiyCDufVzR9ruwvMAD7Cy57YADj/X/TkNbbAOo6IdzPigDU6+Qt9UnoF1S0U
 2gQlMm3UZYz9RaiNodxR9aWaZAJ7LbmPd+BGW5Mh8hxVh31zMr93bGQmvMf+wmWascsB
 JSWvSnk5sXCB2K4BvDiMtrGexuQVS2ZsqDG1irobpKigzLZqPl++eLsBBaNhhanPYtWu
 xagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=f29/MIGKjiVCXNbXb7QXhmc4KA4eor+Mhn/A2jA2iWs=;
 b=VQdZIEv+p4ZpHVb5XdDzXtdWPxM263cdPLtPsx/IcDJXpcNnGEJWBEGVBg+vRNkHgx
 PKWFqcar4d6mRXjhv02+DEh3nHDoH+UohKLayCD3KhnzPcnhE0m1CvEOSCpIEgQg4zT8
 uhGe2pWsQdKCrgoAoVoWwAyoZEEw0qbmcmy5i6N6kJA8AOa30TMh1vO+cxEcZjkKXGvG
 rJABx+cdglWWSwnDe5bEuQGfYoy03cyBEe2fCjw6nOOB3cRflTLOglE5maQx7nhFNmlP
 rmtcroWlNaPY5X32sNBZVo81zTp/9mpfM4o0wVoDeuhI5l6MU8qLmJy4sBd7F9j++uFL
 Ph2Q==
X-Gm-Message-State: AOAM531fCUMLVvyPDZvGQ/0NX/+J1p+wNy5OKRwF5lp55i39iKtVLnHf
 uVBGgbEYiffBItpG29AIGowNpsIbfjM=
X-Google-Smtp-Source: ABdhPJzXh5fqsqOLbUyvdsrfc19bAAQd0SyMWAd0LLQtMbMkVi1HDhynYNEmZjRrZ57ugrqA88FVFA==
X-Received: by 2002:a1c:2183:: with SMTP id h125mr43989795wmh.83.1593874235357; 
 Sat, 04 Jul 2020 07:50:35 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:50:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 23/26] hw/usb/usb-hcd: Use EHCI type definitions
Date: Sat,  4 Jul 2020 16:49:40 +0200
Message-Id: <20200704144943.18292-24-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704144943.18292-1-f4bug@amsat.org>
References: <20200704144943.18292-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Magnus Damm <magnus.damm@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Leif Lindholm <leif@nuviainc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Various machine/board/soc models create EHCI device instances
with the generic QDEV API, and don't need to access USB internals.

Simplify header inclusions by moving the QOM type names into a
simple header, with no need to include other "hw/usb" headers.

Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/hcd-ehci.h         | 11 +----------
 include/hw/usb/chipidea.h |  2 +-
 include/hw/usb/usb-hcd.h  | 11 +++++++++++
 hw/arm/allwinner-h3.c     |  1 -
 hw/arm/exynos4210.c       |  2 +-
 hw/arm/sbsa-ref.c         |  3 ++-
 hw/arm/xilinx_zynq.c      |  2 +-
 hw/ppc/sam460ex.c         |  1 -
 hw/usb/chipidea.c         |  1 +
 hw/usb/hcd-ehci-sysbus.c  |  1 +
 10 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 337b3ad05c..da70767409 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -23,6 +23,7 @@
 #include "hw/pci/pci.h"
 #include "hw/sysbus.h"
 #include "usb-internal.h"
+#include "hw/usb/usb-hcd.h"
 
 #define CAPA_SIZE        0x10
 
@@ -316,7 +317,6 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev, Error **errp);
 void usb_ehci_unrealize(EHCIState *s, DeviceState *dev);
 void ehci_reset(void *opaque);
 
-#define TYPE_PCI_EHCI "pci-ehci-usb"
 #define PCI_EHCI(obj) OBJECT_CHECK(EHCIPCIState, (obj), TYPE_PCI_EHCI)
 
 typedef struct EHCIPCIState {
@@ -327,15 +327,6 @@ typedef struct EHCIPCIState {
     EHCIState ehci;
 } EHCIPCIState;
 
-
-#define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
-#define TYPE_PLATFORM_EHCI "platform-ehci-usb"
-#define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
-#define TYPE_AW_H3_EHCI "aw-h3-ehci-usb"
-#define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
-#define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
-#define TYPE_FUSBH200_EHCI "fusbh200-ehci-usb"
-
 #define SYS_BUS_EHCI(obj) \
     OBJECT_CHECK(EHCISysBusState, (obj), TYPE_SYS_BUS_EHCI)
 #define SYS_BUS_EHCI_CLASS(class) \
diff --git a/include/hw/usb/chipidea.h b/include/hw/usb/chipidea.h
index 1ec2e9dbda..28f46291de 100644
--- a/include/hw/usb/chipidea.h
+++ b/include/hw/usb/chipidea.h
@@ -2,6 +2,7 @@
 #define CHIPIDEA_H
 
 #include "hw/usb/hcd-ehci.h"
+#include "hw/usb/usb-hcd.h"
 
 typedef struct ChipideaState {
     /*< private >*/
@@ -10,7 +11,6 @@ typedef struct ChipideaState {
     MemoryRegion iomem[3];
 } ChipideaState;
 
-#define TYPE_CHIPIDEA "usb-chipidea"
 #define CHIPIDEA(obj) OBJECT_CHECK(ChipideaState, (obj), TYPE_CHIPIDEA)
 
 #endif /* CHIPIDEA_H */
diff --git a/include/hw/usb/usb-hcd.h b/include/hw/usb/usb-hcd.h
index 21fdfaf22d..74af3a4533 100644
--- a/include/hw/usb/usb-hcd.h
+++ b/include/hw/usb/usb-hcd.h
@@ -13,4 +13,15 @@
 #define TYPE_SYSBUS_OHCI            "sysbus-ohci"
 #define TYPE_PCI_OHCI               "pci-ohci"
 
+/* EHCI */
+#define TYPE_SYS_BUS_EHCI           "sysbus-ehci-usb"
+#define TYPE_PCI_EHCI               "pci-ehci-usb"
+#define TYPE_PLATFORM_EHCI          "platform-ehci-usb"
+#define TYPE_EXYNOS4210_EHCI        "exynos4210-ehci-usb"
+#define TYPE_AW_H3_EHCI             "aw-h3-ehci-usb"
+#define TYPE_TEGRA2_EHCI            "tegra2-ehci-usb"
+#define TYPE_PPC4xx_EHCI            "ppc4xx-ehci-usb"
+#define TYPE_FUSBH200_EHCI          "fusbh200-ehci-usb"
+#define TYPE_CHIPIDEA               "usb-chipidea"
+
 #endif
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index d1d90ffa79..8b7adddc27 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -29,7 +29,6 @@
 #include "hw/char/serial.h"
 #include "hw/misc/unimp.h"
 #include "hw/usb/usb-hcd.h"
-#include "hw/usb/hcd-ehci.h"
 #include "hw/loader.h"
 #include "sysemu/sysemu.h"
 #include "hw/arm/allwinner-h3.h"
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index fa639806ec..692fb02159 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -35,7 +35,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/exynos4210.h"
 #include "hw/sd/sdhci.h"
-#include "hw/usb/hcd-ehci.h"
+#include "hw/usb/usb-hcd.h"
 
 #define EXYNOS4210_CHIPID_ADDR         0x10000000
 
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 021e7c1b8b..4e4c338ae9 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -38,6 +38,7 @@
 #include "hw/loader.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/qdev-properties.h"
+#include "hw/usb/usb-hcd.h"
 #include "hw/char/pl011.h"
 #include "net/net.h"
 
@@ -485,7 +486,7 @@ static void create_ehci(const SBSAMachineState *sms)
     hwaddr base = sbsa_ref_memmap[SBSA_EHCI].base;
     int irq = sbsa_ref_irqmap[SBSA_EHCI];
 
-    sysbus_create_simple("platform-ehci-usb", base,
+    sysbus_create_simple(TYPE_PLATFORM_EHCI, base,
                          qdev_get_gpio_in(sms->gic, irq));
 }
 
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index ed970273f3..9ccdc03095 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -29,7 +29,7 @@
 #include "hw/loader.h"
 #include "hw/misc/zynq-xadc.h"
 #include "hw/ssi/ssi.h"
-#include "hw/usb/chipidea.h"
+#include "hw/usb/usb-hcd.h"
 #include "qemu/error-report.h"
 #include "hw/sd/sdhci.h"
 #include "hw/char/cadence_uart.h"
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index ac60d17a86..3f7cf0d1ae 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -37,7 +37,6 @@
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/usb/usb.h"
 #include "hw/usb/usb-hcd.h"
-#include "hw/usb/hcd-ehci.h"
 #include "hw/ppc/fdt.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci.h"
diff --git a/hw/usb/chipidea.c b/hw/usb/chipidea.c
index 3dcd22ccba..e81f63295e 100644
--- a/hw/usb/chipidea.c
+++ b/hw/usb/chipidea.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/usb/hcd-ehci.h"
+#include "hw/usb/usb-hcd.h"
 #include "hw/usb/chipidea.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 3730736540..b7debc1934 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "hw/qdev-properties.h"
 #include "hw/usb/hcd-ehci.h"
+#include "hw/usb/usb-hcd.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 
-- 
2.21.3


