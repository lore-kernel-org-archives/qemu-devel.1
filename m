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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82448C43603
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 18:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4490D205F4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 18:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh3Qgkh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4490D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie1jc-0004AU-Lh
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 13:56:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tn-0002Ef-B6
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Te-0003AQ-Kh
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:21 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43260)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ie1Tc-00036J-MW
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:16 -0500
Received: by mail-wr1-x442.google.com with SMTP id d16so13489188wre.10
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 10:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fiDJnfw8KuN71OMSUCFWBmBl80J4Xx3JLR0YGBv3k54=;
 b=dh3Qgkh5O/Z08xMTQC+e6wQCesq/EztPdsPUiMToA31SGU2JHsnosBclKVu/Y9OdvA
 /lZrzNJDt5wJccxhvyusMq1RNioasC3vIzC5VCNYBI7WIIQCsDhxDO7B626/v7AERpOt
 Xonis6eOOK2j0tOkRcKCJG+jKoJKnvTQYDBz+U5ZB6URmqTrO+gfo1EM6xPZgcEXdyb7
 NBgRilHh21r1D83rRDiFJeHirkkxJ1E9OBiSdOHTb8+Skben61TIxuS++usrRhqhONOZ
 HRcMGm9OUqvIrH/2xizzv/pmEC7QTjzC9AchC3ibjODytbQ2sp7kgi2rtbLy3De6IwNR
 INEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fiDJnfw8KuN71OMSUCFWBmBl80J4Xx3JLR0YGBv3k54=;
 b=UxBt1QFEdfRZnN7J6hQAauSg2k8UzhxxUBAi1fn6k5RDZdVCN7dy7Br7cLc/8JUuOy
 Di5TGFISq0oANwpp55JQY6oAeF3pORNyfzSm8cXNLPmVL2LhMObzaitAP7ZrVO/RjPdi
 tnyZ5qjftvc01Vl58u84jTGuz+wzNA/r7+NWDNG58SSya9ixpqbKW6CvU4k5wjil0LjJ
 F11gpDc4CwQnq8pl+t+IFVbhvKy6qsARf801BTAcpB7ThMwsDQ2pKL02S/nR9kJxQOJO
 t423CitB4Q/c6AHAI2BMMhuE04q1l0lXjRBX8vHp/v0XLy757aDBNwLO/CBGoYS9PGxp
 oWHg==
X-Gm-Message-State: APjAAAWRGcq947jTjnryZZ9V3Pf1LhEWoEZZXzmfJDvn/6PcY1vM0j9s
 yq0RTJfBSD59kKn7bf65v47mS+je0kWapdu6
X-Google-Smtp-Source: APXvYqzQOzHqm79zzBGUHVZrEgRdgEdk5VZnS7g5M5ubKQnc8hoVqyWdb1QuKSOagYMdYlg7P2t86A==
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr24305672wru.40.1575830415249; 
 Sun, 08 Dec 2019 10:40:15 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-180-52-3.red.bezeqint.net. [79.180.52.3])
 by smtp.gmail.com with ESMTPSA id h17sm25289717wrs.18.2019.12.08.10.40.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 08 Dec 2019 10:40:14 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v38 12/22] target/avr: Add limited support for USART peripheral
Date: Sun,  8 Dec 2019 20:39:12 +0200
Message-Id: <20191208183922.13757-13-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191208183922.13757-1-mrolnik@gmail.com>
References: <20191208183922.13757-1-mrolnik@gmail.com>
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
 me@xcancerberox.com.ar, richard.henderson@linaro.org,
 Sarah Harris <S.E.Harris@kent.ac.uk>, dovgaluk@ispras.ru, imammedo@redhat.com,
 philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These were designed to facilitate testing but should provide enough function to be useful in other contexts.
Only a subset of the functions of each peripheral is implemented, mainly due to the lack of a standard way to handle electrical connections (like GPIO pins).

Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
---
 include/hw/char/avr_usart.h |  93 +++++++++++
 hw/char/avr_usart.c         | 320 ++++++++++++++++++++++++++++++++++++
 hw/char/Kconfig             |   3 +
 hw/char/Makefile.objs       |   1 +
 4 files changed, 417 insertions(+)
 create mode 100644 include/hw/char/avr_usart.h
 create mode 100644 hw/char/avr_usart.c

