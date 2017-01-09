Received: from eggs.gnu.org ([2001:4830:134:3::10]:34458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cQc2j-0005jR-DE
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:39:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cQc2i-0000kZ-F6
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:39:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cQc2i-0000k1-9N
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:39:28 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 605D681231
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 15:39:28 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon,  9 Jan 2017 15:39:09 +0000
Message-Id: <20170109153914.27424-4-berrange@redhat.com>
In-Reply-To: <20170109153914.27424-1-berrange@redhat.com>
References: <20170109153914.27424-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/8] io: fix typo in docs for QIOTask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
