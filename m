Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FA8C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF64206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAXJKlWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF64206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHWfc-00021e-6M
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 13:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iHWTH-0006k5-Sj
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iHWTF-0004ut-Rm
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:06:55 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iHWTF-0004uZ-KI; Mon, 07 Oct 2019 13:06:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id 3so262871wmi.3;
 Mon, 07 Oct 2019 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e1Snfw54qByhFem85dbkNaD4L+dqPgwwgdg4e/O7Ibc=;
 b=NAXJKlWYcUB/LUYRANjRSqPjRaIn6iB91jdJl5Xn029Mzo9UqXjpN0UKY+bqOPoL17
 mDU71Jz2bhdQZMdprLFbZ4HU9AXSxf34KnPkmo9ifbRwN0jBp/wTrg55/RtSOHvXHj4N
 FTLJ+LEdwecQzWl8L1geTErpY5hi6a5l2GENUOm6mJJYhxGpnNtL5u4RGoSQo7YXo36N
 E/NJhKcKyZAElzb3Uq1E/KGJhtnLg3OEGIV2O58/TFZDxcJidujtXQtbGlXdOVXGuprB
 U4+HeBQPO1t7VU+c62OPlJRr/uwKWs4zG+UmjEHTfMTyf3iiHnzX31/XdDHmtLazaRE9
 7adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=e1Snfw54qByhFem85dbkNaD4L+dqPgwwgdg4e/O7Ibc=;
 b=UD5kklZB/+YIfSq+rBvGatWOhf36YHp52PLR+wwJQq2T00NA5f+00ik/qtE9l41Oh0
 rWVno911dSDIrX+M8kzOrZK3HQa+eLECI4HAQdw1P9WSs6X/O4AzXWLs0wNTZ1olUkQf
 9Sw/h+tfI08cHnj20vw5ObbBBo/0CUBoBcaJXPa9qGpoMXd1HbFHDdezt0zKPk8Kbkv1
 gRiaQoOYMDqdkYBx4i8vZaPnJn7ZsBPZLfmPmdOVxUB2PLaq0HUZNrTX8rjPsWIYKK5v
 BsX7CJyeZZj/y/SiNih5qcUYGwfP6b+IRXU90myv90nUaNU24jFtwOkIFIzFPPUUQJ8l
 n9Bw==
X-Gm-Message-State: APjAAAWDqq3HbxIj739N2vxEIcFWn1nOYmXIRZr73ZTBvoy29vWXU+4i
 11EchpzJWyb5zDiAkovuOJfgknojCmM=
X-Google-Smtp-Source: APXvYqyBu9Iat3kMycK9D9B9YrRS+adpZ1OjfNu7j1QNJ5nvfADvKaTt+XP9CyqowNp6Sx15TKPIug==
X-Received: by 2002:a1c:1b0b:: with SMTP id b11mr249281wmb.82.1570468012040;
 Mon, 07 Oct 2019 10:06:52 -0700 (PDT)