diff --git a/include/hw/char/avr_usart.h b/include/hw/char/avr_usart.h
new file mode 100644
index 0000000000..467e97e8c0
--- /dev/null
+++ b/include/hw/char/avr_usart.h
@@ -0,0 +1,93 @@
+/*
+ * AVR USART
+ *
+ * Copyright (c) 2018 University of Kent
+ * Author: Sarah Harris
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#ifndef HW_AVR_USART_H
+#define HW_AVR_USART_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+#include "hw/hw.h"
+
+/* Offsets of registers. */
+#define USART_DR   0x06
+#define USART_CSRA  0x00
+#define USART_CSRB  0x01
+#define USART_CSRC  0x02
+#define USART_BRRH 0x05
+#define USART_BRRL 0x04
+
+/* Relevant bits in regiters. */
+#define USART_CSRA_RXC    (1 << 7)
+#define USART_CSRA_TXC    (1 << 6)
+#define USART_CSRA_DRE    (1 << 5)
+#define USART_CSRA_MPCM   (1 << 0)
+
+#define USART_CSRB_RXCIE  (1 << 7)
+#define USART_CSRB_TXCIE  (1 << 6)
+#define USART_CSRB_DREIE  (1 << 5)
+#define USART_CSRB_RXEN   (1 << 4)
+#define USART_CSRB_TXEN   (1 << 3)
+#define USART_CSRB_CSZ2   (1 << 2)
+#define USART_CSRB_RXB8   (1 << 1)
+#define USART_CSRB_TXB8   (1 << 0)
+
+#define USART_CSRC_MSEL1  (1 << 7)
+#define USART_CSRC_MSEL0  (1 << 6)
+#define USART_CSRC_PM1    (1 << 5)
+#define USART_CSRC_PM0    (1 << 4)
+#define USART_CSRC_CSZ1   (1 << 2)
+#define USART_CSRC_CSZ0   (1 << 1)
+
+#define TYPE_AVR_USART "avr-usart"
+#define AVR_USART(obj) \
+    OBJECT_CHECK(AVRUsartState, (obj), TYPE_AVR_USART)
+
+typedef struct {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion mmio;
+
+    CharBackend chr;
+
+    bool enabled;
+
+    uint8_t data;
+    bool data_valid;
+    uint8_t char_mask;
+    /* Control and Status Registers */
+    uint8_t csra;
+    uint8_t csrb;
+    uint8_t csrc;
+    /* Baud Rate Registers (low/high byte) */
+    uint8_t brrh;
+    uint8_t brrl;
+
+    /* Receive Complete */
+    qemu_irq rxc_irq;
+    /* Transmit Complete */
+    qemu_irq txc_irq;
+    /* Data Register Empty */
+    qemu_irq dre_irq;
+} AVRUsartState;
+
+#endif /* HW_AVR_USART_H */
diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
new file mode 100644
index 0000000000..cb307fe23d
--- /dev/null
+++ b/hw/char/avr_usart.c
@@ -0,0 +1,320 @@
+/*
+ * AVR USART
+ *
+ * Copyright (c) 2018 University of Kent
+ * Author: Sarah Harris
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#include "qemu/osdep.h"
+#include "hw/char/avr_usart.h"
+#include "qemu/log.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+
+static int avr_usart_can_receive(void *opaque)
+{
+    AVRUsartState *usart = opaque;
+
+    if (usart->data_valid || !(usart->csrb & USART_CSRB_RXEN)) {
+        return 0;
+    }
+    return 1;
+}
+
+static void avr_usart_receive(void *opaque, const uint8_t *buffer, int size)
+{
+    AVRUsartState *usart = opaque;
+    assert(size == 1);
+    assert(!usart->data_valid);
+    usart->data = buffer[0];
+    usart->data_valid = true;
+    usart->csra |= USART_CSRA_RXC;
+    if (usart->csrb & USART_CSRB_RXCIE) {
+        qemu_set_irq(usart->rxc_irq, 1);
+    }
+}
+
+static void update_char_mask(AVRUsartState *usart)
+{
+    uint8_t mode = ((usart->csrc & USART_CSRC_CSZ0) ? 1 : 0) |
+        ((usart->csrc & USART_CSRC_CSZ1) ? 2 : 0) |
+        ((usart->csrb & USART_CSRB_CSZ2) ? 4 : 0);
+    switch (mode) {
+    case 0:
+        usart->char_mask = 0b11111;
+        break;
+    case 1:
+        usart->char_mask = 0b111111;
+        break;
+    case 2:
+        usart->char_mask = 0b1111111;
+        break;
+    case 3:
+        usart->char_mask = 0b11111111;
+        break;
+    case 4:
+        /* Fallthrough. */
+    case 5:
+        /* Fallthrough. */
+    case 6:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: Reserved character size 0x%x\n",
+            __func__,
+            mode);
+        break;
+    case 7:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: Nine bit character size not supported (forcing eight)\n",
+            __func__);
+        usart->char_mask = 0b11111111;
+        break;
+    default:
+        assert(0);
+    }
+}
+
+static void avr_usart_reset(DeviceState *dev)
+{
+    AVRUsartState *usart = AVR_USART(dev);
+    usart->data_valid = false;
+    usart->csra = 0b00100000;
+    usart->csrb = 0b00000000;
+    usart->csrc = 0b00000110;
+    usart->brrl = 0;
+    usart->brrh = 0;
+    update_char_mask(usart);
+    qemu_set_irq(usart->rxc_irq, 0);
+    qemu_set_irq(usart->txc_irq, 0);
+    qemu_set_irq(usart->dre_irq, 0);
+}
+
+static uint64_t avr_usart_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    AVRUsartState *usart = opaque;
+    uint8_t data;
+    assert(size == 1);
+
+    if (!usart->enabled) {
+        return 0;
+    }
+
+    switch (addr) {
+    case USART_DR:
+        if (!(usart->csrb & USART_CSRB_RXEN)) {
+            /* Receiver disabled, ignore. */
+            return 0;
+        }
+        if (usart->data_valid) {
+            data = usart->data & usart->char_mask;
+            usart->data_valid = false;
+        } else {
+            data = 0;
+        }
+        usart->csra &= 0xff ^ USART_CSRA_RXC;
+        qemu_set_irq(usart->rxc_irq, 0);
+        qemu_chr_fe_accept_input(&usart->chr);
+        return data;
+    case USART_CSRA:
+        return usart->csra;
+    case USART_CSRB:
+        return usart->csrb;
+    case USART_CSRC:
+        return usart->csrc;
+    case USART_BRRL:
+        return usart->brrl;
+    case USART_BRRH:
+        return usart->brrh;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+            __func__,
+            addr);
+    }
+    return 0;
+}
+
+static void avr_usart_write(void *opaque, hwaddr addr, uint64_t value,
+                                unsigned int size)
+{
+    AVRUsartState *usart = opaque;
+    uint8_t mask;
+    uint8_t data;
+    assert((value & 0xff) == value);
+    assert(size == 1);
+
+    if (!usart->enabled) {
+        return;
+    }
+
+    switch (addr) {
+    case USART_DR:
+        if (!(usart->csrb & USART_CSRB_TXEN)) {
+            /* Transmitter disabled, ignore. */
+            return;
+        }
+        usart->csra |= USART_CSRA_TXC;
+        usart->csra |= USART_CSRA_DRE;
+        if (usart->csrb & USART_CSRB_TXCIE) {
+            qemu_set_irq(usart->txc_irq, 1);
+            usart->csra &= 0xff ^ USART_CSRA_TXC;
+        }
+        if (usart->csrb & USART_CSRB_DREIE) {
+            qemu_set_irq(usart->dre_irq, 1);
+        }
+        data = value;
+        qemu_chr_fe_write_all(&usart->chr, &data, 1);
+        break;
+    case USART_CSRA:
+        mask = 0b01000011;
+        /* Mask read-only bits. */
+        value = (value & mask) | (usart->csra & (0xff ^ mask));
+        usart->csra = value;
+        if (value & USART_CSRA_TXC) {
+            usart->csra ^= USART_CSRA_TXC;
+            qemu_set_irq(usart->txc_irq, 0);
+        }
+        if (value & USART_CSRA_MPCM) {
+            qemu_log_mask(
+                LOG_GUEST_ERROR,
+                "%s: MPCM not supported by USART\n",
+                __func__);
+        }
+        break;
+    case USART_CSRB:
+        mask = 0b11111101;
+        /* Mask read-only bits. */
+        value = (value & mask) | (usart->csrb & (0xff ^ mask));
+        usart->csrb = value;
+        if (!(value & USART_CSRB_RXEN)) {
+            /* Receiver disabled, flush input buffer. */
+            usart->data_valid = false;
+        }
+        qemu_set_irq(usart->rxc_irq,
+            ((value & USART_CSRB_RXCIE) &&
+            (usart->csra & USART_CSRA_RXC)) ? 1 : 0);
+        qemu_set_irq(usart->txc_irq,
+            ((value & USART_CSRB_TXCIE) &&
+            (usart->csra & USART_CSRA_TXC)) ? 1 : 0);
+        qemu_set_irq(usart->dre_irq,
+            ((value & USART_CSRB_DREIE) &&
+            (usart->csra & USART_CSRA_DRE)) ? 1 : 0);
+        update_char_mask(usart);
+        break;
+    case USART_CSRC:
+        usart->csrc = value;
+        if ((value & USART_CSRC_MSEL1) && (value & USART_CSRC_MSEL0)) {
+            qemu_log_mask(
+                LOG_GUEST_ERROR,
+                "%s: SPI mode not supported by USART\n",
+                __func__);
+        }
+        if ((value & USART_CSRC_MSEL1) && !(value & USART_CSRC_MSEL0)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad USART mode\n", __func__);
+        }
+        if (!(value & USART_CSRC_PM1) && (value & USART_CSRC_PM0)) {
+            qemu_log_mask(
+                LOG_GUEST_ERROR,
+                "%s: Bad USART parity mode\n",
+                __func__);
+        }
+        update_char_mask(usart);
+        break;
+    case USART_BRRL:
+        usart->brrl = value;
+        break;
+    case USART_BRRH:
+        usart->brrh = value & 0b00001111;
+        break;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: Bad offset 0x%"HWADDR_PRIx"\n",
+            __func__,
+            addr);
+    }
+}
+
+static const MemoryRegionOps avr_usart_ops = {
+    .read = avr_usart_read,
+    .write = avr_usart_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {.min_access_size = 1, .max_access_size = 1}
+};
+
+static Property avr_usart_properties[] = {
+    DEFINE_PROP_CHR("chardev", AVRUsartState, chr),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void avr_usart_pr(void *opaque, int irq, int level)
+{
+    AVRUsartState *s = AVR_USART(opaque);
+
+    s->enabled = !level;
+
+    if (!s->enabled) {
+        avr_usart_reset(DEVICE(s));
+    }
+}
+
+static void avr_usart_init(Object *obj)
+{
+    AVRUsartState *s = AVR_USART(obj);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rxc_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->dre_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->txc_irq);
+    memory_region_init_io(&s->mmio, obj, &avr_usart_ops, s, TYPE_AVR_USART, 8);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+    qdev_init_gpio_in(DEVICE(s), avr_usart_pr, 1);
+    s->enabled = true;
+}
+
+static void avr_usart_realize(DeviceState *dev, Error **errp)
+{
+    AVRUsartState *s = AVR_USART(dev);
+    qemu_chr_fe_set_handlers(&s->chr, avr_usart_can_receive,
+                             avr_usart_receive, NULL, NULL,
+                             s, NULL, true);
+    avr_usart_reset(dev);
+}
+
+static void avr_usart_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = avr_usart_reset;
+    dc->props = avr_usart_properties;
+    dc->realize = avr_usart_realize;
+}
+
+static const TypeInfo avr_usart_info = {
+    .name          = TYPE_AVR_USART,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AVRUsartState),
+    .instance_init = avr_usart_init,
+    .class_init    = avr_usart_class_init,
+};
+
+static void avr_usart_register_types(void)
+{
+    type_register_static(&avr_usart_info);
+}
+
+type_init(avr_usart_register_types)
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 40e7a8b8bb..331b20983f 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -46,3 +46,6 @@ config SCLPCONSOLE
 
 config TERMINAL3270
     bool
+
+config AVR_USART
+    bool
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index 02d8a66925..f05c1f5667 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -21,6 +21,7 @@ obj-$(CONFIG_PSERIES) += spapr_vty.o
 obj-$(CONFIG_DIGIC) += digic-uart.o
 obj-$(CONFIG_STM32F2XX_USART) += stm32f2xx_usart.o
 obj-$(CONFIG_RASPI) += bcm2835_aux.o
+common-obj-$(CONFIG_AVR_USART) += avr_usart.o
 
 common-obj-$(CONFIG_CMSDK_APB_UART) += cmsdk-apb-uart.o
 common-obj-$(CONFIG_ETRAXFS) += etraxfs_ser.o
-- 
2.17.2 (Apple Git-113)


