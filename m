Received: from eggs.gnu.org ([2001:4830:134:3::10]:43527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCv0R-0002yi-Uh
	for qemu-devel@nongnu.org; Mon, 22 May 2017 17:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCv0N-0000hH-2g
	for qemu-devel@nongnu.org; Mon, 22 May 2017 17:36:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCv0M-0000h3-Sy
	for qemu-devel@nongnu.org; Mon, 22 May 2017 17:36:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F26561B8D
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 21:36:41 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 22 May 2017 16:36:36 -0500
Message-Id: <20170522213636.11550-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] qapi: Fix some blockdev-add documentation
 regressions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, marcandre.lureau@redhat.com

In the process of getting rid of docs/qmp-commands.txt, we
managed to regress on any text that changed after the point
where the move was first branched and when the move actually
occurred.  For example, commit 3282eca for blockdev-snapshot
re-added the extra "options" layer which had been cleaned up
in commit 0153d2f.

While I didn't audit for all such regressions, I did scrub
for all bogus uses of nested "options".

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6b974b9..3bd7fa2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1206,11 +1206,11 @@
 # Example:
 #
 # -> { "execute": "blockdev-add",
-#      "arguments": { "options": { "driver": "qcow2",
-#                                  "node-name": "node1534",
-#                                  "file": { "driver": "file",
-#                                            "filename": "hd1.qcow2" },
-#                                  "backing": "" } } }
+#      "arguments": { "driver": "qcow2",
+#                     "node-name": "node1534",
+#                     "file": { "driver": "file",
+#                               "filename": "hd1.qcow2" },
+#                     "backing": "" } }
 #
 # <- { "return": {} }
 #
@@ -3237,10 +3237,10 @@
 #
 # -> { "execute": "blockdev-add",
 #      "arguments": {
-#          "options": { "node-name": "node0",
-#                       "driver": "raw",
-#                       "file": { "driver": "file",
-#                                 "filename": "fedora.iso" } } } }
+#          "node-name": "node0",
+#          "driver": "raw",
+#          "file": { "driver": "file",
+#                    "filename": "fedora.iso" } } }
 # <- { "return": {} }
 #
 # -> { "execute": "x-blockdev-insert-medium",
@@ -3693,10 +3693,10 @@
 # 1. Add a new node to a quorum
 # -> { "execute": "blockdev-add",
 #      "arguments": {
-#          "options": { "driver": "raw",
-#                       "node-name": "new_node",
-#                        "file": { "driver": "file",
-#                                  "filename": "test.raw" } } } }
+#          "driver": "raw",
+#          "node-name": "new_node",
+#          "file": { "driver": "file",
+#                    "filename": "test.raw" } } }
 # <- { "return": {} }
 # -> { "execute": "x-blockdev-change",
 #      "arguments": { "parent": "disk1",
-- 
2.9.4
