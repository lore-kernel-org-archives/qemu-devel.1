Received: from eggs.gnu.org ([2001:4830:134:3::10]:36169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVh0f-00052Q-C5
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVh0a-0006Rr-Gs
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:58:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVh0a-0006Rl-B8
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:58:16 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 23 Jan 2017 15:57:32 +0000
Message-Id: <20170123155737.3793-4-berrange@redhat.com>
In-Reply-To: <20170123155737.3793-1-berrange@redhat.com>
References: <20170123155737.3793-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v2 3/8] io: fix typo in docs for QIOTask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

The GDestroyNotify parameter is already a pointer, so does
not need a '*' suffix on the type.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/io/task.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/io/task.h b/include/io/task.h
index c268eb0..1407747 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -49,7 +49,7 @@ typedef int (*QIOTaskWorker)(QIOTask *task,
  *  void myobject_operation(QMyObject *obj,
  *                          QIOTaskFunc *func,
  *                          gpointer opaque,
- *                          GDestroyNotify *notify);
+ *                          GDestroyNotify notify);
  *   </programlisting>
  * </example>
  *
@@ -67,7 +67,7 @@ typedef int (*QIOTaskWorker)(QIOTask *task,
  *    void myobject_operation(QMyObject *obj,
  *                            QIOTaskFunc *func,
  *                            gpointer opaque,
- *                            GDestroyNotify *notify)
+ *                            GDestroyNotify notify)
  *    {
  *      QIOTask *task;
  *
@@ -154,7 +154,7 @@ typedef int (*QIOTaskWorker)(QIOTask *task,
  *                               SocketAddress *addr,
  *                               QIOTaskFunc *func,
  *                               gpointer opaque,
- *                               GDestroyNotify *notify)
+ *                               GDestroyNotify notify)
  *    {
  *      QIOTask *task;
  *      SocketAddress *addrCopy;
-- 
2.9.3
