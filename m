Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3D9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68291206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzwcUeYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68291206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfnAp-0004f5-71
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 12:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5R-0005D4-Il
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:14:53 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:50384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5Q-0001WK-E9
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:14:53 -0400
Received: by mail-wm1-x32a.google.com with SMTP id v19so98909wmj.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 09:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XZACxZccAAi2TopI+c0OP5VJ17b3bi19ygcofM3uJGA=;
 b=FzwcUeYW2+67f69pfit/uM1xweSHfFruIv7n29na2PvU8rO23rzqGGoFo0I6Mgn6ER
 7kslkyVDV6NPFXUBVZkqACwthSqUVLVtWq6uSnWOeOdFS6CqGZshAMsHxhnfMdB5163V
 Bsfmxx0ROVLAV4R/VxVCmFwB2kVTqaxA/hqD0xb+QfKjdy5iEDf8/YQQmd48fOjaK3m6
 svx46cp015xYXUqkLMmU1pm8c5zMQCjFvh1WnLoOvHBPYmFahDLCClkr40z/NFHTPwsi
 r2BhZHtE0h9Ae1+OcI2iCqDBA5C8DQsvw9HSLCLRwNokd4RIkNlNefIudWWdtqgwfelt
 VCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=XZACxZccAAi2TopI+c0OP5VJ17b3bi19ygcofM3uJGA=;
 b=Uh3NczRmDTRf3fDraxloxZoNTNng+HkyU34JCpUUkJLbG7UjT1tRUrXyVrwu/2/zfv
 mXi9YcHlYycphC7l9w0DuezCTprvskOYwN1QnAweZobjMrURKMOAaxvQoMM/Et4DhRr6
 mOQuqKxrptnLhMfgcN33biglQezKZ3dbi2LK/ujLseNrkz9X678gnGkEjDpGrHS+47Mv
 9n7nhIA/3PBN2/DAmzWkv0GtG74OvvNb3y6K8ktV/GymWQivO2O5dM6OAi+SaAcyX8OC
 bDQboA9ejpHmEXzDw+a+4Axh+JHYdJXIhILe+N/ulDt66CICzcBXZ5nvutvGd19qaxuH
 hWvQ==
X-Gm-Message-State: AOAM531hBqemI2AC/RyyH1J3v9i3Gj3n5AsGk57qDgKaJZaog7DgzdcH
 UYpQ+pddUkycR8o8j3R6aGk=
X-Google-Smtp-Source: ABdhPJwRdNIqEYeWvz2xgbQzZPCIbKgtd4BA5VEJR7pzvBgCrBmUq5KPA4N2iRX6pWlP/EU7yISMog==
X-Received: by 2002:a7b:cb4e:: with SMTP id v14mr122849wmj.54.1591028091100;
 Mon, 01 Jun 2020 09:14:51 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a6sm21309896wrn.38.2020.06.01.09.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 09:14:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 05/12] hw/timer: RX62N compare match timer (CMT)
Date: Mon,  1 Jun 2020 18:14:34 +0200
Message-Id: <20200601161441.8086-6-f4bug@amsat.org>
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
 hw/timer/Kconfig               |   3 +
 hw/timer/Makefile.objs         |   1 +
 4 files changed, 327 insertions(+)
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


