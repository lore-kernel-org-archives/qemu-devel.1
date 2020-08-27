Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB936C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FB322B40
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FB322B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHDT-0004Y6-RE
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1kBHBR-0007xb-BS
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:13 -0400
Received: from mail01.asahi-net.or.jp ([202.224.55.13]:47886)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1kBHBO-0005vG-17
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:13 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail01.asahi-net.or.jp (Postfix) with ESMTPA id 4C9D3108673;
 Thu, 27 Aug 2020 21:39:07 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id F34F41C0792;
 Thu, 27 Aug 2020 21:39:06 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/20] hw/timer: Remove renesas_cmt.
Date: Thu, 27 Aug 2020 21:38:48 +0900
Message-Id: <20200827123859.81793-10-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827123859.81793-1-ysato@users.sourceforge.jp>
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=202.224.55.13;
 envelope-from=ysato@users.sourceforge.jp; helo=mail01.asahi-net.or.jp
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 08:39:06
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This module replaced to unified renesas_timer.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/hw/timer/renesas_cmt.h |  40 -----
 hw/timer/renesas_cmt.c         | 283 ---------------------------------
 2 files changed, 323 deletions(-)
 delete mode 100644 include/hw/timer/renesas_cmt.h
 delete mode 100644 hw/timer/renesas_cmt.c

