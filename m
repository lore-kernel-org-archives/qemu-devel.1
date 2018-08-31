Received: from eggs.gnu.org ([2001:4830:134:3::10]:57918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvs0P-0001d2-Ga
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvrur-00078G-16
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:29:21 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 31 Aug 2018 18:29:02 -0400
Message-Id: <20180831222907.16257-11-jsnow@redhat.com>
In-Reply-To: <20180831222907.16257-1-jsnow@redhat.com>
References: <20180831222907.16257-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 10/15] tests/test-blockjob-txn: move .exit
 to .clean
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jtc@redhat.com, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>

The exit callback in this test actually only performs cleanup.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/test-blockjob-txn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index ef29f35e44..86606f92b3 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -24,7 +24,7 @@ typedef struct {
     int *result;
 } TestBlockJob;
 
-static void test_block_job_exit(Job *job)
+static void test_block_job_clean(Job *job)
 {
     BlockJob *bjob = container_of(job, BlockJob, job);
     BlockDriverState *bs = blk_bs(bjob->blk);
@@ -73,7 +73,7 @@ static const BlockJobDriver test_block_job_driver = {
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
         .run           = test_block_job_run,
-        .exit          = test_block_job_exit,
+        .clean         = test_block_job_clean,
     },
 };
 
-- 
2.14.4
