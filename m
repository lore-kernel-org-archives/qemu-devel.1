Received: from eggs.gnu.org ([2001:4830:134:3::10]:59021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmcw-00019v-SO
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmcv-0004RZ-N3
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:14 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:25 +0100
Message-Id: <20180313161803.1814-4-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/41] Blockjobs: documentation touchup
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

From: John Snow <jsnow@redhat.com>

Trivial; Document what the job creation flags do,
and some general tidying.

Signed-off-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob.h     | 8 ++++----
 include/block/blockjob_int.h | 4 +++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 29cde3ffe3..b77fac118d 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -127,12 +127,10 @@ typedef struct BlockJob {
     /** Reference count of the block job */
     int refcnt;
 
-    /* True if this job has reported completion by calling block_job_completed.
-     */
+    /** True when job has reported completion by calling block_job_completed. */
     bool completed;
 
-    /* ret code passed to block_job_completed.
-     */
+    /** ret code passed to block_job_completed. */
     int ret;
 
     /**
@@ -146,7 +144,9 @@ typedef struct BlockJob {
 } BlockJob;
 
 typedef enum BlockJobCreateFlags {
+    /* Default behavior */
     BLOCK_JOB_DEFAULT = 0x00,
+    /* BlockJob is not QMP-created and should not send QMP events */
     BLOCK_JOB_INTERNAL = 0x01,
 } BlockJobCreateFlags;
 
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index becaae74c2..259d49b32a 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -114,11 +114,13 @@ struct BlockJobDriver {
  * block_job_create:
  * @job_id: The id of the newly-created job, or %NULL to have one
  * generated automatically.
- * @job_type: The class object for the newly-created job.
+ * @driver: The class object for the newly-created job.
  * @txn: The transaction this job belongs to, if any. %NULL otherwise.
  * @bs: The block
  * @perm, @shared_perm: Permissions to request for @bs
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
+ * @flags: Creation flags for the Block Job.
+ *         See @BlockJobCreateFlags
  * @cb: Completion function for the job.
  * @opaque: Opaque pointer value passed to @cb.
  * @errp: Error object.
-- 
2.13.6
