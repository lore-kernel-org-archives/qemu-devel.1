Received: from eggs.gnu.org ([2001:4830:134:3::10]:45791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLlH-000549-QZ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLlH-0001IR-0d
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:52:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duLlG-0001Hm-Qu
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:52:38 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Sep 2017 18:52:00 +0200
Message-Id: <20170919165226.23022-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170919165226.23022-1-marcandre.lureau@redhat.com>
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 01/27] glib-compat: move
 G_SOURCE_CONTINUE/REMOVE there
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
Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 include/glib-compat.h                     | 7 +++++++
 contrib/vhost-user-scsi/vhost-user-scsi.c | 8 --------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index fcffcd3f07..d35d641b7f 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -354,5 +354,12 @@ g_test_add_data_func_full(const char *path,
 }
 #endif
=20
+/* Small compat shim from glib 2.32 */
+#ifndef G_SOURCE_CONTINUE
+#define G_SOURCE_CONTINUE TRUE
+#endif
+#ifndef G_SOURCE_REMOVE
+#define G_SOURCE_REMOVE FALSE
+#endif
=20
 #endif
diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index b5ae02c96f..78bcc65f5a 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -17,14 +17,6 @@
=20
 #include <glib.h>
=20
-/* Small compat shim from glib 2.32 */
-#ifndef G_SOURCE_CONTINUE
-#define G_SOURCE_CONTINUE TRUE
-#endif
-#ifndef G_SOURCE_REMOVE
-#define G_SOURCE_REMOVE FALSE
-#endif
-
 /* #define VUS_DEBUG 1 */
=20
 /** Log helpers **/
--=20
2.14.1.146.gd35faa819
