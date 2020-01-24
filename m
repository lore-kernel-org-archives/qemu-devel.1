Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE407C35240
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72062071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWsoP6Br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72062071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iunGF-0001mY-PP
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 19:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCi-00029I-DS
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCg-0005KE-Pz
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:08 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCg-0005J6-Id; Thu, 23 Jan 2020 19:52:06 -0500
Received: by mail-wm1-x343.google.com with SMTP id s144so3007406wme.1;
 Thu, 23 Jan 2020 16:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J3qwH5nB+ktm+X0YAoP4RKFh5TB1rhPNUkL1SuqyNYw=;
 b=aWsoP6Broiq7V2M/brzbOiIdxz9OAMW3aoOxm0PB52SZePoN6wG8Zmgtyza818UBy8
 /5c+3aBDNlvg+ZjJNIWJ4EHzBbHIQV3araDjIw89E36Xot5ODreA3u6TD7KvV2XBLVjl
 HV8ZxhNz3+px8c7YUWi1cglZtE00bYOarQHLFSxfxaPs2dRObtOjor9ui8iIOX4JmhzL
 yDylb9mG9jeE3OiumRYzY/Hq07f129yVJowpgkc7zT8LkPyPcOX0aw8uNt8QOLFmVMNi
 PuupqQNwK8U2cdG70empwEVIvVK9TAs0LqeU6vSNnobhSc/McvLp7t+WvU06czXm6RRw
 4SFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=J3qwH5nB+ktm+X0YAoP4RKFh5TB1rhPNUkL1SuqyNYw=;
 b=aHCWUMYauNXc5dzBqvt9DtYGibQINsh62fvu0sbxNoa84pGZrEum+lQxDZherwCYHj
 +fbV8FiASKddpuFLfNvQxRPxKJJadFmykeUG+qmv1kas1HSzCgd2YiJMQzbjy01F/oA9
 i3wyp9V5E+qkAAWuepHkKbEOjww0W31wrIYz0ld2JsArRVFGZ970G7NihpXNlbIcFMS+
 d9BHDuylspBw+GE/XqA5mwxaUeodm9kVjmjFGDEbp3UJ+K1fgpYMV/CYjyZFCvQAe030
 TtsC4GOiAFevlWVYiVZLQ1yoMjWXD7sQeSUiBtuywdu+0+BWDEL0itX89lOjRV7n7CvO
 I2Qw==
X-Gm-Message-State: APjAAAVBEjpiKD880PG/NdmoVksRWmvj2XFdW+g3a1TyTPOO7al20twH
 8pMBNuAbf2Ey74oLgz/QGTg97cI5
X-Google-Smtp-Source: APXvYqw24vLy1IIoF0TrkQxenjk0HTiwDJz8rO/GTwWG1vTyGMUXdNwICltPj1kPtB45JONegneRXg==
X-Received: by 2002:a05:600c:2046:: with SMTP id
 p6mr505648wmg.167.1579827125352; 
 Thu, 23 Jan 2020 16:52:05 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s139sm4598271wme.35.2020.01.23.16.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 16:52:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org,
 me@xcancerberox.com.ar
Subject: [PATCH rc2 13/25] hw/misc: Add Atmel power device
Date: Fri, 24 Jan 2020 01:51:19 +0100
Message-Id: <20200124005131.16276-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200124005131.16276-1-f4bug@amsat.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 S.E.Harris@kent.ac.uk, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, dovgaluk@ispras.ru,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, thuth@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, imammedo@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, aleksandar.m.mail@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

This is a simple device of just one register, whenver this register is
written it calls qemu_set_irq function for each of 8 bits/IRQs..
It is used to implement AVR Power Reduction

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Message-Id: <20200118191416.19934-14-mrolnik@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[rth: Squash include fix and file rename from f4bug, which was:]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/misc/atmel_power.h |  46 ++++++++++++++
 hw/misc/atmel_power.c         | 112 ++++++++++++++++++++++++++++++++++
 hw/misc/Kconfig               |   3 +
 hw/misc/Makefile.objs         |   2 +
 4 files changed, 163 insertions(+)
 create mode 100644 include/hw/misc/atmel_power.h
 create mode 100644 hw/misc/atmel_power.c

diff --git a/include/hw/misc/atmel_power.h b/include/hw/misc/atmel_power.h
new file mode 100644
index 0000000000..5366e9693f
--- /dev/null
+++ b/include/hw/misc/atmel_power.h
@@ -0,0 +1,46 @@
+/*
+ * Atmel AVR Power Reduction Management
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
+#ifndef HW_MISC_ATMEL_POWER_H
+#define HW_MISC_ATMEL_POWER_H
+
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+
+
+#define TYPE_AVR_MASK "atmel-power"
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
+#endif /* HW_MISC_ATMEL_POWER_H */
diff --git a/hw/misc/atmel_power.c b/hw/misc/atmel_power.c
new file mode 100644
index 0000000000..adab729f66
--- /dev/null
+++ b/hw/misc/atmel_power.c
@@ -0,0 +1,112 @@
+/*
+ * Atmel AVR Power Reduction Management
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
+#include "hw/misc/atmel_power.h"
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
index bdd77d8020..3a3c32e1b0 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -131,4 +131,7 @@ config MAC_VIA
     select MOS6522
     select ADB
 
+config ATMEL_POWER
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index da993f45b7..e605964f4b 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -85,3 +85,5 @@ common-obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
 obj-$(CONFIG_MAC_VIA) += mac_via.o
 
 common-obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
+
+obj-$(CONFIG_ATMEL_POWER) += atmel_power.o
-- 
2.21.1


