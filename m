Received: from eggs.gnu.org ([2001:4830:134:3::10]:50717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEKLx-0003wR-Ri
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:20:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEKLx-0001cO-0a
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:20:33 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue,  6 Dec 2016 12:20:20 -0600
Message-Id: <20161206182020.25736-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.8] qapi: Document introduction of
 gluster's 'debug' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, stefanha@redhat.com

We intentionally renamed 'debug-level' to 'debug' in the QMP
schema for 'blockdev-add' related to gluster, in order to
match the command line (commit 1a417e46).  However, since
'debug-level' was visible in 2.7, that means that we should
document that 'debug' was not available until 2.8.

The change was intentional because 'blockdev-add' itself
underwent incompatible changes (such as commit 0153d2f) for
the same release; our intent is that after 2.8, these
interfaces will now be stable.  [In hindsight, we should have
used the name x-blockdev-add when we first introduced it]

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index a298e76..6b42216 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2196,6 +2196,7 @@
 # @server:      gluster servers description
 #
 # @debug:       #optional libgfapi log level (default '4' which is Error)
+#               (Since 2.8)
 #
 # @logfile:     #optional libgfapi log file (default /dev/stderr) (Since 2.8)
 #
-- 
2.9.3
