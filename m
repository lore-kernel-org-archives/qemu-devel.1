Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A412C46470
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 04:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC1D2087B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 04:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdt6ects"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC1D2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42340 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRUxi-00048A-1b
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 00:59:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRUqU-0006Cr-5G
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRUqR-0007jt-TE
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:50 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRUqR-0007j1-Jn
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:47 -0400
Received: by mail-pf1-x442.google.com with SMTP id y11so3020676pfm.13
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 21:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=D1bmIYoHtE2W4uAmFH8G2hsXhvuTJSiTbbUhfJ+a7tE=;
	b=hdt6ectsEedC2jBQDW4uwFtl0xyL8qC9gYSSru5d8nwFW/C9ILG8hlemECo9zN//RE
	0jofg+qL8ZWjxihOCQ4a04QfJjtTI2197zrDzxL8Z6/igVxsfnhbuuS77KLY2jaB8BsN
	Suc9XsVZzSTO5EqDXn3eYnRxoxRjNeddmM0Kzf/wnH7BbvheMcPajD4Vm1pb+Jns6oSh
	+fiiSY04m5FdGWz6CgEuq6YingSBA0AjKb+xdUrj/YXuMnItP0ps6OKVzXlSH8ugxokm
	+nvSZsEbS+923+I39vT2BuCfd2oXsOC6B1UbKOsy20cJ/S1ntXz94mJG7xz67sfv5aLs
	m+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=D1bmIYoHtE2W4uAmFH8G2hsXhvuTJSiTbbUhfJ+a7tE=;
	b=Cop3TfFOvAU4HCKLxjlh4IC+m1PYRJVSEvxmmRh2FUVnDJAl9ELI/c7qLJnQfrj4r7
	Xe0YEPDgA5SIpuTX8yNjpiH8jfaIGd0hgRXg4Xws6/RzoF5vYcsw1vsXpBfsru1+KiJW
	maJYQHInV9pczIdCOojRuHFSDYUtVMrp5uqliljjYgX68s6ONgMGeLy0kI4W0d/CeBSK
	SdR2dQdAaadpWQiP8HiQJKUTsZ7P0PLGgziKKOiYKPmLLbSVNkn9y2xTEX8efL3R6GQz
	23oF5yFFrfePS6C48zAVuWxogCZ81gPqO/9YGq1EwX0c6vLEHu/STFpaxmoaxbw3wF7l
	p6mQ==
X-Gm-Message-State: APjAAAVh2NMa+eVBksJWIBMhOhJW4Retjnb/HnEdt1pwCNezG8AsxjLt
	+H7EOXLx4C267QVJ5HQqVQ3ru4FiO9o=
X-Google-Smtp-Source: APXvYqz08mHLtfpSrHmOTPloEK6xB+wWgABzl5eyFlH1NeNSpQY/AC6C4LWZm89YxA8PKu8S08nbtA==
X-Received: by 2002:aa7:8d89:: with SMTP id i9mr59471218pfr.77.1558068706226; 
	Thu, 16 May 2019 21:51:46 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	132sm7709625pga.79.2019.05.16.21.51.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 21:51:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 21:51:30 -0700
Message-Id: <20190517045136.3509-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517045136.3509-1-richard.henderson@linaro.org>
References: <20190517045136.3509-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v14 07/13] hw/char: RX62N serial communication
 interface (SCI)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: philmd@redhat.com, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

This module supported only non FIFO type.
Hardware manual.
https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033ej0140_rx62n.pdf

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190516055244.95559-8-ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/char/renesas_sci.h |  45 +++++
 hw/char/renesas_sci.c         | 340 ++++++++++++++++++++++++++++++++++
 hw/char/Kconfig               |   3 +
 hw/char/Makefile.objs         |   1 +
 4 files changed, 389 insertions(+)
 create mode 100644 include/hw/char/renesas_sci.h
 create mode 100644 hw/char/renesas_sci.c

