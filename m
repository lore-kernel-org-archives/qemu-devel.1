Received: from eggs.gnu.org ([2001:4830:134:3::10]:49409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxvc7-0007Yl-Jl
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxvc6-0005Ns-SG
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:13:43 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Apr 2017 15:13:27 +0200
Message-Id: <20170411131327.10734-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9?] block/nfs: Do not strcmp() with NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>

Parsing the URI is not required to give us a scheme; uri->scheme may be
NULL.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/nfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nfs.c b/block/nfs.c
index 0816678307..0c7d5619fe 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -83,7 +83,7 @@ static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
         error_setg(errp, "Invalid URI specified");
         goto out;
     }
-    if (strcmp(uri->scheme, "nfs") != 0) {
+    if (!uri->scheme || strcmp(uri->scheme, "nfs") != 0) {
         error_setg(errp, "URI scheme must be 'nfs'");
         goto out;
     }
-- 
2.12.2
