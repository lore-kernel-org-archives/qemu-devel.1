Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255D4C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:30:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35DC2072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PxO9zC4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35DC2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSdS-0007yd-Ci
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbp-0006BQ-V6
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbn-0006zG-U6
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:25 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:38522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isSbn-0006y9-Mk
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:23 -0500
Received: by mail-wr1-x42d.google.com with SMTP id y17so22923819wrh.5
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ViQYn/SP2ktPLplWFaUP3JXDeUEzGxV2C5C4iuN2qjk=;
 b=PxO9zC4Nq3qzbdlXsojd0oorVAo3+gAeO24xr7dsfchR3XWGIsp+ghzY+3Lw24j/1M
 D4Pr0/jSfKqnOzvCEsOXauyKfwtBJ9zLDVDYn2wBFdRW+piwMZPq/sSepP8l/WEDfL56
 0xbF5xnBE1GgsLj93aoYxp8SRY9V1FhfAyW9Dd+9JS/VjhxkNNO6l63+iXitcGun87ou
 Smufj048TcjCENp4tAoTBmaNugKRfcBWeM0fCTy9fXuiDYavu4ogOOV9jbjpUSgJycHI
 7qWShXPBZDs6jS4fQPV5C8nr3+FzT/o8B31Rq30rFEafoihDyAQ8Jwl6JzIVJjcht9wW
 gRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ViQYn/SP2ktPLplWFaUP3JXDeUEzGxV2C5C4iuN2qjk=;
 b=HZ9mifZ8A30jdQapRzXmpKxVgX6mQ8md09ekq7GC/JPJjGq6P2RxzOqbRujm7Dt6nt
 1FOk0GNGeX5nTA783oETEV/iiTtE6xf6VvbvdmyUOGsfHqFZmsVdu6BzAud3OYbCsu1n
 Za60OAj8ehHLug4789642HZjqStfipSbUuudXPAmaPbhuW3QsL3xjXV0KCUZ7s+9r5vI
 5eTKPv6McawYDQep61ZO4WlecCmJJK/CBc+hFyZjI3bDSqVeJTNTSKPmEUavEJe+SRKI
 9BDbTLiJ+DFViWPBesntyN8UR2uq+sv2itBO5VSOKPfQudZ+NmyO6Rp65SByobH3dD9A
 MkLg==
X-Gm-Message-State: APjAAAXgYgTaszU1jU+zhpWk/ji4wn50fIKkozaVgnySKucHCjNy30in
 iNTSFGvXE4708Bcn4JWSDCQhbCjW1Wxemw==
X-Google-Smtp-Source: APXvYqxOfzAM6XOHnWfvmeks+A+ETfIVuYkEztsULlnNSy3RjST2F3RyED6AnP6aZWlpUgo5C7k40Q==
X-Received: by 2002:adf:df90:: with SMTP id z16mr3295131wrl.273.1579271302184; 
 Fri, 17 Jan 2020 06:28:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e18sm33811146wrw.70.2020.01.17.06.28.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 06:28:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/15] hw/misc: Add the STM32F4xx EXTI device
Date: Fri, 17 Jan 2020 14:28:03 +0000
Message-Id: <20200117142816.15110-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117142816.15110-1-peter.maydell@linaro.org>
References: <20200117142816.15110-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

From: Alistair Francis <alistair@alistair23.me>

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: ef941d59fd8658589d34ed432e1d6dfdcf7fb1d0.1576658572.git.alistair@alistair23.me
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/Makefile.objs            |   1 +
 include/hw/misc/stm32f4xx_exti.h |  60 ++++++++++
 hw/misc/stm32f4xx_exti.c         | 188 +++++++++++++++++++++++++++++++
 hw/arm/Kconfig                   |   1 +
 hw/misc/Kconfig                  |   3 +
 hw/misc/trace-events             |   5 +
 6 files changed, 258 insertions(+)
 create mode 100644 include/hw/misc/stm32f4xx_exti.h
 create mode 100644 hw/misc/stm32f4xx_exti.c

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index ea8025e0bb1..c6ecbdd7b0e 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -59,6 +59,7 @@ common-obj-$(CONFIG_ZYNQ) += zynq_slcr.o
 common-obj-$(CONFIG_ZYNQ) += zynq-xadc.o
 common-obj-$(CONFIG_STM32F2XX_SYSCFG) += stm32f2xx_syscfg.o
 common-obj-$(CONFIG_STM32F4XX_SYSCFG) += stm32f4xx_syscfg.o
