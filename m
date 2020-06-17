Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B50CC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:31:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4976A20707
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ypu4ABTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4976A20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSXV-0005Ni-Ie
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSL-0004qq-G8; Wed, 17 Jun 2020 03:25:57 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSJ-0002bu-S1; Wed, 17 Jun 2020 03:25:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id j198so3818753wmj.0;
 Wed, 17 Jun 2020 00:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Wn/S+Lkpj/MyyvkUTlm4O5jXxrYR9y1m0yC/3Oj6YYI=;
 b=Ypu4ABTlXN7HMTV3WTyW/2GxWl45v0DaXt4HdXxiyEE0KPOrQrFSVRQTZQ6qGUTdil
 d5RlUWRHysqJrLu2D+orLeC1Wzlp/nVmFFDySp960jOmgGyaUJ9PIOsODOaMXDdnZj/R
 sxrsZIvIDL+Z/GtmevwdI3hLa2brCjiWJlZ2dsJWqiIO2gQmHe2zfBruxY/NgtvOWcvS
 dod8MkGtQX031kpiGsAG/pxUY6ePImthSZoIEv7ePvDfTCHWAz3K66YPHbeiPldYHXGT
 CPULbbq5T2+zrtv+Ltyr3jdGdgjzTxEyh1DRTQ0DFJl+4ZfXbZS5XRTat3jmF9unppal
 moQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Wn/S+Lkpj/MyyvkUTlm4O5jXxrYR9y1m0yC/3Oj6YYI=;
 b=sQweNhllb7CEMssCWgDf/BPpvhrMn1Trti2e1dlmXPzbzNW+uxELwXs/Ic3DJ3f0O3
 /qXTv9h6zUV6PZLKa8CofpeQS1+ERHPN1BPTwptpn3EvfkZzBTaMLbtW7ymjj1A4+mlf
 BF2DxreW6ygmy9hEYQrnB9qpy22vA7bVfWbGifP8DAIl2KT3qxMOdY1ERohNmiiBAyKQ
 d1LWMcJHCvPoCUkzfGdxKpwd75AZapMVZstiS48dt9QYBYRX8C9YThNdmNFIvoE9Ep1R
 6zVnsMZM07ARjcJ8pqqRozs2DAYUkITGpgRpQMuVmiAErGi3f43blUhp/qIGjSdePVyo
 OWzA==
X-Gm-Message-State: AOAM5304ChHHGrS1RlGDS3i+mns+7R8ZnWe3Nl/Uwx/htIXJP09vtdrx
 azQ7AmZmhfHD+zcG+3MBVhZJKk6a
X-Google-Smtp-Source: ABdhPJzyowyq3FSleQjiU4mAoQfGBInREbINrOmmHQOjQYEaJmoyO8+jrlQ0DzkQOXaJad7odKolYQ==
X-Received: by 2002:a7b:cf02:: with SMTP id l2mr7074249wmg.136.1592378753882; 
 Wed, 17 Jun 2020 00:25:53 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id j5sm32894781wrq.39.2020.06.17.00.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 00:25:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/14] hw/arm/mps2: Add SPI devices
Date: Wed, 17 Jun 2020 09:25:36 +0200
Message-Id: <20200617072539.32686-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617072539.32686-1-f4bug@amsat.org>
References: <20200617072539.32686-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 'Application Note AN385', chapter 3.9, SPI:

  The SMM implements five PL022 SPI modules.

Two pairs of modules share the same OR-gated IRQ.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/mps2.c  | 24 ++++++++++++++++++++++++
 hw/arm/Kconfig |  6 +++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index e106123225..daa26f68d7 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -39,6 +39,7 @@
 #include "hw/timer/cmsdk-apb-dualtimer.h"
 #include "hw/misc/mps2-scc.h"
 #include "hw/misc/mps2-fpgaio.h"
+#include "hw/ssi/pl022.h"
 #include "hw/net/lan9118.h"
 #include "net/net.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
@@ -341,6 +342,29 @@ static void mps2_common_init(MachineState *machine)
     qdev_prop_set_uint32(DEVICE(&mms->fpgaio), "prescale-clk", 25000000);
     sysbus_realize(SYS_BUS_DEVICE(&mms->fpgaio), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&mms->fpgaio), 0, 0x40028000);
+    sysbus_create_simple(TYPE_PL022, 0x40025000,        /* External ADC */
+                         qdev_get_gpio_in(armv7m, 22));
+    for (i = 0; i < 2; i++) {
+        static const int spi_irqno[] = {11, 24};
+        static const hwaddr spibase[] = {0x40020000,    /* APB */
+                                         0x40021000,    /* LCD */
+                                         0x40026000,    /* Shield0 */
+                                         0x40027000};   /* Shield1 */
+        DeviceState *orgate_dev;
+        Object *orgate;
+        int j;
+
+        orgate = object_new(TYPE_OR_IRQ);
+        object_property_set_int(orgate, 2, "num-lines", &error_fatal);
+        orgate_dev = DEVICE(orgate);
+        qdev_realize(orgate_dev, NULL, &error_fatal);
+        qdev_connect_gpio_out(orgate_dev, 0,
+                              qdev_get_gpio_in(armv7m, spi_irqno[i]));
+        for (j = 0; j < 2; j++) {
+            sysbus_create_simple(TYPE_PL022, spibase[2 * i + j],
+                                 qdev_get_gpio_in(orgate_dev, j));
+        }
+    }
 
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 5c8f689b3d..90ed584e7a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -59,7 +59,7 @@ config HIGHBANK
     select ARM_TIMER # sp804
     select ARM_V7M
     select PL011 # UART
-    select PL022 # Serial port
+    select PL022 # SPI
     select PL031 # RTC
     select PL061 # GPIO
     select PL310 # cache controller
@@ -222,7 +222,7 @@ config STELLARIS
     select CMSDK_APB_WATCHDOG
     select I2C
     select PL011 # UART
-    select PL022 # Serial port
+    select PL022 # SPI
     select PL061 # GPIO
     select SSD0303 # OLED display
     select SSD0323 # OLED display
@@ -401,7 +401,7 @@ config MPS2
     select MPS2_FPGAIO
     select MPS2_SCC
     select OR_IRQ
-    select PL022    # Serial port
+    select PL022    # SPI
     select PL080    # DMA controller
     select SPLIT_IRQ
     select UNIMP
-- 
2.21.3


