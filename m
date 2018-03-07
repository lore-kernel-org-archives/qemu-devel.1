Received: from eggs.gnu.org ([2001:4830:134:3::10]:38091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXCj-0002LK-Qc
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:25:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXCf-0000PA-W3
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:25:53 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  7 Mar 2018 11:25:27 +0000
Message-Id: <20180307112532.24248-2-berrange@redhat.com>
In-Reply-To: <20180307112532.24248-1-berrange@redhat.com>
References: <20180307112532.24248-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/6] qio: rename qio_task_thread_result
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

It is strange that it was called gio_task_thread_result.  Rename it to
follow the naming rule of the file.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 io/task.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io/task.c b/io/task.c
index 3ce556017c..1a0a1c7185 100644
--- a/io/task.c
+++ b/io/task.c
@@ -80,7 +80,7 @@ struct QIOTaskThreadData {
 };
=20
=20
-static gboolean gio_task_thread_result(gpointer opaque)
+static gboolean qio_task_thread_result(gpointer opaque)
 {
     struct QIOTaskThreadData *data =3D opaque;
=20
@@ -110,7 +110,7 @@ static gpointer qio_task_thread_worker(gpointer opaqu=
e)
      * the worker results
      */
     trace_qio_task_thread_exit(data->task);
-    g_idle_add(gio_task_thread_result, data);
+    g_idle_add(qio_task_thread_result, data);
     return NULL;
 }
=20
--=20
2.14.3
