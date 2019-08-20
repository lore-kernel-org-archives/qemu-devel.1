Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100A6C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F18214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F18214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyLp-0004iM-TT
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8X-0005gD-05
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8U-0003LN-Br
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60339)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy8S-0003Ha-MC
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CC45011A06
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 07:00:50 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38AD17E00C;
 Tue, 20 Aug 2019 07:00:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:36 +0200
Message-Id: <1566284395-30287-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 20 Aug 2019 07:00:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 17/36] timer: Remove reset notifiers
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

Remove the reset notifer from the core qemu-timer code.
The only user was mc146818 and we've just remove it's use.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190724115823.4199-3-dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/timer.h | 22 ----------------------
 util/qemu-timer.c    | 21 +--------------------
 2 files changed, 1 insertion(+), 42 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 5d978e1..6817c78 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -228,28 +228,6 @@ void qemu_clock_enable(QEMUClockType type, bool enabled);
 void qemu_start_warp_timer(void);
 
 /**
- * qemu_clock_register_reset_notifier:
- * @type: the clock type
- * @notifier: the notifier function
- *
- * Register a notifier function to call when the clock
- * concerned is reset.
- */
-void qemu_clock_register_reset_notifier(QEMUClockType type,
-                                        Notifier *notifier);
-
-/**
- * qemu_clock_unregister_reset_notifier:
- * @type: the clock type
- * @notifier: the notifier function
- *
- * Unregister a notifier function to call when the clock
- * concerned is reset.
- */
-void qemu_clock_unregister_reset_notifier(QEMUClockType type,
-                                          Notifier *notifier);
-
-/**
  * qemu_clock_run_timers:
  * @type: clock on which to operate
  *
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 1cc1b2f..2faaaf9 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -48,7 +48,6 @@ typedef struct QEMUClock {
     /* We rely on BQL to protect the timerlists */
     QLIST_HEAD(, QEMUTimerList) timerlists;
 
-    NotifierList reset_notifiers;
     int64_t last;
 
     QEMUClockType type;
@@ -133,7 +132,6 @@ static void qemu_clock_init(QEMUClockType type, QEMUTimerListNotifyCB *notify_cb
     clock->enabled = (type == QEMU_CLOCK_VIRTUAL ? false : true);
     clock->last = INT64_MIN;
     QLIST_INIT(&clock->timerlists);
-    notifier_list_init(&clock->reset_notifiers);
     main_loop_tlg.tl[type] = timerlist_new(type, notify_cb, NULL);
 }
 
@@ -630,7 +628,7 @@ int64_t timerlistgroup_deadline_ns(QEMUTimerListGroup *tlg)
 
 int64_t qemu_clock_get_ns(QEMUClockType type)
 {
-    int64_t now, last;
+    int64_t now;
     QEMUClock *clock = qemu_clock_ptr(type);
 
     switch (type) {
@@ -645,11 +643,7 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
         }
     case QEMU_CLOCK_HOST:
         now = REPLAY_CLOCK(REPLAY_CLOCK_HOST, get_clock_realtime());
-        last = clock->last;
         clock->last = now;
-        if (now < last || now > (last + get_max_clock_jump())) {
-            notifier_list_notify(&clock->reset_notifiers, &now);
-        }
         return now;
     case QEMU_CLOCK_VIRTUAL_RT:
         return REPLAY_CLOCK(REPLAY_CLOCK_VIRTUAL_RT, cpu_get_clock());
@@ -668,19 +662,6 @@ void qemu_clock_set_last(QEMUClockType type, uint64_t last)
     clock->last = last;
 }
 
-void qemu_clock_register_reset_notifier(QEMUClockType type,
-                                        Notifier *notifier)
-{
-    QEMUClock *clock = qemu_clock_ptr(type);
-    notifier_list_add(&clock->reset_notifiers, notifier);
-}
-
-void qemu_clock_unregister_reset_notifier(QEMUClockType type,
-                                          Notifier *notifier)
-{
-    notifier_remove(notifier);
-}
-
 void init_clocks(QEMUTimerListNotifyCB *notify_cb)
 {
     QEMUClockType type;
-- 
1.8.3.1



