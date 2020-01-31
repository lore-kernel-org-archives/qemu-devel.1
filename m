Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC75C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 01:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4810720678
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 01:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XD3HxmxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4810720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixKpv-0000Oq-Cd
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 20:11:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixKou-0007vO-6T
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 20:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixKos-00077N-BN
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 20:10:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38703
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixKos-00072O-7i
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 20:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580432997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wAKgo7Pb5RXY3JeoxK8pKIRYXPT9L1pD79bpcBQT6do=;
 b=XD3HxmxAVo3SQZLoXjUkGQoRmOVzdNRO/frrS9vwYD47NozLDK1ayU0VOWAhOyDYleVESV
 N4aIoRF11RI1nM0tQrwsDuYgBInnSbnGAwhu7omfYjbJEPIAV3LQv+jS2P+EhZq1+FbAEX
 BaaamAEzK4dn5VsEtWAEeFZGeTcknsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-X3UfZ4b6McqnUKOeMJY1cQ-1; Thu, 30 Jan 2020 20:09:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DBF2182B8EB;
 Fri, 31 Jan 2020 01:09:54 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-34.brq.redhat.com [10.40.204.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 558725DA75;
 Fri, 31 Jan 2020 01:09:52 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] !fixup "hw/timer: Add limited support for AVR 16-bit
 timer peripheral"
Date: Fri, 31 Jan 2020 02:09:41 +0100
Message-Id: <20200131010941.10636-3-philmd@redhat.com>
In-Reply-To: <20200131010941.10636-1-philmd@redhat.com>
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <20200131010941.10636-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: X3UfZ4b6McqnUKOeMJY1cQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert DB_PRINT() to trace events.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/timer/avr_timer16.c | 25 +++++++++++++++----------
 hw/timer/trace-events  | 12 ++++++++++++
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
index 4e16afc61c..073f36aa76 100644
--- a/hw/timer/avr_timer16.c
+++ b/hw/timer/avr_timer16.c
@@ -36,6 +36,7 @@
 #include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "trace.h"
=20
 /* Register offsets */
 #define T16_CRA     0x0
@@ -104,7 +105,6 @@
 /* Helper macros */
 #define VAL16(l, h) ((h << 8) | l)
 #define DB_PRINT(fmt, args...) /* Nothing */
-/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n", __func__, ## args=
)*/
=20
 static inline int64_t avr_timer16_ns_to_ticks(AVRTimer16State *t16, int64_=
t t)
 {
@@ -168,8 +168,8 @@ static void avr_timer16_clksrc_update(AVRTimer16State *=
t16)
     if (divider) {
         t16->freq_hz =3D t16->cpu_freq_hz / divider;
         t16->period_ns =3D NANOSECONDS_PER_SECOND / t16->freq_hz;
-        DB_PRINT("Timer frequency %" PRIu64 " hz, period %" PRIu64 " ns (%=
f s)",
-                 t16->freq_hz, t16->period_ns, 1 / (double)t16->freq_hz);
+        trace_avr_timer16_clksrc_update(t16->freq_hz, t16->period_ns,
+                                        (uint64_t)(1e6 / t16->freq_hz));
     }
 }
=20
@@ -235,8 +235,7 @@ static void avr_timer16_set_alarm(AVRTimer16State *t16)
         t16->reset_time_ns + ((CNT(t16) + alarm_offset) * t16->period_ns);
     timer_mod(t16->timer, alarm_ns);
=20
-    DB_PRINT("next alarm %" PRIu64 " ns from now",
-        alarm_offset * t16->period_ns);
+    trace_avr_timer16_next_alarm(alarm_offset * t16->period_ns);
 }
=20
 static void avr_timer16_interrupt(void *opaque)
@@ -253,11 +252,11 @@ static void avr_timer16_interrupt(void *opaque)
         return;
     }
