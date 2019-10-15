Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A682AC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6AC2086A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6AC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKPm3-00068r-2p
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 12:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKPfo-000057-DF
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKPfn-0004Hj-2n
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:27:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55382)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKPfm-0004HS-Qm
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:27:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D8FE52A09AA;
 Tue, 15 Oct 2019 16:27:45 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-35.brq.redhat.com [10.40.204.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACF8119C69;
 Tue, 15 Oct 2019 16:27:39 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/32] mc146818rtc: move structure to header file
Date: Tue, 15 Oct 2019 18:26:36 +0200
Message-Id: <20191015162705.28087-4-philmd@redhat.com>
In-Reply-To: <20191015162705.28087-1-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 15 Oct 2019 16:27:46 +0000 (UTC)
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
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

We are now able to embed a timer in another object.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Message-Id: <20171216090228.28505-4-hpoussin@reactos.org>
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


