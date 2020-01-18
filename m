Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE555C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 16:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA53C2469A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 16:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMFW3kHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA53C2469A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isrDN-0006qI-Hj
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 11:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1isrBJ-00042t-M8
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 11:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1isrBI-0002Au-DB
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 11:42:41 -0500
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:41572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1isrBF-00026y-E8; Sat, 18 Jan 2020 11:42:37 -0500
Received: by mail-yb1-xb41.google.com with SMTP id z15so7674679ybm.8;
 Sat, 18 Jan 2020 08:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ldTrGfmguJmXL3eSQF5uN0jHMmEr5R4Wn7Le7S6JTWM=;
 b=qMFW3kHxzSZO2JcAflvVutUH/zWG3/zXlSaqe2vtxpjsv2WR9FJN2+5F32EupBUUW6
 r5rR4skqXurVzbiB8Jeql3Qf/Lgd2mecHldz9hgAfEqeYk2+m8eM0fM55pU0+wT8sSzu
 ZCPlYJt2QCFck9zvQeIG54xZBhV5q/Vi/nNSyWfBueKiBOByvXfpjPDmFVSByEWD8UJM
 tv6RL5GDvfMBUKstlKtCvlQYQ5BDwK3ZCU3MpMfu8+ezRvwMNq/jrVg5Yfj9aSQgrvtS
 k+HFILg9Me+7N7ePhC3uDeYqiqYytoRJJFXVx7wWLCkhI5MVtFCpkJiB5kKxAMGBX7pq
 cGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=ldTrGfmguJmXL3eSQF5uN0jHMmEr5R4Wn7Le7S6JTWM=;
 b=JMjhgfbTjNOhDjC8eOkLXPhiktQTry18dFF3wSjjlTZgvAqwkQy0asLP+3DRdQ7CIq
 mAc6kD3k7JD18nJyh7CQhoEWLm/wsruRWmZ7BEbIZBWdED8ykagLR+mOM3st38gUVLpG
 ydGMSszFr1+/82EOxTHVRv3yMfWPrQNaRMZsCof2Ml9z/22uyJx2D0zJLL9cjuBh3Guf
 tRMdaTSpgVZe8pWgepkW4n4UTh9o8oogReDa16lDRGrBuHutCmfbBKMK9+rqgVhKMCD7
 i1+OtMdjToeE2JxW6mbiZHgbUCktRoJdB5hX5D2djj4uBzUG1w0hbeeveBDM80/R1SQG
 XhlA==
X-Gm-Message-State: APjAAAWw8uD1XtpmjOFO1aJpRccucbc47WHGqZMtW95sLI5NXqQ6dgwq
 AFKUk2r/prPAfAPv8yoZFqc=
X-Google-Smtp-Source: APXvYqzb6pu0LagOQbWIGJ2oYkWpnfK/1EY9jvG2dWQSrAP5UqtSw1iuBvaIbVmz4gGIyH94uMiDFQ==
X-Received: by 2002:a25:230d:: with SMTP id j13mr34605263ybj.22.1579365756861; 
 Sat, 18 Jan 2020 08:42:36 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id l74sm13213723ywc.45.2020.01.18.08.42.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 18 Jan 2020 08:42:36 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/7] hw/arm/exynos4210: Fix DMA initialization
Date: Sat, 18 Jan 2020 08:42:24 -0800
Message-Id: <20200118164229.22539-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200118164229.22539-1-linux@roeck-us.net>
References: <20200118164229.22539-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

First parameter to exynos4210_get_irq() is not the SPI port number,
but the interrupt group number. Interrupt groups are 20 for mdma
and 21 for pdma. Interrupts are not inverted. Controllers support 32
events (pdma) or 31 events (mdma). Events must all be routed to a single
interrupt line. Set other parameters as documented in Exynos4210 datasheet,
section 8 (DMA controller).

Reduce the number of DMA events to 30 for both pdma and mdma. QEMU's OR
interrupt gates are currently limited to less than 32, and we would need
33 gates to support 32 event interrupts plus the abort interrupt.
Operationally this should not make a difference since they are all
routed to a single interrupt line anyway.

Fixes: 59520dc65e ("hw/arm/exynos4210: Add DMA support for the Exynos4210")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Use interrupt combiner instead of connecting all events to a
    single interrupt. Limit number of events per DMA channel
    to 31 to meet qemu interrupt combiner limitations.
    [Not sure if "assert(s->num_lines < MAX_OR_LINES);" should be
     "assert(s->num_lines <= MAX_OR_LINES);"]
    Introduce exynos4210_init() to handle interrupt combiner
    initialization.

 hw/arm/exynos4210.c         | 51 +++++++++++++++++++++++++++++++------
 include/hw/arm/exynos4210.h |  4 +++
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 77fbe1baab..91586fe265 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -166,17 +166,36 @@ static uint64_t exynos4210_calc_affinity(int cpu)
     return (0x9 << ARM_AFF1_SHIFT) | cpu;
 }
 
