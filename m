Received: from eggs.gnu.org ([2001:4830:134:3::10]:41360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cX3Kr-0007n3-AC
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cX3Kn-0006kH-Vh
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:00:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cX3Kn-0006k7-P7
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:00:45 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D577883F45
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 10:00:45 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 27 Jan 2017 10:00:29 +0000
Message-Id: <20170127100029.11356-5-stefanha@redhat.com>
In-Reply-To: <20170127100029.11356-1-stefanha@redhat.com>
References: <20170127100029.11356-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] block/gluster: add missing
 QLIST_HEAD_INITIALIZER()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The "qemu/queue.h" data structures provide static initializer macros.
The QLIST version just initializes to NULL so code happens to work when
the initializer is forgotten.  Other types like SLIST are not so
forgiving because they set fields to non-NULL values.

The initializer macro should always be used for consistency and so that
no errors are introduced when switching between list/queue variants.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/gluster.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/gluster.c b/block/gluster.c
index 181b345..3ac9105 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -63,7 +63,8 @@ typedef struct GlfsPreopened {
     QLIST_ENTRY(GlfsPreopened) list;
 } GlfsPreopened;
 
-static QLIST_HEAD(glfs_list, GlfsPreopened) glfs_list;
+static QLIST_HEAD(glfs_list, GlfsPreopened) glfs_list =
+    QLIST_HEAD_INITIALIZER(glfs_list);
 
 static QemuOptsList qemu_gluster_create_opts = {
     .name = "qemu-gluster-create-opts",
-- 
2.9.3
