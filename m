Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1C9CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 15:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1958421726
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 15:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1958421726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQvhx-0003iL-CF
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 11:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iQvef-0002ok-72
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 11:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iQved-0008Tc-Iu
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 11:49:33 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:44717)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iQved-0008Hu-4S; Sat, 02 Nov 2019 11:49:31 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M6EOc-1iKM5E4BbM-006bzy; Sat, 02 Nov 2019 16:49:25 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] mos6522: fix T1 and T2 timers
Date: Sat,  2 Nov 2019 16:49:19 +0100
Message-Id: <20191102154919.17775-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lxPM1oApDQFPqGw5T6navl7R8aE6FWEAe0k7kAIw7NMIqKdDgAw
 a+9Fy5nbTCniFYDT92tt1kDs8PgdaLauCypZh0s3a9aKFnpvtfTbuWB9THYs02ikgHgKK4w
 gP/p4ZlOdxEU1MTi82NMmdJGj0+Z50+9BHAWEak1qg/xhcziO2OjsrZyWvHq5z8Eg2cW6g7
 eE55gaaTf5lRmjL3z1Y3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CI6paQRWPNg=:DyxWbefO8UQmHSJfTUzUFX
 rHkG+X2mjQbyLRy3CQuK0nW5O4C8s53DHKvfXGqXxxsPT4iIhrXLEbMtkwTX3b/OSlUdv6Pn1
 F7t9+7hnyN8HwX03DxiTXuY5+AZgrTUeitaaXAxYqmjqnPxmFZ1csGhqmCwQOqNYW2wFN1vWb
 mk/h4zNc+X+Vk4ziALah/KnjrDnGRvnwa/TEYwcIKFC734OSqrqLraAy4DvfgVGB+Q8UGV7pa
 zH/opLPAg+jzNEhgKOybi8wv7m3BRfopxcguyMn6PViQv3RvtZmCU11M8WJ4BKuM8hlwgIKSF
 MNldFXZo03Lk5dOsQD3NA4q2uug23SHXa5CoABezBogVf+Ei+IwsAcwNhabDzBiOg18O/0CjQ
 2RHpPw3t14vNAIO6+viwGyZP4rKEd0JAJg97j8lg4IAUs7X/GsU9SjuQoQrR8CugJrePB8APi
 XeNatJ6O+rX3lIg2lm9xaYZIRVCgNVP4Dl9bL+wIJPHEguyHWHBQJsqyaIsZruGFKdr96Iyk8
 J2wi7CQcasMdtqsB+xBpabbC3HfVfrTTmpwdPJ1jEpXlu1HKgn4PQytpA9y3tUQMsxuMVppRj
 hWHStg8/endyfy045hsayiEk4HzLdO1ZwPZIke9C7a2eohP7wuxR2VRMp7CKcT2UZulqTCiGn
 0R8h1SDjGCvHJdcTd6IailoJlW6Cw//FyNKtoFcIiQ+vqiBoqNAHnKudFlhDqrsWMERDtXEU7
 4psF/IkVhRVdRmyamUAfds1zFQdz8aumHXfVizasG11F3AJDsnnuxjjKiJXuTuiu+3N80cRRW
 syJi02eNkB4Clm7qOwJKwcoTjxCWj4pj9HQrS5Xc7ay1btzJyR4mzYSy98cYylJ2x+f82/L5G
 5egpbUJzwRljpztaFQ4A==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.75
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the Quadra 800 emulation, mos6522 timers processing can consume
until 70% of the host CPU time with an idle guest (I guess the problem
should also happen with PowerMac emulation).

On a recent system, it can be painless (except if you look at top), but
on an old host like a PowerMac G5 the guest kernel can be terribly slow
during the boot sequence (for instance, unpacking initramfs can take 15
seconds rather than only 3 seconds).

We can avoid this CPU overload by enabling QEMU internal timers only if
the mos6522 counter interrupts are enabled. Sometime the guest kernel
wants to read the counters values, but we don't need the timers to
update the counters.

With this patch applied, an idle Q800 consumes only 3% of host CPU time
(and the guest can boot in a decent time).

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/mos6522.c | 67 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 15 deletions(-)

diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 57f13db266..aa3bfe1afd 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -38,8 +38,10 @@
 
 /* XXX: implement all timer modes */
 
