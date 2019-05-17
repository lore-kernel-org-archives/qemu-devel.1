Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05053C04E84
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 04:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60C920833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 04:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FiFoGROw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60C920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRUsP-0007hO-Sf
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 00:53:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRUqR-0006BB-Jm
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRUqP-0007h3-I3
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:47 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRUqP-0007gF-8p
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:45 -0400
Received: by mail-pg1-x542.google.com with SMTP id d30so2672846pgm.7
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 21:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Z0ZdLoMy0d/4TPYPawKcpAMNbM31FQPLybJs+GMojo4=;
	b=FiFoGROwarg5LTftRKgLaGU0OYhSpW7ZNC8aWctMVC6EvIrRgTls0SXJOB0ksJgUm4
	ukX3a0OieSeGt0ffjjWPsAI046Gjz06zNoAO8WZykRgiHeTv/8xXPpFkiwY2B/gbpOyk
	4RKedDB1Y8ZM4nGt0Ri+uQqYdQm8vyTxjaQFIcyFUm5Bc9TcsdSJRorCX06ea0wFkL1U
	guCkz9qubxL+E0dqPssoOvAJmOtbllWGmZ01nhk2yOKZzDUgoeeETz3WjtP4PCJjyhWh
	2SR7OgVZr1t3ZVyeolF7Uv5GZjIPEzdYoCdC1setHPAIUjU7ICoA12J4ciFZmgxPTQ9x
	zQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Z0ZdLoMy0d/4TPYPawKcpAMNbM31FQPLybJs+GMojo4=;
	b=mJ8reNXXOmouZDuIRtLfHUHlLblw+Qp8R1aPCptGaCuodyy4ZuoKSwxy2hLDZwbYxm
	V1KwjtgbGOhwoiHRnoGrHZLtOtaVw9Zpa1H3kxJL7IGPKWE0SnRiJ5hrx3FjikmD4/KI
	LwyHBMtVlm+TtswcRhwduGPqq1WfGZ0Js3IkWBOgKqGZlu3IuWbyE5Zyehu4FLKzUdDM
	BF5nXIbDQNN1sF4u9kJFEjBNhQemBjLdr+Jk3UcmdprT1PYfhDYWxdGR0rOzgE+skL3i
	XkheiCZFBiOPjApMaTdJ9oPE3VbEL7b57hWKP1lDLADpu2gQ5woji5p5ds0BNuT0AF0h
	Eb5Q==
X-Gm-Message-State: APjAAAVGcPFz+8BqubJX0Kx3LjVLqAx9Hq8Mrh+VQJH9u7ydS22EFb73
	pfTjYWW3R9O1sPgwpjGr4slcfc6BW7c=
X-Google-Smtp-Source: APXvYqyNjEBikeNEv7kPuNa9kord0VfKaHoGr7Qj6vXFm/DrcmyjubzJPg6PrUVwZaHxQJo27YUCCA==
X-Received: by 2002:a63:4045:: with SMTP id n66mr40215167pga.386.1558068704005;
	Thu, 16 May 2019 21:51:44 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	132sm7709625pga.79.2019.05.16.21.51.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 21:51:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 21:51:28 -0700
Message-Id: <20190517045136.3509-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517045136.3509-1-richard.henderson@linaro.org>
References: <20190517045136.3509-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v14 05/13] hw/intc: RX62N interrupt controller
 (ICUa)
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

This implementation supported only ICUa.
Hardware manual.
https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033ej0140_rx62n.pdf

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190516055244.95559-6-ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/intc/rx_icu.h |  56 ++++++
 hw/intc/rx_icu.c         | 376 +++++++++++++++++++++++++++++++++++++++
 hw/intc/Kconfig          |   3 +
 hw/intc/Makefile.objs    |   1 +
 4 files changed, 436 insertions(+)
 create mode 100644 include/hw/intc/rx_icu.h
 create mode 100644 hw/intc/rx_icu.c