diff --git a/include/hw/char/renesas_sci.h b/include/hw/char/renesas_sci.h
new file mode 100644
index 0000000000..50d1336944
--- /dev/null
+++ b/include/hw/char/renesas_sci.h
@@ -0,0 +1,45 @@
+/*
+ * Renesas Serial Communication Interface
+ *
+ * Copyright (c) 2018 Yoshinori Sato
+ *
+ * This code is licensed under the GPL version 2 or later.
+ *
+ */
+
+#include "chardev/char-fe.h"
+#include "qemu/timer.h"
+#include "hw/sysbus.h"
+
+#define TYPE_RENESAS_SCI "renesas-sci"
+#define RSCI(obj) OBJECT_CHECK(RSCIState, (obj), TYPE_RENESAS_SCI)
+
+enum {
+    ERI = 0,
+    RXI = 1,
+    TXI = 2,
+    TEI = 3,
+    SCI_NR_IRQ = 4,
+};
+
+typedef struct {
+    SysBusDevice parent_obj;
+    MemoryRegion memory;
+
+    uint8_t smr;
+    uint8_t brr;
+    uint8_t scr;
+    uint8_t tdr;
+    uint8_t ssr;
+    uint8_t rdr;
+    uint8_t scmr;
+    uint8_t semr;
+
+    uint8_t read_ssr;
+    int64_t trtime;
+    int64_t rx_next;
+    QEMUTimer *timer;
+    CharBackend chr;
+    uint64_t input_freq;
+    qemu_irq irq[SCI_NR_IRQ];
+} RSCIState;
diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c
new file mode 100644
index 0000000000..6298cbf43a
--- /dev/null
+++ b/hw/char/renesas_sci.c
@@ -0,0 +1,340 @@
+/*
+ * Renesas Serial Communication Interface
+ *
+ * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
+ * (Rev.1.40 R01UH0033EJ0140)
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/sysbus.h"
+#include "hw/registerfields.h"
+#include "hw/char/renesas_sci.h"
+#include "qemu/error-report.h"
+
+/* SCI register map */
+REG8(SMR, 0)
+  FIELD(SMR, CKS,  0, 2)
+  FIELD(SMR, MP,   2, 1)
+  FIELD(SMR, STOP, 3, 1)
+  FIELD(SMR, PM,   4, 1)
+  FIELD(SMR, PE,   5, 1)
+  FIELD(SMR, CHR,  6, 1)
+  FIELD(SMR, CM,   7, 1)
+REG8(BRR, 1)
+REG8(SCR, 2)
+  FIELD(SCR, CKE, 0, 2)
+  FIELD(SCR, TEIE, 2, 1)
+  FIELD(SCR, MPIE, 3, 1)
+  FIELD(SCR, RE,   4, 1)
+  FIELD(SCR, TE,   5, 1)
+  FIELD(SCR, RIE,  6, 1)
+  FIELD(SCR, TIE,  7, 1)
+REG8(TDR, 3)
+REG8(SSR, 4)
+  FIELD(SSR, MPBT, 0, 1)
+  FIELD(SSR, MPB,  1, 1)
+  FIELD(SSR, TEND, 2, 1)
+  FIELD(SSR, ERR, 3, 3)
+    FIELD(SSR, PER,  3, 1)
+    FIELD(SSR, FER,  4, 1)
+    FIELD(SSR, ORER, 5, 1)
+  FIELD(SSR, RDRF, 6, 1)
+  FIELD(SSR, TDRE, 7, 1)
+REG8(RDR, 5)
+REG8(SCMR, 6)
+  FIELD(SCMR, SMIF, 0, 1)
+  FIELD(SCMR, SINV, 2, 1)
+  FIELD(SCMR, SDIR, 3, 1)
+  FIELD(SCMR, BCP2, 7, 1)
+REG8(SEMR, 7)
+  FIELD(SEMR, ACS0, 0, 1)
+  FIELD(SEMR, ABCS, 4, 1)
+
+static int can_receive(void *opaque)
+{
+    RSCIState *sci = RSCI(opaque);
+    if (sci->rx_next > qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)) {
+        return 0;
+    } else {
+        return FIELD_EX8(sci->scr, SCR, RE);
+    }
+}
+
+static void receive(void *opaque, const uint8_t *buf, int size)
+{
+    RSCIState *sci = RSCI(opaque);
+    sci->rx_next = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + sci->trtime;
+    if (FIELD_EX8(sci->ssr, SSR, RDRF) || size > 1) {
+        sci->ssr = FIELD_DP8(sci->ssr, SSR, ORER, 1);
+        if (FIELD_EX8(sci->scr, SCR, RIE)) {
+            qemu_set_irq(sci->irq[ERI], 1);
+        }
+    } else {
+        sci->rdr = buf[0];
+        sci->ssr = FIELD_DP8(sci->ssr, SSR, RDRF, 1);
+        if (FIELD_EX8(sci->scr, SCR, RIE)) {
+            qemu_irq_pulse(sci->irq[RXI]);
+        }
+    }
+}
+
+static void send_byte(RSCIState *sci)
+{
+    if (qemu_chr_fe_backend_connected(&sci->chr)) {
+        qemu_chr_fe_write_all(&sci->chr, &sci->tdr, 1);
+    }
+    timer_mod(sci->timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + sci->trtime);
+    sci->ssr = FIELD_DP8(sci->ssr, SSR, TEND, 0);
+    sci->ssr = FIELD_DP8(sci->ssr, SSR, TDRE, 1);
+    qemu_set_irq(sci->irq[TEI], 0);
+    if (FIELD_EX8(sci->scr, SCR, TIE)) {
+        qemu_irq_pulse(sci->irq[TXI]);
+    }
+}
+
+static void txend(void *opaque)
+{
+    RSCIState *sci = RSCI(opaque);
+    if (!FIELD_EX8(sci->ssr, SSR, TDRE)) {
+        send_byte(sci);
+    } else {
+        sci->ssr = FIELD_DP8(sci->ssr, SSR, TEND, 1);
+        if (FIELD_EX8(sci->scr, SCR, TEIE)) {
+            qemu_set_irq(sci->irq[TEI], 1);
+        }
+    }
+}
+
+static void update_trtime(RSCIState *sci)
+{
+    /* char per bits */
+    sci->trtime = 8 - FIELD_EX8(sci->smr, SMR, CHR);
+    sci->trtime += FIELD_EX8(sci->smr, SMR, PE);
+    sci->trtime += FIELD_EX8(sci->smr, SMR, STOP) + 1;
+    /* x bit transmit time (32 * divrate * brr) / base freq */
+    sci->trtime *= 32 * sci->brr;
+    sci->trtime *= 1 << (2 * FIELD_EX8(sci->smr, SMR, CKS));
+    sci->trtime *= NANOSECONDS_PER_SECOND;
+    sci->trtime /= sci->input_freq;
+}
+
+#define IS_TR_ENABLED(scr) \
+    (FIELD_EX8(scr, SCR, TE) || FIELD_EX8(scr, SCR, RE))
+
+static void sci_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    hwaddr offset = addr & 0x07;
+    RSCIState *sci = RSCI(opaque);
+
+    switch (offset) {
+    case A_SMR:
+        if (!IS_TR_ENABLED(sci->scr)) {
+            sci->smr = val;
+            update_trtime(sci);
+        }
+        break;
+    case A_BRR:
+        if (!IS_TR_ENABLED(sci->scr)) {
+            sci->brr = val;
+            update_trtime(sci);
+        }
+        break;
+    case A_SCR:
+        sci->scr = val;
+        if (FIELD_EX8(sci->scr, SCR, TE)) {
+            sci->ssr = FIELD_DP8(sci->ssr, SSR, TDRE, 1);
+            sci->ssr = FIELD_DP8(sci->ssr, SSR, TEND, 1);
+            if (FIELD_EX8(sci->scr, SCR, TIE)) {
+                qemu_irq_pulse(sci->irq[TXI]);
+            }
+        }
+        if (!FIELD_EX8(sci->scr, SCR, TEIE)) {
+            qemu_set_irq(sci->irq[TEI], 0);
+        }
+        if (!FIELD_EX8(sci->scr, SCR, RIE)) {
+            qemu_set_irq(sci->irq[ERI], 0);
+        }
+        break;
+    case A_TDR:
+        sci->tdr = val;
+        if (FIELD_EX8(sci->ssr, SSR, TEND)) {
+            send_byte(sci);
+        } else {
+            sci->ssr = FIELD_DP8(sci->ssr, SSR, TDRE, 0);
+        }
+        break;
+    case A_SSR:
+        sci->ssr = FIELD_DP8(sci->ssr, SSR, MPBT,
+                             FIELD_EX8(val, SSR, MPBT));
+        sci->ssr = FIELD_DP8(sci->ssr, SSR, ERR,
+                             FIELD_EX8(val, SSR, ERR) & 0x07);
+        if (FIELD_EX8(sci->read_ssr, SSR, ERR) &&
+            FIELD_EX8(sci->ssr, SSR, ERR) == 0) {
+            qemu_set_irq(sci->irq[ERI], 0);
+        }
+        break;
+    case A_RDR:
+        qemu_log_mask(LOG_GUEST_ERROR, "reneas_sci: RDR is read only.\n");
+        break;
+    case A_SCMR:
+        sci->scmr = val; break;
+    case A_SEMR: /* SEMR */
+        sci->semr = val; break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_sci: Register 0x%" HWADDR_PRIX
+                      " not implemented\n", offset);
+    }
+}
+
+static uint64_t sci_read(void *opaque, hwaddr addr, unsigned size)
+{
+    hwaddr offset = addr & 0x07;
+    RSCIState *sci = RSCI(opaque);
+
+    switch (offset) {
+    case A_SMR:
+        return sci->smr;
+    case A_BRR:
+        return sci->brr;
+    case A_SCR:
+        return sci->scr;
+    case A_TDR:
+        return sci->tdr;
+    case A_SSR:
+        sci->read_ssr = sci->ssr;
+        return sci->ssr;
+    case A_RDR:
+        sci->ssr = FIELD_DP8(sci->ssr, SSR, RDRF, 0);
+        return sci->rdr;
+    case A_SCMR:
+        return sci->scmr;
+    case A_SEMR:
+        return sci->semr;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_sci: Register 0x%" HWADDR_PRIX
+                      " not implemented.\n", offset);
+    }
+    return UINT64_MAX;
+}
+
+static const MemoryRegionOps sci_ops = {
+    .write = sci_write,
+    .read  = sci_read,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .max_access_size = 1,
+    },
+};
+
+static void rsci_reset(DeviceState *dev)
+{
+    RSCIState *sci = RSCI(dev);
+    sci->smr = sci->scr = 0x00;
+    sci->brr = 0xff;
+    sci->tdr = 0xff;
+    sci->rdr = 0x00;
+    sci->ssr = 0x84;
+    sci->scmr = 0x00;
+    sci->semr = 0x00;
+    sci->rx_next = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+}
+
+static void sci_event(void *opaque, int event)
+{
+    RSCIState *sci = RSCI(opaque);
+    if (event == CHR_EVENT_BREAK) {
+        sci->ssr = FIELD_DP8(sci->ssr, SSR, FER, 1);
+        if (FIELD_EX8(sci->scr, SCR, RIE)) {
+            qemu_set_irq(sci->irq[ERI], 1);
+        }
+    }
+}
+
+static void rsci_realize(DeviceState *dev, Error **errp)
+{
+    RSCIState *sci = RSCI(dev);
+
+    if (sci->input_freq == 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas_sci: input-freq property must be set.");
+        return;
+    }
+    qemu_chr_fe_set_handlers(&sci->chr, can_receive, receive,
+                             sci_event, NULL, sci, NULL, true);
+}
+
+static void rsci_init(Object *obj)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    RSCIState *sci = RSCI(obj);
+    int i;
+
+    memory_region_init_io(&sci->memory, OBJECT(sci), &sci_ops,
+                          sci, "renesas-sci", 0x8);
+    sysbus_init_mmio(d, &sci->memory);
+
+    for (i = 0; i < SCI_NR_IRQ; i++) {
+        sysbus_init_irq(d, &sci->irq[i]);
+    }
+    sci->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, txend, sci);
+}
+
+static const VMStateDescription vmstate_rcmt = {
+    .name = "renesas-sci",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property rsci_properties[] = {
+    DEFINE_PROP_UINT64("input-freq", RSCIState, input_freq, 0),
+    DEFINE_PROP_CHR("chardev", RSCIState, chr),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rsci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = rsci_realize;
+    dc->props = rsci_properties;
+    dc->vmsd = &vmstate_rcmt;
+    dc->reset = rsci_reset;
+}
+
+static const TypeInfo rsci_info = {
+    .name       = TYPE_RENESAS_SCI,
+    .parent     = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RSCIState),
+    .instance_init = rsci_init,
+    .class_init = rsci_class_init,
+};
+
+static void rsci_register_types(void)
+{
+    type_register_static(&rsci_info);
+}
+
+type_init(rsci_register_types)
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 6360c9fffa..10c24ca87f 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -40,3 +40,6 @@ config SCLPCONSOLE
 
 config TERMINAL3270
     bool
+
+config RENESAS_SCI
+    bool
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index cf086e7114..f1b9bf0ecb 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -20,6 +20,7 @@ obj-$(CONFIG_PSERIES) += spapr_vty.o
 obj-$(CONFIG_DIGIC) += digic-uart.o
 obj-$(CONFIG_STM32F2XX_USART) += stm32f2xx_usart.o
 obj-$(CONFIG_RASPI) += bcm2835_aux.o
+obj-$(CONFIG_RENESAS_SCI) += renesas_sci.o
 
 common-obj-$(CONFIG_CMSDK_APB_UART) += cmsdk-apb-uart.o
 common-obj-$(CONFIG_ETRAXFS) += etraxfs_ser.o
-- 
2.17.1


