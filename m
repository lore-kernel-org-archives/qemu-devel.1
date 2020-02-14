Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210C0C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 06:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF8312187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 06:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seheKpj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8312187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2UNk-0002hX-6I
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 01:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j2ULt-0008Tz-Cp
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:21:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j2ULs-00084j-8r
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:21:25 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38975)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j2ULp-0007ub-1t; Fri, 14 Feb 2020 01:21:21 -0500
Received: by mail-pj1-x1041.google.com with SMTP id e9so3485900pjr.4;
 Thu, 13 Feb 2020 22:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uSI6UGwVXPkrla+R3kIjKT7Kl55AJFmzZRtGcCUVGBI=;
 b=seheKpj0spMk8r8qng1fvTY9miF6A5EF8l2ZSfog7Xbm1TrPTAV4sDlgOZHMPIidNC
 BcvLDNy6dkeW6AX4mG8BIaxKO8KPETwony+rPG+KDv4xEmDMgZHoLnCufG+C2VLuPheI
 +3FxOT0G2aLdwgW6xpkpxkxrOGmBi1+wQAnlgfG78s62HWcl5GCrDAUDPpWq0q9bgIjs
 PMzy3jDLk/vHOMyOn7b3ocgBjoqPrlggAFuRSI4Mks9LJpgh4DDfWOSqyiNoIga9LJef
 UAqCMw6poDV4A0WDux+tzzOp1Gw8pyMN4lHTiaOhMxhQacZQH5UjqVWvKA59dW9TSYfn
 A7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=uSI6UGwVXPkrla+R3kIjKT7Kl55AJFmzZRtGcCUVGBI=;
 b=U63A2yX9xyGdh8hH/nJYxoYamt67WeU7uwLgaSlrCLn8ElsTXkfrkiNJRhGTZYM1+2
 COeT/zvkUqqI0w3Yn6VCJFJkeWIoOON50TF9jwAkmBSCfAqc35SWKAU5DFH72tfE1Z7r
 hQf7KGv4Uujxv/loTHFL4Dg/4tZV/E1NqeK0a0DfBOMvorg9DKNN3nJRK0IHYiLlkjKD
 1UO/RTesW60jwWaRRvsXwxJiXwG2VltMOJEPylVmcIyeYiczE6h65DkeR/VwOmho8WtM
 VjV/x4R1DXcFCFfKK0hKKck3dOdvF/7jCI4CxnCa8Xj7VHSzeW5ngPjb6/+g5SvTKgpq
 9s9A==
X-Gm-Message-State: APjAAAUZS55HDHtIuLnOVFA+9JEQPPil4Mgz9gyjY8pEGADWgENf4b63
 f7IgcTKYUNQYcU/i8Uv3X64=
X-Google-Smtp-Source: APXvYqwwOPaBpd/H8KbNO5mzGooUB4/peODa8bblMzeLcdthb6I9FJNRsOgv1+tKuNGqV4gYugpVDw==
X-Received: by 2002:a17:90a:c389:: with SMTP id
 h9mr1733981pjt.128.1581661279995; 
 Thu, 13 Feb 2020 22:21:19 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id u26sm5112210pfn.46.2020.02.13.22.21.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Feb 2020 22:21:19 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 3/3] arm: allwinner: Wire up USB EHCI
Date: Thu, 13 Feb 2020 22:21:09 -0800
Message-Id: <20200214062109.24494-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214062109.24494-1-linux@roeck-us.net>
References: <20200214062109.24494-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Initialize EHCI controllers on Allwinner A10. With this patch applied,
USB EHCI ports are discovered when booting the cubieboard machine with
a recent Linux kernel.

ehci-platform 1c14000.usb: EHCI Host Controller
ehci-platform 1c14000.usb: new USB bus registered, assigned bus number 1
ehci-platform 1c14000.usb: irq 26, io mem 0x01c14000
ehci-platform 1c14000.usb: USB 2.0 started, EHCI 1.00
ehci-platform 1c1c000.usb: EHCI Host Controller
ehci-platform 1c1c000.usb: new USB bus registered, assigned bus number 2
ehci-platform 1c1c000.usb: irq 31, io mem 0x01c1c000
ehci-platform 1c1c000.usb: USB 2.0 started, EHCI 1.00

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/allwinner-a10.c         | 17 +++++++++++++++++
 include/hw/arm/allwinner-a10.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 818145428c..f8b963b5c3 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -32,6 +32,7 @@
 #define AW_A10_PIT_REG_BASE     0x01c20c00
 #define AW_A10_UART0_REG_BASE   0x01c28000
 #define AW_A10_EMAC_BASE        0x01c0b000
+#define AW_A10_EHCI_BASE        0x01c14000
 #define AW_A10_OHCI_BASE        0x01c14400
 #define AW_A10_SATA_BASE        0x01c18000
 
@@ -64,6 +65,10 @@ static void aw_a10_init(Object *obj)
             sysbus_init_child_obj(obj, "ohci[*]", OBJECT(&s->ohci[i]),
                                   sizeof(s->ohci[i]), TYPE_SYSBUS_OHCI);
         }
+        for (i = 0; i < ARRAY_SIZE(s->ehci); i++) {
+            sysbus_init_child_obj(obj, "ehci[*]", OBJECT(&s->ehci[i]),
+                                  sizeof(s->ehci[i]), TYPE_PLATFORM_EHCI);
+        }
     }
 }
 
@@ -162,6 +167,18 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
             sysbus_connect_irq(SYS_BUS_DEVICE(&s->ohci[i]), 0,
                                qdev_get_gpio_in(dev, 64 + i));
         }
+        for (i = 0; i < ARRAY_SIZE(s->ehci); i++) {
+            object_property_set_bool(OBJECT(&s->ehci[i]), true, "realized",
+                                     &err);
+            if (err) {
+                error_propagate(errp, err);
+                return;
+            }
+            sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                            AW_A10_EHCI_BASE + i * 0x8000);
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                               qdev_get_gpio_in(dev, 39 + i));
+        }
     }
 }
 
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 4864adbec3..17e1ee92e2 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -10,6 +10,7 @@
 #include "hw/net/allwinner_emac.h"
 #include "hw/ide/ahci.h"
 #include "hw/usb/hcd-ohci.h"
+#include "hw/usb/hcd-ehci.h"
 
 #include "target/arm/cpu.h"
 
@@ -31,6 +32,7 @@ typedef struct AwA10State {
     AllwinnerAHCIState sata;
     MemoryRegion sram_a;
     OHCISysBusState ohci[2];
+    EHCISysBusState ehci[2];
 } AwA10State;
 
 #endif
-- 
2.17.1


