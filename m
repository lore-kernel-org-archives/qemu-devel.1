Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95497C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 20:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA7A2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 20:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsCNWbxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA7A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iq18k-00074o-Fc
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 15:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iq14Y-0000fv-L2
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 15:40:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iq14X-0007Gt-Cr
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 15:39:58 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45075)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iq14U-00076A-NW; Fri, 10 Jan 2020 15:39:54 -0500
Received: by mail-pf1-x441.google.com with SMTP id 2so1657503pfg.12;
 Fri, 10 Jan 2020 12:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kJL6D43Lk44GZABLgzICULfdZGP31GnZA6iTy8OUmgw=;
 b=BsCNWbxRViMev+a4DX4+9xeUa52wF6S1322fYGoJDlQzZsEJ3l+GxXET57BfH3m+8R
 fwaS13ZcNn1CWoMdPojoFz1kZ8rKizegtU/0iAbVzdWHFtGB/2Si0mD/mkFzHnf23OgI
 psisQthE6QJm2Ep7sCFEfjWyfTR6wIF02zYwDeOIJ3Pjzn6+5OgS7tYVGd504DGtORAq
 eDjU4OquxYOMgCkMU3vatfjLBE0DxSCc9tWtH+H5gEMRrcrqaEOpuYbaJNuuooUMGnu/
 xmBd6VkAR/z3H41BSpgqN1f3vVDFdlO4TKU/6AZ9uViwd2+cMXOzoDR6zjxfSmxNz4L8
 ocjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=kJL6D43Lk44GZABLgzICULfdZGP31GnZA6iTy8OUmgw=;
 b=CmQ1su3Y8XWskNIu2NKim+Z4XdOvxoW8XUOAKH/cAPxzi6L0AomfQEnwzim45JJ+vd
 VuY7QOLu64CfkYdMACUTN5zYUFsAKGUQdk33JopGoefUnsc/TnuIjoXG65KJ/EJZBRyJ
 JBClb09LqG8P/B64edmtGaZJf9MXHSDAi6t7cdt96OdlCvraQGF0jWx26xIzrXZtPs8a
 zHtKp7oeLzkifLxcEP+a2y3ZREA4b5HJQjP20JbJTLEVGDSRz68erJ8VnocCG6MFqF3d
 4cE1dkl6z06wGG7rRRpbCfYvLcuu73qNRwExh1hyHSKK+sBF925loMTbNvR6NC0fECYo
 LuXg==
X-Gm-Message-State: APjAAAVW0B6lvQeTxhrM94gNiImX5v9p95kC867SjL63G0o7BEyv4XrV
 8SGQRcEhWJhe/b6ho+EVL80=
X-Google-Smtp-Source: APXvYqwdOyu3M1mbVELe8etK8mN+WuHKvEzNyQ97i91475aP2ysKfljuyTmMAAVsKWO+3OgHxdDsOg==
X-Received: by 2002:a62:788a:: with SMTP id t132mr6234013pfc.134.1578688793976; 
 Fri, 10 Jan 2020 12:39:53 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id d3sm3826240pfn.113.2020.01.10.12.39.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 10 Jan 2020 12:39:53 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>
Subject: [PATCH 6/6] hw/arm/exynos4210: Connect serial port DMA busy signals
 with pl330
Date: Fri, 10 Jan 2020 12:39:42 -0800
Message-Id: <20200110203942.5745-7-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110203942.5745-1-linux@roeck-us.net>
References: <20200110203942.5745-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

The Exynos4210 serial driver uses an interrupt line to signal if receive
data is available. Connect that interrupt with the DMA controller's
'peripheral busy' gpio pin.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/exynos4210.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index c7b5c587b1..498d79ebb2 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -166,8 +166,8 @@ static uint64_t exynos4210_calc_affinity(int cpu)
     return (0x9 << ARM_AFF1_SHIFT) | cpu;
 }
 
