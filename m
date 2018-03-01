Received: from eggs.gnu.org ([2001:4830:134:3::10]:52394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJpn-0007iI-61
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJpi-0006qZ-9q
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:45:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42056 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erJpi-0006qD-5u
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:44:58 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1ECEEAEAB
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 08:44:57 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu,  1 Mar 2018 16:44:25 +0800
Message-Id: <20180301084438.13594-3-peterx@redhat.com>
In-Reply-To: <20180301084438.13594-1-peterx@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/15] qio: rename qio_task_thread_result
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

It is strange that it was called gio_task_thread_result.  Rename it to
follow the naming rule of the file.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 io/task.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io/task.c b/io/task.c
index 3ce556017c..1a0a1c7185 100644
--- a/io/task.c
+++ b/io/task.c
@@ -80,7 +80,7 @@ struct QIOTaskThreadData {
 };
 
 
-static gboolean gio_task_thread_result(gpointer opaque)
+static gboolean qio_task_thread_result(gpointer opaque)
 {
     struct QIOTaskThreadData *data = opaque;
 
@@ -110,7 +110,7 @@ static gpointer qio_task_thread_worker(gpointer opaque)
      * the worker results
      */
     trace_qio_task_thread_exit(data->task);
-    g_idle_add(gio_task_thread_result, data);
+    g_idle_add(qio_task_thread_result, data);
     return NULL;
 }
 
-- 
2.14.3
