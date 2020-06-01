Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D6AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F89206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAEcn3bS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F89206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfn8q-0001dC-91
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 12:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5Q-00059b-9y
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:14:52 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:38608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5O-0001W5-Sq
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:14:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id f185so90858wmf.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 09:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ErceqITnGhLCPYkCifzq710iEZfD+Gb1EMJUjvYvPyk=;
 b=UAEcn3bS8BDbr2dRRdDILGIMQavd9FiDzG9h7aMZNnYWtMzHEfcD2vKkM16q2JqhnK
 sztjGewD7iEw+zAPedHXak8euOAHscfcOMAHsH//J6nE+tBikRVHZmPMqLXVaO/YbC7X
 P16tqMfngPIk1Gl1xHgWuPX99t/r4NCXNI0cEiQ7XNGK1LjGHYXMFywAONSHAfEIvyqz
 Hc0COr+YCQxf3TKA+GfL2QEQYDacXWGCLoLmY1oVOwcPe5rG2131LuQogSZg00NhCpHn
 ROPh4FpnRN7t7ErzwPaas4c11iabqD6CZLPvlJRrOeVPRtGbBKV7Z0bNSeWBMkpm41yC
 DVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ErceqITnGhLCPYkCifzq710iEZfD+Gb1EMJUjvYvPyk=;
 b=KQbDz+G2VhHTOK6qgCgk1IgOm0F3eG8u0qLy9SDo6y/TKh8hiTbv7AEUTCf9GsH8LP
 8PYvY7/ajLCsm2WfRxIC2q+2zkxJamArhg6FWUTmXmhNUbMQU5VZH4zzmodO4Fnbzk0r
 KYHb5lU2kNJ0GJRaZDp5woN2s3YX1Uefaunc/rBfErhrZuaa/D1OiR6aVRJVgwjVsvSj
 guQvokerP5jDj/HFXKXsBFNWVOgRfKL3HPO/9cGhacrkHr1sMsB/cw4rWe1wltxZnS7N
 ACgWqudLAvnRvWvftN9hSET6EU106TcshPkMiTyZkydoZY0cvVJSU7DDiZmFZiOtHijO
 UVAw==
X-Gm-Message-State: AOAM531WDniGTBjOHX3L1Q2DfPS3uSx7GOiGSUA0Ky1NiFIjpBnVS1gc
 aY1vciKr7O/2zJ627wb8xNQ=
X-Google-Smtp-Source: ABdhPJxT2KfLyf1O+BdbNLNGQzvFhnfEmVdrHDW2EybFYWktiSNpjg9HXQrXbcePw4/HL4QiM/L52Q==
X-Received: by 2002:a1c:c908:: with SMTP id f8mr98912wmb.150.1591028089362;
 Mon, 01 Jun 2020 09:14:49 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a6sm21309896wrn.38.2020.06.01.09.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 09:14:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 04/12] hw/timer: RX62N 8-Bit timer (TMR)
Date: Mon,  1 Jun 2020 18:14:33 +0200
Message-Id: <20200601161441.8086-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200601161441.8086-1-f4bug@amsat.org>
References: <20200601161441.8086-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32a.google.com
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

renesas_tmr: 8bit timer modules.
This part use many renesas's CPU.
Hardware manual.
https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033ej0140_rx62n.pdf

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200224141923.82118-16-ysato@users.sourceforge.jp>
[PMD: Split from CMT, filled VMStateField for migration]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/timer/renesas_tmr.h |  55 ++++
 hw/timer/renesas_tmr.c         | 477 +++++++++++++++++++++++++++++++++
 hw/timer/Kconfig               |   3 +
 hw/timer/Makefile.objs         |   1 +
 4 files changed, 536 insertions(+)
 create mode 100644 include/hw/timer/renesas_tmr.h
 create mode 100644 hw/timer/renesas_tmr.c

