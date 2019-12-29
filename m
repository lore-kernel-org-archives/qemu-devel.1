Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957AFC2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3692071E
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXfnOO0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3692071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilgfV-0003dT-98
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 17:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ilgUu-0007gm-8N
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ilgUs-0003wU-Kq
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:16 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44125)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ilgUs-0003tq-DC
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:14 -0500
Received: by mail-wr1-x442.google.com with SMTP id q10so31188393wrm.11
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 13:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7Ou9vxdbcZz9S1NhW4ejjR9PVwKvsdppSdHeDXKBIdQ=;
 b=EXfnOO0G9O/DbNANTpCWuPkcTRvU1hj6UdqUuaUuC4HCDikBn6dng5RT7QhM7Swl9I
 cHAvbwmJbVpFXDkQV1u6QjIWGz6mu3BbJDWrTy1G/99CFdiiT2LrBDaijlaNl+V7Vpp7
 Pjh4mGzdip9DqWN9CeCSY/mjho8H0xhAwJiDByiWAuZmzZxry2A6BuPwOPb5/FSjw79Y
 Bq/foJ4V9XHlkPooitlyeWo4mQwk4TterA4Ez9GbNo3O0YMT0scvUZjy0vzKcgAnDA++
 9trZmsZcSGWHNAuzfa8VEVh0n3ACSu+WJTU0OJPjS35BiXAipCWuedUg1m64MzfH5/t+
 FNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7Ou9vxdbcZz9S1NhW4ejjR9PVwKvsdppSdHeDXKBIdQ=;
 b=fgMzBn/U9W7zVrL2uV4l02iUkVc7ZsTs7zh36U1tjPG6NvoC+pfMaAZ7C87XehzmXg
 /MiSBZ6hwe5scsjgliwbT/uHfoDRminj4JwnMhbi+ZD0tIN6y/ZoptPQb6NuuFj0g9o9
 bR2houXr7tVMSMDPs4QtHRZkQ/FEbmuxhDWS6HwDCGU8qPdIGQxty+K4Ro0LZajWfscd
 QkjA4JR9us6R1UWkZJ0CTAQD9zeljcTpMPlWeFcPCqzGK8j3FXmipsIpwIOFVwnpiBJr
 ET0XubNdgJCYzdnmnlwfhM8dU4jzCNAASGJj7NBhUE0tYsMIivJM2uS81vEJ42d4yDQe
 dzEw==
X-Gm-Message-State: APjAAAUlrpXToDarzJJviYPKLjbfLB04cVXYObLciOmvDq/rrMyiuUvG
 E/Hm+VAEOX6KT5hWLspIvVuqMKWwoPkeDQ==
X-Google-Smtp-Source: APXvYqydtFkyRHP/2B0gRdrMr7AOOfpIrUMj7eocQ4DYuPFBLZzIWHU/HUYge3xOAIbmORL1jqA+5w==
X-Received: by 2002:a05:6000:1187:: with SMTP id
 g7mr7827634wrx.109.1577656393156; 
 Sun, 29 Dec 2019 13:53:13 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-183-93-3.red.bezeqint.net. [79.183.93.3])
 by smtp.gmail.com with ESMTPSA id 25sm18182850wmi.32.2019.12.29.13.53.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 29 Dec 2019 13:53:12 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v40 13/21] hw/avr: Add dummy mask device
Date: Sun, 29 Dec 2019 23:51:50 +0200
Message-Id: <20191229215158.5788-14-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191229215158.5788-1-mrolnik@gmail.com>
References: <20191229215158.5788-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a simple device of just one register, whenver this register is
written it calls qemu_set_irq function for each of 8 bits/IRQs..
It is used to implement AVR Power Reduction

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 include/hw/misc/avr_mask.h |  47 ++++++++++++++++
 hw/misc/avr_mask.c         | 112 +++++++++++++++++++++++++++++++++++++
 hw/misc/Kconfig            |   3 +
 hw/misc/Makefile.objs      |   2 +
 4 files changed, 164 insertions(+)
 create mode 100644 include/hw/misc/avr_mask.h
 create mode 100644 hw/misc/avr_mask.c

