Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED89EC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C2D214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C2D214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyLL-0004LA-Qk
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8Y-0005gP-4I
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8W-0003NJ-Ts
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy8U-0003K4-BL
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4211E195D84D
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 07:00:53 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D1557E006;
 Tue, 20 Aug 2019 07:00:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:38 +0200
Message-Id: <1566284395-30287-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Tue, 20 Aug 2019 07:00:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 19/36] timer: last, remove last bits of last
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The reset notifiers kept a 'last' counter to notice jumps;
now that we've remove the notifier we don't need to keep 'last'.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190724115823.4199-5-dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/timer.h | 13 -------------
 util/qemu-timer.c    | 22 +---------------------
 2 files changed, 1 insertion(+), 34 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 6817c78..5bcab93 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -248,19 +248,6 @@ bool qemu_clock_run_timers(QEMUClockType type);
  */
 bool qemu_clock_run_all_timers(void);
 
-/**
- * qemu_clock_get_last:
- *
- * Returns last clock query time.
- */
-uint64_t qemu_clock_get_last(QEMUClockType type);
-/**
- * qemu_clock_set_last:
- *
- * Sets last clock query time.
- */
-void qemu_clock_set_last(QEMUClockType type, uint64_t last);
-
 
 /*
  * QEMUTimerList
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 2faaaf9..b73041d 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -48,8 +48,6 @@ typedef struct QEMUClock {
     /* We rely on BQL to protect the timerlists */
     QLIST_HEAD(, QEMUTimerList) timerlists;
 
-    int64_t last;
-
     QEMUClockType type;
     bool enabled;
 } QEMUClock;
@@ -130,7 +128,6 @@ static void qemu_clock_init(QEMUClockType type, QEMUTimerListNotifyCB *notify_cb
 
     clock->type = type;
     clock->enabled = (type == QEMU_CLOCK_VIRTUAL ? false : true);
-    clock->last = INT64_MIN;
     QLIST_INIT(&clock->timerlists);
     main_loop_tlg.tl[type] = timerlist_new(type, notify_cb, NULL);
 }
@@ -628,9 +625,6 @@ int64_t timerlistgroup_deadline_ns(QEMUTimerListGroup *tlg)
 
 int64_t qemu_clock_get_ns(QEMUClockType type)
 {
-    int64_t now;
-    QEMUClock *clock = qemu_clock_ptr(type);
-
     switch (type) {
     case QEMU_CLOCK_REALTIME:
         return get_clock();
@@ -642,26 +636,12 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
             return cpu_get_clock();
         }
     case QEMU_CLOCK_HOST:
-        now = REPLAY_CLOCK(REPLAY_CLOCK_HOST, get_clock_realtime());
-        clock->last = now;
-        return now;
+        return REPLAY_CLOCK(REPLAY_CLOCK_HOST, get_clock_realtime());
     case QEMU_CLOCK_VIRTUAL_RT:
         return REPLAY_CLOCK(REPLAY_CLOCK_VIRTUAL_RT, cpu_get_clock());
     }
 }
 
-uint64_t qemu_clock_get_last(QEMUClockType type)
-{
-    QEMUClock *clock = qemu_clock_ptr(type);
-    return clock->last;
-}
-
-void qemu_clock_set_last(QEMUClockType type, uint64_t last)
-{
-    QEMUClock *clock = qemu_clock_ptr(type);
-    clock->last = last;
-}
-
 void init_clocks(QEMUTimerListNotifyCB *notify_cb)
 {
     QEMUClockType type;
-- 
1.8.3.1



