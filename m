Received: from eggs.gnu.org ([2001:4830:134:3::10]:45261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1y4t-00088T-Qi
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1y4o-0007fk-3S
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:12:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1y4n-0007fR-TZ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:12:18 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 19:11:15 +0200
Message-Id: <20171010171122.9756-21-marcandre.lureau@redhat.com>
In-Reply-To: <20171010171122.9756-1-marcandre.lureau@redhat.com>
References: <20171010171122.9756-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/27] vhost-user-scsi: avoid use of iscsi_
 namespace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, f4bug@amsat.org, changpeng.liu@intel.com, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

It is confusing and could easily conflict with future versions.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index fdd6014712..c7f9d82142 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -247,7 +247,7 @@ struct scsi_task {
=20
 /** libiscsi integration **/
=20
-static int iscsi_add_lun(VusIscsiLun *lun, char *iscsi_uri)
+static int vus_iscsi_add_lun(VusIscsiLun *lun, char *iscsi_uri)
 {
     struct iscsi_url *iscsi_url;
     struct iscsi_context *iscsi_ctx;
@@ -703,7 +703,7 @@ int main(int argc, char **argv)
     }
     vdev_scsi =3D vdev_scsi_new(sock);
=20
-    if (iscsi_add_lun(&vdev_scsi->lun, iscsi_uri) !=3D 0) {
+    if (vus_iscsi_add_lun(&vdev_scsi->lun, iscsi_uri) !=3D 0) {
         goto err;
     }
=20
--=20
2.15.0.rc0.40.gaefcc5f6f
