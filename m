Received: from eggs.gnu.org ([2001:4830:134:3::10]:32778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA42-0001HL-CP
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3s-0005oY-Dw
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:23 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:33121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA3p-0005h6-MN
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:18 -0400
Received: by mail-wm0-x22d.google.com with SMTP id i134-v6so10056636wmf.0
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:17 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:44 +0200
Message-Id: <1534870966-9287-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/74] hw/timer/mc146818rtc: White space clean-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

mc146818rtc.c still contains some TABs. Replace them with spaces.
And while we're at it, also delete trailing whitespace in this file.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1534419358-10932-4-git-send-email-thuth@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/mc146818rtc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 6f1f723..3a14075 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -120,7 +120,7 @@ static void rtc_coalesced_timer_update(RTCState *s)
         timer_del(s->coalesced_timer);
     } else {
         /* divide each RTC interval to 2 - 8 smaller intervals */
-        int c = MIN(s->irq_coalesced, 7) + 1; 
+        int c = MIN(s->irq_coalesced, 7) + 1;
         int64_t next_clock = qemu_clock_get_ns(rtc_clock) +
             periodic_clock_to_ns(s->period / c);
         timer_mod(s->coalesced_timer, next_clock);
@@ -485,7 +485,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
             s->cmos_data[s->cmos_index] = data;
             check_update_timer(s);
             break;
-	case RTC_IBM_PS2_CENTURY_BYTE:
+        case RTC_IBM_PS2_CENTURY_BYTE:
             s->cmos_index = RTC_CENTURY;
             /* fall through */
         case RTC_CENTURY:
@@ -713,7 +713,7 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
         return 0xff;
     } else {
         switch(s->cmos_index) {
-	case RTC_IBM_PS2_CENTURY_BYTE:
+        case RTC_IBM_PS2_CENTURY_BYTE:
             s->cmos_index = RTC_CENTURY;
             /* fall through */
         case RTC_CENTURY:
@@ -915,7 +915,7 @@ static void rtc_reset(void *opaque)
 
     if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
         s->irq_coalesced = 0;
-        s->irq_reinject_on_ack_count = 0;		
+        s->irq_reinject_on_ack_count = 0;
     }
 }
 
-- 
1.8.3.1
