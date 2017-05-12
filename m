Received: from eggs.gnu.org ([2001:4830:134:3::10]:43880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9GGg-0005lG-Pd
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:30:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9GGb-0000ZV-O1
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:30:26 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 12 May 2017 14:30:15 -0500
Message-Id: <20170512193015.22155-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Correct documentation for
 BLOCK_WRITE_THRESHOLD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>

Use the correct command name.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 614181b..206e33b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3582,7 +3582,7 @@
 # means the device should be extended to avoid pausing for
 # disk exhaustion.
 # The event is one shot. Once triggered, it needs to be
-# re-registered with another block-set-threshold command.
+# re-registered with another block-set-write-threshold command.
 #
 # @node-name: graph node name on which the threshold was exceeded.
 #
-- 
2.9.3