-static void pl330_create(uint32_t base, qemu_irq irq, int nreq)
+static void pl330_create(uint32_t base, qemu_or_irq *orgate, qemu_irq irq,
+                         int nreq, int nevents, int width)
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
+
+    object_property_set_int(OBJECT(orgate), nevents + 1, "num-lines",
+                            &error_abort);
+    object_property_set_bool(OBJECT(orgate), true, "realized", &error_abort);
+
+    for (i = 0; i < nevents + 1; i++) {
+        sysbus_connect_irq(busdev, i, qdev_get_gpio_in(DEVICE(orgate), i));
+    }
+    qdev_connect_gpio_out(DEVICE(orgate), 0, irq);
 }
 
 static void exynos4210_realize(DeviceState *socdev, Error **errp)
@@ -431,12 +450,27 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
             s->irq_table[exynos4210_get_irq(28, 3)]);
 
     /*** DMA controllers ***/
-    pl330_create(EXYNOS4210_PL330_BASE0_ADDR,
-                 qemu_irq_invert(s->irq_table[exynos4210_get_irq(35, 1)]), 32);
-    pl330_create(EXYNOS4210_PL330_BASE1_ADDR,
-                 qemu_irq_invert(s->irq_table[exynos4210_get_irq(36, 1)]), 32);
-    pl330_create(EXYNOS4210_PL330_BASE2_ADDR,
-                 qemu_irq_invert(s->irq_table[exynos4210_get_irq(34, 1)]), 1);
+    pl330_create(EXYNOS4210_PL330_BASE0_ADDR, &s->pl330_irq_orgate[0],
+                 s->irq_table[exynos4210_get_irq(21, 0)], 32, 30, 32);
+    pl330_create(EXYNOS4210_PL330_BASE1_ADDR, &s->pl330_irq_orgate[1],
+                 s->irq_table[exynos4210_get_irq(21, 1)], 32, 30, 32);
+    pl330_create(EXYNOS4210_PL330_BASE2_ADDR, &s->pl330_irq_orgate[2],
+                 s->irq_table[exynos4210_get_irq(20, 1)], 1, 30, 64);
+}
+
+static void exynos4210_init(Object *obj)
+{
+    Exynos4210State *s = EXYNOS4210_SOC(obj);
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->pl330_irq_orgate); i++) {
+        char *name = g_strdup_printf("pl330-irq-orgate%d", i);
+        qemu_or_irq *orgate = &s->pl330_irq_orgate[i];
+
+        object_initialize_child(obj, name, orgate, sizeof(*orgate),
+                                TYPE_OR_IRQ, &error_abort, NULL);
+        g_free(name);
+    }
 }
 
 static void exynos4210_class_init(ObjectClass *klass, void *data)
@@ -450,6 +484,7 @@ static const TypeInfo exynos4210_info = {
     .name = TYPE_EXYNOS4210_SOC,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(Exynos4210State),
+    .instance_init = exynos4210_init,
     .class_init = exynos4210_class_init,
 };
 
diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index f0f23b0e9b..55260394af 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -24,6 +24,7 @@
 #ifndef EXYNOS4210_H
 #define EXYNOS4210_H
 
+#include "hw/or-irq.h"
 #include "hw/sysbus.h"
 #include "target/arm/cpu-qom.h"
 
@@ -74,6 +75,8 @@
 
 #define EXYNOS4210_I2C_NUMBER               9
 
+#define EXYNOS4210_NUM_DMA      3
+
 typedef struct Exynos4210Irq {
     qemu_irq int_combiner_irq[EXYNOS4210_MAX_INT_COMBINER_IN_IRQ];
     qemu_irq ext_combiner_irq[EXYNOS4210_MAX_EXT_COMBINER_IN_IRQ];
@@ -97,6 +100,7 @@ typedef struct Exynos4210State {
     MemoryRegion boot_secondary;
     MemoryRegion bootreg_mem;
     I2CBus *i2c_if[EXYNOS4210_I2C_NUMBER];
+    qemu_or_irq pl330_irq_orgate[EXYNOS4210_NUM_DMA];
 } Exynos4210State;
 
 #define TYPE_EXYNOS4210_SOC "exynos4210"
-- 
2.17.1


