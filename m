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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E6DC43603
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 19:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD5E20663
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 19:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvJTr/W8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD5E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie26N-0002i6-NI
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 14:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ie1U2-0002PB-1C
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tx-0003NV-Et
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:40 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ie1Tw-0003A9-Qi
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:37 -0500
Received: by mail-wr1-x442.google.com with SMTP id q10so13509589wrm.11
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 10:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WuLUCTZKjcrbtBbXBWE/9k725Nt3/zoxnyLmMaWTvho=;
 b=GvJTr/W8CooXrf7ZIxslVo4Djlsv1gL0QgPxuxj5w6e953D7OGzxpD/QN+yY0m38DF
 lxuvbOLpJRuM+5T6oQOIg7U5ijtTuZQ6fn9rZykAXCOmXOb9w4TiUeyLl3LPiyrWAyht
 WbTUuxJMdfuFhbTGO6wXQS+xala1g22+7a3iEiibbLuUdxaSbxWsLL3qVZcPGiyDAsZL
 Wc3z3OZ5dXC8OMgGs97Rh+2aEPTP2HFV7bZu8PsAXp5Ul2gTrmiuN+udJoU8C0mfaojp
 W2WToaXuTXJ88OagBUBYWAqfL2HsyMn5smK/zmP/CXvebQfrf+aPQgEakOCKE7+AMPhR
 qF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WuLUCTZKjcrbtBbXBWE/9k725Nt3/zoxnyLmMaWTvho=;
 b=ne3mkwnaR4k0F7szDW8pVhuaPYQTqe50buTrbCNJOppt6bzjGcVmtWB0sMNeEnh8Om
 bsKSfFzL6MkHL1LeY8PwJgCpnlHrQhCJPrM6mfDEX3pvYUVCspi5jrU5B3Ht+JhCM96/
 hrDIpJ5URX7vfZy56wAH/wWeqwezSGmKrhBZb7c5DSrgQN50ciFeiWS6FtXd3uOBrj3a
 qNYy94YfPh3KhIVWDbf5YBUXjkHMIE1QPMk772WjoojldV71dEkIQfrDSbdIQie7Ehth
 zso56CDwKe72YVcgtngIWhPcORZMokVn39mDZvjUEJDxSLpUM5V3n/3XYQt5sjDJFPFb
 yCXQ==
X-Gm-Message-State: APjAAAV9LOYMkq/ffRN48V4YiSL8I4AdElThFaUrfWOm6KoDT2BgCRgj
 6fsDdGNpby8F9KPfdlfdSo23gxVuo+NW66Qb
X-Google-Smtp-Source: APXvYqwnAbc03YbjlpcdOv5HAhIT1SCM4WRCUP9VGHqZpOqczbFMAj3buQ9wT+E1o2AXOdysWm9PUg==
X-Received: by 2002:a5d:4481:: with SMTP id j1mr27796423wrq.348.1575830417071; 
 Sun, 08 Dec 2019 10:40:17 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-180-52-3.red.bezeqint.net. [79.180.52.3])
 by smtp.gmail.com with ESMTPSA id h17sm25289717wrs.18.2019.12.08.10.40.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 08 Dec 2019 10:40:16 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v38 13/22] target/avr: Add limited support for 16 bit timer
 peripheral
Date: Sun,  8 Dec 2019 20:39:13 +0200
Message-Id: <20191208183922.13757-14-mrolnik@gmail.com>
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
 include/hw/timer/avr_timer16.h |  93 +++++
 hw/timer/avr_timer16.c         | 601 +++++++++++++++++++++++++++++++++
 hw/timer/Kconfig               |   3 +
 hw/timer/Makefile.objs         |   2 +
 4 files changed, 699 insertions(+)
 create mode 100644 include/hw/timer/avr_timer16.h
 create mode 100644 hw/timer/avr_timer16.c