-static void mos6522_timer_update(MOS6522State *s, MOS6522Timer *ti,
-                                 int64_t current_time);
+static void mos6522_timer1_update(MOS6522State *s, MOS6522Timer *ti,
+                                  int64_t current_time);
+static void mos6522_timer2_update(MOS6522State *s, MOS6522Timer *ti,
+                                  int64_t current_time);
 
 static void mos6522_update_irq(MOS6522State *s)
 {
@@ -98,7 +100,11 @@ static void set_counter(MOS6522State *s, MOS6522Timer *ti, unsigned int val)
     trace_mos6522_set_counter(1 + ti->index, val);
     ti->load_time = get_load_time(s, ti);
     ti->counter_value = val;
-    mos6522_timer_update(s, ti, ti->load_time);
+    if (ti->index == 0) {
+        mos6522_timer1_update(s, ti, ti->load_time);
+    } else {
+        mos6522_timer2_update(s, ti, ti->load_time);
+    }
 }
 
 static int64_t get_next_irq_time(MOS6522State *s, MOS6522Timer *ti,
@@ -130,19 +136,34 @@ static int64_t get_next_irq_time(MOS6522State *s, MOS6522Timer *ti,
     trace_mos6522_get_next_irq_time(ti->latch, d, next_time - d);
     next_time = muldiv64(next_time, NANOSECONDS_PER_SECOND, ti->frequency) +
                          ti->load_time;
+
     if (next_time <= current_time) {
         next_time = current_time + 1;
     }
     return next_time;
 }
 
-static void mos6522_timer_update(MOS6522State *s, MOS6522Timer *ti,
+static void mos6522_timer1_update(MOS6522State *s, MOS6522Timer *ti,
+                                 int64_t current_time)
+{
+    if (!ti->timer) {
+        return;
+    }
+    if ((s->ier & T1_INT) == 0 || (s->acr & T1MODE) != T1MODE_CONT) {
+        timer_del(ti->timer);
+    } else {
+        ti->next_irq_time = get_next_irq_time(s, ti, current_time);
+        timer_mod(ti->timer, ti->next_irq_time);
+    }
+}
+
+static void mos6522_timer2_update(MOS6522State *s, MOS6522Timer *ti,
                                  int64_t current_time)
 {
     if (!ti->timer) {
         return;
     }
-    if (ti->index == 0 && (s->acr & T1MODE) != T1MODE_CONT) {
+    if ((s->ier & T2_INT) == 0) {
         timer_del(ti->timer);
     } else {
         ti->next_irq_time = get_next_irq_time(s, ti, current_time);
@@ -155,7 +176,7 @@ static void mos6522_timer1(void *opaque)
     MOS6522State *s = opaque;
     MOS6522Timer *ti = &s->timers[0];
 
-    mos6522_timer_update(s, ti, ti->next_irq_time);
+    mos6522_timer1_update(s, ti, ti->next_irq_time);
     s->ifr |= T1_INT;
     mos6522_update_irq(s);
 }
@@ -165,7 +186,7 @@ static void mos6522_timer2(void *opaque)
     MOS6522State *s = opaque;
     MOS6522Timer *ti = &s->timers[1];
 
-    mos6522_timer_update(s, ti, ti->next_irq_time);
+    mos6522_timer2_update(s, ti, ti->next_irq_time);
     s->ifr |= T2_INT;
     mos6522_update_irq(s);
 }
@@ -204,7 +225,16 @@ uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size)
 {
     MOS6522State *s = opaque;
     uint32_t val;
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
+    if (now >= s->timers[0].next_irq_time) {
+        mos6522_timer1_update(s, &s->timers[0], now);
+        s->ifr |= T1_INT;
+    }
+    if (now >= s->timers[1].next_irq_time) {
+        mos6522_timer2_update(s, &s->timers[1], now);
+        s->ifr |= T2_INT;
+    }
     switch (addr) {
     case VIA_REG_B:
         val = s->b;
@@ -299,8 +329,8 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
         break;
     case VIA_REG_T1CL:
         s->timers[0].latch = (s->timers[0].latch & 0xff00) | val;
-        mos6522_timer_update(s, &s->timers[0],
-                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+        mos6522_timer1_update(s, &s->timers[0],
+                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         break;
     case VIA_REG_T1CH:
         s->timers[0].latch = (s->timers[0].latch & 0xff) | (val << 8);
@@ -309,14 +339,14 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
         break;
     case VIA_REG_T1LL:
         s->timers[0].latch = (s->timers[0].latch & 0xff00) | val;
-        mos6522_timer_update(s, &s->timers[0],
-                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+        mos6522_timer1_update(s, &s->timers[0],
+                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         break;
     case VIA_REG_T1LH:
         s->timers[0].latch = (s->timers[0].latch & 0xff) | (val << 8);
         s->ifr &= ~T1_INT;
-        mos6522_timer_update(s, &s->timers[0],
-                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+        mos6522_timer1_update(s, &s->timers[0],
+                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         break;
     case VIA_REG_T2CL:
         s->timers[1].latch = (s->timers[1].latch & 0xff00) | val;
@@ -334,8 +364,8 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
         break;
     case VIA_REG_ACR:
         s->acr = val;
-        mos6522_timer_update(s, &s->timers[0],
-                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+        mos6522_timer1_update(s, &s->timers[0],
+                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         break;
     case VIA_REG_PCR:
         s->pcr = val;
@@ -354,6 +384,11 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
             s->ier &= ~val;
         }
         mos6522_update_irq(s);
+        /* if IER is modified starts needed timers */
+        mos6522_timer1_update(s, &s->timers[0],
+                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+        mos6522_timer2_update(s, &s->timers[1],
+                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         break;
     default:
     case VIA_REG_ANH:
@@ -426,9 +461,11 @@ static void mos6522_reset(DeviceState *dev)
     s->timers[0].frequency = s->frequency;
     s->timers[0].latch = 0xffff;
     set_counter(s, &s->timers[0], 0xffff);
+    timer_del(s->timers[0].timer);
 
     s->timers[1].frequency = s->frequency;
     s->timers[1].latch = 0xffff;
+    timer_del(s->timers[1].timer);
 }
 
 static void mos6522_init(Object *obj)
-- 
2.21.0