=20
-    DB_PRINT("interrupt, cnt =3D %d", CNT(t16));
+    trace_avr_timer16_interrupt_count(CNT(t16));
=20
     /* Counter overflow */
     if (t16->next_interrupt =3D=3D OVERFLOW) {
-        DB_PRINT("0xffff overflow");
+        trace_avr_timer16_interrupt_overflow("counter 0xffff");
         avr_timer16_clock_reset(t16);
         if (t16->imsk & T16_INT_TOV) {
             t16->ifr |=3D T16_INT_TOV;
@@ -266,12 +265,12 @@ static void avr_timer16_interrupt(void *opaque)
     }
     /* Check for ocra overflow in CTC mode */
     if (mode =3D=3D T16_MODE_CTC_OCRA && t16->next_interrupt =3D=3D COMPA)=
 {
-        DB_PRINT("CTC OCRA overflow");
+        trace_avr_timer16_interrupt_overflow("CTC OCRA");
         avr_timer16_clock_reset(t16);
     }
     /* Check for icr overflow in CTC mode */
     if (mode =3D=3D T16_MODE_CTC_ICR && t16->next_interrupt =3D=3D CAPT) {
-        DB_PRINT("CTC ICR overflow");
+        trace_avr_timer16_interrupt_overflow("CTC ICR");
         avr_timer16_clock_reset(t16);
         if (t16->imsk & T16_INT_IC) {
             t16->ifr |=3D T16_INT_IC;
@@ -367,6 +366,8 @@ static uint64_t avr_timer16_read(void *opaque, hwaddr o=
ffset, unsigned size)
     default:
         break;
     }
+    trace_avr_timer16_read(offset, retval);
+
     return (uint64_t)retval;
 }
=20
@@ -378,7 +379,7 @@ static void avr_timer16_write(void *opaque, hwaddr offs=
et,
     uint8_t val8 =3D (uint8_t)val64;
     uint8_t prev_clk_src =3D CLKSRC(t16);
=20
-    DB_PRINT("write %d to offset %d", val8, (uint8_t)offset);
+    trace_avr_timer16_write(offset, val8);
=20
     switch (offset) {
     case T16_CRA:
@@ -475,6 +476,7 @@ static uint64_t avr_timer16_imsk_read(void *opaque,
 {
     assert(size =3D=3D 1);
     AVRTimer16State *t16 =3D opaque;
+    trace_avr_timer16_read_imsk(offset ? 0 : t16->imsk);
     if (offset !=3D 0) {
         return 0;
     }
@@ -486,6 +488,7 @@ static void avr_timer16_imsk_write(void *opaque, hwaddr=
 offset,
 {
     assert(size =3D=3D 1);
     AVRTimer16State *t16 =3D opaque;
+    trace_avr_timer16_write_imsk(val64);
     if (offset !=3D 0) {
         return;
     }
@@ -498,6 +501,7 @@ static uint64_t avr_timer16_ifr_read(void *opaque,
 {
     assert(size =3D=3D 1);
     AVRTimer16State *t16 =3D opaque;
+    trace_avr_timer16_read_ifr(offset ? 0 : t16->ifr);
     if (offset !=3D 0) {
         return 0;
     }
@@ -509,6 +513,7 @@ static void avr_timer16_ifr_write(void *opaque, hwaddr =
offset,
 {
     assert(size =3D=3D 1);
     AVRTimer16State *t16 =3D opaque;
+    trace_avr_timer16_write_imsk(val64);
     if (offset !=3D 0) {
         return;
     }
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 29fda7870e..5d9f4c93fb 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -74,3 +74,15 @@ nrf51_timer_write(uint64_t addr, uint32_t value, unsigne=
d size) "write addr 0x%"
 bcm2835_systmr_irq(bool enable) "timer irq state %u"
 bcm2835_systmr_read(uint64_t offset, uint64_t data) "timer read: offset 0x=
%" PRIx64 " data 0x%" PRIx64
 bcm2835_systmr_write(uint64_t offset, uint64_t data) "timer write: offset =
0x%" PRIx64 " data 0x%" PRIx64
+
+# avr_timer16.c
+avr_timer16_read(uint8_t addr, uint8_t value) "timer16 read addr:%u value:=
%u"
+avr_timer16_read_ifr(uint8_t value) "timer16 read addr:ifr value:%u"
+avr_timer16_read_imsk(uint8_t value) "timer16 read addr:imsk value:%u"
+avr_timer16_write(uint8_t addr, uint8_t value) "timer16 write addr:%u valu=
e:%u"
+avr_timer16_write_ifr(uint8_t value) "timer16 write addr:ifr value:%u"
+avr_timer16_write_imsk(uint8_t value) "timer16 write addr:imsk value:%u"
+avr_timer16_interrupt_count(uint8_t cnt) "count: %u"
+avr_timer16_interrupt_overflow(const char *reason) "overflow: %s"
+avr_timer16_next_alarm(uint64_t delay_ns) "next alarm: %" PRIu64 " ns from=
 now"
+avr_timer16_clksrc_update(uint64_t freq_hz, uint64_t period_ns, uint64_t d=
elay_s) "timer frequency: %" PRIu64 " Hz, period: %" PRIu64 " ns (%" PRId64=
 " us)"
--=20
2.21.1


