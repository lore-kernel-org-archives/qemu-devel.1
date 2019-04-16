Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C70EC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 01:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B4A20652
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 01:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnIQM4f1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B4A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57828 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGD6B-0007gB-4A
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 21:41:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4W-0006XX-1i
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4V-0007qx-1d
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:40 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrew.smirnov@gmail.com>)
	id 1hGD4S-0007p0-Kc; Mon, 15 Apr 2019 21:39:36 -0400
Received: by mail-pl1-x642.google.com with SMTP id a96so9474552pla.6;
	Mon, 15 Apr 2019 18:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=2Jrfp6guHhu12IiPCjZRuA1AOo7RUF4vA5QQQUxraEE=;
	b=PnIQM4f1YSKwxMRbTTZ5RnvgndeWOtz4LRBQmjWczMxAVNGCBb73BXFoIc3057WBct
	BiWz1XS5dM09B2yAQVbYG+F+clxiM/wbc9Ol7cG+vNt5X0bTwuEZWyEOYBeSmpUNfSZT
	kdx1yf/01UHfp7UgjKIcFyWpFwIZJZncsnkSM1iVXidjgcMMpglUdTNOQfNElpgFTvXL
	VwZ62yk+7bjPm9rWi85C78+qgeoTbXmhQ83/hmuR7Cy9NrOn6ykJWDvK73115TjoEhOc
	kS0Y8zXv/duOV7r3MPIGU80+Qp5xBVhlyeenX252pIWCjaOKkeZ5ScFZrBjlrB1zDXmr
	cWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2Jrfp6guHhu12IiPCjZRuA1AOo7RUF4vA5QQQUxraEE=;
	b=TWNCJyjAPqH7yJkWGM8EnEtdphH4FbNTWyMJ56CW8AWhl7sTUxW0ftQe5tJsBv1hTa
	XZSJDzzz8yFBiVRU180/uVSFrVkZTpNwO9YW8U2ggzkcfKwUDUfkfRWycD6lT5GhPgFv
	llBeZwESsJ6FkxbzNeSSv/WfooYvtBKRlN1xkJVhD9JcMnmoKKc+9fY66Yvsd31Sur22
	jG0LqJC4j1N5zCh1VfELUbU8hBxTaPBTETokS/YcKdmEn2SzcNZmvXogANkkjBu5ma3V
	BunHAPLsyKFWCvrKzp+u1lDI1Tv2xAYQaeGqOVvfTTjkLPkkizfLa9keBcoa8KB1Uyt9
	2QKA==
X-Gm-Message-State: APjAAAVUO8olaqz8y74yKq8WQK0Ol3qFh6eA0gS19q5SUEPJuAEuoxhk
	DvNsUBvleoTQiaz73/O6D3AgLzy+
X-Google-Smtp-Source: APXvYqy1m4rplTbpYgUevdHEeRqfyc/1765/R/yv1kLkK4B3vFwXgFCUN0xMQTMB6bcKUt9ozCh58Q==
X-Received: by 2002:a17:902:a5ca:: with SMTP id
	t10mr76432641plq.234.1555378775344; 
	Mon, 15 Apr 2019 18:39:35 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
	[24.22.235.96]) by smtp.gmail.com with ESMTPSA id
	v20sm74710362pfn.116.2019.04.15.18.39.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 15 Apr 2019 18:39:34 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: qemu-arm@nongnu.org
Date: Mon, 15 Apr 2019 18:39:02 -0700
Message-Id: <20190416013902.4941-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416013902.4941-1-andrew.smirnov@gmail.com>
References: <20190416013902.4941-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH 5/5] i.mx7d: pci: Update PCI IRQ mapping to
 match HW
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	"Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416013902.Jp3c1YSiIlax1bB9vqbVm5k6WQXgneggVeqIPmXWzaM@z>

Datasheet for i.MX7 is incorrect and i.MX7's PCI IRQ mapping matches
that of i.MX6:

    * INTD/MSI    122
    * INTC        123
    * INTB        124
    * INTA        125

Fix all of the relevant code to reflect that fact. Needed by latest
Linux kernels.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
---
 include/hw/arm/fsl-imx7.h | 8 ++++----
 hw/pci-host/designware.c  | 6 ++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 3efa697adc..9750003a4f 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -213,10 +213,10 @@ enum FslIMX7IRQs {
     FSL_IMX7_USB2_IRQ     = 42,
     FSL_IMX7_USB3_IRQ     = 40,
 
-    FSL_IMX7_PCI_INTA_IRQ = 122,
-    FSL_IMX7_PCI_INTB_IRQ = 123,
-    FSL_IMX7_PCI_INTC_IRQ = 124,
-    FSL_IMX7_PCI_INTD_IRQ = 125,
+    FSL_IMX7_PCI_INTA_IRQ = 125,
+    FSL_IMX7_PCI_INTB_IRQ = 124,
+    FSL_IMX7_PCI_INTC_IRQ = 123,
+    FSL_IMX7_PCI_INTD_IRQ = 122,
 
     FSL_IMX7_UART7_IRQ    = 126,
 
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index e80facc4a0..f4c58b25c1 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -50,6 +50,8 @@
 #define DESIGNWARE_PCIE_ATU_DEVFN(x)               (((x) >> 16) & 0xff)
 #define DESIGNWARE_PCIE_ATU_UPPER_TARGET           0x91C
 
+#define DESIGNWARE_PCIE_IRQ_MSI                    3
+
 static DesignwarePCIEHost *
 designware_pcie_root_to_host(DesignwarePCIERoot *root)
 {
@@ -66,7 +68,7 @@ static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
     root->msi.intr[0].status |= BIT(val) & root->msi.intr[0].enable;
 
     if (root->msi.intr[0].status & ~root->msi.intr[0].mask) {
-        qemu_set_irq(host->pci.irqs[0], 1);
+        qemu_set_irq(host->pci.irqs[DESIGNWARE_PCIE_IRQ_MSI], 1);
     }
 }
 
@@ -310,7 +312,7 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
     case DESIGNWARE_PCIE_MSI_INTR0_STATUS:
         root->msi.intr[0].status ^= val;
         if (!root->msi.intr[0].status) {
-            qemu_set_irq(host->pci.irqs[0], 0);
+            qemu_set_irq(host->pci.irqs[DESIGNWARE_PCIE_IRQ_MSI], 0);
         }
         break;
 
-- 
2.20.1


