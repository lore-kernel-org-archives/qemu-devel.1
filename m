Received: from eggs.gnu.org ([2001:4830:134:3::10]:52756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZ0-0001oY-ML
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTYz-0006yT-BH
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:22 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 23 May 2018 15:11:16 +0200
Message-Id: <20180523131155.12359-8-kwolf@redhat.com>
In-Reply-To: <20180523131155.12359-1-kwolf@redhat.com>
References: <20180523131155.12359-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/46] blockjob: Update block-job-pause/resume
 documentation
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

Commit 0ec4dfb8d changed block-job_pause/resume so that they return an
error if they don't do anything because the job is already
paused/running. It forgot to update the documentation, so do that now.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 55728cb823..d32ec95666 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2338,8 +2338,7 @@
 #
 # This command returns immediately after marking the active background block
 # operation for pausing.  It is an error to call this command if no
-# operation is in progress.  Pausing an already paused job has no cumulative
-# effect; a single block-job-resume command will resume the job.
+# operation is in progress or if the job is already paused.
 #
 # The operation will pause as soon as possible.  No event is emitted when
 # the operation is actually paused.  Cancelling a paused job automatically
@@ -2363,7 +2362,7 @@
 #
 # This command returns immediately after resuming a paused background block
 # operation.  It is an error to call this command if no operation is in
-# progress.  Resuming an already running job is not an error.
+# progress or if the job is not paused.
 #
 # This command also clears the error status of the job.
 #
-- 
2.13.6
