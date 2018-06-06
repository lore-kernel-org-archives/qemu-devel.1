Received: from eggs.gnu.org ([2001:4830:134:3::10]:55735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQhSN-0000Yc-8K
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 19:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQhSM-0002sV-BW
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 19:03:07 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed,  6 Jun 2018 19:02:57 -0400
Message-Id: <20180606230257.9038-3-jsnow@redhat.com>
In-Reply-To: <20180606230257.9038-1-jsnow@redhat.com>
References: <20180606230257.9038-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] jobs: fix verb references in docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

These point to the job versions now, not the blockjob versions which
don't really exist anymore.

Except set-speed, which does. It sticks out like a sore thumb. This
patch doesn't fix that, but it doesn't make it any worse, either.

Signed-off-by: John Snow <jsnow@redhat.com>
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
2.14.3
