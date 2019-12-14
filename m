Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735A1C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 02:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3537D214AF
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 02:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="ELjaNJLn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q5bLk/7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3537D214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifxRN-0005S2-JG
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 21:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1ifxPv-0004Dx-30
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 21:44:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair@alistair23.me>) id 1ifxPt-0000kg-3M
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 21:44:26 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42297)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alistair@alistair23.me>)
 id 1ifxPo-0000ZP-Dm; Fri, 13 Dec 2019 21:44:20 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 2820822381;
 Fri, 13 Dec 2019 21:44:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Fri, 13 Dec 2019 21:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=Ycj47i8fK5kEa
 RcOR8Jj/ZfHwVQ6hNHq28ldpaD/6mk=; b=ELjaNJLnAn67Tw3GDymAsPIoPT+7T
 6VuT42EkrMp8kZbWF2yxrTbZ/4g3nf1DgnD7OkeoKPYTUg1M60vtz/RDwNtxsKMP
 3whWZVIEsuR5uuLIkMA5JvFaYCPY3j85lcrKXJwEOfEkcNy9npZKT6YYlTkW+gkw
 MjcTTF33VII2PCxqLGvFKzSc5Rp701F/T96oA3+oaEx6f5MamGHVMVIL7Z+mLLBr
 7atMHpZ5Vk5Aai9g+V9G4JUy6fNnPEaP0LEQcAva6mbaLzfDftt06bXMlIs/CCQo
 SvqrJNoKRacj7258bpEcQXLz/6y28J89R0/K4Qq2Lw6k1p9uKpYA7XrEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=Ycj47i8fK5kEaRcOR8Jj/ZfHwVQ6hNHq28ldpaD/6mk=; b=q5bLk/7R
 xAdkWeFb/1Cn9ulRsnSjegi9dvdTFZeYbyhIDQrs6fU+CQeh80Lpk+uunReVS1/+
 BKJ9qCQxVqyo182PwH74G2tfAoH8sEdvBBd20OpAat78DR4MVTKJLt0EM+PyzhlJ
 rtZIGYfVwAEIRzTbpoet6M8sfjK0jFAIYWY8FGQxUcTb7Vl9hLaaMnN+IdQLLq8Y
 2L6EuYK1J0bJoe/5ycQWsa7j+wAt+YhfGxz9yvogbW9ywyVi5mTogiYlCCXbi8jh
 RWewJXicLljdMS3QT4b9mUfF0yiHimtUkA7iAiwABbFnH0/Must90h75ZIsOTPUY
 dzrlkowaV6wn8w==
X-ME-Sender: <xms:hEz0XbduIHyymuhw2jPeJliEqmCNVnRAkromRTfFg-tEEnidZChqfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddttddggeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
 ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucfkphepjeefrdelfedrkeegrddvtdekne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdef
 rdhmvgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:hEz0XRUftwL7GcQlxZqzG-FMb82LzqtsbL2QPfC2hh5jXaU8XOgGMg>
 <xmx:hEz0Xb8udhLk1sQgqGisLKFlIC-czwC30tZ_F9V78RuTP1ifChxEfg>
 <xmx:hEz0XTghLHGMUY8OgGY_y8omck0Z3VdqgQ6JW_YP6fozHwaDt8cQWw>
 <xmx:hEz0XVIPwFgKfn596Qzn6h5jfvvXWZFmVZ5FSwbIr9zCvV0u2SZWNw>
Received: from alistair-xps-14z.alistair23.me
 (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
 by mail.messagingengine.com (Postfix) with ESMTPA id 566B380059;
 Fri, 13 Dec 2019 21:44:19 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v6 1/4] hw/misc: Add the STM32F4xx Sysconfig device
Date: Fri, 13 Dec 2019 18:44:18 -0800
Message-Id: <36b89b7805c66cd115925cc738e6e0594b3241ec.1576227325.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1576227325.git.alistair@alistair23.me>
References: <cover.1576227325.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.29
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
Cc: alistair23@gmail.com, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 default-configs/arm-softmmu.mak    |   1 +
 hw/arm/Kconfig                     |   9 ++
 hw/misc/Kconfig                    |   3 +
 hw/misc/Makefile.objs              |   1 +
 hw/misc/stm32f4xx_syscfg.c         | 171 +++++++++++++++++++++++++++++
 hw/misc/trace-events               |   6 +
 include/hw/misc/stm32f4xx_syscfg.h |  61 ++++++++++
 7 files changed, 252 insertions(+)
 create mode 100644 hw/misc/stm32f4xx_syscfg.c
 create mode 100644 include/hw/misc/stm32f4xx_syscfg.h

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 1f2e0e7fde..645e6201bb 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -30,6 +30,7 @@ CONFIG_Z2=y
 CONFIG_COLLIE=y
 CONFIG_ASPEED_SOC=y
 CONFIG_NETDUINO2=y
