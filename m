Received: from eggs.gnu.org ([2001:4830:134:3::10]:43720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYOw-0005ub-Eb
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYOv-0007Sc-Ja
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:21:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkYOv-0007Ql-DP
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:21:05 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 18:19:54 +0200
Message-Id: <20170823162004.27337-18-marcandre.lureau@redhat.com>
In-Reply-To: <20170823162004.27337-1-marcandre.lureau@redhat.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 17/27] vhost-user-scsi: remove unimplemented
 functions
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
 contrib/vhost-user-scsi/vhost-user-scsi.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index 429e3065ea..882d887a32 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -469,16 +469,6 @@ static void vus_del_watch_cb(VuDev *vu_dev, int fd)
     }
 }
=20
-static void vus_proc_ctl(VuDev *vu_dev, int idx)
-{
-    /* Control VQ not implemented */
-}
-
-static void vus_proc_evt(VuDev *vu_dev, int idx)
-{
-    /* Event VQ not implemented */
-}
-
 static void vus_proc_req(VuDev *vu_dev, int idx)
 {
     vhost_scsi_dev_t *vdev_scsi;
@@ -559,14 +549,9 @@ static void vus_queue_set_started(VuDev *vu_dev, int=
 idx, bool started)
=20
     vq =3D vu_get_queue(vu_dev, idx);
=20
-    switch (idx) {
-    case 0:
-        vu_set_queue_handler(vu_dev, vq, started ? vus_proc_ctl : NULL);
-        break;
-    case 1:
-        vu_set_queue_handler(vu_dev, vq, started ? vus_proc_evt : NULL);
-        break;
-    default:
+    if (idx =3D=3D 0 || idx =3D=3D 1) {
+        PDBG("queue %d unimplemented", idx);
+    } else {
         vu_set_queue_handler(vu_dev, vq, started ? vus_proc_req : NULL);
     }
 }
--=20
2.14.1.146.gd35faa819
