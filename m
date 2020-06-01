Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDDCC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD12206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STS9Azod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD12206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfn8r-0001gd-HF
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 12:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5T-0005Hb-PO
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:14:55 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:33607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5S-0001Wd-3P
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:14:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id j198so324822wmj.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 09:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Li+ZxqOvBnHhwlFkNS7cHG2yKEmymfLFzHdiZWMqey8=;
 b=STS9AzodsE7qq473JsyXWHzjOdcIIeIGOnjmCqo+EXPsuegk6SKS4UxhAQ8IzhfxQo
 zJGiHjLioMTzbIjiS7OAs9+8d9o8NXp9zbD1/m7bevsRBUOVixaXzK2tHbkD6iR7zWBR
 BAjeAslVhW17ljYlC8mepCHmIQqQCMl+3/DVCxEVN21/zOlz7Xinn42XoquiQ0nzIRA+
 2fVI4YhKRMpi+f5xRznH6FrM60I8FWGQHFwrUF2fwPugK9hmWP1LtX4J0Zrk85qSP0V5
 dJj6tcuMmbcWMrFmZXaWotz8//DSVCiI6EiarQ9qZW85zgTGqOZas+32A4C2ZHw6wc07
 j/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Li+ZxqOvBnHhwlFkNS7cHG2yKEmymfLFzHdiZWMqey8=;
 b=cm03Joasf8liYqpohzRJZcBbraC1YdmNjTnr8+qrG/9DRovOtOZTlxs2+b17ArbZS5
 UFk9P2bbovd3gbGk9Y127dG6/iBHIPzH6hmc90QLrLSlL0lwsl1dIeSztjVquYbnHs4U
 AQdf7hMLm2h+uMRUfdxXVLuoptwm/kDM54WaGqxr2y/HbfU2EijllE2qvotUEUXDQosP
 AvFvNz56rTBswRZisBK2iU3zxEjEgaMwCsnuOvHOWz74Yb79YJDY8gOE9wZidtfqxLqj
 o09K5R5x45BB7+wh3V6pq/hsLtwat9gDwoC/mYqIRVZo6/wwiRhp6v0V/+r3RaPazugf
 2VNA==
X-Gm-Message-State: AOAM530USYpGuwwH57TRrtLquu3kDTTQ63MjqDuZ98/9OCm/FHEQ/Z3l
 9QUb93+Sn7miPM5r5o5vc6c=
X-Google-Smtp-Source: ABdhPJyZcrsF+SLaEzfxijqiROsrL1xJlA+B3QO2VRbxVEkTGDI5QPw/irNQpZvCteoI2HzNTRy9Kg==
X-Received: by 2002:a1c:a901:: with SMTP id s1mr117563wme.66.1591028092565;
 Mon, 01 Jun 2020 09:14:52 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a6sm21309896wrn.38.2020.06.01.09.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 09:14:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 06/12] hw/char: RX62N serial communication interface (SCI)
Date: Mon,  1 Jun 2020 18:14:35 +0200
Message-Id: <20200601161441.8086-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200601161441.8086-1-f4bug@amsat.org>
References: <20200601161441.8086-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32d.google.com
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

This module supported only non FIFO type.
Hardware manual.
https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033ej0140_rx62n.pdf

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200224141923.82118-17-ysato@users.sourceforge.jp>
[PMD: Filled VMStateField for migration]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/char/renesas_sci.h |  51 +++++
 hw/char/renesas_sci.c         | 350 ++++++++++++++++++++++++++++++++++
 hw/char/Kconfig               |   3 +
 hw/char/Makefile.objs         |   1 +
 4 files changed, 405 insertions(+)
 create mode 100644 include/hw/char/renesas_sci.h
 create mode 100644 hw/char/renesas_sci.c