diff --git a/include/hw/misc/avr_mask.h b/include/hw/misc/avr_mask.h
new file mode 100644
index 0000000000..d3e21972d8
--- /dev/null
+++ b/include/hw/misc/avr_mask.h
@@ -0,0 +1,47 @@
+/*
+ * AVR Power Reduction
+ *
+ * Copyright (c) 2019 Michael Rolnik
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_avr_mask_H
+#define HW_avr_mask_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+#include "hw/hw.h"
+
+
+#define TYPE_AVR_MASK "avr-mask"
+#define AVR_MASK(obj) OBJECT_CHECK(AVRMaskState, (obj), TYPE_AVR_MASK)
+
+typedef struct {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion iomem;
+
+    uint8_t val;
+    qemu_irq irq[8];
+} AVRMaskState;
+
+#endif /* HW_avr_mask_H */
diff --git a/hw/misc/avr_mask.c b/hw/misc/avr_mask.c
new file mode 100644
index 0000000000..3af82ed9c1
--- /dev/null
+++ b/hw/misc/avr_mask.c
@@ -0,0 +1,112 @@
+/*
+ * AVR Power Reduction
+ *
+ * Copyright (c) 2019 Michael Rolnik
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/avr_mask.h"
+#include "qemu/log.h"
+#include "hw/qdev-properties.h"
+#include "hw/irq.h"
+
+#define DB_PRINT(fmt, args...) /* Nothing */
+/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n", __func__, ## args)*/
+
+static void avr_mask_reset(DeviceState *dev)
+{
+    AVRMaskState *s = AVR_MASK(dev);
+
+    s->val = 0x00;
+
+    for (int i = 0; i < 8; i++) {
+        qemu_set_irq(s->irq[i], 0);
+    }
+}
+
+static uint64_t avr_mask_read(void *opaque, hwaddr offset, unsigned size)
+{
+    assert(size == 1);
+    assert(offset == 0);
+    AVRMaskState *s = opaque;
+
+    return (uint64_t)s->val;
+}
+
+static void avr_mask_write(void *opaque, hwaddr offset,
+                              uint64_t val64, unsigned size)
+{
+    assert(size == 1);
+    assert(offset == 0);
+    AVRMaskState *s = opaque;
+    uint8_t val8 = val64;
+
+    DB_PRINT("write %d to offset %d", val8, (uint8_t)offset);
+
+    s->val = val8;
+    for (int i = 0; i < 8; i++) {
+        qemu_set_irq(s->irq[i], (val8 & (1 << i)) != 0);
+    }
+}
+
+static const MemoryRegionOps avr_mask_ops = {
+    .read = avr_mask_read,
+    .write = avr_mask_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {.max_access_size = 1}
+};
+
+static void avr_mask_init(Object *dev)
+{
+    AVRMaskState *s = AVR_MASK(dev);
+    SysBusDevice *busdev = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->iomem, dev, &avr_mask_ops, s, TYPE_AVR_MASK,
+            0x01);
+    sysbus_init_mmio(busdev, &s->iomem);
+
+    for (int i = 0; i < 8; i++) {
+        sysbus_init_irq(busdev, &s->irq[i]);
+    }
+    s->val = 0x00;
+}
+
+static void avr_mask_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = avr_mask_reset;
+}
+
+static const TypeInfo avr_mask_info = {
+    .name          = TYPE_AVR_MASK,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AVRMaskState),
+    .class_init    = avr_mask_class_init,
+    .instance_init = avr_mask_init,
+};
+
+static void avr_mask_register_types(void)
+{
+    type_register_static(&avr_mask_info);
+}
+
+type_init(avr_mask_register_types)
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 2164646553..e79841e3a4 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -125,4 +125,7 @@ config MAC_VIA
     select MOS6522
     select ADB
 
+config AVR_MASK
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index ba898a5781..3a8093be6a 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -82,3 +82,5 @@ common-obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
 obj-$(CONFIG_MAC_VIA) += mac_via.o
 
 common-obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
+
+obj-$(CONFIG_AVR_MASK) += avr_mask.o
-- 
2.17.2 (Apple Git-113)


