Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0DEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA812073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvWHrrSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA812073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrQn8-000662-EG
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 14:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrQl5-0002o5-PD; Fri, 03 Jul 2020 14:50:00 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrQl4-0007c4-6D; Fri, 03 Jul 2020 14:49:59 -0400
Received: by mail-wm1-x344.google.com with SMTP id j18so32911120wmi.3;
 Fri, 03 Jul 2020 11:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=85Vo85dlXi5Qq6BqTnHvgMMBtF9WwINamq1bSkdTN/o=;
 b=qvWHrrSBEjI0szTwAGsuBfDnN5w1Nse0l5ehuFDZdFQfJRYRI0PgZJA/fsSIgoctYD
 e+sJb0mKPOcA8GhC/HMYV6oxRip7B6LUfsaFg61Lk3j2vOTe9xTRbo9Fjb0ch2J4SQpg
 IBfigSyHpx7JLUZ3vCgXRWFSqKuqGPL3vQp6LSHQ5aC/JTQWtPhm7K2Qtkj8UQbg8j70
 pYal8PtpM7AY2eZgbjPebSMMlD7GIRO/rZc3DpocIMPpG1hpoK5qfREpOm2C55BTVFA4
 qkPRoVlqaDtH+NScAn+XrA1ucKb5T+pDznCHq2gA1ni3B9P0kcn0PI2N64/B7YsHq9/j
 O5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=85Vo85dlXi5Qq6BqTnHvgMMBtF9WwINamq1bSkdTN/o=;
 b=ATwiilYgDMQ3aKWJb8InLcvItv+NAAOhWdtIkgywLZtSL2xi1U4q1tngDPN5zfZIfI
 2gvtukgqHFawfbstnUGDgpSR/NHt1cSiyDuveUxyNjOCKv5/gFzsQoxO0mbzl0MqtQea
 oE07izKQbQhrNJHUv2GnzzMeoBDt4OjF+bvyCUWKJNDXsDAP01tTU2nbb9KhoSWU56UE
 33q9G96OslsA8Qq1mDLDbmCtnJGwPn38tIsl7Ti+XU0v8ZxgqPlPoy7ZSZobeoAXwyHm
 P8irhgiKX6so0EOfEBjJvo1vmZmU1UdCp5rCsGqZ6db24OXIIXXloWkY9ii1Wugft3UF
 iJLw==
X-Gm-Message-State: AOAM532lbsTyzFXiqgHACNAF/7w6cZH2aoG4HBlZMVZDvsfvt+Y+QRFH
 hYCt+6OpFn2/SWjuQQg3W6F7WH6cWT0=
X-Google-Smtp-Source: ABdhPJweV4exSS3i3m1A2WEh/Mh+3GMKKP9eEJLGHf/tDmIiMcDkq6vLPGhT9dAFDCFL2knG8yquNw==
X-Received: by 2002:a7b:c099:: with SMTP id r25mr40274554wmh.159.1593802195659; 
 Fri, 03 Jul 2020 11:49:55 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x11sm13778369wmc.26.2020.07.03.11.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 11:49:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/arm: Use TYPE_SYSBUS_OHCI instead of hardcoded string
Date: Fri,  3 Jul 2020 20:49:51 +0200
Message-Id: <20200703184952.4918-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703184952.4918-1-f4bug@amsat.org>
References: <20200703184952.4918-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By using the TYPE_* definitions for devices, we can:
- quickly find where devices are used with 'git-grep'
- easily rename a non-user-creatable device (one-line change).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/allwinner-h3.c | 9 +++++----
 hw/arm/pxa2xx.c       | 3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 8e09468e86..231d9ad647 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -28,6 +28,7 @@
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
 #include "hw/misc/unimp.h"
+#include "hw/usb/hcd-ohci.h"
 #include "hw/usb/hcd-ehci.h"
 #include "hw/loader.h"
 #include "sysemu/sysemu.h"
@@ -381,16 +382,16 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_EHCI3));
 
-    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI0],
+    sysbus_create_simple(TYPE_SYSBUS_OHCI, s->memmap[AW_H3_OHCI0],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_OHCI0));
-    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI1],
+    sysbus_create_simple(TYPE_SYSBUS_OHCI, s->memmap[AW_H3_OHCI1],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_OHCI1));
-    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI2],
+    sysbus_create_simple(TYPE_SYSBUS_OHCI, s->memmap[AW_H3_OHCI2],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_OHCI2));
-    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI3],
+    sysbus_create_simple(TYPE_SYSBUS_OHCI, s->memmap[AW_H3_OHCI3],
                          qdev_get_gpio_in(DEVICE(&s->gic),
                                           AW_H3_GIC_SPI_OHCI3));
 
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index f104a33463..1e8a1cbc24 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -22,6 +22,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/ssi/ssi.h"
+#include "hw/usb/hcd-ohci.h"
 #include "chardev/char-fe.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/qtest.h"
@@ -2196,7 +2197,7 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,
         s->ssp[i] = (SSIBus *)qdev_get_child_bus(dev, "ssi");
     }
 
-    sysbus_create_simple("sysbus-ohci", 0x4c000000,
+    sysbus_create_simple(TYPE_SYSBUS_OHCI, 0x4c000000,
                          qdev_get_gpio_in(s->pic, PXA2XX_PIC_USBH1));
 
     s->pcmcia[0] = pxa2xx_pcmcia_init(address_space, 0x20000000);
-- 
2.21.3


