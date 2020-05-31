Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32A8C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C711820723
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C711820723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfQmV-0005qS-0B
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1jfQlM-0004Df-B5
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:24:40 -0400
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:58737)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1jfQlK-0004Kb-1S
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:24:40 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail02.asahi-net.or.jp (Postfix) with ESMTPA id 45135EB8AA;
 Mon,  1 Jun 2020 01:24:35 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id E9CA21C05D2;
 Mon,  1 Jun 2020 01:24:34 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/10] hw/timer: remove sh_timer.c
Date: Mon,  1 Jun 2020 01:24:27 +0900
Message-Id: <20200531162427.57410-11-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200531162427.57410-1-ysato@users.sourceforge.jp>
References: <20200531162427.57410-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=202.224.55.14;
 envelope-from=ysato@users.sourceforge.jp; helo=mail02.asahi-net.or.jp
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:24:33
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_SOFTFAIL=0.665, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

SH4 TMU using new module. This file is obsolute.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 hw/timer/sh_timer.c | 341 --------------------------------------------
 1 file changed, 341 deletions(-)
 delete mode 100644 hw/timer/sh_timer.c

diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
deleted file mode 100644
index 13c4051808..0000000000
--- a/hw/timer/sh_timer.c
+++ /dev/null
@@ -1,341 +0,0 @@
-/*
- * SuperH Timer modules.
- *
- * Copyright (c) 2007 Magnus Damm
- * Based on arm_timer.c by Paul Brook
- * Copyright (c) 2005-2006 CodeSourcery.
- *
- * This code is licensed under the GPL.
- */
-
-#include "qemu/osdep.h"
-#include "hw/hw.h"
-#include "hw/irq.h"
-#include "hw/sh4/sh.h"
-#include "qemu/timer.h"
-#include "hw/ptimer.h"
-
-//#define DEBUG_TIMER
-
-#define TIMER_TCR_TPSC          (7 << 0)
-#define TIMER_TCR_CKEG          (3 << 3)
-#define TIMER_TCR_UNIE          (1 << 5)
-#define TIMER_TCR_ICPE          (3 << 6)
-#define TIMER_TCR_UNF           (1 << 8)
-#define TIMER_TCR_ICPF          (1 << 9)
-#define TIMER_TCR_RESERVED      (0x3f << 10)
-
-#define TIMER_FEAT_CAPT   (1 << 0)
-#define TIMER_FEAT_EXTCLK (1 << 1)
-
-#define OFFSET_TCOR   0
-#define OFFSET_TCNT   1
-#define OFFSET_TCR    2
-#define OFFSET_TCPR   3
-
-typedef struct {
-    ptimer_state *timer;
-    uint32_t tcnt;
-    uint32_t tcor;
-    uint32_t tcr;
-    uint32_t tcpr;
-    int freq;
-    int int_level;
-    int old_level;
-    int feat;
-    int enabled;
-    qemu_irq irq;
-} sh_timer_state;
-
-/* Check all active timers, and schedule the next timer interrupt. */
-
-static void sh_timer_update(sh_timer_state *s)
-{
-    int new_level = s->int_level && (s->tcr & TIMER_TCR_UNIE);
-
-    if (new_level != s->old_level)
-      qemu_set_irq (s->irq, new_level);
-
-    s->old_level = s->int_level;
-    s->int_level = new_level;
-}
-
-static uint32_t sh_timer_read(void *opaque, hwaddr offset)
-{
-    sh_timer_state *s = (sh_timer_state *)opaque;
-
-    switch (offset >> 2) {
-    case OFFSET_TCOR:
-        return s->tcor;
-    case OFFSET_TCNT:
-        return ptimer_get_count(s->timer);
-    case OFFSET_TCR:
-        return s->tcr | (s->int_level ? TIMER_TCR_UNF : 0);
-    case OFFSET_TCPR:
-        if (s->feat & TIMER_FEAT_CAPT)
-            return s->tcpr;
-        /* fall through */
-    default:
-        hw_error("sh_timer_read: Bad offset %x\n", (int)offset);
-        return 0;
-    }
-}
-
-static void sh_timer_write(void *opaque, hwaddr offset,
-                            uint32_t value)
-{
-    sh_timer_state *s = (sh_timer_state *)opaque;
-    int freq;
-
-    switch (offset >> 2) {
-    case OFFSET_TCOR:
-        s->tcor = value;
-        ptimer_transaction_begin(s->timer);
-        ptimer_set_limit(s->timer, s->tcor, 0);
-        ptimer_transaction_commit(s->timer);
-        break;
-    case OFFSET_TCNT:
-        s->tcnt = value;
-        ptimer_transaction_begin(s->timer);
-        ptimer_set_count(s->timer, s->tcnt);
-        ptimer_transaction_commit(s->timer);
-        break;
-    case OFFSET_TCR:
-        ptimer_transaction_begin(s->timer);
-        if (s->enabled) {
-            /* Pause the timer if it is running.  This may cause some
-               inaccuracy dure to rounding, but avoids a whole lot of other
-               messyness.  */
-            ptimer_stop(s->timer);
-        }
-        freq = s->freq;
-        /* ??? Need to recalculate expiry time after changing divisor.  */
-        switch (value & TIMER_TCR_TPSC) {
-        case 0: freq >>= 2; break;
-        case 1: freq >>= 4; break;
-        case 2: freq >>= 6; break;
-        case 3: freq >>= 8; break;
-        case 4: freq >>= 10; break;
-	case 6:
-	case 7: if (s->feat & TIMER_FEAT_EXTCLK) break;
-	default: hw_error("sh_timer_write: Reserved TPSC value\n"); break;
-        }
-        switch ((value & TIMER_TCR_CKEG) >> 3) {
-	case 0: break;
-        case 1:
-        case 2:
-        case 3: if (s->feat & TIMER_FEAT_EXTCLK) break;
-	default: hw_error("sh_timer_write: Reserved CKEG value\n"); break;
-        }
-        switch ((value & TIMER_TCR_ICPE) >> 6) {
-	case 0: break;
-        case 2:
-        case 3: if (s->feat & TIMER_FEAT_CAPT) break;
-	default: hw_error("sh_timer_write: Reserved ICPE value\n"); break;
-        }
-	if ((value & TIMER_TCR_UNF) == 0)
-            s->int_level = 0;
-
-	value &= ~TIMER_TCR_UNF;
-
-	if ((value & TIMER_TCR_ICPF) && (!(s->feat & TIMER_FEAT_CAPT)))
-            hw_error("sh_timer_write: Reserved ICPF value\n");
-
-	value &= ~TIMER_TCR_ICPF; /* capture not supported */
-
-	if (value & TIMER_TCR_RESERVED)
-            hw_error("sh_timer_write: Reserved TCR bits set\n");
-        s->tcr = value;
-        ptimer_set_limit(s->timer, s->tcor, 0);
-        ptimer_set_freq(s->timer, freq);
-        if (s->enabled) {
-            /* Restart the timer if still enabled.  */
-            ptimer_run(s->timer, 0);
-        }
-        ptimer_transaction_commit(s->timer);
-        break;
-    case OFFSET_TCPR:
-        if (s->feat & TIMER_FEAT_CAPT) {
-            s->tcpr = value;
-	    break;
-	}
-    default:
-        hw_error("sh_timer_write: Bad offset %x\n", (int)offset);
-    }
-    sh_timer_update(s);
-}
-
-static void sh_timer_start_stop(void *opaque, int enable)
-{
-    sh_timer_state *s = (sh_timer_state *)opaque;
-
-#ifdef DEBUG_TIMER
-    printf("sh_timer_start_stop %d (%d)\n", enable, s->enabled);
-#endif
-
-    ptimer_transaction_begin(s->timer);
-    if (s->enabled && !enable) {
-        ptimer_stop(s->timer);
-    }
-    if (!s->enabled && enable) {
-        ptimer_run(s->timer, 0);
-    }
-    ptimer_transaction_commit(s->timer);
-    s->enabled = !!enable;
-
-#ifdef DEBUG_TIMER
-    printf("sh_timer_start_stop done %d\n", s->enabled);
-#endif
-}
-
-static void sh_timer_tick(void *opaque)
-{
-    sh_timer_state *s = (sh_timer_state *)opaque;
-    s->int_level = s->enabled;
-    sh_timer_update(s);
-}
-
-static void *sh_timer_init(uint32_t freq, int feat, qemu_irq irq)
-{
-    sh_timer_state *s;
-
-    s = (sh_timer_state *)g_malloc0(sizeof(sh_timer_state));
-    s->freq = freq;
-    s->feat = feat;
-    s->tcor = 0xffffffff;
-    s->tcnt = 0xffffffff;
-    s->tcpr = 0xdeadbeef;
-    s->tcr = 0;
-    s->enabled = 0;
-    s->irq = irq;
-
-    s->timer = ptimer_init(sh_timer_tick, s, PTIMER_POLICY_DEFAULT);
-
-    sh_timer_write(s, OFFSET_TCOR >> 2, s->tcor);
-    sh_timer_write(s, OFFSET_TCNT >> 2, s->tcnt);
-    sh_timer_write(s, OFFSET_TCPR >> 2, s->tcpr);
-    sh_timer_write(s, OFFSET_TCR  >> 2, s->tcpr);
-    /* ??? Save/restore.  */
-    return s;
-}
-
-typedef struct {
-    MemoryRegion iomem;
-    MemoryRegion iomem_p4;
-    MemoryRegion iomem_a7;
-    void *timer[3];
-    int level[3];
-    uint32_t tocr;
-    uint32_t tstr;
-    int feat;
-} tmu012_state;
-
-static uint64_t tmu012_read(void *opaque, hwaddr offset,
-                            unsigned size)
-{
-    tmu012_state *s = (tmu012_state *)opaque;
-
-#ifdef DEBUG_TIMER
-    printf("tmu012_read 0x%lx\n", (unsigned long) offset);
-#endif
-
-    if (offset >= 0x20) {
-        if (!(s->feat & TMU012_FEAT_3CHAN))
-	    hw_error("tmu012_write: Bad channel offset %x\n", (int)offset);
-        return sh_timer_read(s->timer[2], offset - 0x20);
-    }
-
-    if (offset >= 0x14)
-        return sh_timer_read(s->timer[1], offset - 0x14);
-
-    if (offset >= 0x08)
-        return sh_timer_read(s->timer[0], offset - 0x08);
-
-    if (offset == 4)
-        return s->tstr;
-
-    if ((s->feat & TMU012_FEAT_TOCR) && offset == 0)
-        return s->tocr;
-
-    hw_error("tmu012_write: Bad offset %x\n", (int)offset);
-    return 0;
-}
-
-static void tmu012_write(void *opaque, hwaddr offset,
-                        uint64_t value, unsigned size)
-{
-    tmu012_state *s = (tmu012_state *)opaque;
-
-#ifdef DEBUG_TIMER
-    printf("tmu012_write 0x%lx 0x%08x\n", (unsigned long) offset, value);
-#endif
-
-    if (offset >= 0x20) {
-        if (!(s->feat & TMU012_FEAT_3CHAN))
-	    hw_error("tmu012_write: Bad channel offset %x\n", (int)offset);
-        sh_timer_write(s->timer[2], offset - 0x20, value);
-	return;
-    }
-
-    if (offset >= 0x14) {
-        sh_timer_write(s->timer[1], offset - 0x14, value);
-	return;
-    }
-
-    if (offset >= 0x08) {
-        sh_timer_write(s->timer[0], offset - 0x08, value);
-	return;
-    }
-
-    if (offset == 4) {
-        sh_timer_start_stop(s->timer[0], value & (1 << 0));
-        sh_timer_start_stop(s->timer[1], value & (1 << 1));
-        if (s->feat & TMU012_FEAT_3CHAN)
-            sh_timer_start_stop(s->timer[2], value & (1 << 2));
-	else
-            if (value & (1 << 2))
-                hw_error("tmu012_write: Bad channel\n");
-
-	s->tstr = value;
-	return;
-    }
-
-    if ((s->feat & TMU012_FEAT_TOCR) && offset == 0) {
-        s->tocr = value & (1 << 0);
-    }
-}
-
-static const MemoryRegionOps tmu012_ops = {
-    .read = tmu012_read,
-    .write = tmu012_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-void tmu012_init(MemoryRegion *sysmem, hwaddr base,
-                 int feat, uint32_t freq,
-		 qemu_irq ch0_irq, qemu_irq ch1_irq,
-		 qemu_irq ch2_irq0, qemu_irq ch2_irq1)
-{
-    tmu012_state *s;
-    int timer_feat = (feat & TMU012_FEAT_EXTCLK) ? TIMER_FEAT_EXTCLK : 0;
-
-    s = (tmu012_state *)g_malloc0(sizeof(tmu012_state));
-    s->feat = feat;
-    s->timer[0] = sh_timer_init(freq, timer_feat, ch0_irq);
-    s->timer[1] = sh_timer_init(freq, timer_feat, ch1_irq);
-    if (feat & TMU012_FEAT_3CHAN)
-        s->timer[2] = sh_timer_init(freq, timer_feat | TIMER_FEAT_CAPT,
-				    ch2_irq0); /* ch2_irq1 not supported */
-
-    memory_region_init_io(&s->iomem, NULL, &tmu012_ops, s,
-                          "timer", 0x100000000ULL);
-
-    memory_region_init_alias(&s->iomem_p4, NULL, "timer-p4",
-                             &s->iomem, 0, 0x1000);
-    memory_region_add_subregion(sysmem, P4ADDR(base), &s->iomem_p4);
-
-    memory_region_init_alias(&s->iomem_a7, NULL, "timer-a7",
-                             &s->iomem, 0, 0x1000);
-    memory_region_add_subregion(sysmem, A7ADDR(base), &s->iomem_a7);
-    /* ??? Save/restore.  */
-}
-- 
2.20.1


