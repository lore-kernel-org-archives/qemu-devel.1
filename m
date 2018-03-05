Received: from eggs.gnu.org ([2001:4830:134:3::10]:45499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esjqZ-0002je-60
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esjqU-0005oJ-AN
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:43:43 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36512 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1esjqU-0005nc-60
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:43:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C1174040852
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 06:43:37 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  5 Mar 2018 14:43:19 +0800
Message-Id: <20180305064324.9238-2-peterx@redhat.com>
In-Reply-To: <20180305064324.9238-1-peterx@redhat.com>
References: <20180305064324.9238-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/6] qio: rename qio_task_thread_result
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

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
