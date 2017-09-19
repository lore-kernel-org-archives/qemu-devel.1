Received: from eggs.gnu.org ([2001:4830:134:3::10]:47136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLmc-0006Ab-2b
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLmb-0002US-9w
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duLmb-0002U8-3a
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:01 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Sep 2017 18:52:15 +0200
Message-Id: <20170919165226.23022-17-marcandre.lureau@redhat.com>
In-Reply-To: <20170919165226.23022-1-marcandre.lureau@redhat.com>
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 16/27] vhost-user-scsi: remove
 vdev_scsi_add_iscsi_lun()
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index 0573ae794e..38fe451619 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -657,20 +657,6 @@ static vhost_scsi_dev_t *vdev_scsi_new(int server_so=
ck)
     return vdev_scsi;
 }
=20
-static int vdev_scsi_add_iscsi_lun(vhost_scsi_dev_t *vdev_scsi,
-                                   char *iscsi_uri, uint32_t lun)
-{
-    assert(vdev_scsi);
-    assert(iscsi_uri);
-    assert(lun < VUS_MAX_LUNS);
-
-    if (iscsi_add_lun(&vdev_scsi->luns[lun], iscsi_uri) !=3D 0) {
-        return -1;
-    }
-
-    return 0;
-}
-
 static int vdev_scsi_run(vhost_scsi_dev_t *vdev_scsi)
 {
     int cli_sock;
@@ -734,7 +720,7 @@ int main(int argc, char **argv)
     }
     vdev_scsi =3D vdev_scsi_new(sock);
=20
-    if (vdev_scsi_add_iscsi_lun(vdev_scsi, iscsi_uri, 0) !=3D 0) {
+    if (iscsi_add_lun(&vdev_scsi->luns[0], iscsi_uri) !=3D 0) {
         goto err;
     }
=20
--=20
2.14.1.146.gd35faa819
