Received: from eggs.gnu.org ([2001:4830:134:3::10]:46116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dEKqN-0002J0-Vf
	for qemu-devel@nongnu.org; Fri, 26 May 2017 15:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dEKqN-0005rl-6e
	for qemu-devel@nongnu.org; Fri, 26 May 2017 15:24:15 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri, 26 May 2017 15:23:53 -0400
Message-Id: <20170526192404.32186-2-jcody@redhat.com>
In-Reply-To: <20170526192404.32186-1-jcody@redhat.com>
References: <20170526192404.32186-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 01/12] blockjob: remove unnecessary check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

!job is always checked prior to the call, drop it from here.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 20170508141310.8674-2-pbonzini@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 blockjob.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blockjob.c b/blockjob.c
index 6e48932..23022b3 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -480,7 +480,7 @@ static bool block_job_should_pause(BlockJob *job)
 
 bool block_job_user_paused(BlockJob *job)
 {
-    return job ? job->user_paused : 0;
+    return job->user_paused;
 }
 
 void coroutine_fn block_job_pause_point(BlockJob *job)
-- 
2.9.3
