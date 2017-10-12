Received: from eggs.gnu.org ([2001:4830:134:3::10]:42519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e2kU8-0001XX-5S
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e2kU5-0000aA-Sz
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:53:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e2kU5-0000Zi-Ne
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:53:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB6708046F
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 20:53:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 12 Oct 2017 22:53:27 +0200
Message-Id: <20171012205330.29942-2-marcandre.lureau@redhat.com>
In-Reply-To: <20171012205330.29942-1-marcandre.lureau@redhat.com>
References: <20171012205330.29942-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] libvhost-user: vu_queue_started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a vu_queue_started method to complement vu_queue_enabled.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20171002191521.15748-2-dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h | 9 +++++++++
 contrib/libvhost-user/libvhost-user.c | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 5825b66880..ff8059257e 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -334,6 +334,15 @@ void vu_queue_set_notification(VuDev *dev, VuVirtq *=
vq, int enable);
  */
 bool vu_queue_enabled(VuDev *dev, VuVirtq *vq);
=20
+/**
+ * vu_queue_started:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ *
+ * Returns: whether the queue is started.
+ */
+bool vu_queue_started(const VuDev *dev, const VuVirtq *vq);
+
 /**
  * vu_queue_empty:
  * @dev: a VuDev context
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index a0e0da4ccb..62be958f59 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -966,6 +966,12 @@ vu_queue_enabled(VuDev *dev, VuVirtq *vq)
     return vq->enable;
 }
=20
+bool
+vu_queue_started(const VuDev *dev, const VuVirtq *vq)
+{
+    return vq->started;
+}
+
 static inline uint16_t
 vring_avail_flags(VuVirtq *vq)
 {
--=20
2.15.0.rc0.40.gaefcc5f6f
