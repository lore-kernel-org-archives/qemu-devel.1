Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C51C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246C921D56
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="THFBNxjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246C921D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSn9-0002oY-13
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbv-0006LJ-TK
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbu-00075p-Gv
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:31 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isSbu-000756-9J
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:30 -0500
Received: by mail-wr1-x444.google.com with SMTP id y11so22907587wrt.6
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=wHewatig1WxOwt8qBOmxg33iHOr1ClM0+duepeP3lHk=;
 b=THFBNxjj7kwt29WZRwwfdM8E0AgveREHQOK9/X1xCwQ3gY9tWnJ2qURNo688JpoQuf
 BzvvZ7aAxQ+9swTUr9QQ3Rar44sKu20xUaljRHgKYNQhVYacez47rEAgNwPtna0w0CX4
 YF+hByxgtzHWyndXhC7yYyJZvjdLeQZnjpnUeWPc5nFl3po7rjnPFNWp0lHuS3/4CUl2
 UqkVe0rQxa6DmVAw6LmHIFFAIuGz5yhELJlkGs8q8shFTzA3RvJWubhHdoQRtcjk7Qn8
 qYwJuJ6o51ABQu8O+9iNCdxZckD9TEYVOP8+7O8opmn+wXK62qhOzv3cJ0HcHdSkpSWS
 CgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wHewatig1WxOwt8qBOmxg33iHOr1ClM0+duepeP3lHk=;
 b=p8RLN+VKE7yi2/Co4ivIPKULWX8QhxXU/hruYfddX6ET8oq0s9UkAHxVvfhYUreEql
 RA0PmFqftTvIsZt255stGmEpz2jr1c1aPVx91v/nJCSMedIhdvyyuUB70Gz7oOpTo5O0
 dAFErthhQZ1N9v0slxGPRPskgBfsKxTQ5Bd4zfRwKMoltnzPTRNU9YAbD8JmFH7oI0y7
 9pwZhBlMb3P8nYrWAxO9wL0dzysxkuRDMX17XFRP0aQD+Sti9RBpawzr/hnK2Q9nU9SR
 ixS5xag4143DdK69Z78BnVlNpRagczYL4YwB92XU4dDtKSZVP/xtG+0FxiVOSGLlyQlv
 HHLg==
X-Gm-Message-State: APjAAAU1QlVOeKM8/vc8Gp1TmDOrEjOv/YUR/Mg1fdbqK+kY597yu7mN
 o1/9gGIupaJo8sBdPkeSudY6kMIfmjXDTA==
X-Google-Smtp-Source: APXvYqxGqQOE0Xb247lAS7tqVZgkOmbENqMOmT9hcokx1uxu5fuhmGXppsJdpCQckIrjjU0/WQv9og==
X-Received: by 2002:adf:8150:: with SMTP id 74mr3424813wrm.114.1579271309037; 
 Fri, 17 Jan 2020 06:28:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e18sm33811146wrw.70.2020.01.17.06.28.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 06:28:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/15] hw/arm/allwinner-a10: Simplify by passing IRQs with
 qdev_pass_gpios()
Date: Fri, 17 Jan 2020 14:28:09 +0000
Message-Id: <20200117142816.15110-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117142816.15110-1-peter.maydell@linaro.org>
References: <20200117142816.15110-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

By calling qdev_pass_gpios() we don't need to hold a copy of the
IRQs from the INTC into the SoC state.
Instead of filling an array of qemu_irq and passing it around, we
can now directly call qdev_get_gpio_in() on the SoC.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20191230110953.25496-5-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/allwinner-a10.h |  1 -
 hw/arm/allwinner-a10.c         | 24 +++++++++++-------------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 941c61e5336..40d0b1d9c05 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -23,7 +23,6 @@ typedef struct AwA10State {
     /*< public >*/
 
     ARMCPU cpu;
-    qemu_irq irq[AW_A10_PIC_INT_NR];
     AwA10PITState timer;
     AwA10PICState intc;
     AwEmacState emac;
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 0f1af5a880f..966fbd4a6e5 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -55,7 +55,6 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
 {
     AwA10State *s = AW_A10(dev);
     SysBusDevice *sysbusdev;
-    uint8_t i;
     qemu_irq fiq, irq;
     Error *err = NULL;
 
@@ -76,9 +75,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(sysbusdev, 0, AW_A10_PIC_REG_BASE);
     sysbus_connect_irq(sysbusdev, 0, irq);
     sysbus_connect_irq(sysbusdev, 1, fiq);
-    for (i = 0; i < AW_A10_PIC_INT_NR; i++) {
-        s->irq[i] = qdev_get_gpio_in(DEVICE(&s->intc), i);
-    }
+    qdev_pass_gpios(DEVICE(&s->intc), dev, NULL);
 
     object_property_set_bool(OBJECT(&s->timer), true, "realized", &err);
     if (err != NULL) {
@@ -87,12 +84,12 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     }
     sysbusdev = SYS_BUS_DEVICE(&s->timer);
     sysbus_mmio_map(sysbusdev, 0, AW_A10_PIT_REG_BASE);
-    sysbus_connect_irq(sysbusdev, 0, s->irq[22]);
-    sysbus_connect_irq(sysbusdev, 1, s->irq[23]);
-    sysbus_connect_irq(sysbusdev, 2, s->irq[24]);
-    sysbus_connect_irq(sysbusdev, 3, s->irq[25]);
-    sysbus_connect_irq(sysbusdev, 4, s->irq[67]);
-    sysbus_connect_irq(sysbusdev, 5, s->irq[68]);
+    sysbus_connect_irq(sysbusdev, 0, qdev_get_gpio_in(dev, 22));
+    sysbus_connect_irq(sysbusdev, 1, qdev_get_gpio_in(dev, 23));
+    sysbus_connect_irq(sysbusdev, 2, qdev_get_gpio_in(dev, 24));
+    sysbus_connect_irq(sysbusdev, 3, qdev_get_gpio_in(dev, 25));
+    sysbus_connect_irq(sysbusdev, 4, qdev_get_gpio_in(dev, 67));
+    sysbus_connect_irq(sysbusdev, 5, qdev_get_gpio_in(dev, 68));
 
     memory_region_init_ram(&s->sram_a, OBJECT(dev), "sram A", 48 * KiB,
                            &error_fatal);
@@ -111,7 +108,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     }
     sysbusdev = SYS_BUS_DEVICE(&s->emac);
     sysbus_mmio_map(sysbusdev, 0, AW_A10_EMAC_BASE);
-    sysbus_connect_irq(sysbusdev, 0, s->irq[55]);
+    sysbus_connect_irq(sysbusdev, 0, qdev_get_gpio_in(dev, 55));
 
     object_property_set_bool(OBJECT(&s->sata), true, "realized", &err);
     if (err) {
@@ -119,10 +116,11 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sata), 0, AW_A10_SATA_BASE);
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sata), 0, s->irq[56]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sata), 0, qdev_get_gpio_in(dev, 56));
 
     /* FIXME use a qdev chardev prop instead of serial_hd() */
-    serial_mm_init(get_system_memory(), AW_A10_UART0_REG_BASE, 2, s->irq[1],
+    serial_mm_init(get_system_memory(), AW_A10_UART0_REG_BASE, 2,
+                   qdev_get_gpio_in(dev, 1),
                    115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
 }
 
-- 
2.20.1


