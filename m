Received: from eggs.gnu.org ([2001:4830:134:3::10]:49305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpabJ-0000o5-T7
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpabJ-0005Ip-5v
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42314 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fpabJ-0005Hz-1M
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:13 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 14 Aug 2018 16:46:55 +0200
Message-Id: <1534258018-22859-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1534258018-22859-1-git-send-email-thuth@redhat.com>
References: <1534258018-22859-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] hw/timer/mc146818rtc: White space clean-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

mc146818rtc.c still contains some TABs. Replace them with spaces.

Signed-off-by: Thomas Huth <thuth@redhat.com>
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
