Received: from eggs.gnu.org ([2001:4830:134:3::10]:58835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eBfSI-0004WL-QQ
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eBfSH-0002ni-Cq
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:20:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eBfSH-0002nC-7P
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:20:37 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon,  6 Nov 2017 11:20:27 +0000
Message-Id: <20171106112027.10196-2-stefanha@redhat.com>
In-Reply-To: <20171106112027.10196-1-stefanha@redhat.com>
References: <20171106112027.10196-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] aio-posix: drop QEMU_AIO_POLL_MAX_NS env var
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

This hunk should not have been merged but I forgot to remove it.  Let's
remove it before it slips into a QEMU release.

=C2=AF\_(=E3=83=84)_/=C2=AF

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20171103154041.12617-1-stefanha@redhat.com
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
