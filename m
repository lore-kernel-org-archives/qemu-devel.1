Received: from eggs.gnu.org ([2001:4830:134:3::10]:38597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzrK-0002lf-NR
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzrF-0005jd-Oo
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:16:06 -0500
Received: from mail.kernel.org ([198.145.29.136]:48708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzrF-0005it-IM
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:16:01 -0500
Date: Fri, 16 Dec 2016 23:15:57 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1481922841-4324-3-git-send-email-mst@redhat.com>
References: <1481922841-4324-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1481922841-4324-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 2/9] tests/vhost-user-bridge: remove
 unnecessary dispatcher_remove
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

The call fd is not watched

Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/vhost-user-bridge.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index e91279b..19b0e94 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -979,7 +979,6 @@ vubr_get_vring_base_exec(VubrDev *dev, VhostUserMsg *=
vmsg)
=20
     if (dev->vq[index].call_fd !=3D -1) {
         close(dev->vq[index].call_fd);
-        dispatcher_remove(&dev->dispatcher, dev->vq[index].call_fd);
         dev->vq[index].call_fd =3D -1;
     }
     if (dev->vq[index].kick_fd !=3D -1) {
@@ -1043,7 +1042,6 @@ vubr_set_vring_call_exec(VubrDev *dev, VhostUserMsg=
 *vmsg)
=20
     if (dev->vq[index].call_fd !=3D -1) {
         close(dev->vq[index].call_fd);
-        dispatcher_remove(&dev->dispatcher, dev->vq[index].call_fd);
     }
     dev->vq[index].call_fd =3D vmsg->fds[0];
     DPRINT("Got call_fd: %d for vq: %d\n", vmsg->fds[0], index);
--=20
MST
