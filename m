Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DEACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0483F2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWx9Hhlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0483F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdgi-0000oQ-64
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNcAc-00061H-PP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNcAa-0007NL-Jp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:24:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36121
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNcAa-0007Mw-G7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571919888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C8CTjgeOwG4HE5TRaGW+z86QAGyKyGnufEPpNzi2Qcw=;
 b=BWx9Hhlgi2NPcE15lt3LnDN6m35i7Lx2mYem8j4hQm68wEzwtLmiLMUUEERYpKiyvfiImU
 DaWH/7QDEBGVVPzghbtAW2wmf7C7v5xV0SxDDHrxZLhTPmK+VtZGuu3kybUNZXKyMCOpbO
 u1T7xxVxPDBE5Wgdoz6gbGdZL5TQnsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-tCeGcfvxMrCn67biWkezkg-1; Thu, 24 Oct 2019 08:24:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5736B107AD31;
 Thu, 24 Oct 2019 12:24:45 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-184.brq.redhat.com [10.40.204.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E5D760559;
 Thu, 24 Oct 2019 12:24:41 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] mc146818rtc: Tidy up indentation
Date: Thu, 24 Oct 2019 14:24:24 +0200
Message-Id: <20191024122425.2483-3-philmd@redhat.com>
In-Reply-To: <20191024122425.2483-1-philmd@redhat.com>
References: <20191024122425.2483-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: tCeGcfvxMrCn67biWkezkg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Xiao Guangrong <guangrong.xiao@gmail.com>,
 Vadim Rozenfeld <vrozenfe@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Re-indent, no functional change.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Patch easier to review with 'diff -b' (git show -b)
---
 hw/timer/mc146818rtc.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 2b6371faac..8da7fd1a50 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -209,22 +209,21 @@ periodic_timer_update(RTCState *s, int64_t current_ti=
me, uint32_t old_period)
         return;
     }
=20
-        /* compute 32 khz clock */
-        cur_clock =3D
-            muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND)=
;
+    /* compute 32 khz clock */
+    cur_clock =3D muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_S=
ECOND);
=20
-        /*
-        * if the periodic timer's update is due to period re-configuration=
,
-        * we should count the clock since last interrupt.
-        */
-        if (old_period) {
-            int64_t last_periodic_clock, next_periodic_clock;
+    /*
+     * if the periodic timer's update is due to period re-configuration,
+     * we should count the clock since last interrupt.
+     */
+    if (old_period) {
+        int64_t last_periodic_clock, next_periodic_clock;
=20
-            next_periodic_clock =3D muldiv64(s->next_periodic_time,
-                                    RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND=
);
-            last_periodic_clock =3D next_periodic_clock - old_period;
-            lost_clock =3D cur_clock - last_periodic_clock;
-            assert(lost_clock >=3D 0);
+        next_periodic_clock =3D muldiv64(s->next_periodic_time,
+                                RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
+        last_periodic_clock =3D next_periodic_clock - old_period;
+        lost_clock =3D cur_clock - last_periodic_clock;
+        assert(lost_clock >=3D 0);
         }
=20
         /*
@@ -256,18 +255,18 @@ periodic_timer_update(RTCState *s, int64_t current_ti=
me, uint32_t old_period)
                 rtc_coalesced_timer_update(s);
             }
         } else {
-           /*
+            /*
              * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
              * is not used, we should make the time progress anyway.
              */
             lost_clock =3D MIN(lost_clock, period);
         }
=20
-        assert(lost_clock >=3D 0 && lost_clock <=3D period);
+    assert(lost_clock >=3D 0 && lost_clock <=3D period);
=20
-        next_irq_clock =3D cur_clock + period - lost_clock;
-        s->next_periodic_time =3D periodic_clock_to_ns(next_irq_clock) + 1=
;
-        timer_mod(s->periodic_timer, s->next_periodic_time);
+    next_irq_clock =3D cur_clock + period - lost_clock;
+    s->next_periodic_time =3D periodic_clock_to_ns(next_irq_clock) + 1;
+    timer_mod(s->periodic_timer, s->next_periodic_time);
 }
=20
 static void rtc_periodic_timer(void *opaque)
--=20
2.21.0


