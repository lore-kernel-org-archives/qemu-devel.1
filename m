Received: from eggs.gnu.org ([2001:4830:134:3::10]:46100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLle-0005L3-4t
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLld-0001aG-AI
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:53:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duLld-0001ZW-4C
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:53:01 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Sep 2017 18:52:05 +0200
Message-Id: <20170919165226.23022-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170919165226.23022-1-marcandre.lureau@redhat.com>
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 06/27] vhost-user-scsi: use g_strdup()
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

Since vhost-user-scsi uses glib.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
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
