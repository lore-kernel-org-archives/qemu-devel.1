Received: from eggs.gnu.org ([2001:4830:134:3::10]:60564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1eHVW2-00065X-Pa
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 08:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1eHVVz-0005DB-Kd
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 08:56:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1eHVVz-0005Am-Em
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 08:56:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8FB9FC0587C5
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 13:56:34 +0000 (UTC)
From: Frediano Ziglio <fziglio@redhat.com>
Date: Wed, 22 Nov 2017 13:56:24 +0000
Message-Id: <20171122135625.16625-3-fziglio@redhat.com>
In-Reply-To: <20171122135625.16625-1-fziglio@redhat.com>
References: <20171122135625.16625-1-fziglio@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] spice: remove only written event_mask field
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
 ui/spice-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 85b9ea2127..6d579faaae 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -89,7 +89,6 @@ static void timer_remove(SpiceTimer *timer)
 
 struct SpiceWatch {
     int fd;
-    int event_mask;
     SpiceWatchFunc func;
     void *opaque;
 };
@@ -111,11 +110,10 @@ static void watch_update_mask(SpiceWatch *watch, int event_mask)
     IOHandler *on_read = NULL;
     IOHandler *on_write = NULL;
 
-    watch->event_mask = event_mask;
-    if (watch->event_mask & SPICE_WATCH_EVENT_READ) {
+    if (event_mask & SPICE_WATCH_EVENT_READ) {
         on_read = watch_read;
     }
-    if (watch->event_mask & SPICE_WATCH_EVENT_WRITE) {
+    if (event_mask & SPICE_WATCH_EVENT_WRITE) {
         on_write = watch_write;
     }
     qemu_set_fd_handler(watch->fd, on_read, on_write, watch);
-- 
2.14.3
