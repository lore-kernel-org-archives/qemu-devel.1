Return-Path: <SRS0=QAbx=Z6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F266FC43603
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 18:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F6A205F4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 18:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxeP6aFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F6A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie1kq-0005K5-NV
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 13:58:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tz-0002Mn-B1
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tx-0003Na-EF
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:39 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:37981)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ie1Tw-0003Bm-Sa
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:37 -0500
Received: by mail-wr1-x42f.google.com with SMTP id y17so13536637wrh.5
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 10:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=L5GBv65rCRw+KZToBo8ex2Pqy+nCe531GVJ1B1ABRcI=;
 b=PxeP6aFQYrNDo0ZqXw9vRE3FFP5sRoaBDqiTNySugDtGPARDP3WtoEWFIBNJy9Z0BE
 VRFKj77D9ckDDq0OUB096j2NTBqrk4lpHC2RjFqcvPvH7VBFEvj9N8MOL2uBiRKmmDUz
 3VNlwYsnWZYEQkLT7bFdlk0Qnp50/uWpuhL0MtM6oHTQQL6xSeBDBFkTzCLVXePTMENI
 GgeiyXJ+xT3JiMKmCBrGkpOkI8B07DXwJNEd278uTmmUM2/VbSeV0lIOsr779BKaDX5r
 W4W47dvx8qzzVUL3LJlj0BTDjHLe9cQQ008bQcM2Hhvesgp9/iYr9DXXlVSMH91u9OOc
 44Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=L5GBv65rCRw+KZToBo8ex2Pqy+nCe531GVJ1B1ABRcI=;
 b=WlR2ekeF6CB78/6I++fq4pHRhsaQj+NoHk/e+JRAvRktHtaS7f3Ldj0Oy+ADqEywYt
 uBTXNdN7WmjBdyTl4d8LRrgs4Xk8E1YtafcQF2A3F2pg7LiuF7x07Wq3X+qcvr7HTTSw
 cbsT4bRPL+kzb9uZD2ny7cJ5PUKHS4RX1Zrq5ZFbv8b1khpgLnQEgjPH4VBQfUZaiwZY
 6K5L9HbheHbZZHSoaUTll0ODWQ4vx5mT35ps7mfav/efvfcSQnvyWlDNoD+k9l+IZKck
 2ExYqd/ev1Pydy6tlOfsFznMwJiNUQ6y3jOig5/L9wjb6Mb3nzgILcNENXP1jjd7P8i4
 QE2A==
X-Gm-Message-State: APjAAAVTdBJU0u8V95wQ9kzKfwJKgLeIQ9YsiQ3sOb9/MEcrVJ93C70f
 LtwuqSXoxc3imEpH/SAZpVV0mbO73tU3jvWp
X-Google-Smtp-Source: APXvYqyL6JsRupnPkHNpFqIguLagmaAny/OrSJIPCxGL4FF8vzYSRoDHmC/gZiB54mIexf7Yk5RLXg==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr25603666wrp.71.1575830418774; 
 Sun, 08 Dec 2019 10:40:18 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-180-52-3.red.bezeqint.net. [79.180.52.3])
 by smtp.gmail.com with ESMTPSA id h17sm25289717wrs.18.2019.12.08.10.40.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 08 Dec 2019 10:40:18 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v38 14/22] target/avr: Add dummy mask device
Date: Sun,  8 Dec 2019 20:39:14 +0200
Message-Id: <20191208183922.13757-15-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191208183922.13757-1-mrolnik@gmail.com>
References: <20191208183922.13757-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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