diff --git a/include/hw/intc/rx_icu.h b/include/hw/intc/rx_icu.h
new file mode 100644
index 0000000000..aab88f2ea7
--- /dev/null
+++ b/include/hw/intc/rx_icu.h
@@ -0,0 +1,56 @@
+#ifndef RX_ICU_H
+#define RX_ICU_H
+
+#include "qemu-common.h"
+#include "hw/irq.h"
+
+enum TRG_MODE {
+    TRG_LEVEL = 0,
+    TRG_NEDGE = 1,	/* Falling */
+    TRG_PEDGE = 2,	/* Raising */
+    TRG_BEDGE = 3,	/* Both */
+};
+
+struct IRQSource {
+    enum TRG_MODE sense;
+    int level;
+};
+
+enum {
+    /* Software interrupt request */
+    SWI = 27,
+    NR_IRQS = 256,
+};
+
+struct RXICUState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion memory;
+    struct IRQSource src[NR_IRQS];
+    char *icutype;
+    uint32_t nr_irqs;
+    uint32_t *map;
+    uint32_t nr_sense;
+    uint32_t *init_sense;
+
+    uint8_t ir[NR_IRQS];
+    uint8_t dtcer[NR_IRQS];
+    uint8_t ier[NR_IRQS / 8];
+    uint8_t ipr[142];
+    uint8_t dmasr[4];
+    uint16_t fir;
+    uint8_t nmisr;
+    uint8_t nmier;
+    uint8_t nmiclr;
+    uint8_t nmicr;
+    int req_irq;
+    qemu_irq _irq;
+    qemu_irq _fir;
+    qemu_irq _swi;
+};
+typedef struct RXICUState RXICUState;
+
+#define TYPE_RXICU "rx-icu"
+#define RXICU(obj) OBJECT_CHECK(RXICUState, (obj), TYPE_RXICU)
+
+#endif /* RX_ICU_H */
diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
new file mode 100644
index 0000000000..cb28c7a8d2
--- /dev/null
+++ b/hw/intc/rx_icu.c
@@ -0,0 +1,376 @@
+/*
+ * RX Interrupt Control Unit
+ *
+ * Warning: Only ICUa is supported.
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
+#include "qemu-common.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/sysbus.h"
+#include "hw/registerfields.h"
+#include "hw/intc/rx_icu.h"
+#include "qemu/error-report.h"
+
+REG8(IR, 0)
+  FIELD(IR, IR,  0, 1)
+REG8(DTCER, 0x100)
+  FIELD(DTCER, DTCE,  0, 1)
+REG8(IER, 0x200)
+REG8(SWINTR, 0x2e0)
+  FIELD(SWINTR, SWINT, 0, 1)
+REG16(FIR, 0x2f0)
+  FIELD(FIR, FVCT, 0, 8)
+  FIELD(FIR, FIEN, 15, 1)
+REG8(IPR, 0x300)
+  FIELD(IPR, IPR, 0, 4)
+REG8(DMRSR, 0x400)
+REG8(IRQCR, 0x500)
+  FIELD(IRQCR, IRQMD, 2, 2)
+REG8(NMISR, 0x580)
+  FIELD(NMISR, NMIST, 0, 1)
+  FIELD(NMISR, LVDST, 1, 1)
+  FIELD(NMISR, OSTST, 2, 1)
+REG8(NMIER, 0x581)
+  FIELD(NMIER, NMIEN, 0, 1)
+  FIELD(NMIER, LVDEN, 1, 1)
+  FIELD(NMIER, OSTEN, 2, 1)
+REG8(NMICLR, 0x582)
+  FIELD(NMICLR, NMICLR, 0, 1)
+  FIELD(NMICLR, OSTCLR, 2, 1)
+REG8(NMICR, 0x583)
+  FIELD(NMICR, NMIMD, 3, 1)
+
+#define request(icu, n) (icu->ipr[icu->map[n]] << 8 | n)
+
+static void set_irq(RXICUState *icu, int n_IRQ, int req)
+{
+    if ((icu->fir & R_FIR_FIEN_MASK) &&
+        (icu->fir & R_FIR_FVCT_MASK) == n_IRQ) {
+        qemu_set_irq(icu->_fir, req);
+    } else {
+        qemu_set_irq(icu->_irq, req);
+    }
+}
+
+static void rxicu_request(RXICUState *icu, int n_IRQ)
+{
+    int enable;
+
+    enable = icu->ier[n_IRQ / 8] & (1 << (n_IRQ & 7));
+    if (n_IRQ > 0 && enable != 0 && atomic_read(&icu->req_irq) < 0) {
+        atomic_set(&icu->req_irq, n_IRQ);
+        set_irq(icu, n_IRQ, request(icu, n_IRQ));
+    }
+}
+
+static void rxicu_set_irq(void *opaque, int n_IRQ, int level)
+{
+    RXICUState *icu = opaque;
+    struct IRQSource *src;
+    int issue;
+
+    if (n_IRQ >= NR_IRQS) {
+        error_report("%s: IRQ %d out of range", __func__, n_IRQ);
+        return;
+    }
+
+    src = &icu->src[n_IRQ];
+
+    level = (level != 0);
+    switch (src->sense) {
+    case TRG_LEVEL:
+        /* level-sensitive irq */
+        issue = level;
+        src->level = level;
+        break;
+    case TRG_NEDGE:
+        issue = (level == 0 && src->level == 1);
+        src->level = level;
+        break;
+    case TRG_PEDGE:
+        issue = (level == 1 && src->level == 0);
+        src->level = level;
+        break;
+    case TRG_BEDGE:
+        issue = ((level ^ src->level) & 1);
+        src->level = level;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    if (issue == 0 && src->sense == TRG_LEVEL) {
+        icu->ir[n_IRQ] = 0;
+        if (atomic_read(&icu->req_irq) == n_IRQ) {
+            /* clear request */
+            set_irq(icu, n_IRQ, 0);
+            atomic_set(&icu->req_irq, -1);
+        }
+        return;
+    }
+    if (issue) {
+        icu->ir[n_IRQ] = 1;
+        rxicu_request(icu, n_IRQ);
+    }
+}
+
+static void rxicu_ack_irq(void *opaque, int no, int level)
+{
+    RXICUState *icu = opaque;
+    int i;
+    int n_IRQ;
+    int max_pri;
+
+    n_IRQ = atomic_read(&icu->req_irq);
+    if (n_IRQ < 0) {
+        return;
+    }
+    atomic_set(&icu->req_irq, -1);
+    if (icu->src[n_IRQ].sense != TRG_LEVEL) {
+        icu->ir[n_IRQ] = 0;
+    }
+
+    max_pri = 0;
+    n_IRQ = -1;
+    for (i = 0; i < NR_IRQS; i++) {
+        if (icu->ir[i]) {
+            if (max_pri < icu->ipr[icu->map[i]]) {
+                n_IRQ = i;
+                max_pri = icu->ipr[icu->map[i]];
+            }
+        }
+    }
+
+    if (n_IRQ >= 0) {
+        rxicu_request(icu, n_IRQ);
+    }
+}
+
+static uint64_t icu_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RXICUState *icu = opaque;
+    int reg = addr & 0xff;
+
+    if ((addr != A_FIR && size != 1) ||
+        (addr == A_FIR && size != 2)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "rx_icu: Invalid read size 0x%"
+                      HWADDR_PRIX "\n", addr);
+        return UINT64_MAX;
+    }
+    switch (addr) {
+    case A_IR ... A_IR + 0xff:
+        return icu->ir[reg] & R_IR_IR_MASK;
+    case A_DTCER ... A_DTCER + 0xff:
+        return icu->dtcer[reg] & R_DTCER_DTCE_MASK;
+    case A_IER ... A_IER + 0x1f:
+        return icu->ier[reg];
+    case A_SWINTR:
+        return 0;
+    case A_FIR:
+        return icu->fir & (R_FIR_FIEN_MASK | R_FIR_FVCT_MASK);
+    case A_IPR ... A_IPR + 0x8f:
+        return icu->ipr[reg] & R_IPR_IPR_MASK;
+    case A_DMRSR:
+    case A_DMRSR + 4:
+    case A_DMRSR + 8:
+    case A_DMRSR + 12:
+        return icu->dmasr[reg >> 2];
+    case A_IRQCR ... A_IRQCR + 0x1f:
+        return icu->src[64 + reg].sense << R_IRQCR_IRQMD_SHIFT;
+    case A_NMISR:
+    case A_NMICLR:
+        return 0;
+    case A_NMIER:
+        return icu->nmier;
+    case A_NMICR:
+        return icu->nmicr;
+    default:
+        qemu_log_mask(LOG_UNIMP, "rx_icu: Register 0x%" HWADDR_PRIX
+                      " not implemented.\n", addr);
+        break;
+    }
+    return UINT64_MAX;
+}
+
+static void icu_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    RXICUState *icu = opaque;
+    int reg = addr & 0xff;
+
+    if ((addr != A_FIR && size != 1) ||
+        (addr == A_FIR && size != 2)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "rx_icu: Invalid write size at 0x%"
+                      HWADDR_PRIX "\n", addr);
+        return;
+    }
+    switch (addr) {
+    case A_IR ... A_IR + 0xff:
+        if (icu->src[reg].sense != TRG_LEVEL && val == 0) {
+            icu->ir[reg] = 0;
+        }
+        break;
+    case A_DTCER ... A_DTCER + 0xff:
+        icu->dtcer[reg] = val & R_DTCER_DTCE_MASK;
+        qemu_log_mask(LOG_UNIMP,
+                      "rx_icu: DTC not implemented\n");
+        break;
+    case A_IER ... A_IER + 0x1f:
+        icu->ier[reg] = val;
+        break;
+    case A_SWINTR:
+        if (val & R_SWINTR_SWINT_MASK) {
+            qemu_irq_pulse(icu->_swi);
+        }
+        break;
+    case A_FIR:
+        icu->fir = val & (R_FIR_FIEN_MASK | R_FIR_FVCT_MASK);
+        break;
+    case A_IPR ... A_IPR + 0x8f:
+        icu->ipr[reg] = val & R_IPR_IPR_MASK;
+        break;
+    case A_DMRSR:
+    case A_DMRSR + 4:
+    case A_DMRSR + 8:
+    case A_DMRSR + 12:
+        icu->dmasr[reg >> 2] = val;
+        qemu_log_mask(LOG_UNIMP,
+                      "rx_icu: DMAC not implemented\n");
+        break;
+    case A_IRQCR ... A_IRQCR + 0x1f:
+        icu->src[64 + reg].sense = val >> R_IRQCR_IRQMD_SHIFT;
+        break;
+    case A_NMICLR:
+        break;
+    case A_NMIER:
+        icu->nmier |= val & (R_NMIER_NMIEN_MASK |
+                             R_NMIER_LVDEN_MASK |
+                             R_NMIER_OSTEN_MASK);
+            break;
+    case A_NMICR:
+        if ((icu->nmier & R_NMIER_NMIEN_MASK) == 0) {
+            icu->nmicr = val & R_NMICR_NMIMD_MASK;
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "rx_icu: Register 0x%" HWADDR_PRIX
+                      " not implemented\n", addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps icu_ops = {
+    .write = icu_write,
+    .read  = icu_read,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .max_access_size = 2,
+    },
+};
+
+static void rxicu_realize(DeviceState *dev, Error **errp)
+{
+    RXICUState *icu = RXICU(dev);
+    int i, j;
+
+    if (icu->init_sense == NULL) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "rx_icu: trigger-level property must be set.");
+        return;
+    }
+    for (i = j = 0; i < NR_IRQS; i++) {
+        if (icu->init_sense[j] == i) {
+            icu->src[i].sense = TRG_LEVEL;
+            if (j < icu->nr_sense) {
+                j++;
+            }
+        } else {
+            icu->src[i].sense = TRG_PEDGE;
+        }
+    }
+    icu->req_irq = -1;
+}
+
+static void rxicu_init(Object *obj)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    RXICUState *icu = RXICU(obj);
+
+    memory_region_init_io(&icu->memory, OBJECT(icu), &icu_ops,
+                          icu, "rx-icu", 0x600);
+    sysbus_init_mmio(d, &icu->memory);
+
+    qdev_init_gpio_in(DEVICE(d), rxicu_set_irq, NR_IRQS);
+    qdev_init_gpio_in_named(DEVICE(d), rxicu_ack_irq, "ack", 1);
+    sysbus_init_irq(d, &icu->_irq);
+    sysbus_init_irq(d, &icu->_fir);
+    sysbus_init_irq(d, &icu->_swi);
+}
+
+static void rxicu_fini(Object *obj)
+{
+    RXICUState *icu = RXICU(obj);
+    g_free(icu->map);
+    g_free(icu->init_sense);
+}
+
+static const VMStateDescription vmstate_rxicu = {
+    .name = "rx-icu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property rxicu_properties[] = {
+    DEFINE_PROP_ARRAY("ipr-map", RXICUState, nr_irqs, map,
+                      qdev_prop_uint32, uint32_t),
+    DEFINE_PROP_ARRAY("trigger-level", RXICUState, nr_sense, init_sense,
+                      qdev_prop_uint32, uint32_t),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rxicu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = rxicu_realize;
+    dc->props = rxicu_properties;
+    dc->vmsd = &vmstate_rxicu;
+}
+
+static const TypeInfo rxicu_info = {
+    .name       = TYPE_RXICU,
+    .parent     = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RXICUState),
+    .instance_init = rxicu_init,
+    .instance_finalize = rxicu_fini,
+    .class_init = rxicu_class_init,
+};
+
+static void rxicu_register_types(void)
+{
+    type_register_static(&rxicu_info);
+}
+
+type_init(rxicu_register_types)
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 5347f8412c..67e9d97464 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -58,3 +58,6 @@ config S390_FLIC_KVM
 
 config OMPIC
     bool
+
+config RX_ICU
+    bool
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index df712c3e6c..b54b09b12e 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -48,3 +48,4 @@ obj-$(CONFIG_ARM_GIC) += arm_gicv3_cpuif.o
 obj-$(CONFIG_MIPS_CPS) += mips_gic.o
 obj-$(CONFIG_NIOS2) += nios2_iic.o
 obj-$(CONFIG_OMPIC) += ompic.o
+obj-$(CONFIG_RX) += rx_icu.o
-- 
2.17.1


