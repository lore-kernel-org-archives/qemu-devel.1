Received: from eggs.gnu.org ([2001:4830:134:3::10]:58785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNXeQ-0004Ta-8i
	for qemu-devel@nongnu.org; Tue, 29 May 2018 01:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNXeM-0001Of-A1
	for qemu-devel@nongnu.org; Tue, 29 May 2018 01:58:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59216 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fNXeM-0001OO-61
	for qemu-devel@nongnu.org; Tue, 29 May 2018 01:58:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B32B77D839
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 05:58:25 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 29 May 2018 13:57:52 +0800
Message-Id: <20180529055755.12404-5-peterx@redhat.com>
In-Reply-To: <20180529055755.12404-1-peterx@redhat.com>
References: <20180529055755.12404-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v9 4/7] monitor: fix comment for monitor_lock
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/monitor.c b/monitor.c
index f23178951e..2504696d76 100644
--- a/monitor.c
+++ b/monitor.c
@@ -267,10 +267,11 @@ typedef struct QMPRequest QMPRequest;
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
 
@@ -572,8 +573,6 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
 };
 
-GHashTable *monitor_qapi_event_state;
-
 /*
  * Emits the event to every monitor instance, @event is only used for trace
  * Called with monitor_lock held.
-- 
2.17.0
