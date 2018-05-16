Received: from eggs.gnu.org ([2001:4830:134:3::10]:52229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIz0l-0001y5-1F
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIz0k-0005KO-5d
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:10:42 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 16 May 2018 18:10:34 +0200
Message-Id: <20180516161034.27440-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] nfs: Fix error path in
 nfs_options_qdict_to_qapi()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

Don't throw away local_err, but propagate it to errp.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/nfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/nfs.c b/block/nfs.c
index d6364d28bb..3349b67a76 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -571,6 +571,7 @@ static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,
     qobject_unref(crumpled);
 
     if (local_err) {
+        error_propagate(errp, local_err);
         return NULL;
     }
 
-- 
2.13.6
