Received: from eggs.gnu.org ([2001:4830:134:3::10]:40989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ea0hd-0003lR-9l
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ea0hc-0005fC-7Q
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ea0hc-0005eY-0e
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:04 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14B27DF3E
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 14:53:03 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Jan 2018 15:52:55 +0100
Message-Id: <20180112145258.10578-7-kraxel@redhat.com>
In-Reply-To: <20180112145258.10578-1-kraxel@redhat.com>
References: <20180112145258.10578-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 6/9] spice: remove unused timer list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Frediano Ziglio <fziglio@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Frediano Ziglio <fziglio@redhat.com>

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
Message-id: 20171122135625.16625-4-fziglio@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
2.9.3