diff --git a/include/hw/timer/avr_timer16.h b/include/hw/timer/avr_timer16.h
new file mode 100644
index 0000000000..662f56aa55
--- /dev/null
+++ b/include/hw/timer/avr_timer16.h
@@ -0,0 +1,93 @@
+/*
+ * AVR 16 bit timer
+ *
+ * Copyright (c) 2018 University of Kent
+ * Author: Ed Robbins
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
+/*
+ * Driver for 16 bit timers on 8 bit AVR devices.
+ * Note:
+ * On ATmega640/V-1280/V-1281/V-2560/V-2561/V timers 1, 3, 4 and 5 are 16 bit
+ */
+
+#ifndef AVR_TIMER16_H
+#define AVR_TIMER16_H
+
+#include "hw/sysbus.h"
+#include "qemu/timer.h"
+#include "hw/hw.h"
+
+enum NextInterrupt {
+    OVERFLOW,
+    COMPA,
+    COMPB,
+    COMPC,
+    CAPT
+};
+
+#define TYPE_AVR_TIMER16 "avr-timer16"
+#define AVR_TIMER16(obj) \
+    OBJECT_CHECK(AVRTimer16State, (obj), TYPE_AVR_TIMER16)
+
+typedef struct AVRTimer16State {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion iomem;
+    MemoryRegion imsk_iomem;
+    MemoryRegion ifr_iomem;
+    QEMUTimer *timer;
+    qemu_irq capt_irq;
+    qemu_irq compa_irq;
+    qemu_irq compb_irq;
+    qemu_irq compc_irq;
+    qemu_irq ovf_irq;
+
+    bool enabled;
+
+    /* registers */
+    uint8_t cra;
+    uint8_t crb;
+    uint8_t crc;
+    uint8_t cntl;
+    uint8_t cnth;
+    uint8_t icrl;
+    uint8_t icrh;
+    uint8_t ocral;
+    uint8_t ocrah;
+    uint8_t ocrbl;
+    uint8_t ocrbh;
+    uint8_t ocrcl;
+    uint8_t ocrch;
+    /*
+     * Reads and writes to CNT and ICR utilise a bizarre temporary
+     * register, which we emulate
+     */
+    uint8_t rtmp;
+    uint8_t imsk;
+    uint8_t ifr;
+
+    uint64_t cpu_freq_hz;
+    uint64_t freq_hz;
+    uint64_t period_ns;
+    uint64_t reset_time_ns;
+    enum NextInterrupt next_interrupt;
+} AVRTimer16State;
+
+#endif /* AVR_TIMER16_H */
diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
new file mode 100644
index 0000000000..f3dcef7246
--- /dev/null
+++ b/hw/timer/avr_timer16.c
@@ -0,0 +1,601 @@
+/*
+ * AVR 16 bit timer
+ *
+ * Copyright (c) 2018 University of Kent
+ * Author: Ed Robbins
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
+/*
+ * Driver for 16 bit timers on 8 bit AVR devices.
+ * Note:
+ * ATmega640/V-1280/V-1281/V-2560/V-2561/V timers 1, 3, 4 and 5 are 16 bit
+ */
+
+/*
+ * XXX TODO: Power Reduction Register support
+ *           prescaler pause support
+ *           PWM modes, GPIO, output capture pins, input compare pin
+ */
+
+#include "qemu/osdep.h"
+#include "hw/timer/avr_timer16.h"
+#include "qemu/log.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+
+/* Register offsets */
+#define T16_CRA     0x0
+#define T16_CRB     0x1
+#define T16_CRC     0x2
+#define T16_CNTL    0x4
+#define T16_CNTH    0x5
+#define T16_ICRL    0x6
+#define T16_ICRH    0x7
+#define T16_OCRAL   0x8
+#define T16_OCRAH   0x9
+#define T16_OCRBL   0xa
+#define T16_OCRBH   0xb
+#define T16_OCRCL   0xc
+#define T16_OCRCH   0xd
+
+/* Field masks */
+#define T16_CRA_WGM01   0x3
+#define T16_CRA_COMC    0xc
+#define T16_CRA_COMB    0x30
+#define T16_CRA_COMA    0xc0
+#define T16_CRA_OC_CONF \
+    (T16_CRA_COMA | T16_CRA_COMB | T16_CRA_COMC)
+
+#define T16_CRB_CS      0x7
+#define T16_CRB_WGM23   0x18
+#define T16_CRB_ICES    0x40
+#define T16_CRB_ICNC    0x80
+
+#define T16_CRC_FOCC    0x20
+#define T16_CRC_FOCB    0x40
+#define T16_CRC_FOCA    0x80
+
+/* Fields masks both TIMSK and TIFR (interrupt mask/flag registers) */
+#define T16_INT_TOV    0x1 /* Timer overflow */
+#define T16_INT_OCA    0x2 /* Output compare A */
+#define T16_INT_OCB    0x4 /* Output compare B */
+#define T16_INT_OCC    0x8 /* Output compare C */
+#define T16_INT_IC     0x20 /* Input capture */
+
+/* Clock source values */
+#define T16_CLKSRC_STOPPED     0
+#define T16_CLKSRC_DIV1        1
+#define T16_CLKSRC_DIV8        2
+#define T16_CLKSRC_DIV64       3
+#define T16_CLKSRC_DIV256      4
+#define T16_CLKSRC_DIV1024     5
+#define T16_CLKSRC_EXT_FALLING 6
+#define T16_CLKSRC_EXT_RISING  7
+
+/* Timer mode values (not including PWM modes) */
+#define T16_MODE_NORMAL     0
+#define T16_MODE_CTC_OCRA   4
+#define T16_MODE_CTC_ICR    12
+
+/* Accessors */
+#define CLKSRC(t16) (t16->crb & T16_CRB_CS)
+#define MODE(t16)   (((t16->crb & T16_CRB_WGM23) >> 1) | \
+                     (t16->cra & T16_CRA_WGM01))
+#define CNT(t16)    VAL16(t16->cntl, t16->cnth)
+#define OCRA(t16)   VAL16(t16->ocral, t16->ocrah)
+#define OCRB(t16)   VAL16(t16->ocrbl, t16->ocrbh)
+#define OCRC(t16)   VAL16(t16->ocrcl, t16->ocrch)
+#define ICR(t16)    VAL16(t16->icrl, t16->icrh)
+
+/* Helper macros */
+#define VAL16(l, h) ((h << 8) | l)
+#define ERROR(fmt, args...) \
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: " fmt "\n", __func__, ## args)
+#define DB_PRINT(fmt, args...) /* Nothing */
+/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n", __func__, ## args)*/
+
+static inline int64_t avr_timer16_ns_to_ticks(AVRTimer16State *t16, int64_t t)
+{
+    if (t16->period_ns == 0) {
+        return 0;
+    }
+    return t / t16->period_ns;
+}
+
+static void avr_timer16_update_cnt(AVRTimer16State *t16)
+{
+    uint16_t cnt;
+    cnt = avr_timer16_ns_to_ticks(t16, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
+                                       t16->reset_time_ns);
+    t16->cntl = (uint8_t)(cnt & 0xff);
+    t16->cnth = (uint8_t)((cnt & 0xff00) >> 8);
+}
+
+static inline void avr_timer16_recalc_reset_time(AVRTimer16State *t16)
+{
+    t16->reset_time_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
+                         CNT(t16) * t16->period_ns;
+}
+
+static void avr_timer16_clock_reset(AVRTimer16State *t16)
+{
+    t16->cntl = 0;
+    t16->cnth = 0;
+    t16->reset_time_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+}
+
+static void avr_timer16_clksrc_update(AVRTimer16State *t16)
+{
+    uint16_t divider = 0;
+    switch (CLKSRC(t16)) {
+    case T16_CLKSRC_EXT_FALLING:
+    case T16_CLKSRC_EXT_RISING:
+        ERROR("external clock source unsupported");
+        goto end;
+    case T16_CLKSRC_STOPPED:
+        goto end;
+    case T16_CLKSRC_DIV1:
+        divider = 1;
+        break;
+    case T16_CLKSRC_DIV8:
+        divider = 8;
+        break;
+    case T16_CLKSRC_DIV64:
+        divider = 64;
+        break;
+    case T16_CLKSRC_DIV256:
+        divider = 256;
+        break;
+    case T16_CLKSRC_DIV1024:
+        divider = 1024;
+        break;
+    default:
+        goto end;
+    }
+    t16->freq_hz = t16->cpu_freq_hz / divider;
+    t16->period_ns = NANOSECONDS_PER_SECOND / t16->freq_hz;
+    DB_PRINT("Timer frequency %" PRIu64 " hz, period %" PRIu64 " ns (%f s)",
+             t16->freq_hz, t16->period_ns, 1 / (double)t16->freq_hz);
+end:
+    return;
+}
+
+static void avr_timer16_set_alarm(AVRTimer16State *t16)
+{
+    if (CLKSRC(t16) == T16_CLKSRC_EXT_FALLING ||
+        CLKSRC(t16) == T16_CLKSRC_EXT_RISING ||
+        CLKSRC(t16) == T16_CLKSRC_STOPPED) {
+        /* Timer is disabled or set to external clock source (unsupported) */
+        goto end;
+    }
+
+    uint64_t alarm_offset = 0xffff;
+    enum NextInterrupt next_interrupt = OVERFLOW;
+
+    switch (MODE(t16)) {
+    case T16_MODE_NORMAL:
+        /* Normal mode */
+        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16) &&
+            (t16->imsk & T16_INT_OCA)) {
+            alarm_offset = OCRA(t16);
+            next_interrupt = COMPA;
+        }
+        break;
+    case T16_MODE_CTC_OCRA:
+        /* CTC mode, top = ocra */
+        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16)) {
+            alarm_offset = OCRA(t16);
+            next_interrupt = COMPA;
+        }
+       break;
+    case T16_MODE_CTC_ICR:
+        /* CTC mode, top = icr */
+        if (ICR(t16) < alarm_offset && ICR(t16) > CNT(t16)) {
+            alarm_offset = ICR(t16);
+            next_interrupt = CAPT;
+        }
+        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16) &&
+            (t16->imsk & T16_INT_OCA)) {
+            alarm_offset = OCRA(t16);
+            next_interrupt = COMPA;
+        }
+        break;
+    default:
+        ERROR("pwm modes are unsupported");
+        goto end;
+    }
+    if (OCRB(t16) < alarm_offset && OCRB(t16) > CNT(t16) &&
+        (t16->imsk & T16_INT_OCB)) {
+        alarm_offset = OCRB(t16);
+        next_interrupt = COMPB;
+    }
+    if (OCRC(t16) < alarm_offset && OCRB(t16) > CNT(t16) &&
+        (t16->imsk & T16_INT_OCC)) {
+        alarm_offset = OCRB(t16);
+        next_interrupt = COMPC;
+    }
+    alarm_offset -= CNT(t16);
+
+    t16->next_interrupt = next_interrupt;
+    uint64_t alarm_ns =
+        t16->reset_time_ns + ((CNT(t16) + alarm_offset) * t16->period_ns);
+    timer_mod(t16->timer, alarm_ns);
+
+    DB_PRINT("next alarm %" PRIu64 " ns from now",
+        alarm_offset * t16->period_ns);
+
+end:
+    return;
+}
+
+static void avr_timer16_interrupt(void *opaque)
+{
+    AVRTimer16State *t16 = opaque;
+    uint8_t mode = MODE(t16);
+
+    avr_timer16_update_cnt(t16);
+
+    if (CLKSRC(t16) == T16_CLKSRC_EXT_FALLING ||
+        CLKSRC(t16) == T16_CLKSRC_EXT_RISING ||
+        CLKSRC(t16) == T16_CLKSRC_STOPPED) {
+        /* Timer is disabled or set to external clock source (unsupported) */
+        return;
+    }
+
+    DB_PRINT("interrupt, cnt = %d", CNT(t16));
+
+    /* Counter overflow */
+    if (t16->next_interrupt == OVERFLOW) {
+        DB_PRINT("0xffff overflow");
+        avr_timer16_clock_reset(t16);
+        if (t16->imsk & T16_INT_TOV) {
+            t16->ifr |= T16_INT_TOV;
+            qemu_set_irq(t16->ovf_irq, 1);
+        }
+    }
+    /* Check for ocra overflow in CTC mode */
+    if (mode == T16_MODE_CTC_OCRA && t16->next_interrupt == COMPA) {
+        DB_PRINT("CTC OCRA overflow");
+        avr_timer16_clock_reset(t16);
+    }
+    /* Check for icr overflow in CTC mode */
+    if (mode == T16_MODE_CTC_ICR && t16->next_interrupt == CAPT) {
+        DB_PRINT("CTC ICR overflow");
+        avr_timer16_clock_reset(t16);
+        if (t16->imsk & T16_INT_IC) {
+            t16->ifr |= T16_INT_IC;
+            qemu_set_irq(t16->capt_irq, 1);
+        }
+    }
+    /* Check for output compare interrupts */
+    if (t16->imsk & T16_INT_OCA && t16->next_interrupt == COMPA) {
+        t16->ifr |= T16_INT_OCA;
+        qemu_set_irq(t16->compa_irq, 1);
+    }
+    if (t16->imsk & T16_INT_OCB && t16->next_interrupt == COMPB) {
+        t16->ifr |= T16_INT_OCB;
+        qemu_set_irq(t16->compb_irq, 1);
+    }
+    if (t16->imsk & T16_INT_OCC && t16->next_interrupt == COMPC) {
+        t16->ifr |= T16_INT_OCC;
+        qemu_set_irq(t16->compc_irq, 1);
+    }
+    avr_timer16_set_alarm(t16);
+}
+
+static void avr_timer16_reset(DeviceState *dev)
+{
+    AVRTimer16State *t16 = AVR_TIMER16(dev);
+
+    avr_timer16_clock_reset(t16);
+    avr_timer16_clksrc_update(t16);
+    avr_timer16_set_alarm(t16);
+
+    qemu_set_irq(t16->capt_irq, 0);
+    qemu_set_irq(t16->compa_irq, 0);
+    qemu_set_irq(t16->compb_irq, 0);
+    qemu_set_irq(t16->compc_irq, 0);
+    qemu_set_irq(t16->ovf_irq, 0);
+}
+
+static uint64_t avr_timer16_read(void *opaque, hwaddr offset, unsigned size)
+{
+    assert(size == 1);
+    AVRTimer16State *t16 = opaque;
+    uint8_t retval = 0;
+
+    switch (offset) {
+    case T16_CRA:
+        retval = t16->cra;
+        break;
+    case T16_CRB:
+        retval = t16->crb;
+        break;
+    case T16_CRC:
+        retval = t16->crc;
+        break;
+    case T16_CNTL:
+        avr_timer16_update_cnt(t16);
+        t16->rtmp = t16->cnth;
+        retval = t16->cntl;
+        break;
+    case T16_CNTH:
+        retval = t16->rtmp;
+        break;
+    case T16_ICRL:
+        /*
+         * The timer copies cnt to icr when the input capture pin changes
+         * state or when the analog comparator has a match. We don't
+         * emulate this behaviour. We do support it's use for defining a
+         * TOP value in T16_MODE_CTC_ICR
+         */
+        t16->rtmp = t16->icrh;
+        retval = t16->icrl;
+        break;
+    case T16_ICRH:
+        retval = t16->rtmp;
+        break;
+    case T16_OCRAL:
+        retval = t16->ocral;
+        break;
+    case T16_OCRAH:
+        retval = t16->ocrah;
+        break;
+    case T16_OCRBL:
+        retval = t16->ocrbl;
+        break;
+    case T16_OCRBH:
+        retval = t16->ocrbh;
+        break;
+    case T16_OCRCL:
+        retval = t16->ocrcl;
+        break;
+    case T16_OCRCH:
+        retval = t16->ocrch;
+        break;
+    default:
+        break;
+    }
+    return (uint64_t)retval;
+}
+
+static void avr_timer16_write(void *opaque, hwaddr offset,
+                              uint64_t val64, unsigned size)
+{
+    assert(size == 1);
+    AVRTimer16State *t16 = opaque;
+    uint8_t val8 = (uint8_t)val64;
+    uint8_t prev_clk_src = CLKSRC(t16);
+
+    DB_PRINT("write %d to offset %d", val8, (uint8_t)offset);
+
+    switch (offset) {
+    case T16_CRA:
+        t16->cra = val8;
+        if (t16->cra & T16_CRA_OC_CONF) {
+            ERROR("output compare pins unsupported");
+        }
+        break;
+    case T16_CRB:
+        t16->crb = val8;
+        if (t16->crb & T16_CRB_ICNC) {
+            ERROR("input capture noise canceller unsupported");
+        }
+        if (t16->crb & T16_CRB_ICES) {
+            ERROR("input capture unsupported");
+        }
+        if (CLKSRC(t16) != prev_clk_src) {
+            avr_timer16_clksrc_update(t16);
+            if (prev_clk_src == T16_CLKSRC_STOPPED) {
+                t16->reset_time_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+            }
+        }
+        break;
+    case T16_CRC:
+        t16->crc = val8;
+        ERROR("output compare pins unsupported");
+        break;
+    case T16_CNTL:
+        /*
+         * CNT is the 16-bit counter value, it must be read/written via
+         * a temporary register (rtmp) to make the read/write atomic.
+         */
+        /* ICR also has this behaviour, and shares rtmp */
+        /*
+         * Writing CNT blocks compare matches for one clock cycle.
+         * Writing CNT to TOP or to an OCR value (if in use) will
+         * skip the relevant interrupt
+         */
+        t16->cntl = val8;
+        t16->cnth = t16->rtmp;
+        avr_timer16_recalc_reset_time(t16);
+        break;
+    case T16_CNTH:
+        t16->rtmp = val8;
+        break;
+    case T16_ICRL:
+        /* ICR can only be written in mode T16_MODE_CTC_ICR */
+        if (MODE(t16) == T16_MODE_CTC_ICR) {
+            t16->icrl = val8;
+            t16->icrh = t16->rtmp;
+        }
+        break;
+    case T16_ICRH:
+        if (MODE(t16) == T16_MODE_CTC_ICR) {
+            t16->rtmp = val8;
+        }
+        break;
+    case T16_OCRAL:
+        /*
+         * OCRn cause the relevant output compare flag to be raised, and
+         * trigger an interrupt, when CNT is equal to the value here
+         */
+        t16->ocral = val8;
+        break;
+    case T16_OCRAH:
+        t16->ocrah = val8;
+        break;
+    case T16_OCRBL:
+        t16->ocrbl = val8;
+        break;
+    case T16_OCRBH:
+        t16->ocrbh = val8;
+        break;
+    case T16_OCRCL:
+        t16->ocrcl = val8;
+        break;
+    case T16_OCRCH:
+        t16->ocrch = val8;
+        break;
+    default:
+        break;
+    }
+    avr_timer16_set_alarm(t16);
+}
+
+static uint64_t avr_timer16_imsk_read(void *opaque,
+                                      hwaddr offset,
+                                      unsigned size)
+{
+    assert(size == 1);
+    AVRTimer16State *t16 = opaque;
+    if (offset != 0) {
+        return 0;
+    }
+    return t16->imsk;
+}
+
+static void avr_timer16_imsk_write(void *opaque, hwaddr offset,
+                                   uint64_t val64, unsigned size)
+{
+    assert(size == 1);
+    AVRTimer16State *t16 = opaque;
+    if (offset != 0) {
+        return;
+    }
+    t16->imsk = (uint8_t)val64;
+}
+
+static uint64_t avr_timer16_ifr_read(void *opaque,
+                                     hwaddr offset,
+                                     unsigned size)
+{
+    assert(size == 1);
+    AVRTimer16State *t16 = opaque;
+    if (offset != 0) {
+        return 0;
+    }
+    return t16->ifr;
+}
+
+static void avr_timer16_ifr_write(void *opaque, hwaddr offset,
+                                  uint64_t val64, unsigned size)
+{
+    assert(size == 1);
+    AVRTimer16State *t16 = opaque;
+    if (offset != 0) {
+        return;
+    }
+    t16->ifr = (uint8_t)val64;
+}
+
+static const MemoryRegionOps avr_timer16_ops = {
+    .read = avr_timer16_read,
+    .write = avr_timer16_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {.max_access_size = 1}
+};
+
+static const MemoryRegionOps avr_timer16_imsk_ops = {
+    .read = avr_timer16_imsk_read,
+    .write = avr_timer16_imsk_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {.max_access_size = 1}
+};
+
+static const MemoryRegionOps avr_timer16_ifr_ops = {
+    .read = avr_timer16_ifr_read,
+    .write = avr_timer16_ifr_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {.max_access_size = 1}
+};
+
+static Property avr_timer16_properties[] = {
+    DEFINE_PROP_UINT64("cpu-frequency-hz", struct AVRTimer16State,
+                       cpu_freq_hz, 20000000),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void avr_timer16_pr(void *opaque, int irq, int level)
+{
+    AVRTimer16State *s = AVR_TIMER16(opaque);
+
+    s->enabled = !level;
+
+    if (!s->enabled) {
+        avr_timer16_reset(DEVICE(s));
+    }
+}
+
+static void avr_timer16_init(Object *obj)
+{
+    AVRTimer16State *s = AVR_TIMER16(obj);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->capt_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->compa_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->compb_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->compc_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->ovf_irq);
+
+    memory_region_init_io(&s->iomem, obj, &avr_timer16_ops,
+                          s, TYPE_AVR_TIMER16, 0xe);
+    memory_region_init_io(&s->imsk_iomem, obj, &avr_timer16_imsk_ops,
+                          s, TYPE_AVR_TIMER16, 0x1);
+    memory_region_init_io(&s->ifr_iomem, obj, &avr_timer16_ifr_ops,
+                          s, TYPE_AVR_TIMER16, 0x1);
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->imsk_iomem);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->ifr_iomem);
+    qdev_init_gpio_in(DEVICE(s), avr_timer16_pr, 1);
+
+    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, avr_timer16_interrupt, s);
+    s->enabled = true;
+}
+
+static void avr_timer16_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = avr_timer16_reset;
+    dc->props = avr_timer16_properties;
+}
+
+static const TypeInfo avr_timer16_info = {
+    .name          = TYPE_AVR_TIMER16,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AVRTimer16State),
+    .instance_init = avr_timer16_init,
+    .class_init    = avr_timer16_class_init,
+};
+
+static void avr_timer16_register_types(void)
+{
+    type_register_static(&avr_timer16_info);
+}
+
+type_init(avr_timer16_register_types)
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index a990f9fe35..4343bc23f3 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -34,3 +34,6 @@ config CMSDK_APB_TIMER
 config CMSDK_APB_DUALTIMER
     bool
     select PTIMER
+
+config AVR_TIMER16
+    bool
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index dece235fd7..af0913ca3b 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -35,3 +35,5 @@ common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
 common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) += cmsdk-apb-dualtimer.o
 common-obj-$(CONFIG_MSF2) += mss-timer.o
 common-obj-$(CONFIG_RASPI) += bcm2835_systmr.o
+
+obj-$(CONFIG_AVR_TIMER16) += avr_timer16.o
-- 
2.17.2 (Apple Git-113)