diff --git a/include/hw/char/renesas_sci.h b/include/hw/char/renesas_sci.h
new file mode 100644
index 0000000000..efdebc620a
--- /dev/null
+++ b/include/hw/char/renesas_sci.h
@@ -0,0 +1,51 @@
+/*
+ * Renesas Serial Communication Interface
+ *
+ * Copyright (c) 2018 Yoshinori Sato
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_CHAR_RENESAS_SCI_H
+#define HW_CHAR_RENESAS_SCI_H
+
+#include "chardev/char-fe.h"
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
+    SCI_NR_IRQ = 4
+};
+
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion memory;
+    QEMUTimer timer;
+    CharBackend chr;
+    qemu_irq irq[SCI_NR_IRQ];
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
+    uint64_t input_freq;
+} RSCIState;
+
+#endif
diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c
new file mode 100644
index 0000000000..5d7c6e6523
--- /dev/null
+++ b/hw/char/renesas_sci.c
@@ -0,0 +1,350 @@
+/*
+ * Renesas Serial Communication Interface
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
+#include "hw/irq.h"
+#include "hw/registerfields.h"
+#include "hw/qdev-properties.h"
+#include "hw/char/renesas_sci.h"
+#include "migration/vmstate.h"
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
+  FIELD(SCR, CKE,  0, 2)
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
+  FIELD(SSR, ERR,  3, 3)
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
+    timer_mod(&sci->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + sci->trtime);
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
+static bool sci_is_tr_enabled(RSCIState *sci)
+{
+    return FIELD_EX8(sci->scr, SCR, TE) || FIELD_EX8(sci->scr, SCR, RE);
+}
+
+static void sci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+{
+    RSCIState *sci = RSCI(opaque);
+
+    switch (offset) {
+    case A_SMR:
+        if (!sci_is_tr_enabled(sci)) {
+            sci->smr = val;
+            update_trtime(sci);
+        }
+        break;
+    case A_BRR:
+        if (!sci_is_tr_enabled(sci)) {
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
+        qemu_log_mask(LOG_UNIMP, "renesas_sci: Register 0x%" HWADDR_PRIX " "
+                                 "not implemented\n",
+                      offset);
+    }
+}
+
+static uint64_t sci_read(void *opaque, hwaddr offset, unsigned size)
+{
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
+    .impl.max_access_size = 1,
+    .valid.max_access_size = 1,
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
+static void sci_event(void *opaque, QEMUChrEvent event)
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
+    timer_init_ns(&sci->timer, QEMU_CLOCK_VIRTUAL, txend, sci);
+}
+
+static const VMStateDescription vmstate_rsci = {
+    .name = "renesas-sci",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_INT64(trtime, RSCIState),
+        VMSTATE_INT64(rx_next, RSCIState),
+        VMSTATE_UINT8(smr, RSCIState),
+        VMSTATE_UINT8(brr, RSCIState),
+        VMSTATE_UINT8(scr, RSCIState),
+        VMSTATE_UINT8(tdr, RSCIState),
+        VMSTATE_UINT8(ssr, RSCIState),
+        VMSTATE_UINT8(rdr, RSCIState),
+        VMSTATE_UINT8(scmr, RSCIState),
+        VMSTATE_UINT8(semr, RSCIState),
+        VMSTATE_UINT8(read_ssr, RSCIState),
+        VMSTATE_TIMER(timer, RSCIState),
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
+    dc->vmsd = &vmstate_rsci;
+    dc->reset = rsci_reset;
+    device_class_set_props(dc, rsci_properties);
+}
+
+static const TypeInfo rsci_info = {
+    .name = TYPE_RENESAS_SCI,
+    .parent = TYPE_SYS_BUS_DEVICE,
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
index 40e7a8b8bb..874627520c 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -46,3 +46,6 @@ config SCLPCONSOLE
 
 config TERMINAL3270
     bool
+
+config RENESAS_SCI
+    bool
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index 9e9a6c1aff..996c170750 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -20,6 +20,7 @@ common-obj-$(CONFIG_SH4) += sh_serial.o
 common-obj-$(CONFIG_DIGIC) += digic-uart.o
 common-obj-$(CONFIG_STM32F2XX_USART) += stm32f2xx_usart.o
 common-obj-$(CONFIG_RASPI) += bcm2835_aux.o
+common-obj-$(CONFIG_RENESAS_SCI) += renesas_sci.o
 
 common-obj-$(CONFIG_CMSDK_APB_UART) += cmsdk-apb-uart.o
 common-obj-$(CONFIG_ETRAXFS) += etraxfs_ser.o
-- 
2.21.3