diff --git a/include/hw/timer/renesas_tmr.h b/include/hw/timer/renesas_tmr.h
new file mode 100644
index 0000000000..cf3baa7a28
--- /dev/null
+++ b/include/hw/timer/renesas_tmr.h
@@ -0,0 +1,55 @@
+/*
+ * Renesas 8bit timer Object
+ *
+ * Copyright (c) 2018 Yoshinori Sato
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_TIMER_RENESAS_TMR_H
+#define HW_TIMER_RENESAS_TMR_H
+
+#include "qemu/timer.h"
+#include "hw/sysbus.h"
+
+#define TYPE_RENESAS_TMR "renesas-tmr"
+#define RTMR(obj) OBJECT_CHECK(RTMRState, (obj), TYPE_RENESAS_TMR)
+
+enum timer_event {
+    cmia = 0,
+    cmib = 1,
+    ovi = 2,
+    none = 3,
+    TMR_NR_EVENTS = 4
+};
+
+enum {
+    TMR_CH = 2,
+    TMR_NR_IRQ = 3 * TMR_CH
+};
+
+typedef struct RTMRState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    uint64_t input_freq;
+    MemoryRegion memory;
+
+    int64_t tick;
+    uint8_t tcnt[TMR_CH];
+    uint8_t tcora[TMR_CH];
+    uint8_t tcorb[TMR_CH];
+    uint8_t tcr[TMR_CH];
+    uint8_t tccr[TMR_CH];
+    uint8_t tcor[TMR_CH];
+    uint8_t tcsr[TMR_CH];
+    int64_t div_round[TMR_CH];
+    uint8_t next[TMR_CH];
+    qemu_irq cmia[TMR_CH];
+    qemu_irq cmib[TMR_CH];
+    qemu_irq ovi[TMR_CH];
+    QEMUTimer timer[TMR_CH];
+} RTMRState;
+
+#endif
diff --git a/hw/timer/renesas_tmr.c b/hw/timer/renesas_tmr.c
new file mode 100644
index 0000000000..446f2eacdd
--- /dev/null
+++ b/hw/timer/renesas_tmr.c
@@ -0,0 +1,477 @@
+/*
+ * Renesas 8bit timer
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
+#include "hw/timer/renesas_tmr.h"
+#include "migration/vmstate.h"
+
+REG8(TCR, 0)
+  FIELD(TCR, CCLR,  3, 2)
+  FIELD(TCR, OVIE,  5, 1)
+  FIELD(TCR, CMIEA, 6, 1)
+  FIELD(TCR, CMIEB, 7, 1)
+REG8(TCSR, 2)
+  FIELD(TCSR, OSA,  0, 2)
+  FIELD(TCSR, OSB,  2, 2)
+  FIELD(TCSR, ADTE, 4, 2)
+REG8(TCORA, 4)
+REG8(TCORB, 6)
+REG8(TCNT, 8)
+REG8(TCCR, 10)
+  FIELD(TCCR, CKS,   0, 3)
+  FIELD(TCCR, CSS,   3, 2)
+  FIELD(TCCR, TMRIS, 7, 1)
+
+#define INTERNAL  0x01
+#define CASCADING 0x03
+#define CCLR_A    0x01
+#define CCLR_B    0x02
+
+static const int clkdiv[] = {0, 1, 2, 8, 32, 64, 1024, 8192};
+
+static uint8_t concat_reg(uint8_t *reg)
+{
+    return (reg[0] << 8) | reg[1];
+}
+
+static void update_events(RTMRState *tmr, int ch)
+{
+    uint16_t diff[TMR_NR_EVENTS], min;
+    int64_t next_time;
+    int i, event;
+
+    if (tmr->tccr[ch] == 0) {
+        return ;
+    }
+    if (FIELD_EX8(tmr->tccr[ch], TCCR, CSS) == 0) {
+        /* external clock mode */
+        /* event not happened */
+        return ;
+    }
+    if (FIELD_EX8(tmr->tccr[0], TCCR, CSS) == CASCADING) {
+        /* cascading mode */
+        if (ch == 1) {
+            tmr->next[ch] = none;
+            return ;
+        }
+        diff[cmia] = concat_reg(tmr->tcora) - concat_reg(tmr->tcnt);
+        diff[cmib] = concat_reg(tmr->tcorb) - concat_reg(tmr->tcnt);
+        diff[ovi] = 0x10000 - concat_reg(tmr->tcnt);
+    } else {
+        /* separate mode */
+        diff[cmia] = tmr->tcora[ch] - tmr->tcnt[ch];
+        diff[cmib] = tmr->tcorb[ch] - tmr->tcnt[ch];
+        diff[ovi] = 0x100 - tmr->tcnt[ch];
+    }
+    /* Search for the most recently occurring event. */
+    for (event = 0, min = diff[0], i = 1; i < none; i++) {
+        if (min > diff[i]) {
+            event = i;
+            min = diff[i];
+        }
+    }
+    tmr->next[ch] = event;
+    next_time = diff[event];
+    next_time *= clkdiv[FIELD_EX8(tmr->tccr[ch], TCCR, CKS)];
+    next_time *= NANOSECONDS_PER_SECOND;
+    next_time /= tmr->input_freq;
+    next_time += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    timer_mod(&tmr->timer[ch], next_time);
+}
+
+static int elapsed_time(RTMRState *tmr, int ch, int64_t delta)
+{
+    int divrate = clkdiv[FIELD_EX8(tmr->tccr[ch], TCCR, CKS)];
+    int et;
+
+    tmr->div_round[ch] += delta;
+    if (divrate > 0) {
+        et = tmr->div_round[ch] / divrate;
+        tmr->div_round[ch] %= divrate;
+    } else {
+        /* disble clock. so no update */
+        et = 0;
+    }
+    return et;
+}
+
+static uint16_t read_tcnt(RTMRState *tmr, unsigned size, int ch)
+{
+    int64_t delta, now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    int elapsed, ovf = 0;
+    uint16_t tcnt[2];
+    uint32_t ret;
+
+    delta = (now - tmr->tick) * NANOSECONDS_PER_SECOND / tmr->input_freq;
+    if (delta > 0) {
+        tmr->tick = now;
+
+        if (FIELD_EX8(tmr->tccr[1], TCCR, CSS) == INTERNAL) {
+            /* timer1 count update */
+            elapsed = elapsed_time(tmr, 1, delta);
+            if (elapsed >= 0x100) {
+                ovf = elapsed >> 8;
+            }
+            tcnt[1] = tmr->tcnt[1] + (elapsed & 0xff);
+        }
+        switch (FIELD_EX8(tmr->tccr[0], TCCR, CSS)) {
+        case INTERNAL:
+            elapsed = elapsed_time(tmr, 0, delta);
+            tcnt[0] = tmr->tcnt[0] + elapsed;
+            break;
+        case CASCADING:
+            if (ovf > 0) {
+                tcnt[0] = tmr->tcnt[0] + ovf;
+            }
+            break;
+        }
+    } else {
+        tcnt[0] = tmr->tcnt[0];
+        tcnt[1] = tmr->tcnt[1];
+    }
+    if (size == 1) {
+        return tcnt[ch];
+    } else {
+        ret = 0;
+        ret = deposit32(ret, 0, 8, tcnt[1]);
+        ret = deposit32(ret, 8, 8, tcnt[0]);
+        return ret;
+    }
+}
+
+static uint8_t read_tccr(uint8_t r)
+{
+    uint8_t tccr = 0;
+    tccr = FIELD_DP8(tccr, TCCR, TMRIS,
+                     FIELD_EX8(r, TCCR, TMRIS));
+    tccr = FIELD_DP8(tccr, TCCR, CSS,
+                     FIELD_EX8(r, TCCR, CSS));
+    tccr = FIELD_DP8(tccr, TCCR, CKS,
+                     FIELD_EX8(r, TCCR, CKS));
+    return tccr;
+}
+
+static uint64_t tmr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RTMRState *tmr = opaque;
+    int ch = addr & 1;
+    uint64_t ret;
+
+    if (size == 2 && (ch != 0 || addr == A_TCR || addr == A_TCSR)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "renesas_tmr: Invalid read size 0x%"
+                                       HWADDR_PRIX "\n",
+                      addr);
+        return UINT64_MAX;
+    }
+    switch (addr & 0x0e) {
+    case A_TCR:
+        ret = 0;
+        ret = FIELD_DP8(ret, TCR, CCLR,
+                        FIELD_EX8(tmr->tcr[ch], TCR, CCLR));
+        ret = FIELD_DP8(ret, TCR, OVIE,
+                        FIELD_EX8(tmr->tcr[ch], TCR, OVIE));
+        ret = FIELD_DP8(ret, TCR, CMIEA,
+                        FIELD_EX8(tmr->tcr[ch], TCR, CMIEA));
+        ret = FIELD_DP8(ret, TCR, CMIEB,
+                        FIELD_EX8(tmr->tcr[ch], TCR, CMIEB));
+        return ret;
+    case A_TCSR:
+        ret = 0;
+        ret = FIELD_DP8(ret, TCSR, OSA,
+                        FIELD_EX8(tmr->tcsr[ch], TCSR, OSA));
+        ret = FIELD_DP8(ret, TCSR, OSB,
+                        FIELD_EX8(tmr->tcsr[ch], TCSR, OSB));
+        switch (ch) {
+        case 0:
+            ret = FIELD_DP8(ret, TCSR, ADTE,
+                            FIELD_EX8(tmr->tcsr[ch], TCSR, ADTE));
+            break;
+        case 1: /* CH1 ADTE unimplement always 1 */
+            ret = FIELD_DP8(ret, TCSR, ADTE, 1);
+            break;
+        }
+        return ret;
+    case A_TCORA:
+        if (size == 1) {
+            return tmr->tcora[ch];
+        } else if (ch == 0) {
+            return concat_reg(tmr->tcora);
+        }
+    case A_TCORB:
+        if (size == 1) {
+            return tmr->tcorb[ch];
+        } else {
+            return concat_reg(tmr->tcorb);
+        }
+    case A_TCNT:
+        return read_tcnt(tmr, size, ch);
+    case A_TCCR:
+        if (size == 1) {
+            return read_tccr(tmr->tccr[ch]);
+        } else {
+            return read_tccr(tmr->tccr[0]) << 8 | read_tccr(tmr->tccr[1]);
+        }
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_tmr: Register 0x%" HWADDR_PRIX
+                                 " not implemented\n",
+                      addr);
+        break;
+    }
+    return UINT64_MAX;
+}
+
+static void tmr_write_count(RTMRState *tmr, int ch, unsigned size,
+                            uint8_t *reg, uint64_t val)
+{
+    if (size == 1) {
+        reg[ch] = val;
+        update_events(tmr, ch);
+    } else {
+        reg[0] = extract32(val, 8, 8);
+        reg[1] = extract32(val, 0, 8);
+        update_events(tmr, 0);
+        update_events(tmr, 1);
+    }
+}
+
+static void tmr_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    RTMRState *tmr = opaque;
+    int ch = addr & 1;
+
+    if (size == 2 && (ch != 0 || addr == A_TCR || addr == A_TCSR)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas_tmr: Invalid write size 0x%" HWADDR_PRIX "\n",
+                      addr);
+        return;
+    }
+    switch (addr & 0x0e) {
+    case A_TCR:
+        tmr->tcr[ch] = val;
+        break;
+    case A_TCSR:
+        tmr->tcsr[ch] = val;
+        break;
+    case A_TCORA:
+        tmr_write_count(tmr, ch, size, tmr->tcora, val);
+        break;
+    case A_TCORB:
+        tmr_write_count(tmr, ch, size, tmr->tcorb, val);
+        break;
+    case A_TCNT:
+        tmr_write_count(tmr, ch, size, tmr->tcnt, val);
+        break;
+    case A_TCCR:
+        tmr_write_count(tmr, ch, size, tmr->tccr, val);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_tmr: Register 0x%" HWADDR_PRIX
+                                 " not implemented\n",
+                      addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps tmr_ops = {
+    .write = tmr_write,
+    .read  = tmr_read,
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
+static void timer_events(RTMRState *tmr, int ch);
+
+static uint16_t issue_event(RTMRState *tmr, int ch, int sz,
+                        uint16_t tcnt, uint16_t tcora, uint16_t tcorb)
+{
+    uint16_t ret = tcnt;
+
+    switch (tmr->next[ch]) {
+    case none:
+        break;
+    case cmia:
+        if (tcnt >= tcora) {
+            if (FIELD_EX8(tmr->tcr[ch], TCR, CCLR) == CCLR_A) {
+                ret = tcnt - tcora;
+            }
+            if (FIELD_EX8(tmr->tcr[ch], TCR, CMIEA)) {
+                qemu_irq_pulse(tmr->cmia[ch]);
+            }
+            if (sz == 8 && ch == 0 &&
+                FIELD_EX8(tmr->tccr[1], TCCR, CSS) == CASCADING) {
+                tmr->tcnt[1]++;
+                timer_events(tmr, 1);
+            }
+        }
+        break;
+    case cmib:
+        if (tcnt >= tcorb) {
+            if (FIELD_EX8(tmr->tcr[ch], TCR, CCLR) == CCLR_B) {
+                ret = tcnt - tcorb;
+            }
+            if (FIELD_EX8(tmr->tcr[ch], TCR, CMIEB)) {
+                qemu_irq_pulse(tmr->cmib[ch]);
+            }
+        }
+        break;
+    case ovi:
+        if ((tcnt >= (1 << sz)) && FIELD_EX8(tmr->tcr[ch], TCR, OVIE)) {
+            qemu_irq_pulse(tmr->ovi[ch]);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return ret;
+}
+
+static void timer_events(RTMRState *tmr, int ch)
+{
+    uint16_t tcnt;
+
+    tmr->tcnt[ch] = read_tcnt(tmr, 1, ch);
+    if (FIELD_EX8(tmr->tccr[0], TCCR, CSS) != CASCADING) {
+        tmr->tcnt[ch] = issue_event(tmr, ch, 8,
+                                    tmr->tcnt[ch],
+                                    tmr->tcora[ch],
+                                    tmr->tcorb[ch]) & 0xff;
+    } else {
+        if (ch == 1) {
+            return ;
+        }
+        tcnt = issue_event(tmr, ch, 16,
+                           concat_reg(tmr->tcnt),
+                           concat_reg(tmr->tcora),
+                           concat_reg(tmr->tcorb));
+        tmr->tcnt[0] = (tcnt >> 8) & 0xff;
+        tmr->tcnt[1] = tcnt & 0xff;
+    }
+    update_events(tmr, ch);
+}
+
+static void timer_event0(void *opaque)
+{
+    RTMRState *tmr = opaque;
+
+    timer_events(tmr, 0);
+}
+
+static void timer_event1(void *opaque)
+{
+    RTMRState *tmr = opaque;
+
+    timer_events(tmr, 1);
+}
+
+static void rtmr_reset(DeviceState *dev)
+{
+    RTMRState *tmr = RTMR(dev);
+    tmr->tcr[0]   = tmr->tcr[1]   = 0x00;
+    tmr->tcsr[0]  = 0x00;
+    tmr->tcsr[1]  = 0x10;
+    tmr->tcnt[0]  = tmr->tcnt[1]  = 0x00;
+    tmr->tcora[0] = tmr->tcora[1] = 0xff;
+    tmr->tcorb[0] = tmr->tcorb[1] = 0xff;
+    tmr->tccr[0]  = tmr->tccr[1]  = 0x00;
+    tmr->next[0]  = tmr->next[1]  = none;
+    tmr->tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+}
+
+static void rtmr_init(Object *obj)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    RTMRState *tmr = RTMR(obj);
+    int i;
+
+    memory_region_init_io(&tmr->memory, OBJECT(tmr), &tmr_ops,
+                          tmr, "renesas-tmr", 0x10);
+    sysbus_init_mmio(d, &tmr->memory);
+
+    for (i = 0; i < ARRAY_SIZE(tmr->ovi); i++) {
+        sysbus_init_irq(d, &tmr->cmia[i]);
+        sysbus_init_irq(d, &tmr->cmib[i]);
+        sysbus_init_irq(d, &tmr->ovi[i]);
+    }
+    timer_init_ns(&tmr->timer[0], QEMU_CLOCK_VIRTUAL, timer_event0, tmr);
+    timer_init_ns(&tmr->timer[1], QEMU_CLOCK_VIRTUAL, timer_event1, tmr);
+}
+
+static const VMStateDescription vmstate_rtmr = {
+    .name = "rx-tmr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_INT64(tick, RTMRState),
+        VMSTATE_UINT8_ARRAY(tcnt, RTMRState, TMR_CH),
+        VMSTATE_UINT8_ARRAY(tcora, RTMRState, TMR_CH),
+        VMSTATE_UINT8_ARRAY(tcorb, RTMRState, TMR_CH),
+        VMSTATE_UINT8_ARRAY(tcr, RTMRState, TMR_CH),
+        VMSTATE_UINT8_ARRAY(tccr, RTMRState, TMR_CH),
+        VMSTATE_UINT8_ARRAY(tcor, RTMRState, TMR_CH),
+        VMSTATE_UINT8_ARRAY(tcsr, RTMRState, TMR_CH),
+        VMSTATE_INT64_ARRAY(div_round, RTMRState, TMR_CH),
+        VMSTATE_UINT8_ARRAY(next, RTMRState, TMR_CH),
+        VMSTATE_TIMER_ARRAY(timer, RTMRState, TMR_CH),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property rtmr_properties[] = {
+    DEFINE_PROP_UINT64("input-freq", RTMRState, input_freq, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rtmr_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_rtmr;
+    dc->reset = rtmr_reset;
+    device_class_set_props(dc, rtmr_properties);
+}
+
+static const TypeInfo rtmr_info = {
+    .name = TYPE_RENESAS_TMR,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RTMRState),
+    .instance_init = rtmr_init,
+    .class_init = rtmr_class_init,
+};
+
+static void rtmr_register_types(void)
+{
+    type_register_static(&rtmr_info);
+}
+
+type_init(rtmr_register_types)
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 59b3f44d69..7039c2a686 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -35,3 +35,6 @@ config CMSDK_APB_TIMER
 config CMSDK_APB_DUALTIMER
     bool
     select PTIMER
+
+config RENESAS_TMR
+    bool
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index dece235fd7..44fb47a433 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -23,6 +23,7 @@ common-obj-$(CONFIG_OMAP) += omap_gptimer.o
 common-obj-$(CONFIG_OMAP) += omap_synctimer.o
 common-obj-$(CONFIG_PXA2XX) += pxa2xx_timer.o
 common-obj-$(CONFIG_SH4) += sh_timer.o
+common-obj-$(CONFIG_RENESAS_TMR) += renesas_tmr.o
 common-obj-$(CONFIG_DIGIC) += digic-timer.o
 common-obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
 
-- 
2.21.3


