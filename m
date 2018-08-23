Received: from eggs.gnu.org ([2001:4830:134:3::10]:59341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsy0O-0005fC-Hf
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 18:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsy0N-0001JU-Ag
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 18:23:04 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 23 Aug 2018 18:22:49 -0400
Message-Id: <20180823222249.13518-14-jsnow@redhat.com>
In-Reply-To: <20180823222249.13518-1-jsnow@redhat.com>
References: <20180823222249.13518-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/13] block/backup: qapi documentation fixup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>

Fix documentation to match the other jobs amended for 3.1.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f877e9e414..c0b3d33dbb 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1272,13 +1272,14 @@
 #                   a different block device than @device).
 #
 # @auto-finalize: When false, this job will wait in a PENDING state after it has
-#                 finished its work, waiting for @block-job-finalize.
-#                 When true, this job will automatically perform its abort or
-#                 commit actions.
+#                 finished its work, waiting for @block-job-finalize before
+#                 making any block graph changes.
+#                 When true, this job will automatically
+#                 perform its abort or commit actions.
 #                 Defaults to true. (Since 2.12)
 #
 # @auto-dismiss: When false, this job will wait in a CONCLUDED state after it
-#                has completed ceased all work, and wait for @block-job-dismiss.
+#                has completely ceased all work, and awaits @block-job-dismiss.
 #                When true, this job will automatically disappear from the query
 #                list without user intervention.
 #                Defaults to true. (Since 2.12)
@@ -1327,13 +1328,14 @@
 #                   a different block device than @device).
 #
 # @auto-finalize: When false, this job will wait in a PENDING state after it has
-#                 finished its work, waiting for @block-job-finalize.
-#                 When true, this job will automatically perform its abort or
-#                 commit actions.
+#                 finished its work, waiting for @block-job-finalize before
+#                 making any block graph changes.
+#                 When true, this job will automatically
+#                 perform its abort or commit actions.
 #                 Defaults to true. (Since 2.12)
 #
 # @auto-dismiss: When false, this job will wait in a CONCLUDED state after it
-#                has completed ceased all work, and wait for @block-job-dismiss.
+#                has completely ceased all work, and awaits @block-job-dismiss.
 #                When true, this job will automatically disappear from the query
 #                list without user intervention.
 #                Defaults to true. (Since 2.12)
-- 
2.14.4
