Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437C7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F35B42073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzOrdBJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35B42073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfn8u-0001mQ-5q
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 12:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5O-00055f-J5
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:14:50 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:33642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5N-0001Vn-5F
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:14:50 -0400
Received: by mail-wr1-x429.google.com with SMTP id l11so445553wru.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 09:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p2jgajganxLEDZOO6UpHmOY8HDjZV+a5//BhQvTt+ck=;
 b=VzOrdBJ9k+p+Mn195V997NXJTci0l8Tb+O0wLIdzbgPVjSooRoSmyHkkuF1D6/TYjl
 O4EHRj5Cj16Iqp0T9uvhGGiRBdk7hHVCobMUUiAGKdEkQlOXZ2N9ffsKAMM1NfHyuLjl
 Et4FLamP4IwJoA8uXEDhlzVohV0/yOB1ge1UoA+QQBOZcCqv5BBZUVabvpTORUWPdHGO
 2iJEaSzf0E51RgClVIfcSx6M/comRIXziGTXuQ60t8knikZ6QSQNyNfR/nshGjNDmPYX
 05hzz+k2aA7AOZO4jGLAiQwQgsuARNtpbuU94QT0AbU13joffTEmwF4fvzZiem2lQPE0
 7vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=p2jgajganxLEDZOO6UpHmOY8HDjZV+a5//BhQvTt+ck=;
 b=BdR60uZh6apkD2winyYPu1y38a5pKfhtcF3A1rUL09zUdNLjVDZsRSrjC38IkyPonq
 pDoTdLYQQuB32cyyPqBRXqfiUx7jRREmF54Tos6XjCXpepCCyMFxPZK0sOyxlgHsap/m
 LbGXSme/sht/xohxi4SYVr/6/eCyhR5Nx6HtiX9IxXX1NV+To/Wc1nKjWAMItw5OSlCR
 n6izEP3It0y6IdjynrBbchfJ0n/U0Hv3uMzWbIuEfPfwSwvPNK5kwZXbQKnDZRr8qSs7
 pRJ/SwTgVTEixTH/9tx4CJ+/RKADhZCXydUGlkGZln/nBCBEQk69bueucguqJNrZkHTq
 Ygtg==
X-Gm-Message-State: AOAM532UZ5XcBRID8znKtgakWgLphOlDy96yHBuLvtX8k+n4Fzj/k43j
 7t6z3Zv8fQybcF88aMgMv6Q=
X-Google-Smtp-Source: ABdhPJwvDwEyjLY06BGim3c+Cuj1u9p6olGNdQ58a2aNFlHs0kmPvrjIoXlBEUb6oYKcSqkR87OtlQ==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr22801868wrw.266.1591028087581; 
 Mon, 01 Jun 2020 09:14:47 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a6sm21309896wrn.38.2020.06.01.09.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 09:14:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 03/12] hw/intc: RX62N interrupt controller (ICUa)
Date: Mon,  1 Jun 2020 18:14:32 +0200
Message-Id: <20200601161441.8086-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200601161441.8086-1-f4bug@amsat.org>
References: <20200601161441.8086-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200224141923.82118-15-ysato@users.sourceforge.jp>
[PMD: Filled VMStateField for migration]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/intc/rx_icu.h |  76 ++++++++
 hw/intc/rx_icu.c         | 397 +++++++++++++++++++++++++++++++++++++++
 hw/intc/Kconfig          |   3 +
 hw/intc/Makefile.objs    |   1 +
 4 files changed, 477 insertions(+)
 create mode 100644 include/hw/intc/rx_icu.h
 create mode 100644 hw/intc/rx_icu.c

