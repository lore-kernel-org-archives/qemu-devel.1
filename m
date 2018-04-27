Received: from eggs.gnu.org ([2001:4830:134:3::10]:58699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fC1LP-00022B-NU
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 07:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fC1LL-0007Px-JI
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 07:15:15 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 27 Apr 2018 12:15:02 +0100
Message-Id: <20180427111502.9822-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] migration: Textual fixups for blocktime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, eblake@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Blank lines and comments as suggested by Eric.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 qapi/migration.json | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index f3974c6807..e7010fc611 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -157,11 +157,13 @@
 #              error strings. (Since 2.7)
 #
 # @postcopy-blocktime: total time when all vCPU were blocked during postcopy
-#           live migration (Since 2.13)
+#           live migration. This is only present when the postcopy-blocktime
+#           migration capability is enabled. (Since 2.13)
 #
-# @postcopy-vcpu-blocktime: list of the postcopy blocktime per vCPU (Since 2.13)
+# @postcopy-vcpu-blocktime: list of the postcopy blocktime per vCPU.  This is
+#           only present when the postcopy-blocktime migration capability
+#           is enabled. (Since 2.13)
 #
-
 #
 # Since: 0.14.0
 ##
@@ -363,7 +365,6 @@
 #
 # @x-multifd: Use more than one fd for migration (since 2.11)
 #
-#
 # @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps.
 #                 (since 2.12)
 #
-- 
2.17.0
