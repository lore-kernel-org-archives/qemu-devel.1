Received: from eggs.gnu.org ([2001:4830:134:3::10]:46439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdkq-0001lC-0P
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdkn-00060K-KZ
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:16 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 19 Jan 2018 15:58:40 -0500
Message-Id: <20180119205847.7141-7-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-1-jsnow@redhat.com>
References: <20180119205847.7141-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/13] block/stream: use block_job_relax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com, John Snow <jsnow@redhat.com>

See prior commit for justification.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/stream.c b/block/stream.c
index e85af18c54..49dc102565 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -139,7 +139,7 @@ static void coroutine_fn stream_run(void *opaque)
         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
          */
-        block_job_sleep_ns(&s->common, delay_ns);
+        block_job_relax(&s->common, delay_ns);
         if (block_job_is_cancelled(&s->common)) {
             break;
         }
-- 
2.14.3