diff --git a/include/hw/intc/rx_icu.h b/include/hw/intc/rx_icu.h
new file mode 100644
index 0000000000..7176015cd9
--- /dev/null
+++ b/include/hw/intc/rx_icu.h
@@ -0,0 +1,76 @@
+/*
+ * RX Interrupt Control Unit
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
+#ifndef HW_INTC_RX_ICU_H
+#define HW_INTC_RX_ICU_H
+
+#include "hw/sysbus.h"
+
+enum TRG_MODE {
+    TRG_LEVEL = 0,
+    TRG_NEDGE = 1,      /* Falling */
+    TRG_PEDGE = 2,      /* Raising */
+    TRG_BEDGE = 3,      /* Both */
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
+    NR_IRQS = 256
+};
+
+struct RXICUState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion memory;
+    struct IRQSource src[NR_IRQS];
+    uint32_t nr_irqs;
+    uint8_t *map;
+    uint32_t nr_sense;
+    uint8_t *init_sense;
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
+    int16_t req_irq;
+    qemu_irq _irq;
+    qemu_irq _fir;
+    qemu_irq _swi;
+};
+typedef struct RXICUState RXICUState;
+
+#define TYPE_RX_ICU "rx-icu"
+#define RX_ICU(obj) OBJECT_CHECK(RXICUState, (obj), TYPE_RX_ICU)
+
+#endif /* RX_ICU_H */
diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
new file mode 100644
index 0000000000..df4b6a8d22
--- /dev/null
+++ b/hw/intc/rx_icu.c
@@ -0,0 +1,397 @@
+/*
+ * RX Interrupt Control Unit
+ *
+ * Warning: Only ICUa is supported.
+ *
+ * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
+ *            (Rev.1.40 R01UH0033EJ0140)
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
+#include "qemu/error-report.h"
+#include "hw/irq.h"
+#include "hw/registerfields.h"
+#include "hw/qdev-properties.h"
+#include "hw/intc/rx_icu.h"
+#include "migration/vmstate.h"
+
+REG8(IR, 0)
+  FIELD(IR, IR,  0, 1)
+REG8(DTCER, 0x100)
+  FIELD(DTCER, DTCE,  0, 1)
+REG8(IER, 0x200)
+REG8(SWINTR, 0x2e0)
+  FIELD(SWINTR, SWINT, 0, 1)
+REG16(FIR, 0x2f0)
+  FIELD(FIR, FVCT, 0,  8)
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
+static uint16_t rxicu_level(RXICUState *icu, unsigned n)
+{
+    return (icu->ipr[icu->map[n]] << 8) | n;
+}
+
+static void rxicu_request(RXICUState *icu, int n_IRQ)
+{
+    int enable;
+
+    enable = icu->ier[n_IRQ / 8] & (1 << (n_IRQ & 7));
+    if (n_IRQ > 0 && enable != 0 && atomic_read(&icu->req_irq) < 0) {
+        atomic_set(&icu->req_irq, n_IRQ);
+        set_irq(icu, n_IRQ, rxicu_level(icu, n_IRQ));
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
+                                       HWADDR_PRIX "\n",
+                      addr);
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
+        qemu_log_mask(LOG_UNIMP, "rx_icu: Register 0x%" HWADDR_PRIX " "
+                                 "not implemented.\n",
+                      addr);
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
+        qemu_log_mask(LOG_GUEST_ERROR, "rx_icu: Invalid write size at "
+                                       "0x%" HWADDR_PRIX "\n",
+                      addr);
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
+        qemu_log_mask(LOG_UNIMP, "rx_icu: DTC not implemented\n");
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
+        qemu_log_mask(LOG_UNIMP, "rx_icu: DMAC not implemented\n");
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
+        break;
+    case A_NMICR:
+        if ((icu->nmier & R_NMIER_NMIEN_MASK) == 0) {
+            icu->nmicr = val & R_NMICR_NMIMD_MASK;
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "rx_icu: Register 0x%" HWADDR_PRIX " "
+                                 "not implemented\n",
+                      addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps icu_ops = {
+    .write = icu_write,
+    .read  = icu_read,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 2,
+    },
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 2,
+    },
+};
+
+static void rxicu_realize(DeviceState *dev, Error **errp)
+{
+    RXICUState *icu = RX_ICU(dev);
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
+    RXICUState *icu = RX_ICU(obj);
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
+    RXICUState *icu = RX_ICU(obj);
+    g_free(icu->map);
+    g_free(icu->init_sense);
+}
+
+static const VMStateDescription vmstate_rxicu = {
+    .name = "rx-icu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(ir, RXICUState, NR_IRQS),
+        VMSTATE_UINT8_ARRAY(dtcer, RXICUState, NR_IRQS),
+        VMSTATE_UINT8_ARRAY(ier, RXICUState, NR_IRQS / 8),
+        VMSTATE_UINT8_ARRAY(ipr, RXICUState, 142),
+        VMSTATE_UINT8_ARRAY(dmasr, RXICUState, 4),
+        VMSTATE_UINT16(fir, RXICUState),
+        VMSTATE_UINT8(nmisr, RXICUState),
+        VMSTATE_UINT8(nmier, RXICUState),
+        VMSTATE_UINT8(nmiclr, RXICUState),
+        VMSTATE_UINT8(nmicr, RXICUState),
+        VMSTATE_INT16(req_irq, RXICUState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property rxicu_properties[] = {
+    DEFINE_PROP_ARRAY("ipr-map", RXICUState, nr_irqs, map,
+                      qdev_prop_uint8, uint8_t),
+    DEFINE_PROP_ARRAY("trigger-level", RXICUState, nr_sense, init_sense,
+                      qdev_prop_uint8, uint8_t),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rxicu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = rxicu_realize;
+    dc->vmsd = &vmstate_rxicu;
+    device_class_set_props(dc, rxicu_properties);
+}
+
+static const TypeInfo rxicu_info = {
+    .name = TYPE_RX_ICU,
+    .parent = TYPE_SYS_BUS_DEVICE,
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
index a189d6fedd..f562342bab 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -61,3 +61,6 @@ config S390_FLIC_KVM
 
 config OMPIC
     bool
+
+config RX_ICU
+    bool
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index f726d87532..98a0b0f3bc 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -20,6 +20,7 @@ common-obj-$(CONFIG_ARM_GIC) += arm_gicv3_dist.o
 common-obj-$(CONFIG_ARM_GIC) += arm_gicv3_redist.o
 common-obj-$(CONFIG_ARM_GIC) += arm_gicv3_its_common.o
 common-obj-$(CONFIG_OPENPIC) += openpic.o
+common-obj-$(CONFIG_RX_ICU) += rx_icu.o
 common-obj-y += intc.o
 
 obj-$(CONFIG_APIC) += apic.o apic_common.o
-- 
2.21.3


