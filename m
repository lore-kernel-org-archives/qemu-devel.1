Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5F1C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:30:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98A621835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg5mAbrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98A621835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuV4o-0002Jr-Nl
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 00:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iuV08-0004js-9c
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:25:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iuV06-0001mt-Hj
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:25:56 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iuV02-0001l9-Td; Thu, 23 Jan 2020 00:25:51 -0500
Received: by mail-pj1-x1043.google.com with SMTP id d5so648232pjz.5;
 Wed, 22 Jan 2020 21:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0/99IwBEwzLpC/GNQFCS4xwCpjCZFU1wso8ttuVUOs4=;
 b=Hg5mAbrmj9+eRiWzunQ4BPani/1BitaBGYs3P/4aSCi7O+8qK3Zw8sNIsvaak5g8D/
 aWgeKreCMHpcXxoX5TOY2oSomahbreOUTMAztBsZEO9LHK30X5oDgmdyYln1oRBZ8ZkG
 y+DCVw/z5gYGWrltxYXJFkGFx7aHKD3QrpCpdn8t+I9WPmOYQZR8IZPBEfLN+/ntRsiN
 0ZJy+U9brbGPKO62DO/zbMgjeGysJR510uy+AKH8o7ZLcKvZFe79F40MbJIQsMh0/VgX
 su7BrCZsFicOc388+Vc/Etdrh1vFqmVtXVwkxnPRGxfDcHOg9nNCtMtvYWpX1dzdWlXH
 3pPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=0/99IwBEwzLpC/GNQFCS4xwCpjCZFU1wso8ttuVUOs4=;
 b=hIh+YpNsehBR4bKna/E3NXxJFEmIT39jEPQEWIiavtc+Upf1AX53DrN4TrL3G6x8G0
 eN/QP/t4LiSc5CWeZ7mtwuhsRqFEdF49iRu3qx0hqtagn5mMDGF80aCkBEtqCPes3ZSY
 ozJIjTpOPQcnphLD8TeDxiXpsTcIs/YVCiKeiKW42yuA62Y3MTjF79jugqNK/sct84gX
 Go3m6a+nQkBT7QlJyECNII/g1dax6sFAr8pchgSQ0OQRLUyF/NYm9tCC8E2DqNkOm014
 EPFTdU4dvducfXBaefeX9HPAsTRYfOlkJP//QOK4P0vw51YyeZSxkxq6CbM0ksim4zkn
 9JgQ==
X-Gm-Message-State: APjAAAUD36UsJodd5rQa2MSGqRTz9pJO6fHDhYNK0k9E6bK50dRK5Vkg
 Wg9oABHjIkBwUSKMbFxSVd+GofsI
X-Google-Smtp-Source: APXvYqzNLqihtIXYYqnWBBJHV8CLEP+erdkRaZPIHe8V+d3kzfZamh/OMJgNVqqo+en5Ed/Kt71zpw==
X-Received: by 2002:a17:90a:ac0e:: with SMTP id
 o14mr2615666pjq.11.1579757149935; 
 Wed, 22 Jan 2020 21:25:49 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id a10sm867802pgm.81.2020.01.22.21.25.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 22 Jan 2020 21:25:49 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 3/8] hw/arm/exynos4210: Fix DMA initialization
Date: Wed, 22 Jan 2020 21:25:35 -0800
Message-Id: <20200123052540.6132-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200123052540.6132-1-linux@roeck-us.net>
References: <20200123052540.6132-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Back to 32+1 interrupts for pdma and 31+1 for mdma

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
index 77fbe1baab..7701a3fa8b 100644
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
+                 s->irq_table[exynos4210_get_irq(21, 0)], 32, 32, 32);
+    pl330_create(EXYNOS4210_PL330_BASE1_ADDR, &s->pl330_irq_orgate[1],
+                 s->irq_table[exynos4210_get_irq(21, 1)], 32, 32, 32);
+    pl330_create(EXYNOS4210_PL330_BASE2_ADDR, &s->pl330_irq_orgate[2],
+                 s->irq_table[exynos4210_get_irq(20, 1)], 1, 31, 64);
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