+common-obj-$(CONFIG_STM32F4XX_EXTI) += stm32f4xx_exti.o
 obj-$(CONFIG_MIPS_CPS) += mips_cmgcr.o
 obj-$(CONFIG_MIPS_CPS) += mips_cpc.o
 obj-$(CONFIG_MIPS_ITU) += mips_itu.o
diff --git a/include/hw/misc/stm32f4xx_exti.h b/include/hw/misc/stm32f4xx_exti.h
new file mode 100644
index 00000000000..707036a41b1
--- /dev/null
+++ b/include/hw/misc/stm32f4xx_exti.h
@@ -0,0 +1,60 @@
+/*
+ * STM32F4XX EXTI
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
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
+#ifndef HW_STM_EXTI_H
+#define HW_STM_EXTI_H
+
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+
+#define EXTI_IMR   0x00
+#define EXTI_EMR   0x04
+#define EXTI_RTSR  0x08
+#define EXTI_FTSR  0x0C
+#define EXTI_SWIER 0x10
+#define EXTI_PR    0x14
+
+#define TYPE_STM32F4XX_EXTI "stm32f4xx-exti"
+#define STM32F4XX_EXTI(obj) \
+    OBJECT_CHECK(STM32F4xxExtiState, (obj), TYPE_STM32F4XX_EXTI)
+
+#define NUM_GPIO_EVENT_IN_LINES 16
+#define NUM_INTERRUPT_OUT_LINES 16
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t exti_imr;
+    uint32_t exti_emr;
+    uint32_t exti_rtsr;
+    uint32_t exti_ftsr;
+    uint32_t exti_swier;
+    uint32_t exti_pr;
+
+    qemu_irq irq[NUM_INTERRUPT_OUT_LINES];
+} STM32F4xxExtiState;
+
+#endif
diff --git a/hw/misc/stm32f4xx_exti.c b/hw/misc/stm32f4xx_exti.c
new file mode 100644
index 00000000000..02e78100461
--- /dev/null
+++ b/hw/misc/stm32f4xx_exti.c
@@ -0,0 +1,188 @@
+/*
+ * STM32F4XX EXTI
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
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
+#include "qemu/log.h"
+#include "trace.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "hw/misc/stm32f4xx_exti.h"
+
+static void stm32f4xx_exti_reset(DeviceState *dev)
+{
+    STM32F4xxExtiState *s = STM32F4XX_EXTI(dev);
+
+    s->exti_imr = 0x00000000;
+    s->exti_emr = 0x00000000;
+    s->exti_rtsr = 0x00000000;
+    s->exti_ftsr = 0x00000000;
+    s->exti_swier = 0x00000000;
+    s->exti_pr = 0x00000000;
+}
+
+static void stm32f4xx_exti_set_irq(void *opaque, int irq, int level)
+{
+    STM32F4xxExtiState *s = opaque;
+
+    trace_stm32f4xx_exti_set_irq(irq, level);
+
+    if (((1 << irq) & s->exti_rtsr) && level) {
+        /* Rising Edge */
+        s->exti_pr |= 1 << irq;
+    }
+
+    if (((1 << irq) & s->exti_ftsr) && !level) {
+        /* Falling Edge */
+        s->exti_pr |= 1 << irq;
+    }
+
+    if (!((1 << irq) & s->exti_imr)) {
+        /* Interrupt is masked */
+        return;
+    }
+    qemu_irq_pulse(s->irq[irq]);
+}
+
+static uint64_t stm32f4xx_exti_read(void *opaque, hwaddr addr,
+                                     unsigned int size)
+{
+    STM32F4xxExtiState *s = opaque;
+
+    trace_stm32f4xx_exti_read(addr);
+
+    switch (addr) {
+    case EXTI_IMR:
+        return s->exti_imr;
+    case EXTI_EMR:
+        return s->exti_emr;
+    case EXTI_RTSR:
+        return s->exti_rtsr;
+    case EXTI_FTSR:
+        return s->exti_ftsr;
+    case EXTI_SWIER:
+        return s->exti_swier;
+    case EXTI_PR:
+        return s->exti_pr;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "STM32F4XX_exti_read: Bad offset %x\n", (int)addr);
+        return 0;
+    }
+    return 0;
+}
+
+static void stm32f4xx_exti_write(void *opaque, hwaddr addr,
+                       uint64_t val64, unsigned int size)
+{
+    STM32F4xxExtiState *s = opaque;
+    uint32_t value = (uint32_t) val64;
+
+    trace_stm32f4xx_exti_write(addr, value);
+
+    switch (addr) {
+    case EXTI_IMR:
+        s->exti_imr = value;
+        return;
+    case EXTI_EMR:
+        s->exti_emr = value;
+        return;
+    case EXTI_RTSR:
+        s->exti_rtsr = value;
+        return;
+    case EXTI_FTSR:
+        s->exti_ftsr = value;
+        return;
+    case EXTI_SWIER:
+        s->exti_swier = value;
+        return;
+    case EXTI_PR:
+        /* This bit is cleared by writing a 1 to it */
+        s->exti_pr &= ~value;
+        return;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "STM32F4XX_exti_write: Bad offset %x\n", (int)addr);
+    }
+}
+
+static const MemoryRegionOps stm32f4xx_exti_ops = {
+    .read = stm32f4xx_exti_read,
+    .write = stm32f4xx_exti_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void stm32f4xx_exti_init(Object *obj)
+{
+    STM32F4xxExtiState *s = STM32F4XX_EXTI(obj);
+    int i;
+
+    for (i = 0; i < NUM_INTERRUPT_OUT_LINES; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
+    }
+
+    memory_region_init_io(&s->mmio, obj, &stm32f4xx_exti_ops, s,
+                          TYPE_STM32F4XX_EXTI, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    qdev_init_gpio_in(DEVICE(obj), stm32f4xx_exti_set_irq,
+                      NUM_GPIO_EVENT_IN_LINES);
+}
+
+static const VMStateDescription vmstate_stm32f4xx_exti = {
+    .name = TYPE_STM32F4XX_EXTI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(exti_imr, STM32F4xxExtiState),
+        VMSTATE_UINT32(exti_emr, STM32F4xxExtiState),
+        VMSTATE_UINT32(exti_rtsr, STM32F4xxExtiState),
+        VMSTATE_UINT32(exti_ftsr, STM32F4xxExtiState),
+        VMSTATE_UINT32(exti_swier, STM32F4xxExtiState),
+        VMSTATE_UINT32(exti_pr, STM32F4xxExtiState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void stm32f4xx_exti_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = stm32f4xx_exti_reset;
+    dc->vmsd = &vmstate_stm32f4xx_exti;
+}
+
+static const TypeInfo stm32f4xx_exti_info = {
+    .name          = TYPE_STM32F4XX_EXTI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(STM32F4xxExtiState),
+    .instance_init = stm32f4xx_exti_init,
+    .class_init    = stm32f4xx_exti_class_init,
+};
+
+static void stm32f4xx_exti_register_types(void)
+{
+    type_register_static(&stm32f4xx_exti_info);
+}
+
+type_init(stm32f4xx_exti_register_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4660d147156..3d86691ae0c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -315,6 +315,7 @@ config STM32F405_SOC
     bool
     select ARM_V7M
     select STM32F4XX_SYSCFG
+    select STM32F4XX_EXTI
 
 config XLNX_ZYNQMP_ARM
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 72609650b7a..bdd77d80205 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -85,6 +85,9 @@ config STM32F2XX_SYSCFG
 config STM32F4XX_SYSCFG
     bool
 
+config STM32F4XX_EXTI
+    bool
+
 config MIPS_ITU
     bool
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 44b4f72f57f..7f0f5dff3a8 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -90,6 +90,11 @@ stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
 stm32f4xx_syscfg_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
 stm32f4xx_syscfg_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
 
+# stm32f4xx_exti
+stm32f4xx_exti_set_irq(int irq, int leve) "Set EXTI: %d to %d"
+stm32f4xx_exti_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
+stm32f4xx_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
+
 # tz-mpc.c
 tz_mpc_reg_read(uint32_t offset, uint64_t data, unsigned size) "TZ MPC regs read: offset 0x%x data 0x%" PRIx64 " size %u"
 tz_mpc_reg_write(uint32_t offset, uint64_t data, unsigned size) "TZ MPC regs write: offset 0x%x data 0x%" PRIx64 " size %u"
-- 
2.20.1


