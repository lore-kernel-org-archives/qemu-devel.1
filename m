Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931E7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50EA6206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edDvCar2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EA6206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssPp-00008X-KF
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssAE-0000An-Sl
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:36513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssAB-0002wk-QI
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:53 -0400
Received: by mail-wm1-x330.google.com with SMTP id 17so87331wmo.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zsTv03VARaihe+oGT92uCGB4KZTAlGdB70IybG3Qeu4=;
 b=edDvCar2cn9eMjXOdlh2Y7NDKzzd593p4RCZTIwlYx/SuoBwEFWjKEtqfR2kdKsFy7
 Mj44IjIKC3P0dEgF49Q4v12NNPAy7/7RALlpf4LbwiBmklqjsupAVm6xSvwavRfCaIiS
 3qo3C5P8KVemVSffLchjtt80ORMl8o9L1mdmvRBmTB1QoJUHlScSpNkybv74PIoAmC3v
 Vvq3BGahvW90KIZgNT8FSNOwoF2KZV/oH766WcRZ8zhHsiVSs3zl+xrybO7hQWdeqnHa
 WjouK4kpqeBDhO8+y0hqzNvJ4JyNQgou3aL7UI5olmhet5EdiyQum2Xk0/1gmUME+ot6
 fhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zsTv03VARaihe+oGT92uCGB4KZTAlGdB70IybG3Qeu4=;
 b=cmZYcnHOJaLk3jnC+vMxQJ7mCttfeyoZNgmvem85wGdI/i5Sb5raRzlZSWCgxq+o9K
 9g/5r4r6dtrUPwJUS+bqtq55jDYcQuFno4uO5LQL+vWYj6nEstlwVB3F1gHQQDKJW8+L
 wBTgtMlCJbTD2w/gc3ZEfnQab1/rFqmS5g7uHT5l7xv23JMZEnfaxglgxHgGT9d+MLQ4
 7CDM4t+3wbLDxzUodxO0DK7cyh8wOpZh3S2RLfBOOYdpEOmnFkhHt4isCpvVOLDPW4ld
 /IN+MdERe1VE+HYl1jcrGzWr0+utHDQmaMePxuJ+OId3eP0nx53EHhmOGQJ3Z22kGpwW
 yrsQ==
X-Gm-Message-State: AOAM530/8QnR7s5+K2VhfR8iRyytP7WXbO8GdOlO9vo/rVekDVY6G+Ek
 O/2lPBgxm41tQytXAAXo1G7djpyH
X-Google-Smtp-Source: ABdhPJzlmqyfprzO9P3m8lD9u//smozCTVLQkk/fTb/HItQPf8oOoZHBIyUKGG1WjPUulDbE6GK6xA==
X-Received: by 2002:a1c:2392:: with SMTP id j140mr5338922wmj.6.1594145870108; 
 Tue, 07 Jul 2020 11:17:50 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm2253337wma.48.2020.07.07.11.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:17:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/32] hw/misc: avr: Add limited support for power reduction
 device
Date: Tue,  7 Jul 2020 20:17:01 +0200
Message-Id: <20200707181710.30950-24-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707181710.30950-1-f4bug@amsat.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x330.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

This is a simple device of just one register, and whenever this
register is written to it calls qemu_set_irq function for each
of 8 bits/IRQs. It is used to implement AVR Power Reduction.

[AM: Remove word 'Atmel' from filenames and all elements of code]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[rth: Squash include fix and file rename from f4bug]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20200705140315.260514-22-huth@tuxfamily.org>
---
 include/hw/misc/avr_power.h |  46 +++++++++++++++
 hw/misc/avr_power.c         | 113 ++++++++++++++++++++++++++++++++++++
 MAINTAINERS                 |   2 +
 hw/misc/Kconfig             |   3 +
 hw/misc/Makefile.objs       |   2 +
 hw/misc/trace-events        |   4 ++
 6 files changed, 170 insertions(+)
 create mode 100644 include/hw/misc/avr_power.h
 create mode 100644 hw/misc/avr_power.c

diff --git a/include/hw/misc/avr_power.h b/include/hw/misc/avr_power.h
new file mode 100644
index 0000000000..e08e44f629
--- /dev/null
+++ b/include/hw/misc/avr_power.h
@@ -0,0 +1,46 @@
+/*
+ * AVR Power Reduction Management
+ *
+ * Copyright (c) 2019-2020 Michael Rolnik
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
+#ifndef HW_MISC_AVR_POWER_H
+#define HW_MISC_AVR_POWER_H
+
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+
+
+#define TYPE_AVR_MASK "avr-power"
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
+#endif /* HW_MISC_AVR_POWER_H */
diff --git a/hw/misc/avr_power.c b/hw/misc/avr_power.c
new file mode 100644
index 0000000000..a5412f2cfe
--- /dev/null
+++ b/hw/misc/avr_power.c
@@ -0,0 +1,113 @@
+/*
+ * AVR Power Reduction Management
+ *
+ * Copyright (c) 2019-2020 Michael Rolnik
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
+#include "hw/misc/avr_power.h"
+#include "qemu/log.h"
+#include "hw/qdev-properties.h"
+#include "hw/irq.h"
+#include "trace.h"
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
+    trace_avr_power_read(s->val);
+
+    return (uint64_t)s->val;
+}
+
+static void avr_mask_write(void *opaque, hwaddr offset,
+                           uint64_t val64, unsigned size)
+{
+    assert(size == 1);
+    assert(offset == 0);
+    AVRMaskState *s = opaque;
+    uint8_t val8 = val64;
+
+    trace_avr_power_write(val8);
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
+    .impl = {
+        .max_access_size = 1,
+    },
+};
+
+static void avr_mask_init(Object *dev)
+{
+    AVRMaskState *s = AVR_MASK(dev);
+    SysBusDevice *busdev = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->iomem, dev, &avr_mask_ops, s, TYPE_AVR_MASK,
+                          0x01);
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 61a6017342..443b377a72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -987,6 +987,8 @@ F: include/hw/char/avr_usart.h
 F: hw/char/avr_usart.c
 F: include/hw/timer/avr_timer16.h
 F: hw/timer/avr_timer16.c
+F: include/hw/misc/avr_power.h
+F: hw/misc/avr_power.c
 
 CRIS Machines
 -------------
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index bdd77d8020..92c397ca07 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -131,4 +131,7 @@ config MAC_VIA
     select MOS6522
     select ADB
 
+config AVR_POWER
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 5aaca8a039..6be3d255ab 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -91,3 +91,5 @@ common-obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
 obj-$(CONFIG_MAC_VIA) += mac_via.o
 
 common-obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
+
+obj-$(CONFIG_AVR_POWER) += avr_power.o
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index ebea53735c..066752aa90 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -19,6 +19,10 @@ allwinner_h3_dramphy_write(uint64_t offset, uint64_t data, unsigned size) "write
 allwinner_sid_read(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
 allwinner_sid_write(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
 
+# avr_power.c
+avr_power_read(uint8_t value) "power_reduc read value:%u"
+avr_power_write(uint8_t value) "power_reduc write value:%u"
+
 # eccmemctl.c
 ecc_mem_writel_mer(uint32_t val) "Write memory enable 0x%08x"
 ecc_mem_writel_mdr(uint32_t val) "Write memory delay 0x%08x"
-- 
2.21.3


