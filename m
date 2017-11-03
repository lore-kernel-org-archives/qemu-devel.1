Received: from eggs.gnu.org ([2001:4830:134:3::10]:40384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eAe5X-0004qk-2w
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eAe5W-0005oN-2G
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:40:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  3 Nov 2017 15:40:41 +0000
Message-Id: <20171103154041.12617-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] aio-posix: drop QEMU_AIO_POLL_MAX_NS env var
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, thuth@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

This hunk should not have been merged but I forgot to remove it.  Let's
remove it before it slips into a QEMU release.

=C2=AF\_(=E3=83=84)_/=C2=AF

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/aio-posix.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 5946ac09f0..1427f49b4a 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -701,13 +701,6 @@ bool aio_poll(AioContext *ctx, bool blocking)
=20
 void aio_context_setup(AioContext *ctx)
 {
-    /* TODO remove this in final patch submission */
-    if (getenv("QEMU_AIO_POLL_MAX_NS")) {
-        fprintf(stderr, "The QEMU_AIO_POLL_MAX_NS environment variable h=
as "
-                "been replaced with -object iothread,poll-max-ns=3DNUM\n=
");
-        exit(1);
-    }
-
 #ifdef CONFIG_EPOLL_CREATE1
     assert(!ctx->epollfd);
     ctx->epollfd =3D epoll_create1(EPOLL_CLOEXEC);
--=20
2.13.6
