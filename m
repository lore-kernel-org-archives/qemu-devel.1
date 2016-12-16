Received: from eggs.gnu.org ([2001:4830:134:3::10]:38806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzrv-0003GF-K6
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:16:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzrq-0006NZ-LN
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:16:43 -0500
Received: from mail.kernel.org ([198.145.29.136]:48792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzrq-0006Lt-Eq
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:16:38 -0500
Date: Fri, 16 Dec 2016 23:16:34 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1481922841-4324-5-git-send-email-mst@redhat.com>
References: <1481922841-4324-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1481922841-4324-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 4/9] tests/vhost-user-bridge: do not
 accept more than one connection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Victor Kaplansky <victork@redhat.com>, Eric Blake <eblake@redhat.com>, stefanha@redhat.com

From: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/vhost-user-bridge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index 97e45d8..5b618f6 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -1200,6 +1200,7 @@ vubr_accept_cb(int sock, void *ctx)
     }
     DPRINT("Got connection from remote peer on sock %d\n", conn_fd);
     dispatcher_add(&dev->dispatcher, conn_fd, ctx, vubr_receive_cb);
+    dispatcher_remove(&dev->dispatcher, sock);
 }
=20
 static VubrDev *
--=20
MST
