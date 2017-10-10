Received: from eggs.gnu.org ([2001:4830:134:3::10]:44943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1y4F-0007XT-Ef
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1y4E-0007GJ-II
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:11:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1y4E-0007Fp-Bu
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:11:42 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 19:11:01 +0200
Message-Id: <20171010171122.9756-7-marcandre.lureau@redhat.com>
In-Reply-To: <20171010171122.9756-1-marcandre.lureau@redhat.com>
References: <20171010171122.9756-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/27] vhost-user-scsi: use g_strdup()
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
2.15.0.rc0.40.gaefcc5f6f
