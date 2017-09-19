Received: from eggs.gnu.org ([2001:4830:134:3::10]:47308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLml-0006IO-Bl
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLmg-0002Ym-Ua
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duLmg-0002YK-PJ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:06 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Sep 2017 18:52:17 +0200
Message-Id: <20170919165226.23022-19-marcandre.lureau@redhat.com>
In-Reply-To: <20170919165226.23022-1-marcandre.lureau@redhat.com>
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 18/27] vhost-user-scsi: remove unimplemented
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
Cc: pbonzini@redhat.com, changpeng.liu@intel.com, f4bug@amsat.org, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index 6b55cc71d3..26b17f348b 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -471,16 +471,6 @@ static void vus_del_watch_cb(VuDev *vu_dev, int fd)
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
@@ -561,14 +551,9 @@ static void vus_queue_set_started(VuDev *vu_dev, int=
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
