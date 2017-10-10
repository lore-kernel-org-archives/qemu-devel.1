Received: from eggs.gnu.org ([2001:4830:134:3::10]:38940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e22Cl-0002c0-4O
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 17:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e22Cg-00029B-7r
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 17:36:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e22Cg-00028Y-20
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 17:36:42 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 23:34:50 +0200
Message-Id: <20171010213506.22989-12-marcandre.lureau@redhat.com>
In-Reply-To: <20171010213506.22989-1-marcandre.lureau@redhat.com>
References: <20171010213506.22989-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 11/27] vhost-user-scsi: also free the gtree
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
 contrib/vhost-user-scsi/vhost-user-scsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index e3ae2bbd72..17f676bf00 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -693,6 +693,7 @@ static void vdev_scsi_free(vhost_scsi_dev_t *vdev_scs=
i)
     }
=20
     g_main_loop_unref(vdev_scsi->loop);
+    g_tree_destroy(vdev_scsi->fdmap);
     g_free(vdev_scsi);
 }
=20
--=20
2.15.0.rc0.40.gaefcc5f6f