+CONFIG_NETDUINOPLUS2=y
 CONFIG_MPS2=y
 CONFIG_RASPI=y
 CONFIG_DIGIC=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c6e7782580..4660d14715 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -101,6 +101,10 @@ config NETDUINO2
     bool
     select STM32F205_SOC
 
+config NETDUINOPLUS2
+    bool
+    select STM32F405_SOC
+
 config NSERIES
     bool
     select OMAP
@@ -307,6 +311,11 @@ config STM32F205_SOC
     select STM32F2XX_ADC
     select STM32F2XX_SPI
 
+config STM32F405_SOC
+    bool
+    select ARM_V7M
+    select STM32F4XX_SYSCFG
+
 config XLNX_ZYNQMP_ARM
     bool
     select AHCI
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 2164646553..72609650b7 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -82,6 +82,9 @@ config IMX
 config STM32F2XX_SYSCFG
     bool
 
+config STM32F4XX_SYSCFG
+    bool
+
 config MIPS_ITU
     bool
 
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index ba898a5781..ea8025e0bb 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -58,6 +58,7 @@ common-obj-$(CONFIG_SLAVIO) += slavio_misc.o
 common-obj-$(CONFIG_ZYNQ) += zynq_slcr.o
 common-obj-$(CONFIG_ZYNQ) += zynq-xadc.o
 common-obj-$(CONFIG_STM32F2XX_SYSCFG) += stm32f2xx_syscfg.o
+common-obj-$(CONFIG_STM32F4XX_SYSCFG) += stm32f4xx_syscfg.o
 obj-$(CONFIG_MIPS_CPS) += mips_cmgcr.o
 obj-$(CONFIG_MIPS_CPS) += mips_cpc.o
 obj-$(CONFIG_MIPS_ITU) += mips_itu.o
