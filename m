Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BFBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:22:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9DB320884
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFG8Seyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DB320884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jldeC-0008Iq-Va
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 15:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jldX5-0004Qw-LL
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:15:35 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:45305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jldX3-0006UB-DC
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:15:35 -0400
Received: by mail-ed1-x52f.google.com with SMTP id t21so2903572edr.12
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bcKld0eaekjaOavSgG+FcA8qhxJmWxkd64BI9BXaJ5g=;
 b=HFG8SeypS3lY+T6/Vkmk3AQQezhHSPe0HvtEAi2LaafQALWjk+eLILwkuKQVthDTEb
 77gjMAbYvhXblxiqBPRuriSfjnckZ2tf0HmpBRdI65TY2H1Jt/EZPDnrJAGQvyOYjsqf
 zsPI9zdqdXK0R9WkHQV+6vrn2GB34+ImoB1UKqrnFe7MaITI4HuQKBN/wRP9Kl8HOhq2
 6GqfTtCwvSt+pgEOu7jzMiRLYkWxPp8KRGTZOtQPhB+4uT49Q8ekjVwN0flLRRTRFv6V
 Gn/JLp5Mcb2o7xllYSzWUKrfz4rauCMCS/SldE8gQUpI8ohgbh1eTTiVbQ7gozPpC/bb
 1OzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=bcKld0eaekjaOavSgG+FcA8qhxJmWxkd64BI9BXaJ5g=;
 b=X1GfFmAVL9CA3Fsip4wIZFT/9REeZ8Y7HUgYSij3cJxeus2diUg0yeGojtH6gnkape
 MnDsvpf7TKLsMSxVJF64SIELEef5XI37mGL0c7Wzzq29nSKMoe+s6SUgy3kVMyacR4G+
 QuLteBRfDn3HSXbTtmfpV+xVG37qyfd95uL1tYgGJCj580zh1lwQOa89AjqseUwHLxNz
 H49dCi6u0BwPh/KFykNSzNyWyGVKDeZr2ohMacR5nD9w/lDnWGyUVHlJB4xLkZwDsjYr
 mAtpjpOByUI8OILfgFcX9Eg1lsAE5kiRVJV2JSOpu7d2bnlPSpGkBGMJa6q1Lw43Ad26
 NGgQ==
X-Gm-Message-State: AOAM530oggM5Iq1qQ3TMsqeBNAHw/MGAkq4saAbBi/sBsBAj+AnKXzog
 kWRg0ObFQtZbbj8BgNBNB6g=
X-Google-Smtp-Source: ABdhPJy0aHf10SnhPOpNW5w+BVHJ/IzrachROyqNrK31H3ZgmxWV5jYxo7VmMEAp2knqRrit+IIXzA==
X-Received: by 2002:a50:d499:: with SMTP id s25mr646230edi.161.1592421331994; 
 Wed, 17 Jun 2020 12:15:31 -0700 (PDT)
