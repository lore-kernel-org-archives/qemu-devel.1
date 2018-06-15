Received: from eggs.gnu.org ([2001:4830:134:3::10]:58824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTpbL-0005pw-JW
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTpbK-0003Tb-Rs
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:21:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 15 Jun 2018 16:20:46 +0200
Message-Id: <20180615142108.27814-5-kwolf@redhat.com>
In-Reply-To: <20180615142108.27814-1-kwolf@redhat.com>
References: <20180615142108.27814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 04/26] jobs: fix verb references in docs
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

These point to the job versions now, not the blockjob versions which
don't really exist anymore.

Except set-speed, which does. It sticks out like a sore thumb. This
patch doesn't fix that, but it doesn't make it any worse, either.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/job.json | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/qapi/job.json b/qapi/job.json
index 226443594b..9d074eb8d2 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -76,19 +76,19 @@
 #
 # Represents command verbs that can be applied to a job.
 #
-# @cancel: see @block-job-cancel
+# @cancel: see @job-cancel
 #
-# @pause: see @block-job-pause
+# @pause: see @job-pause
 #
-# @resume: see @block-job-resume
+# @resume: see @job-resume
 #
 # @set-speed: see @block-job-set-speed
 #
-# @complete: see @block-job-complete
+# @complete: see @job-complete
 #
-# @dismiss: see @block-job-dismiss
+# @dismiss: see @job-dismiss
 #
-# @finalize: see @block-job-finalize
+# @finalize: see @job-finalize
 #
 # Since: 2.12
 ##
-- 
2.13.6