diff --git a/hw/misc/stm32f4xx_syscfg.c b/hw/misc/stm32f4xx_syscfg.c
new file mode 100644
index 0000000000..dbcdca59f8
--- /dev/null
+++ b/hw/misc/stm32f4xx_syscfg.c
@@ -0,0 +1,171 @@
+/*
+ * STM32F4xx SYSCFG
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
+#include "hw/misc/stm32f4xx_syscfg.h"
+
+static void stm32f4xx_syscfg_reset(DeviceState *dev)
+{
+    STM32F4xxSyscfgState *s = STM32F4XX_SYSCFG(dev);
+
+    s->syscfg_memrmp = 0x00000000;
+    s->syscfg_pmc = 0x00000000;
+    s->syscfg_exticr[0] = 0x00000000;
+    s->syscfg_exticr[1] = 0x00000000;
+    s->syscfg_exticr[2] = 0x00000000;
+    s->syscfg_exticr[3] = 0x00000000;
+    s->syscfg_cmpcr = 0x00000000;
+}
+
+static void stm32f4xx_syscfg_set_irq(void *opaque, int irq, int level)
+{
+    STM32F4xxSyscfgState *s = opaque;
+    int icrreg = irq / 4;
+    int startbit = (irq & 3) * 4;
+    uint8_t config = config = irq / 16;
+
+    trace_stm32f4xx_syscfg_set_irq(irq / 16, irq % 16, level);
+
+    g_assert(icrreg < SYSCFG_NUM_EXTICR);
+
+    if (extract32(s->syscfg_exticr[icrreg], startbit, 4) == config) {
+        qemu_set_irq(s->gpio_out[irq], level);
+        trace_stm32f4xx_pulse_exti(irq);
+   }
+}
+
+static uint64_t stm32f4xx_syscfg_read(void *opaque, hwaddr addr,
+                                     unsigned int size)
+{
+    STM32F4xxSyscfgState *s = opaque;
+
+    trace_stm32f4xx_syscfg_read(addr);
+
+    switch (addr) {
+    case SYSCFG_MEMRMP:
+        return s->syscfg_memrmp;
+    case SYSCFG_PMC:
+        return s->syscfg_pmc;
+    case SYSCFG_EXTICR1...SYSCFG_EXTICR4:
+        return s->syscfg_exticr[addr / 4 - SYSCFG_EXTICR1 / 4];
+    case SYSCFG_CMPCR:
+        return s->syscfg_cmpcr;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
+        return 0;
+    }
+}
+
+static void stm32f4xx_syscfg_write(void *opaque, hwaddr addr,
+                       uint64_t val64, unsigned int size)
+{
+    STM32F4xxSyscfgState *s = opaque;
+    uint32_t value = val64;
+
+    trace_stm32f4xx_syscfg_write(value, addr);
+
+    switch (addr) {
+    case SYSCFG_MEMRMP:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Changing the memory mapping isn't supported " \
+                      "in QEMU\n", __func__);
+        return;
+    case SYSCFG_PMC:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Changing the memory mapping isn't supported " \
+                      "in QEMU\n", __func__);
+        return;
+    case SYSCFG_EXTICR1...SYSCFG_EXTICR4:
+        s->syscfg_exticr[addr / 4 - SYSCFG_EXTICR1 / 4] = (value & 0xFFFF);
+        return;
+    case SYSCFG_CMPCR:
+        s->syscfg_cmpcr = value;
+        return;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
+    }
+}
+
+static const MemoryRegionOps stm32f4xx_syscfg_ops = {
+    .read = stm32f4xx_syscfg_read,
+    .write = stm32f4xx_syscfg_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void stm32f4xx_syscfg_init(Object *obj)
+{
+    STM32F4xxSyscfgState *s = STM32F4XX_SYSCFG(obj);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    memory_region_init_io(&s->mmio, obj, &stm32f4xx_syscfg_ops, s,
+                          TYPE_STM32F4XX_SYSCFG, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    qdev_init_gpio_in(DEVICE(obj), stm32f4xx_syscfg_set_irq, 16 * 9);
+    qdev_init_gpio_out(DEVICE(obj), s->gpio_out, 16);
+}
+
+static const VMStateDescription vmstate_stm32f4xx_syscfg = {
+    .name = TYPE_STM32F4XX_SYSCFG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(syscfg_memrmp, STM32F4xxSyscfgState),
+        VMSTATE_UINT32(syscfg_pmc, STM32F4xxSyscfgState),
+        VMSTATE_UINT32_ARRAY(syscfg_exticr, STM32F4xxSyscfgState,
+                             SYSCFG_NUM_EXTICR),
+        VMSTATE_UINT32(syscfg_cmpcr, STM32F4xxSyscfgState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void stm32f4xx_syscfg_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = stm32f4xx_syscfg_reset;
+    dc->vmsd = &vmstate_stm32f4xx_syscfg;
+}
+
+static const TypeInfo stm32f4xx_syscfg_info = {
+    .name          = TYPE_STM32F4XX_SYSCFG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(STM32F4xxSyscfgState),
+    .instance_init = stm32f4xx_syscfg_init,
+    .class_init    = stm32f4xx_syscfg_class_init,
+};
+
+static void stm32f4xx_syscfg_register_types(void)
+{
+    type_register_static(&stm32f4xx_syscfg_info);
+}
+
+type_init(stm32f4xx_syscfg_register_types)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 1deb1d08c1..02327562bc 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -84,6 +84,12 @@ mos6522_set_sr_int(void) "set sr_int"
 mos6522_write(uint64_t addr, uint64_t val) "reg=0x%"PRIx64 " val=0x%"PRIx64
 mos6522_read(uint64_t addr, unsigned val) "reg=0x%"PRIx64 " val=0x%x"
 
+# stm32f4xx_syscfg
+stm32f4xx_syscfg_set_irq(int gpio, int line, int level) "Interupt: GPIO: %d, Line: %d; Level: %d"
+stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
+stm32f4xx_syscfg_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
+stm32f4xx_syscfg_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
+
 # tz-mpc.c
 tz_mpc_reg_read(uint32_t offset, uint64_t data, unsigned size) "TZ MPC regs read: offset 0x%x data 0x%" PRIx64 " size %u"
 tz_mpc_reg_write(uint32_t offset, uint64_t data, unsigned size) "TZ MPC regs write: offset 0x%x data 0x%" PRIx64 " size %u"
diff --git a/include/hw/misc/stm32f4xx_syscfg.h b/include/hw/misc/stm32f4xx_syscfg.h
new file mode 100644
index 0000000000..c62c6629e5
--- /dev/null
+++ b/include/hw/misc/stm32f4xx_syscfg.h
@@ -0,0 +1,61 @@
+/*
+ * STM32F4xx SYSCFG
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
+#ifndef HW_STM_SYSCFG_H
+#define HW_STM_SYSCFG_H
+
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+
+#define SYSCFG_MEMRMP  0x00
+#define SYSCFG_PMC     0x04
+#define SYSCFG_EXTICR1 0x08
+#define SYSCFG_EXTICR2 0x0C
+#define SYSCFG_EXTICR3 0x10
+#define SYSCFG_EXTICR4 0x14
+#define SYSCFG_CMPCR   0x20
+
+#define TYPE_STM32F4XX_SYSCFG "stm32f4xx-syscfg"
+#define STM32F4XX_SYSCFG(obj) \
+    OBJECT_CHECK(STM32F4xxSyscfgState, (obj), TYPE_STM32F4XX_SYSCFG)
+
+#define SYSCFG_NUM_EXTICR 4
+
+typedef struct {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion mmio;
+
+    uint32_t syscfg_memrmp;
+    uint32_t syscfg_pmc;
+    uint32_t syscfg_exticr[SYSCFG_NUM_EXTICR];
+    uint32_t syscfg_cmpcr;
+
+    qemu_irq irq;
+    qemu_irq gpio_out[16];
+} STM32F4xxSyscfgState;
+
+#endif
-- 
2.24.0


