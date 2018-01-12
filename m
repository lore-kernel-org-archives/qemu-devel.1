Received: from eggs.gnu.org ([2001:4830:134:3::10]:40994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ea0hd-0003lT-DY
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ea0hc-0005fo-IE
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ea0hc-0005eu-Cl
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C076C051784
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 14:53:03 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Jan 2018 15:52:53 +0100
Message-Id: <20180112145258.10578-5-kraxel@redhat.com>
In-Reply-To: <20180112145258.10578-1-kraxel@redhat.com>
References: <20180112145258.10578-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/9] spice: remove unused watch list
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
Message-id: 20171122135625.16625-2-fziglio@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/spice-core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index ea04dc69b5..85b9ea2127 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -92,9 +92,7 @@ struct SpiceWatch {
     int event_mask;
     SpiceWatchFunc func;
     void *opaque;
-    QTAILQ_ENTRY(SpiceWatch) next;
 };
-static QTAILQ_HEAD(, SpiceWatch) watches = QTAILQ_HEAD_INITIALIZER(watches);
 
 static void watch_read(void *opaque)
 {
@@ -131,7 +129,6 @@ static SpiceWatch *watch_add(int fd, int event_mask, SpiceWatchFunc func, void *
     watch->fd     = fd;
     watch->func   = func;
     watch->opaque = opaque;
-    QTAILQ_INSERT_TAIL(&watches, watch, next);
 
     watch_update_mask(watch, event_mask);
     return watch;
@@ -140,7 +137,6 @@ static SpiceWatch *watch_add(int fd, int event_mask, SpiceWatchFunc func, void *
 static void watch_remove(SpiceWatch *watch)
 {
     qemu_set_fd_handler(watch->fd, NULL, NULL, NULL);
-    QTAILQ_REMOVE(&watches, watch, next);
     g_free(watch);
 }
 
-- 
2.9.3
