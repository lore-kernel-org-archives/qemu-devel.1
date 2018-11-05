Received: from eggs.gnu.org ([2001:4830:134:3::10]:50107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJht4-0006kg-O9
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJht3-0002jM-FW
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:38:02 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:11 +0100
Message-Id: <20181105163744.25139-4-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/36] qemu-io-cmds: Fix two format strings
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

From: Stefan Weil <sw@weilnetz.de>

Use %zu instead of %zd for unsigned numbers.

This fixes two error messages from the LSTM static code analyzer:

    This argument should be of type 'ssize_t' but is of type 'unsigned lo=
ng'

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-io-cmds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index db0b3ee5ef..5363482213 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -907,7 +907,7 @@ static int readv_f(BlockBackend *blk, int argc, char =
**argv)
         memset(cmp_buf, pattern, qiov.size);
         if (memcmp(buf, cmp_buf, qiov.size)) {
             printf("Pattern verification failed at offset %"
-                   PRId64 ", %zd bytes\n", offset, qiov.size);
+                   PRId64 ", %zu bytes\n", offset, qiov.size);
             ret =3D -EINVAL;
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
--=20
2.19.1