Received: from x1w.redhat.com (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id y21sm324308edl.72.2020.06.17.12.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 12:15:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
Subject: [PATCH rc1 08/15] hw/timer: RX62N compare match timer (CMT)
Date: Wed, 17 Jun 2020 21:15:12 +0200
Message-Id: <20200617191519.14842-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617191519.14842-1-f4bug@amsat.org>
References: <20200617191519.14842-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x52f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Magnus Damm <magnus.damm@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

renesas_cmt: 16bit compare match timer modules.
This part use many renesas's CPU.
Hardware manual.
https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033ej0140_rx62n.pdf

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200224141923.82118-16-ysato@users.sourceforge.jp>
[PMD: Split from TMR, filled VMStateField for migration]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/timer/renesas_cmt.h |  40 +++++
 hw/timer/renesas_cmt.c         | 283 +++++++++++++++++++++++++++++++++
 MAINTAINERS                    |   4 +-
 hw/timer/Kconfig               |   3 +
 hw/timer/Makefile.objs         |   1 +
 5 files changed, 329 insertions(+), 2 deletions(-)
 create mode 100644 include/hw/timer/renesas_cmt.h
 create mode 100644 hw/timer/renesas_cmt.c

diff --git a/include/hw/timer/renesas_cmt.h b/include/hw/timer/renesas_cmt.h
new file mode 100644
index 0000000000..e28a15cb38
--- /dev/null
+++ b/include/hw/timer/renesas_cmt.h
@@ -0,0 +1,40 @@
+/*
+ * Renesas Compare-match timer Object
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_TIMER_RENESAS_CMT_H
+#define HW_TIMER_RENESAS_CMT_H
+
+#include "qemu/timer.h"
+#include "hw/sysbus.h"
+
+#define TYPE_RENESAS_CMT "renesas-cmt"
+#define RCMT(obj) OBJECT_CHECK(RCMTState, (obj), TYPE_RENESAS_CMT)
+
+enum {
+    CMT_CH = 2,
+    CMT_NR_IRQ = 1 * CMT_CH
+};
+
+typedef struct RCMTState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    uint64_t input_freq;
+    MemoryRegion memory;
+
+    uint16_t cmstr;
+    uint16_t cmcr[CMT_CH];
+    uint16_t cmcnt[CMT_CH];
+    uint16_t cmcor[CMT_CH];
+    int64_t tick[CMT_CH];
+    qemu_irq cmi[CMT_CH];
+    QEMUTimer timer[CMT_CH];
+} RCMTState;
+
+#endif
diff --git a/hw/timer/renesas_cmt.c b/hw/timer/renesas_cmt.c
new file mode 100644
index 0000000000..2e0fd21a36
--- /dev/null
+++ b/hw/timer/renesas_cmt.c
@@ -0,0 +1,283 @@
+/*
+ * Renesas 16bit Compare-match timer
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
+#include "hw/timer/renesas_cmt.h"
+#include "migration/vmstate.h"
+
+/*
+ *  +0 CMSTR - common control
+ *  +2 CMCR  - ch0
+ *  +4 CMCNT - ch0
+ *  +6 CMCOR - ch0
+ *  +8 CMCR  - ch1
+ * +10 CMCNT - ch1
+ * +12 CMCOR - ch1
+ * If we think that the address of CH 0 has an offset of +2,
+ * we can treat it with the same address as CH 1, so define it like that.
+ */
+REG16(CMSTR, 0)
+  FIELD(CMSTR, STR0, 0, 1)
+  FIELD(CMSTR, STR1, 1, 1)
+  FIELD(CMSTR, STR,  0, 2)
+/* This addeess is channel offset */
+REG16(CMCR, 0)
+  FIELD(CMCR, CKS,  0, 2)
+  FIELD(CMCR, CMIE, 6, 1)
+REG16(CMCNT, 2)
+REG16(CMCOR, 4)
+
+static void update_events(RCMTState *cmt, int ch)
+{
+    int64_t next_time;
+
+    if ((cmt->cmstr & (1 << ch)) == 0) {
+        /* count disable, so not happened next event. */
+        return ;
+    }
+    next_time = cmt->cmcor[ch] - cmt->cmcnt[ch];
+    next_time *= NANOSECONDS_PER_SECOND;
+    next_time /= cmt->input_freq;
+    /*
+     * CKS -> div rate
+     *  0 -> 8 (1 << 3)
+     *  1 -> 32 (1 << 5)
+     *  2 -> 128 (1 << 7)
+     *  3 -> 512 (1 << 9)
+     */
+    next_time *= 1 << (3 + FIELD_EX16(cmt->cmcr[ch], CMCR, CKS) * 2);
+    next_time += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    timer_mod(&cmt->timer[ch], next_time);
+}
+
+static int64_t read_cmcnt(RCMTState *cmt, int ch)
+{
+    int64_t delta, now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    if (cmt->cmstr & (1 << ch)) {
+        delta = (now - cmt->tick[ch]);
+        delta /= NANOSECONDS_PER_SECOND;
+        delta /= cmt->input_freq;
+        delta /= 1 << (3 + FIELD_EX16(cmt->cmcr[ch], CMCR, CKS) * 2);
+        cmt->tick[ch] = now;
+        return cmt->cmcnt[ch] + delta;
+    } else {
+        return cmt->cmcnt[ch];
+    }
+}
+
+static uint64_t cmt_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RCMTState *cmt = opaque;
+    int ch = offset / 0x08;
+    uint64_t ret;
+
+    if (offset == A_CMSTR) {
+        ret = 0;
+        ret = FIELD_DP16(ret, CMSTR, STR,
+                         FIELD_EX16(cmt->cmstr, CMSTR, STR));
+        return ret;
+    } else {
+        offset &= 0x07;
+        if (ch == 0) {
+            offset -= 0x02;
+        }
+        switch (offset) {
+        case A_CMCR:
+            ret = 0;
+            ret = FIELD_DP16(ret, CMCR, CKS,
+                             FIELD_EX16(cmt->cmstr, CMCR, CKS));
+            ret = FIELD_DP16(ret, CMCR, CMIE,
+                             FIELD_EX16(cmt->cmstr, CMCR, CMIE));
+            return ret;
+        case A_CMCNT:
+            return read_cmcnt(cmt, ch);
+        case A_CMCOR:
+            return cmt->cmcor[ch];
+        }
+    }
+    qemu_log_mask(LOG_UNIMP, "renesas_cmt: Register 0x%" HWADDR_PRIX " "
+                             "not implemented\n",
+                  offset);
+    return UINT64_MAX;
+}
+
+static void start_stop(RCMTState *cmt, int ch, int st)
+{
+    if (st) {
+        update_events(cmt, ch);
+    } else {
+        timer_del(&cmt->timer[ch]);
+    }
+}
+
+static void cmt_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+{
+    RCMTState *cmt = opaque;
+    int ch = offset / 0x08;
+
+    if (offset == A_CMSTR) {
+        cmt->cmstr = FIELD_EX16(val, CMSTR, STR);
+        start_stop(cmt, 0, FIELD_EX16(cmt->cmstr, CMSTR, STR0));
+        start_stop(cmt, 1, FIELD_EX16(cmt->cmstr, CMSTR, STR1));
+    } else {
+        offset &= 0x07;
+        if (ch == 0) {
+            offset -= 0x02;
+        }
+        switch (offset) {
+        case A_CMCR:
+            cmt->cmcr[ch] = FIELD_DP16(cmt->cmcr[ch], CMCR, CKS,
+                                       FIELD_EX16(val, CMCR, CKS));
+            cmt->cmcr[ch] = FIELD_DP16(cmt->cmcr[ch], CMCR, CMIE,
+                                       FIELD_EX16(val, CMCR, CMIE));
+            break;
+        case 2:
+            cmt->cmcnt[ch] = val;
+            break;
+        case 4:
+            cmt->cmcor[ch] = val;
+            break;
+        default:
+            qemu_log_mask(LOG_UNIMP, "renesas_cmt: Register 0x%" HWADDR_PRIX " "
+                                     "not implemented\n",
+                          offset);
+            return;
+        }
+        if (FIELD_EX16(cmt->cmstr, CMSTR, STR) & (1 << ch)) {
+            update_events(cmt, ch);
+        }
+    }
+}
+
+static const MemoryRegionOps cmt_ops = {
+    .write = cmt_write,
+    .read  = cmt_read,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 2,
+        .max_access_size = 2,
+    },
+    .valid = {
+        .min_access_size = 2,
+        .max_access_size = 2,
+    },
+};
+
+static void timer_events(RCMTState *cmt, int ch)
+{
+    cmt->cmcnt[ch] = 0;
+    cmt->tick[ch] = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    update_events(cmt, ch);
+    if (FIELD_EX16(cmt->cmcr[ch], CMCR, CMIE)) {
+        qemu_irq_pulse(cmt->cmi[ch]);
+    }
+}
+
+static void timer_event0(void *opaque)
+{
+    RCMTState *cmt = opaque;
+
+    timer_events(cmt, 0);
+}
+
+static void timer_event1(void *opaque)
+{
+    RCMTState *cmt = opaque;
+
+    timer_events(cmt, 1);
+}
+
+static void rcmt_reset(DeviceState *dev)
+{
+    RCMTState *cmt = RCMT(dev);
+    cmt->cmstr = 0;
+    cmt->cmcr[0] = cmt->cmcr[1] = 0;
+    cmt->cmcnt[0] = cmt->cmcnt[1] = 0;
+    cmt->cmcor[0] = cmt->cmcor[1] = 0xffff;
+}
+
+static void rcmt_init(Object *obj)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    RCMTState *cmt = RCMT(obj);
+    int i;
+
+    memory_region_init_io(&cmt->memory, OBJECT(cmt), &cmt_ops,
+                          cmt, "renesas-cmt", 0x10);
+    sysbus_init_mmio(d, &cmt->memory);
+
+    for (i = 0; i < ARRAY_SIZE(cmt->cmi); i++) {
+        sysbus_init_irq(d, &cmt->cmi[i]);
+    }
+    timer_init_ns(&cmt->timer[0], QEMU_CLOCK_VIRTUAL, timer_event0, cmt);
+    timer_init_ns(&cmt->timer[1], QEMU_CLOCK_VIRTUAL, timer_event1, cmt);
+}
+
+static const VMStateDescription vmstate_rcmt = {
+    .name = "rx-cmt",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(cmstr, RCMTState),
+        VMSTATE_UINT16_ARRAY(cmcr, RCMTState, CMT_CH),
+        VMSTATE_UINT16_ARRAY(cmcnt, RCMTState, CMT_CH),
+        VMSTATE_UINT16_ARRAY(cmcor, RCMTState, CMT_CH),
+        VMSTATE_INT64_ARRAY(tick, RCMTState, CMT_CH),
+        VMSTATE_TIMER_ARRAY(timer, RCMTState, CMT_CH),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property rcmt_properties[] = {
+    DEFINE_PROP_UINT64("input-freq", RCMTState, input_freq, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rcmt_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_rcmt;
+    dc->reset = rcmt_reset;
+    device_class_set_props(dc, rcmt_properties);
+}
+
+static const TypeInfo rcmt_info = {
+    .name = TYPE_RENESAS_CMT,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RCMTState),
+    .instance_init = rcmt_init,
+    .class_init = rcmt_class_init,
+};
+
+static void rcmt_register_types(void)
+{
+    type_register_static(&rcmt_info);
+}
+
+type_init(rcmt_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index 4c84fb13ef..b9eb14b27f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1968,10 +1968,10 @@ M: Yoshinori Sato <ysato@users.sourceforge.jp>
 R: Magnus Damm <magnus.damm@gmail.com>
 S: Maintained
 F: hw/char/sh_serial.c
-F: hw/timer/renesas_tmr.c
+F: hw/timer/renesas_*.c
 F: hw/timer/sh_timer.c
 F: include/hw/sh4/sh.h
-F: include/hw/timer/renesas_tmr.h
+F: include/hw/timer/renesas_*.h
 
 Renesas RX peripherals
 M: Yoshinori Sato <ysato@users.sourceforge.jp>
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 7039c2a686..59a667c503 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -38,3 +38,6 @@ config CMSDK_APB_DUALTIMER
 
 config RENESAS_TMR
     bool
+
+config RENESAS_CMT
+    bool
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 44fb47a433..a39f6ec0c2 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -24,6 +24,7 @@ common-obj-$(CONFIG_OMAP) += omap_synctimer.o
 common-obj-$(CONFIG_PXA2XX) += pxa2xx_timer.o
 common-obj-$(CONFIG_SH4) += sh_timer.o
 common-obj-$(CONFIG_RENESAS_TMR) += renesas_tmr.o
+common-obj-$(CONFIG_RENESAS_CMT) += renesas_cmt.o
 common-obj-$(CONFIG_DIGIC) += digic-timer.o
 common-obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
 
-- 
2.21.3


