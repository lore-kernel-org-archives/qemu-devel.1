Received: from eggs.gnu.org ([2001:4830:134:3::10]:38636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWm8O-0006RW-JA
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWm8M-0005rB-2x
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:38:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWm8L-0005qw-Sr
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:38:45 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CD798048B
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 15:38:45 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 26 Jan 2017 15:38:37 +0000
Message-Id: <20170126153837.25597-1-stefanha@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This hunk should not have been merged but I forgot to remove it.  Let's
remove it before it slips into a QEMU release.

=C2=AF\_(=E3=83=84)_/=C2=AF

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 aio-posix.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/aio-posix.c b/aio-posix.c
index 9453d83..9a6348b 100644
--- a/aio-posix.c
+++ b/aio-posix.c
@@ -723,13 +723,6 @@ bool aio_poll(AioContext *ctx, bool blocking)
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
2.9.3
