Received: from eggs.gnu.org ([2001:4830:134:3::10]:60214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1g8rUJ-0000uu-Sr
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 14:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1g8rUG-0004bu-C2
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 14:39:38 -0400
From: Stefan Weil <sw@weilnetz.de>
Date: Sat,  6 Oct 2018 20:38:51 +0200
Message-Id: <20181006183851.3797-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH] qemu-io-cmds: Fix two format strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developer <qemu-devel@nongnu.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>

Use %zu instead of %zd for unsigned numbers.

This fixes two error messages from the LSTM static code analyzer:

This argument should be of type 'ssize_t' but is of type 'unsigned long'

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 qemu-io-cmds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index db0b3ee5ef..5363482213 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -907,7 +907,7 @@ static int readv_f(BlockBackend *blk, int argc, char **argv)
         memset(cmp_buf, pattern, qiov.size);
         if (memcmp(buf, cmp_buf, qiov.size)) {
             printf("Pattern verification failed at offset %"
-                   PRId64 ", %zd bytes\n", offset, qiov.size);
+                   PRId64 ", %zu bytes\n", offset, qiov.size);
             ret = -EINVAL;
         }
         g_free(cmp_buf);
@@ -1294,7 +1294,7 @@ static void aio_read_done(void *opaque, int ret)
         memset(cmp_buf, ctx->pattern, ctx->qiov.size);
         if (memcmp(ctx->buf, cmp_buf, ctx->qiov.size)) {
             printf("Pattern verification failed at offset %"
-                   PRId64 ", %zd bytes\n", ctx->offset, ctx->qiov.size);
+                   PRId64 ", %zu bytes\n", ctx->offset, ctx->qiov.size);
         }
         g_free(cmp_buf);
     }
-- 
2.11.0
