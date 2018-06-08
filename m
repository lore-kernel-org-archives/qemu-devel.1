Received: from eggs.gnu.org ([2001:4830:134:3::10]:47359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fR8V9-0004aU-B8
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 23:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fR8V8-00073m-Ns
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 23:55:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fR8V8-00073a-Hy
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 23:55:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1171181B0096
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 03:55:46 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri,  8 Jun 2018 11:55:08 +0800
Message-Id: <20180608035511.7439-5-peterx@redhat.com>
In-Reply-To: <20180608035511.7439-1-peterx@redhat.com>
References: <20180608035511.7439-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v10 4/7] monitor: fix comment for monitor_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Fix typo in d622cb5879c.  Meanwhile move these variables close to each
other.  monitor_qapi_event_state can be declared static, add that.

Reported-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/monitor.c b/monitor.c
index 5c60bf08cc..fa9c35631f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -266,10 +266,11 @@ typedef struct QMPRequest QMPRequest;
 /* QMP checker flags */
 #define QMP_ACCEPT_UNKNOWNS 1
 
-/* Protects mon_list, monitor_event_state.  */
+/* Protects mon_list, monitor_qapi_event_state.  */
 static QemuMutex monitor_lock;
-
+static GHashTable *monitor_qapi_event_state;
 static QTAILQ_HEAD(mon_list, Monitor) mon_list;
+
 static QLIST_HEAD(mon_fdsets, MonFdset) mon_fdsets;
 static int mon_refcount;
 
@@ -571,8 +572,6 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
 };
 
-GHashTable *monitor_qapi_event_state;
-
 /*
  * Emits the event to every monitor instance, @event is only used for trace
  * Called with monitor_lock held.
-- 
2.17.1
