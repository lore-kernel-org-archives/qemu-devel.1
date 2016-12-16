Received: from eggs.gnu.org ([2001:4830:134:3::10]:38719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzrd-0002vy-Jp
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzrc-00067i-R8
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:16:25 -0500
Received: from mail.kernel.org ([198.145.29.136]:48740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzrc-00066V-Kr
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:16:24 -0500
Date: Fri, 16 Dec 2016 23:16:19 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1481922841-4324-4-git-send-email-mst@redhat.com>
References: <1481922841-4324-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1481922841-4324-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 3/9] tests/vhost-user-bridge: indicate
 peer disconnected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Victor Kaplansky <victork@redhat.com>, Yuanhan Liu <yuanhan.liu@linux.intel.com>, stefanha@redhat.com

From: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/vhost-user-bridge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index 19b0e94..97e45d8 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -385,7 +385,6 @@ vubr_message_read(int conn_fd, VhostUserMsg *vmsg)
     rc =3D recvmsg(conn_fd, &msg, 0);
=20
     if (rc =3D=3D 0) {
-        vubr_die("recvmsg");
         fprintf(stderr, "Peer disconnected.\n");
         exit(1);
     }
--=20
MST