-static void pl330_create(uint32_t base, qemu_irq irq, int nreq, int nevents,
-                         int width)
+static DeviceState *pl330_create(uint32_t base, qemu_irq irq, int nreq,
+                                 int nevents, int width)
 {
     SysBusDevice *busdev;
     DeviceState *dev;
@@ -191,6 +191,7 @@ static void pl330_create(uint32_t base, qemu_irq irq, int nreq, int nevents,
     for (i = 0; i < nevents; i++) {
         sysbus_connect_irq(busdev, i + 1, irq); /* event irq lines */
     }
+    return dev;
 }
 
 static void exynos4210_realize(DeviceState *socdev, Error **errp)
@@ -199,7 +200,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     MemoryRegion *system_mem = get_system_memory();
     qemu_irq gate_irq[EXYNOS4210_NCPUS][EXYNOS4210_IRQ_GATE_NINPUTS];
     SysBusDevice *busdev;
-    DeviceState *dev;
+    DeviceState *dev, *uart[4], *pl330[3];
     int i, n;
 
     for (n = 0; n < EXYNOS4210_NCPUS; n++) {
@@ -385,19 +386,19 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
 
 
     /*** UARTs ***/
-    exynos4210_uart_create(EXYNOS4210_UART0_BASE_ADDR,
+    uart[0] = exynos4210_uart_create(EXYNOS4210_UART0_BASE_ADDR,
                            EXYNOS4210_UART0_FIFO_SIZE, 0, serial_hd(0),
                   s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_GRP, 0)]);
 
-    exynos4210_uart_create(EXYNOS4210_UART1_BASE_ADDR,
+    uart[1] = exynos4210_uart_create(EXYNOS4210_UART1_BASE_ADDR,
                            EXYNOS4210_UART1_FIFO_SIZE, 1, serial_hd(1),
                   s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_GRP, 1)]);
 
-    exynos4210_uart_create(EXYNOS4210_UART2_BASE_ADDR,
+    uart[2] = exynos4210_uart_create(EXYNOS4210_UART2_BASE_ADDR,
                            EXYNOS4210_UART2_FIFO_SIZE, 2, serial_hd(2),
                   s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_GRP, 2)]);
 
-    exynos4210_uart_create(EXYNOS4210_UART3_BASE_ADDR,
+    uart[3] = exynos4210_uart_create(EXYNOS4210_UART3_BASE_ADDR,
                            EXYNOS4210_UART3_FIFO_SIZE, 3, serial_hd(3),
                   s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_GRP, 3)]);
 
@@ -445,12 +446,24 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
             s->irq_table[exynos4210_get_irq(28, 3)]);
 
     /*** DMA controllers ***/
-    pl330_create(EXYNOS4210_PL330_BASE0_ADDR,
-                 s->irq_table[exynos4210_get_irq(21, 0)], 32, 32, 32);
-    pl330_create(EXYNOS4210_PL330_BASE1_ADDR,
-                 s->irq_table[exynos4210_get_irq(21, 1)], 32, 32, 32);
-    pl330_create(EXYNOS4210_PL330_BASE2_ADDR,
-                 s->irq_table[exynos4210_get_irq(20, 1)], 1, 31, 64);
+    pl330[0] = pl330_create(EXYNOS4210_PL330_BASE0_ADDR,
+                            s->irq_table[exynos4210_get_irq(21, 0)],
+                            32, 32, 32);
+    pl330[1] = pl330_create(EXYNOS4210_PL330_BASE1_ADDR,
+                            s->irq_table[exynos4210_get_irq(21, 1)],
+                            32, 32, 32);
+    pl330[2] = pl330_create(EXYNOS4210_PL330_BASE2_ADDR,
+                            s->irq_table[exynos4210_get_irq(20, 1)],
+                            1, 31, 64);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(uart[0]), 1,
+                       qdev_get_gpio_in(pl330[0], 15));
+    sysbus_connect_irq(SYS_BUS_DEVICE(uart[1]), 1,
+                       qdev_get_gpio_in(pl330[1], 15));
+    sysbus_connect_irq(SYS_BUS_DEVICE(uart[2]), 1,
+                       qdev_get_gpio_in(pl330[0], 17));
+    sysbus_connect_irq(SYS_BUS_DEVICE(uart[3]), 1,
+                       qdev_get_gpio_in(pl330[1], 17));
 }
 
 static void exynos4210_class_init(ObjectClass *klass, void *data)
-- 
2.17.1


