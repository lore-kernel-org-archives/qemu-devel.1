Received: from eggs.gnu.org ([2001:4830:134:3::10]:58901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTpbO-0005tX-Mm
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTpbK-0003Tc-Ru
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:21:22 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 15 Jun 2018 16:20:45 +0200
Message-Id: <20180615142108.27814-4-kwolf@redhat.com>
In-Reply-To: <20180615142108.27814-1-kwolf@redhat.com>
References: <20180615142108.27814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/26] jobs: fix stale wording
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: John Snow <jsnow@redhat.com>

During the design for manual completion, we decided not to use the
"manual" property as a shorthand for both auto-dismiss and auto-finalize.

Fix the wording.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/job.json | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/qapi/job.json b/qapi/job.json
index 17d10037c4..226443594b 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -50,16 +50,17 @@
 #           the last job in a transaction.
 #
 # @pending: The job has finished its work, but has finalization steps that it
-#           needs to make prior to completing. These changes may require
-#           manual intervention by the management process if manual was set
-#           to true. These changes may still fail.
+#           needs to make prior to completing. These changes will require
+#           manual intervention via @job-finalize if auto-finalize was set to
+#           false. These pending changes may still fail.
 #
 # @aborting: The job is in the process of being aborted, and will finish with
 #            an error. The job will afterwards report that it is @concluded.
 #            This status may not be visible to the management process.
 #
-# @concluded: The job has finished all work. If manual was set to true, the job
-#             will remain in the query list until it is dismissed.
+# @concluded: The job has finished all work. If auto-dismiss was set to false,
+#             the job will remain in the query list until it is dismissed via
+#             @job-dismiss.
 #
 # @null: The job is in the process of being dismantled. This state should not
 #        ever be visible externally.
-- 
2.13.6
