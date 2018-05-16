Received: from eggs.gnu.org ([2001:4830:134:3::10]:33424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fJ0Rz-0006yA-9c
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fJ0Ry-0006qg-Ib
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:42:55 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 16 May 2018 13:42:33 -0400
Message-Id: <20180516174234.311-4-jcody@redhat.com>
In-Reply-To: <20180516174234.311-1-jcody@redhat.com>
References: <20180516174234.311-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] nfs: Fix error path in
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
Cc: peter.maydell@linaro.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

Don't throw away local_err, but propagate it to errp.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20180516161034.27440-1-kwolf@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/nfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/nfs.c b/block/nfs.c
index 66fddf12d4..4ee2ad59d9 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -570,6 +570,7 @@ static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,
     qobject_unref(crumpled);
 
     if (local_err) {
+        error_propagate(errp, local_err);
         return NULL;
     }
 
-- 
2.13.6
