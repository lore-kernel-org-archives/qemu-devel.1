Received: from eggs.gnu.org ([2001:4830:134:3::10]:41306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cX3Kk-0007hR-9b
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cX3Ke-0006h2-Jf
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:00:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cX3Ke-0006gt-Dl
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:00:36 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 796D73B714
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 10:00:36 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 27 Jan 2017 10:00:26 +0000
Message-Id: <20170127100029.11356-2-stefanha@redhat.com>
In-Reply-To: <20170127100029.11356-1-stefanha@redhat.com>
References: <20170127100029.11356-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] block/gluster: fix wrong indent in
 glfs_find_preopened()
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

QEMU uses 4-space indentation.  Fix this now so checkpatch.pl is happy
with future code changes.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/gluster.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 1a22f29..516a1e1 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -226,12 +226,12 @@ static glfs_t *glfs_find_preopened(const char *volume)
 {
     ListElement *entry = NULL;
 
-     QLIST_FOREACH(entry, &glfs_list, list) {
+    QLIST_FOREACH(entry, &glfs_list, list) {
         if (strcmp(entry->saved.volume, volume) == 0) {
             entry->saved.ref++;
             return entry->saved.fs;
         }
-     }
+    }
 
     return NULL;
 }
-- 
2.9.3
