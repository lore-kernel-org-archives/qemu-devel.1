Received: from eggs.gnu.org ([2001:4830:134:3::10]:37738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUuq3-0000zb-M0
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUuq2-0000UC-LT
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:08:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40142 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fUuq2-0000Td-Fg
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:08:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA669401EF1A
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 14:08:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Jun 2018 16:08:51 +0200
Message-Id: <20180618140854.17824-5-armbru@redhat.com>
In-Reply-To: <20180618140854.17824-1-armbru@redhat.com>
References: <20180618140854.17824-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] monitor: fix comment for monitor_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Fix typo in d622cb5879c.  Meanwhile move these variables close to each
other.  monitor_qapi_event_state can be declared static, add that.

Reported-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180608035511.7439-5-peterx@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
