Received: from eggs.gnu.org ([2001:4830:134:3::10]:43333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYOI-0005E4-7a
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYOH-0006fw-0M
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkYOG-0006ee-R8
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:24 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 18:19:41 +0200
Message-Id: <20170823162004.27337-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170823162004.27337-1-marcandre.lureau@redhat.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/27] vhost-user-scsi: use g_strdup()
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

Since vhost-user-scsi uses glib.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index 78bcc65f5a..1fb57da2da 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -822,10 +822,10 @@ int main(int argc, char **argv)
         case 'h':
             goto help;
         case 'u':
-            unix_fn =3D strdup(optarg);
+            unix_fn =3D g_strdup(optarg);
             break;
         case 'i':
-            iscsi_uri =3D strdup(optarg);
+            iscsi_uri =3D g_strdup(optarg);
             break;
         default:
             goto help;
@@ -854,12 +854,8 @@ out:
         vdev_scsi_deinit(vdev_scsi);
         free(vdev_scsi);
     }
-    if (unix_fn) {
-        free(unix_fn);
-    }
-    if (iscsi_uri) {
-        free(iscsi_uri);
-    }
+    g_free(unix_fn);
+    g_free(iscsi_uri);
=20
     return err;
=20
--=20
2.14.1.146.gd35faa819
