Received: from eggs.gnu.org ([2001:4830:134:3::10]:60567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1eHVW2-00065a-QG
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 08:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1eHVW1-0005Dk-5m
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 08:56:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1eHVW0-0005DY-Vw
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 08:56:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EE4B7F41D
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 13:56:36 +0000 (UTC)
From: Frediano Ziglio <fziglio@redhat.com>
Date: Wed, 22 Nov 2017 13:56:25 +0000
Message-Id: <20171122135625.16625-4-fziglio@redhat.com>
In-Reply-To: <20171122135625.16625-1-fziglio@redhat.com>
References: <20171122135625.16625-1-fziglio@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] spice: remove unused timer list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org, Frediano Ziglio <fziglio@redhat.com>

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
---
 ui/spice-core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 6d579faaae..2baf0c7120 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -55,9 +55,7 @@ static QemuThread me;
 
 struct SpiceTimer {
     QEMUTimer *timer;
-    QTAILQ_ENTRY(SpiceTimer) next;
 };
-static QTAILQ_HEAD(, SpiceTimer) timers = QTAILQ_HEAD_INITIALIZER(timers);
 
 static SpiceTimer *timer_add(SpiceTimerFunc func, void *opaque)
 {
@@ -65,7 +63,6 @@ static SpiceTimer *timer_add(SpiceTimerFunc func, void *opaque)
 
     timer = g_malloc0(sizeof(*timer));
     timer->timer = timer_new_ms(QEMU_CLOCK_REALTIME, func, opaque);
-    QTAILQ_INSERT_TAIL(&timers, timer, next);
     return timer;
 }
 
@@ -83,7 +80,6 @@ static void timer_remove(SpiceTimer *timer)
 {
     timer_del(timer->timer);
     timer_free(timer->timer);
-    QTAILQ_REMOVE(&timers, timer, next);
     g_free(timer);
 }
 
-- 
2.14.3