Received: from x1w.redhat.com (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id x5sm14036603wrt.75.2019.10.07.10.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 10:06:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/char: Add the BCM2835 miniuart
Date: Mon,  7 Oct 2019 19:06:44 +0200
Message-Id: <20191007170646.14961-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191007170646.14961-1-f4bug@amsat.org>
References: <20191007170646.14961-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The miniuart code is already present in the multi-device
hw/char/bcm2835_aux.c. Simply extracting it does not generate
patch easy to review. Instead, add it again, rename the function
names accordingly, use the "hw/registerfields.h" API.
This is roughtly a copy of commit 97398d900caacc.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/Makefile.objs              |   1 +
 hw/char/bcm2835_miniuart.c         | 327 +++++++++++++++++++++++++++++
 hw/char/trace-events               |   4 +
 include/hw/char/bcm2835_miniuart.h |  37 ++++
 4 files changed, 369 insertions(+)
 create mode 100644 hw/char/bcm2835_miniuart.c
 create mode 100644 include/hw/char/bcm2835_miniuart.h

diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index 02d8a66925..5bd93bde9f 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -22,6 +22,7 @@ obj-$(CONFIG_DIGIC) += digic-uart.o
 obj-$(CONFIG_STM32F2XX_USART) += stm32f2xx_usart.o
 obj-$(CONFIG_RASPI) += bcm2835_aux.o
 
+common-obj-$(CONFIG_RASPI) += bcm2835_miniuart.o
 common-obj-$(CONFIG_CMSDK_APB_UART) += cmsdk-apb-uart.o
 common-obj-$(CONFIG_ETRAXFS) += etraxfs_ser.o
 common-obj-$(CONFIG_ISA_DEBUG) += debugcon.o
diff --git a/hw/char/bcm2835_miniuart.c b/hw/char/bcm2835_miniuart.c
new file mode 100644
index 0000000000..0e99cecce7
--- /dev/null
+++ b/hw/char/bcm2835_miniuart.c
@@ -0,0 +1,327 @@
+/*
+ * BCM2835 (Raspberry Pi) mini UART block.
+ *
+ * Copyright (c) 2015, Microsoft
+ * Written by Andrew Baumann
+ * Based on pl011.c.
+ *
+ * This code is licensed under the GPL.
+ *
+ * At present only the core UART functions (data path for tx/rx) are
+ * implemented. The following features/registers are unimplemented:
+ *  - Line/modem control
+ *  - Scratch register
+ *  - Extra control
+ *  - Baudrate
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/char/bcm2835_miniuart.h"
+#include "hw/qdev-properties.h"
+#include "hw/registerfields.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+REG32(MU_IO,        0x00)
+REG32(MU_IER,       0x04)
+REG32(MU_IIR,       0x08)
+REG32(MU_LCR,       0x0c)
+REG32(MU_MCR,       0x10)
+REG32(MU_LSR,       0x14)
+REG32(MU_MSR,       0x18)
+REG32(MU_SCRATCH,   0x1c)
+REG32(MU_CNTL,      0x20)
+REG32(MU_STAT,      0x24)
+REG32(MU_BAUD,      0x28)
+
+/* bits in IER/IIR registers */
+#define RX_INT  0x1
+#define TX_INT  0x2
+
+static void bcm2835_miniuart_update(BCM2835MiniUartState *s)
+{
+    /*
+     * Signal an interrupt if either:
+     *
+     * 1. rx interrupt is enabled and we have a non-empty rx fifo, or
+     * 2. the tx interrupt is enabled (since we instantly drain the tx fifo)
+     */
+    s->iir = 0;
+    if ((s->ier & RX_INT) && s->read_count != 0) {
+        s->iir |= RX_INT;
+    }
+    if (s->ier & TX_INT) {
+        s->iir |= TX_INT;
+    }
+    qemu_set_irq(s->irq, s->iir != 0);
+}
+
+static bool is_16650(hwaddr offset)
+{
+    return offset < A_MU_CNTL;
+}
+
+static uint64_t bcm2835_miniuart_read(void *opaque, hwaddr offset,
+                                      unsigned size)
+{
+    BCM2835MiniUartState *s = opaque;
+    uint32_t c, res = 0;
+
+    switch (offset) {
+    case A_MU_IO:
+        /* "DLAB bit set means access baudrate register" is NYI */
+        c = s->read_fifo[s->read_pos];
+        if (s->read_count > 0) {
+            s->read_count--;
+            if (++s->read_pos == BCM2835_MINIUART_RX_FIFO_LEN) {
+                s->read_pos = 0;
+            }
+        }
+        qemu_chr_fe_accept_input(&s->chr);
+        bcm2835_miniuart_update(s);
+        res = c;
+        break;
+
+    case A_MU_IER:
+        /* "DLAB bit set means access baudrate register" is NYI */
+        res = 0xc0 | s->ier; /* FIFO enables always read 1 */
+        break;
+
+    case A_MU_IIR:
+        res = 0xc0; /* FIFO enables */
+        /*
+         * The spec is unclear on what happens when both tx and rx
+         * interrupts are active, besides that this cannot occur. At
+         * present, we choose to prioritise the rx interrupt, since
+         * the tx fifo is always empty.
+         */
+        if (s->read_count != 0) {
+            res |= 0x4;
+        } else {
+            res |= 0x2;
+        }
+        if (s->iir == 0) {
+            res |= 0x1;
+        }
+        break;
+
+    case A_MU_LCR:
+        qemu_log_mask(LOG_UNIMP, "%s: A_MU_LCR_REG unsupported\n", __func__);
+        break;
+
+    case A_MU_MCR:
+        qemu_log_mask(LOG_UNIMP, "%s: A_MU_MCR_REG unsupported\n", __func__);
+        break;
+
+    case A_MU_LSR:
+        res = 0x60; /* tx idle, empty */
+        if (s->read_count != 0) {
+            res |= 0x1;
+        }
+        break;
+
+    case A_MU_MSR:
+        qemu_log_mask(LOG_UNIMP, "%s: A_MU_MSR_REG unsupported\n", __func__);
+        break;
+
+    case A_MU_SCRATCH:
+        qemu_log_mask(LOG_UNIMP, "%s: A_MU_SCRATCH unsupported\n", __func__);
+        break;
+
+    case A_MU_CNTL:
+        res = 0x3; /* tx, rx enabled */
+        break;
+
+    case A_MU_STAT:
+        res = 0x30e; /* space in the output buffer, empty tx fifo, idle tx/rx */
+        if (s->read_count > 0) {
+            res |= 0x1; /* data in input buffer */
+            assert(s->read_count < BCM2835_MINIUART_RX_FIFO_LEN);
+            res |= ((uint32_t)s->read_count) << 16; /* rx fifo fill level */
+        }
+        break;
+
+    case A_MU_BAUD:
+        qemu_log_mask(LOG_UNIMP, "%s: A_MU_BAUD_REG unsupported\n", __func__);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
+                      __func__, offset);
+        break;
+    }
+
+    if (is_16650(offset)) {
+        trace_serial_ioport_read((offset & 0x1f) >> 2, res);
+    } else {
+        trace_bcm2835_miniuart_read(offset, res);
+    }
+
+    return res;
+}
+
+static void bcm2835_miniuart_write(void *opaque, hwaddr offset, uint64_t value,
+                                   unsigned size)
+{
+    BCM2835MiniUartState *s = opaque;
+    unsigned char ch;
+
+    if (is_16650(offset)) {
+        trace_serial_ioport_write((offset & 0x1f) >> 2, value);
+    } else {
+        trace_bcm2835_miniuart_write(offset, value);
+    }
+
+    switch (offset) {
+    case A_MU_IO:
+        /* "DLAB bit set means access baudrate register" is NYI */
+        ch = value;
+        /*
+         * XXX this blocks entire thread. Rewrite to use
+         * qemu_chr_fe_write and background I/O callbacks
+         */
+        qemu_chr_fe_write_all(&s->chr, &ch, 1);
+        break;
+
+    case A_MU_IER:
+        /* "DLAB bit set means access baudrate register" is NYI */
+        s->ier = value & (TX_INT | RX_INT);
+        bcm2835_miniuart_update(s);
+        break;
+
+    case A_MU_IIR:
+        if (value & 0x2) {
+            s->read_count = 0;
+        }
+        break;
+
+    case A_MU_LCR:
+        qemu_log_mask(LOG_UNIMP, "%s: A_MU_LCR_REG unsupported\n", __func__);
+        break;
+
+    case A_MU_MCR:
+        qemu_log_mask(LOG_UNIMP, "%s: A_MU_MCR_REG unsupported\n", __func__);
+        break;
+
+    case A_MU_SCRATCH:
+        qemu_log_mask(LOG_UNIMP, "%s: A_MU_SCRATCH unsupported\n", __func__);
+        break;
+
+    case A_MU_CNTL:
+        qemu_log_mask(LOG_UNIMP, "%s: A_MU_CNTL_REG unsupported\n", __func__);
+        break;
+
+    case A_MU_BAUD:
+        qemu_log_mask(LOG_UNIMP, "%s: A_MU_BAUD_REG unsupported\n", __func__);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
+                      __func__, offset);
+    }
+
+    bcm2835_miniuart_update(s);
+}
+
+static int bcm2835_miniuart_can_receive(void *opaque)
+{
+    BCM2835MiniUartState *s = opaque;
+
+    return s->read_count < BCM2835_MINIUART_RX_FIFO_LEN;
+}
+
+static void bcm2835_miniuart_put_fifo(void *opaque, uint8_t value)
+{
+    BCM2835MiniUartState *s = opaque;
+    int slot;
+
+    slot = s->read_pos + s->read_count;
+    if (slot >= BCM2835_MINIUART_RX_FIFO_LEN) {
+        slot -= BCM2835_MINIUART_RX_FIFO_LEN;
+    }
+    s->read_fifo[slot] = value;
+    s->read_count++;
+    if (s->read_count == BCM2835_MINIUART_RX_FIFO_LEN) {
+        /* buffer full */
+    }
+    bcm2835_miniuart_update(s);
+}
+
+static void bcm2835_miniuart_receive(void *opaque, const uint8_t *buf, int size)
+{
+    bcm2835_miniuart_put_fifo(opaque, *buf);
+}
+
+static const MemoryRegionOps bcm2835_miniuart_ops = {
+    .read = bcm2835_miniuart_read,
+    .write = bcm2835_miniuart_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static const VMStateDescription vmstate_bcm2835_aux = {
+    .name = TYPE_BCM2835_MINIUART,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(read_fifo, BCM2835MiniUartState,
+                            BCM2835_MINIUART_RX_FIFO_LEN),
+        VMSTATE_UINT8(read_pos, BCM2835MiniUartState),
+        VMSTATE_UINT8(read_count, BCM2835MiniUartState),
+        VMSTATE_UINT8(ier, BCM2835MiniUartState),
+        VMSTATE_UINT8(iir, BCM2835MiniUartState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm2835_miniuart_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    BCM2835MiniUartState *s = BCM2835_MINIUART(obj);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &bcm2835_miniuart_ops, s,
+                          TYPE_BCM2835_MINIUART, 0x40);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void bcm2835_miniuart_realize(DeviceState *dev, Error **errp)
+{
+    BCM2835MiniUartState *s = BCM2835_MINIUART(dev);
+
+    qemu_chr_fe_set_handlers(&s->chr, bcm2835_miniuart_can_receive,
+                             bcm2835_miniuart_receive, NULL, NULL,
+                             s, NULL, true);
+}
+
+static Property bcm2835_miniuart_props[] = {
+    DEFINE_PROP_CHR("chardev", BCM2835MiniUartState, chr),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void bcm2835_miniuart_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = bcm2835_miniuart_realize;
+    dc->vmsd = &vmstate_bcm2835_aux;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+    dc->props = bcm2835_miniuart_props;
+}
+
+static const TypeInfo bcm2835_miniuart_info = {
+    .name          = TYPE_BCM2835_MINIUART,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835MiniUartState),
+    .instance_init = bcm2835_miniuart_init,
+    .class_init    = bcm2835_miniuart_class_init,
+};
+
+static void bcm2835_miniuart_register_types(void)
+{
+    type_register_static(&bcm2835_miniuart_info);
+}
+
+type_init(bcm2835_miniuart_register_types)
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 2ce7f2f998..f1e6dd9918 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -1,5 +1,9 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# bcm2835_miniuart.c
+bcm2835_miniuart_read(uint64_t addr, uint32_t value) "read addr 0x%"PRIx64" value 0x%x"
+bcm2835_miniuart_write(uint64_t addr, uint32_t value) "read addr 0x%"PRIx64" value 0x%x"
+
 # parallel.c
 parallel_ioport_read(const char *desc, uint16_t addr, uint8_t value) "read [%s] addr 0x%02x val 0x%02x"
 parallel_ioport_write(const char *desc, uint16_t addr, uint8_t value) "write [%s] addr 0x%02x val 0x%02x"
diff --git a/include/hw/char/bcm2835_miniuart.h b/include/hw/char/bcm2835_miniuart.h
new file mode 100644
index 0000000000..54d3b622ed
--- /dev/null
+++ b/include/hw/char/bcm2835_miniuart.h
@@ -0,0 +1,37 @@
+/*
+ * BCM2835 (Raspberry Pi) mini UART block.
+ *
+ * Copyright (c) 2015, Microsoft
+ * Written by Andrew Baumann
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_CHAR_BCM2835_MINIUART_H
+#define HW_CHAR_BCM2835_MINIUART_H
+
+#include "chardev/char-fe.h"
+#include "hw/sysbus.h"
+#include "hw/irq.h"
+
+#define TYPE_BCM2835_MINIUART "bcm2835-miniuart"
+#define BCM2835_MINIUART(obj) \
+            OBJECT_CHECK(BCM2835MiniUartState, (obj), TYPE_BCM2835_MINIUART)
+
+#define BCM2835_MINIUART_RX_FIFO_LEN 8
+
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion iomem;
+    CharBackend chr;
+    qemu_irq irq;
+
+    uint8_t read_fifo[BCM2835_MINIUART_RX_FIFO_LEN];
+    uint8_t read_pos, read_count;
+    uint8_t ier, iir;
+} BCM2835MiniUartState;
+
+#endif
-- 
2.21.0


