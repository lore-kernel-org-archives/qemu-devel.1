Received: from eggs.gnu.org ([2001:4830:134:3::10]:43332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYOI-0005E3-7N
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYOF-0006d3-25
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkYOE-0006c5-Ss
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:23 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 18:19:40 +0200
Message-Id: <20170823162004.27337-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170823162004.27337-1-marcandre.lureau@redhat.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/27] libvhost-user: improve vu_queue_pop() doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: changpeng.liu@intel.com, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 53ef222c0b..9b9b00e191 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -351,7 +351,8 @@ void vu_queue_notify(VuDev *dev, VuVirtq *vq);
  * @vq: a VuVirtq queue
  * @sz: the size of struct to return (must be >=3D VuVirtqElement)
  *
- * Returns: a VuVirtqElement filled from the queue or NULL.
+ * Returns: a VuVirtqElement filled from the queue or NULL. The
+ * returned element must be free() by the caller.
  */
 void *vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz);
=20
--=20
2.14.1.146.gd35faa819
