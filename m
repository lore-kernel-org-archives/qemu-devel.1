Received: from eggs.gnu.org ([2001:4830:134:3::10]:39142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e22DF-00036w-4A
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 17:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e22DE-0002Ok-5S
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 17:37:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e22DD-0002OL-VD
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 17:37:16 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 23:34:54 +0200
Message-Id: <20171010213506.22989-16-marcandre.lureau@redhat.com>
In-Reply-To: <20171010213506.22989-1-marcandre.lureau@redhat.com>
References: <20171010213506.22989-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 15/27] vhost-user-scsi: assert() in
 iscsi_add_lun()
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

Instead of a preliminary check, add an assert to the function that has
the pre-condition.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index dd0de1fc89..0573ae794e 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -257,6 +257,7 @@ static int iscsi_add_lun(iscsi_lun_t *lun, char *iscs=
i_uri)
=20
     assert(lun);
     assert(iscsi_uri);
+    assert(!lun->iscsi_ctx);
=20
     iscsi_ctx =3D iscsi_create_context(VUS_ISCSI_INITIATOR);
     if (!iscsi_ctx) {
@@ -663,11 +664,6 @@ static int vdev_scsi_add_iscsi_lun(vhost_scsi_dev_t =
*vdev_scsi,
     assert(iscsi_uri);
     assert(lun < VUS_MAX_LUNS);
=20
-    if (vdev_scsi->luns[lun].iscsi_ctx) {
-        PERR("Lun %d already configured", lun);
-        return -1;
-    }
-
     if (iscsi_add_lun(&vdev_scsi->luns[lun], iscsi_uri) !=3D 0) {
         return -1;
     }
--=20
2.15.0.rc0.40.gaefcc5f6f
