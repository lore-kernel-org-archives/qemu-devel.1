Received: from eggs.gnu.org ([2001:4830:134:3::10]:38626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e22C5-00025q-Ty
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 17:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e22C5-0001Rv-3u
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 17:36:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e22C4-0001Rh-UH
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 17:36:05 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 23:34:44 +0200
Message-Id: <20171010213506.22989-6-marcandre.lureau@redhat.com>
In-Reply-To: <20171010213506.22989-1-marcandre.lureau@redhat.com>
References: <20171010213506.22989-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 05/27] libvhost-user: improve vu_queue_pop()
 doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, changpeng.liu@intel.com, f4bug@amsat.org, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 4021f1124e..5825b66880 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -358,7 +358,8 @@ void vu_queue_notify(VuDev *dev, VuVirtq *vq);
  * @vq: a VuVirtq queue
  * @sz: the size of struct to return (must be >=3D VuVirtqElement)
  *
- * Returns: a VuVirtqElement filled from the queue or NULL.
+ * Returns: a VuVirtqElement filled from the queue or NULL. The
+ * returned element must be free()-d by the caller.
  */
 void *vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz);
=20
--=20
2.15.0.rc0.40.gaefcc5f6f
