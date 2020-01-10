Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAF2C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 20:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A772082E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 20:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMroP8xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A772082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iq16V-0002ks-I6
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 15:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iq14S-0000VP-MB
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 15:39:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iq14R-0006yP-L4
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 15:39:52 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36187)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iq14P-0006py-6Z; Fri, 10 Jan 2020 15:39:49 -0500
Received: by mail-pg1-x542.google.com with SMTP id k3so1526931pgc.3;
 Fri, 10 Jan 2020 12:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TOSNnijAQMtdjCsblYsegVxJcxGmgJnr/faVUnc8a1A=;
 b=rMroP8xmQOYDdZIXfGna6r4cgo0YjguFLZOzo1yt4TEKGCLiCCtnSMsXWogTm+oA7X
 NEhfUVuKfJoLngpiUOPCJ8Pwmi37bSUSqanwX11AAfUhN8ytFSTSkTkBFZLXKlKvhTR/
 HOjckg2z3chOWKlYLvRPjmODIW48sYwivvYmIabWNnRlgixTXlCfK0Jc6baD/UvuTg+1
 YJ+ZhIK/IrWAFkWNdfYA/kzZMa4xmgn8kMxDAsb1OhDXhIAyVH9tdJ6HHAPP88uxfzKA
 CT3F+f3jUAniCEtGK0hgv8wbEyuVo4UOY5Dbg9c6SMGyw0B3Yp5iJoeae9VrfLnDBOh2
 LBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=TOSNnijAQMtdjCsblYsegVxJcxGmgJnr/faVUnc8a1A=;
 b=bPus9H/toerYr71bXOW/ZQmF9Twn2H6FOpn2t1OaSH14ecQNBrUAQZ4umGTjagRy3D
 VCDKHjtK0tWy1PCtGPC7HMOaxCIxvBbs/DR9ic9WXi+7z4xE9fvvzrOfHKuc/UZmrPpj
 ydsx5ZRQ4UsBSxNa+druaVX8XJcU3w8XoqGXL8w7se0V2Mlz1blKsLEjP08tSBPez+Pi
 Z7raIp9pwT48PQNXlbUC4MfuBpheL4soDg4kQ9paiQ0olMKK75c6FQtNDe5TFXIEaERR
 uCpHepodR3JCCRtfgR70H+Q0AaWlyN5jJz5ucq+knwizyxkq8tc4UMmxqJA0SFE8nZmS
 F7mg==
X-Gm-Message-State: APjAAAWjC9a3q5pqcf0PrmR+qR0NnyOI0wd9SanT57bMD+ZzxoSOfYd+
 9XIx0ImnoP5JX5fOos0Kqd0=
X-Google-Smtp-Source: APXvYqxQ7tYC3gdBQ+miWHESpf7C1Rh40TLb5MS/2+NC6/6fr2R19l11kaq5IKTlAXtBgrm/6xWTlA==
X-Received: by 2002:a63:358a:: with SMTP id c132mr6712499pga.286.1578688788334; 
 Fri, 10 Jan 2020 12:39:48 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id s7sm3960148pjk.22.2020.01.10.12.39.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 10 Jan 2020 12:39:47 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>
Subject: [PATCH 2/6] hw/arm/exynos4210: Fix DMA initialization
Date: Fri, 10 Jan 2020 12:39:38 -0800
Message-Id: <20200110203942.5745-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110203942.5745-1-linux@roeck-us.net>
References: <20200110203942.5745-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

First parameter to exynos4210_get_irq() is not the SPI port number,
but the interrupt group number. Interrupt groups are 20 for mdma
and 21 for pdma. Interrupts are not inverted. Controllers support 32
events (pdma) or 31 events (mdma). Events must all be routed to a single
interrupt line. Set other parameters as documented in Exynos4210 datasheet,
section 8 (DMA controller).

Fixes: 59520dc65e ("hw/arm/exynos4210: Add DMA support for the Exynos4210")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/exynos4210.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 77fbe1baab..c7b5c587b1 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -166,17 +166,31 @@ static uint64_t exynos4210_calc_affinity(int cpu)
     return (0x9 << ARM_AFF1_SHIFT) | cpu;
 }
 
-static void pl330_create(uint32_t base, qemu_irq irq, int nreq)
+static void pl330_create(uint32_t base, qemu_irq irq, int nreq, int nevents,
+                         int width)
 {
     SysBusDevice *busdev;
     DeviceState *dev;
+    int i;
 
     dev = qdev_create(NULL, "pl330");
+    qdev_prop_set_uint8(dev, "num_events", nevents);
+    qdev_prop_set_uint8(dev, "num_chnls",  8);
     qdev_prop_set_uint8(dev, "num_periph_req",  nreq);
+
+    qdev_prop_set_uint8(dev, "wr_cap", 4);
+    qdev_prop_set_uint8(dev, "wr_q_dep", 8);
+    qdev_prop_set_uint8(dev, "rd_cap", 4);
+    qdev_prop_set_uint8(dev, "rd_q_dep", 8);
+    qdev_prop_set_uint8(dev, "data_width", width);
+    qdev_prop_set_uint16(dev, "data_buffer_dep", width);
     qdev_init_nofail(dev);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, base);
-    sysbus_connect_irq(busdev, 0, irq);
+    sysbus_connect_irq(busdev, 0, irq);         /* abort irq line */
+    for (i = 0; i < nevents; i++) {
+        sysbus_connect_irq(busdev, i + 1, irq); /* event irq lines */
+    }
 }
 
 static void exynos4210_realize(DeviceState *socdev, Error **errp)
@@ -432,11 +446,11 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
 
     /*** DMA controllers ***/
     pl330_create(EXYNOS4210_PL330_BASE0_ADDR,
-                 qemu_irq_invert(s->irq_table[exynos4210_get_irq(35, 1)]), 32);
+                 s->irq_table[exynos4210_get_irq(21, 0)], 32, 32, 32);
     pl330_create(EXYNOS4210_PL330_BASE1_ADDR,
-                 qemu_irq_invert(s->irq_table[exynos4210_get_irq(36, 1)]), 32);
+                 s->irq_table[exynos4210_get_irq(21, 1)], 32, 32, 32);
     pl330_create(EXYNOS4210_PL330_BASE2_ADDR,
-                 qemu_irq_invert(s->irq_table[exynos4210_get_irq(34, 1)]), 1);
+                 s->irq_table[exynos4210_get_irq(20, 1)], 1, 31, 64);
 }
 
 static void exynos4210_class_init(ObjectClass *klass, void *data)
-- 
2.17.1


