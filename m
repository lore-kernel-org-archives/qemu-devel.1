Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405A3CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185FB222C5
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185FB222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSRW-0008EB-T4
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLSQG-00073i-Sl
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLSQF-0007X7-8N
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:36:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53420)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLSQE-0007WZ-71
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:36:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56B2C30789A0;
 Fri, 18 Oct 2019 13:36:01 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DEA93CC8;
 Fri, 18 Oct 2019 13:35:58 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] mc146818rtc: move structure to header file
Date: Fri, 18 Oct 2019 15:35:44 +0200
Message-Id: <20191018133547.10936-2-philmd@redhat.com>
In-Reply-To: <20191018133547.10936-1-philmd@redhat.com>
References: <20191018133547.10936-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 18 Oct 2019 13:36:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

We are now able to embed a timer in another object.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Message-Id: <20171216090228.28505-4-hpoussin@reactos.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/timer/mc146818rtc.c         | 30 ------------------------------
 include/hw/timer/mc146818rtc.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 6cb378751b..e40b54e743 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -71,36 +71,6 @@
 #define RTC_CLOCK_RATE            32768
 #define UIP_HOLD_LENGTH           (8 * NANOSECONDS_PER_SECOND / 32768)
=20
-#define MC146818_RTC(obj) OBJECT_CHECK(RTCState, (obj), TYPE_MC146818_RT=
C)
-
-typedef struct RTCState {
-    ISADevice parent_obj;
-
-    MemoryRegion io;
-    MemoryRegion coalesced_io;
-    uint8_t cmos_data[128];
-    uint8_t cmos_index;
-    int32_t base_year;
-    uint64_t base_rtc;
-    uint64_t last_update;
-    int64_t offset;
-    qemu_irq irq;
-    int it_shift;
-    /* periodic timer */
-    QEMUTimer *periodic_timer;
-    int64_t next_periodic_time;
-    /* update-ended timer */
-    QEMUTimer *update_timer;
-    uint64_t next_alarm_time;
-    uint16_t irq_reinject_on_ack_count;
-    uint32_t irq_coalesced;
-    uint32_t period;
-    QEMUTimer *coalesced_timer;
-    LostTickPolicy lost_tick_policy;
-    Notifier suspend_notifier;
-    QLIST_ENTRY(RTCState) link;
-} RTCState;
-
 static void rtc_set_time(RTCState *s);
 static void rtc_update_time(RTCState *s);
 static void rtc_set_cmos(RTCState *s, const struct tm *tm);
diff --git a/include/hw/timer/mc146818rtc.h b/include/hw/timer/mc146818rt=
c.h
index fe6ed63f71..0f1c886e5b 100644
--- a/include/hw/timer/mc146818rtc.h
+++ b/include/hw/timer/mc146818rtc.h
@@ -1,10 +1,43 @@
 #ifndef MC146818RTC_H
 #define MC146818RTC_H
=20
+#include "qapi/qapi-types-misc.h"
+#include "qemu/queue.h"
+#include "qemu/timer.h"
 #include "hw/isa/isa.h"
 #include "hw/timer/mc146818rtc_regs.h"
=20
 #define TYPE_MC146818_RTC "mc146818rtc"
+#define MC146818_RTC(obj) OBJECT_CHECK(RTCState, (obj), TYPE_MC146818_RT=
C)
+
+typedef struct RTCState {
+    ISADevice parent_obj;
+
+    MemoryRegion io;
+    MemoryRegion coalesced_io;
+    uint8_t cmos_data[128];
+    uint8_t cmos_index;
+    int32_t base_year;
+    uint64_t base_rtc;
+    uint64_t last_update;
+    int64_t offset;
+    qemu_irq irq;
+    int it_shift;
+    /* periodic timer */
+    QEMUTimer *periodic_timer;
+    int64_t next_periodic_time;
+    /* update-ended timer */
+    QEMUTimer *update_timer;
+    uint64_t next_alarm_time;
+    uint16_t irq_reinject_on_ack_count;
+    uint32_t irq_coalesced;
+    uint32_t period;
+    QEMUTimer *coalesced_timer;
+    Notifier clock_reset_notifier;
+    LostTickPolicy lost_tick_policy;
+    Notifier suspend_notifier;
+    QLIST_ENTRY(RTCState) link;
+} RTCState;
=20
 ISADevice *mc146818_rtc_init(ISABus *bus, int base_year,
                              qemu_irq intercept_irq);
--=20
2.21.0