diff --git a/include/hw/timer/renesas_cmt.h b/include/hw/timer/renesas_cmt.h
deleted file mode 100644
index e28a15cb38..0000000000
--- a/include/hw/timer/renesas_cmt.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * Renesas Compare-match timer Object
- *
- * Copyright (c) 2019 Yoshinori Sato
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef HW_TIMER_RENESAS_CMT_H
-#define HW_TIMER_RENESAS_CMT_H
-
-#include "qemu/timer.h"
-#include "hw/sysbus.h"
-
-#define TYPE_RENESAS_CMT "renesas-cmt"
-#define RCMT(obj) OBJECT_CHECK(RCMTState, (obj), TYPE_RENESAS_CMT)
-
-enum {
-    CMT_CH = 2,
-    CMT_NR_IRQ = 1 * CMT_CH
-};
-
-typedef struct RCMTState {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-
-    uint64_t input_freq;
-    MemoryRegion memory;
-
-    uint16_t cmstr;
-    uint16_t cmcr[CMT_CH];
-    uint16_t cmcnt[CMT_CH];
-    uint16_t cmcor[CMT_CH];
-    int64_t tick[CMT_CH];
-    qemu_irq cmi[CMT_CH];
-    QEMUTimer timer[CMT_CH];
-} RCMTState;
-
-#endif
diff --git a/hw/timer/renesas_cmt.c b/hw/timer/renesas_cmt.c
deleted file mode 100644
index 2e0fd21a36..0000000000
--- a/hw/timer/renesas_cmt.c
+++ /dev/null
@@ -1,283 +0,0 @@
-/*
- * Renesas 16bit Compare-match timer
- *
- * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
- *            (Rev.1.40 R01UH0033EJ0140)
- *
- * Copyright (c) 2019 Yoshinori Sato
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2 or later, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/log.h"
-#include "hw/irq.h"
-#include "hw/registerfields.h"
-#include "hw/qdev-properties.h"
-#include "hw/timer/renesas_cmt.h"
-#include "migration/vmstate.h"
-
-/*
- *  +0 CMSTR - common control
- *  +2 CMCR  - ch0
- *  +4 CMCNT - ch0
- *  +6 CMCOR - ch0
- *  +8 CMCR  - ch1
- * +10 CMCNT - ch1
- * +12 CMCOR - ch1
- * If we think that the address of CH 0 has an offset of +2,
- * we can treat it with the same address as CH 1, so define it like that.
- */
-REG16(CMSTR, 0)
-  FIELD(CMSTR, STR0, 0, 1)
-  FIELD(CMSTR, STR1, 1, 1)
-  FIELD(CMSTR, STR,  0, 2)
-/* This addeess is channel offset */
-REG16(CMCR, 0)
-  FIELD(CMCR, CKS,  0, 2)
-  FIELD(CMCR, CMIE, 6, 1)
-REG16(CMCNT, 2)
-REG16(CMCOR, 4)
-
-static void update_events(RCMTState *cmt, int ch)
-{
-    int64_t next_time;
-
-    if ((cmt->cmstr & (1 << ch)) == 0) {
-        /* count disable, so not happened next event. */
-        return ;
-    }
-    next_time = cmt->cmcor[ch] - cmt->cmcnt[ch];
-    next_time *= NANOSECONDS_PER_SECOND;
-    next_time /= cmt->input_freq;
-    /*
-     * CKS -> div rate
-     *  0 -> 8 (1 << 3)
-     *  1 -> 32 (1 << 5)
-     *  2 -> 128 (1 << 7)
-     *  3 -> 512 (1 << 9)
-     */
-    next_time *= 1 << (3 + FIELD_EX16(cmt->cmcr[ch], CMCR, CKS) * 2);
-    next_time += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    timer_mod(&cmt->timer[ch], next_time);
-}
-
-static int64_t read_cmcnt(RCMTState *cmt, int ch)
-{
-    int64_t delta, now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-
-    if (cmt->cmstr & (1 << ch)) {
-        delta = (now - cmt->tick[ch]);
-        delta /= NANOSECONDS_PER_SECOND;
-        delta /= cmt->input_freq;
-        delta /= 1 << (3 + FIELD_EX16(cmt->cmcr[ch], CMCR, CKS) * 2);
-        cmt->tick[ch] = now;
-        return cmt->cmcnt[ch] + delta;
-    } else {
-        return cmt->cmcnt[ch];
-    }
-}
-
-static uint64_t cmt_read(void *opaque, hwaddr offset, unsigned size)
-{
-    RCMTState *cmt = opaque;
-    int ch = offset / 0x08;
-    uint64_t ret;
-
-    if (offset == A_CMSTR) {
-        ret = 0;
-        ret = FIELD_DP16(ret, CMSTR, STR,
-                         FIELD_EX16(cmt->cmstr, CMSTR, STR));
-        return ret;
-    } else {
-        offset &= 0x07;
-        if (ch == 0) {
-            offset -= 0x02;
-        }
-        switch (offset) {
-        case A_CMCR:
-            ret = 0;
-            ret = FIELD_DP16(ret, CMCR, CKS,
-                             FIELD_EX16(cmt->cmstr, CMCR, CKS));
-            ret = FIELD_DP16(ret, CMCR, CMIE,
-                             FIELD_EX16(cmt->cmstr, CMCR, CMIE));
-            return ret;
-        case A_CMCNT:
-            return read_cmcnt(cmt, ch);
-        case A_CMCOR:
-            return cmt->cmcor[ch];
-        }
-    }
-    qemu_log_mask(LOG_UNIMP, "renesas_cmt: Register 0x%" HWADDR_PRIX " "
-                             "not implemented\n",
-                  offset);
-    return UINT64_MAX;
-}
-
-static void start_stop(RCMTState *cmt, int ch, int st)
-{
-    if (st) {
-        update_events(cmt, ch);
-    } else {
-        timer_del(&cmt->timer[ch]);
-    }
-}
-
-static void cmt_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
-{
-    RCMTState *cmt = opaque;
-    int ch = offset / 0x08;
-
-    if (offset == A_CMSTR) {
-        cmt->cmstr = FIELD_EX16(val, CMSTR, STR);
-        start_stop(cmt, 0, FIELD_EX16(cmt->cmstr, CMSTR, STR0));
-        start_stop(cmt, 1, FIELD_EX16(cmt->cmstr, CMSTR, STR1));
-    } else {
-        offset &= 0x07;
-        if (ch == 0) {
-            offset -= 0x02;
-        }
-        switch (offset) {
-        case A_CMCR:
-            cmt->cmcr[ch] = FIELD_DP16(cmt->cmcr[ch], CMCR, CKS,
-                                       FIELD_EX16(val, CMCR, CKS));
-            cmt->cmcr[ch] = FIELD_DP16(cmt->cmcr[ch], CMCR, CMIE,
-                                       FIELD_EX16(val, CMCR, CMIE));
-            break;
-        case 2:
-            cmt->cmcnt[ch] = val;
-            break;
-        case 4:
-            cmt->cmcor[ch] = val;
-            break;
-        default:
-            qemu_log_mask(LOG_UNIMP, "renesas_cmt: Register 0x%" HWADDR_PRIX " "
-                                     "not implemented\n",
-                          offset);
-            return;
-        }
-        if (FIELD_EX16(cmt->cmstr, CMSTR, STR) & (1 << ch)) {
-            update_events(cmt, ch);
-        }
-    }
-}
-
-static const MemoryRegionOps cmt_ops = {
-    .write = cmt_write,
-    .read  = cmt_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .impl = {
-        .min_access_size = 2,
-        .max_access_size = 2,
-    },
-    .valid = {
-        .min_access_size = 2,
-        .max_access_size = 2,
-    },
-};
-
-static void timer_events(RCMTState *cmt, int ch)
-{
-    cmt->cmcnt[ch] = 0;
-    cmt->tick[ch] = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    update_events(cmt, ch);
-    if (FIELD_EX16(cmt->cmcr[ch], CMCR, CMIE)) {
-        qemu_irq_pulse(cmt->cmi[ch]);
-    }
-}
-
-static void timer_event0(void *opaque)
-{
-    RCMTState *cmt = opaque;
-
-    timer_events(cmt, 0);
-}
-
-static void timer_event1(void *opaque)
-{
-    RCMTState *cmt = opaque;
-
-    timer_events(cmt, 1);
-}
-
-static void rcmt_reset(DeviceState *dev)
-{
-    RCMTState *cmt = RCMT(dev);
-    cmt->cmstr = 0;
-    cmt->cmcr[0] = cmt->cmcr[1] = 0;
-    cmt->cmcnt[0] = cmt->cmcnt[1] = 0;
-    cmt->cmcor[0] = cmt->cmcor[1] = 0xffff;
-}
-
-static void rcmt_init(Object *obj)
-{
-    SysBusDevice *d = SYS_BUS_DEVICE(obj);
-    RCMTState *cmt = RCMT(obj);
-    int i;
-
-    memory_region_init_io(&cmt->memory, OBJECT(cmt), &cmt_ops,
-                          cmt, "renesas-cmt", 0x10);
-    sysbus_init_mmio(d, &cmt->memory);
-
-    for (i = 0; i < ARRAY_SIZE(cmt->cmi); i++) {
-        sysbus_init_irq(d, &cmt->cmi[i]);
-    }
-    timer_init_ns(&cmt->timer[0], QEMU_CLOCK_VIRTUAL, timer_event0, cmt);
-    timer_init_ns(&cmt->timer[1], QEMU_CLOCK_VIRTUAL, timer_event1, cmt);
-}
-
-static const VMStateDescription vmstate_rcmt = {
-    .name = "rx-cmt",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
-        VMSTATE_UINT16(cmstr, RCMTState),
-        VMSTATE_UINT16_ARRAY(cmcr, RCMTState, CMT_CH),
-        VMSTATE_UINT16_ARRAY(cmcnt, RCMTState, CMT_CH),
-        VMSTATE_UINT16_ARRAY(cmcor, RCMTState, CMT_CH),
-        VMSTATE_INT64_ARRAY(tick, RCMTState, CMT_CH),
-        VMSTATE_TIMER_ARRAY(timer, RCMTState, CMT_CH),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static Property rcmt_properties[] = {
-    DEFINE_PROP_UINT64("input-freq", RCMTState, input_freq, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void rcmt_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->vmsd = &vmstate_rcmt;
-    dc->reset = rcmt_reset;
-    device_class_set_props(dc, rcmt_properties);
-}
-
-static const TypeInfo rcmt_info = {
-    .name = TYPE_RENESAS_CMT,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(RCMTState),
-    .instance_init = rcmt_init,
-    .class_init = rcmt_class_init,
-};
-
-static void rcmt_register_types(void)
-{
-    type_register_static(&rcmt_info);
-}
-
-type_init(rcmt_register_types)
-- 
2.20.1


