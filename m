Received: from eggs.gnu.org ([2001:4830:134:3::10]:45106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1y4f-0007wB-Ge
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:12:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1y4Z-0007SL-LP
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:12:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1y4Z-0007RF-ET
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:12:03 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 19:11:09 +0200
Message-Id: <20171010171122.9756-15-marcandre.lureau@redhat.com>
In-Reply-To: <20171010171122.9756-1-marcandre.lureau@redhat.com>
References: <20171010171122.9756-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/27] vhost-user-scsi: use NULL pointer
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index a9a4066eeb..dd0de1fc89 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -684,7 +684,7 @@ static int vdev_scsi_run(vhost_scsi_dev_t *vdev_scsi)
     assert(vdev_scsi->server_sock >=3D 0);
     assert(vdev_scsi->loop);
=20
-    cli_sock =3D accept(vdev_scsi->server_sock, (void *)0, (void *)0);
+    cli_sock =3D accept(vdev_scsi->server_sock, NULL, NULL);
     if (cli_sock < 0) {
         perror("accept");
         return -1;
--=20
2.15.0.rc0.40.gaefcc5f6f
