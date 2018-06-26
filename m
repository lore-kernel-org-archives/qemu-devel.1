Received: from eggs.gnu.org ([2001:4830:134:3::10]:58473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXjZH-0005JB-8b
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXjZG-0001U0-9O
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:43:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Jun 2018 10:43:00 +0200
Message-Id: <20180626084300.12571-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] qapi/job: The next release will be 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

Commit 51f63ec7d tried to change all references to 2.13 into 3.0, but
it failed to achieve this because it was not properly rebased on top of
the series introducing qapi/job.json. Change the references now.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/job.json | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/qapi/job.json b/qapi/job.json
index 9d074eb8d2..a121b615fb 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -104,7 +104,7 @@
 # @id: The job identifier
 # @status: The new job status
 #
-# Since: 2.13
+# Since: 3.0
 ##
 { 'event': 'JOB_STATUS_CHANGE',
   'data': { 'id': 'str',
@@ -126,7 +126,7 @@
 #
 # @id: The job identifier.
 #
-# Since: 2.13
+# Since: 3.0
 ##
 { 'command': 'job-pause', 'data': { 'id': 'str' } }
 
@@ -140,7 +140,7 @@
 #
 # @id : The job identifier.
 #
-# Since: 2.13
+# Since: 3.0
 ##
 { 'command': 'job-resume', 'data': { 'id': 'str' } }
 
@@ -159,7 +159,7 @@
 #
 # @id: The job identifier.
 #
-# Since: 2.13
+# Since: 3.0
 ##
 { 'command': 'job-cancel', 'data': { 'id': 'str' } }
 
@@ -171,7 +171,7 @@
 #
 # @id: The job identifier.
 #
-# Since: 2.13
+# Since: 3.0
 ##
 { 'command': 'job-complete', 'data': { 'id': 'str' } }
 
@@ -187,7 +187,7 @@
 #
 # @id: The job identifier.
 #
-# Since: 2.13
+# Since: 3.0
 ##
 { 'command': 'job-dismiss', 'data': { 'id': 'str' } }
 
@@ -205,7 +205,7 @@
 # @id: The identifier of any job in the transaction, or of a job that is not
 #      part of any transaction.
 #
-# Since: 2.13
+# Since: 3.0
 ##
 { 'command': 'job-finalize', 'data': { 'id': 'str' } }
 
@@ -237,7 +237,7 @@
 #                       the reason for the job failure. It should not be parsed
 #                       by applications.
 #
-# Since: 2.13
+# Since: 3.0
 ##
 { 'struct': 'JobInfo',
   'data': { 'id': 'str', 'type': 'JobType', 'status': 'JobStatus',
@@ -251,6 +251,6 @@
 #
 # Returns: a list with a @JobInfo for each active job
 #
-# Since: 2.13
+# Since: 3.0
 ##
 { 'command': 'query-jobs', 'returns': ['JobInfo'] }
-- 
2.13.6
