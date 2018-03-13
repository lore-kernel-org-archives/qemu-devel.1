Received: from eggs.gnu.org ([2001:4830:134:3::10]:58981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmcv-000191-S1
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmcu-0004Qk-OP
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:13 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:23 +0100
Message-Id: <20180313161803.1814-2-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/41] blockjobs: fix set-speed kick
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

If speed is '0' it's not actually "less than" the previous speed.
Kick the job in this case too.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockjob.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blockjob.c b/blockjob.c
index 801d29d849..afd92db01f 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -499,7 +499,7 @@ void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
     }
 
     job->speed = speed;
-    if (speed <= old_speed) {
+    if (speed && speed <= old_speed) {
         return;
     }
 
-- 
2.13.6
