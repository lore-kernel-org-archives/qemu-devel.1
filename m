Received: from eggs.gnu.org ([209.51.188.92]:42254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gx4An-0002zB-5x
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:19:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gx415-00055C-Uo
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:09:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gx415-0004qL-Md
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:08:59 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 22 Feb 2019 07:07:59 +0100
Message-Id: <20190222060759.17906-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] fixup! display: add -display spice-app
 launching a Spice client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: spice-devel@lists.freedesktop.org
Cc: kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

---
 ui/spice-app.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ui/spice-app.c b/ui/spice-app.c
index 4f5229f3ee..925b27b708 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -181,6 +181,8 @@ static void spice_app_display_init(DisplayState *ds, =
DisplayOptions *opts)
     g_app_info_launch_default_for_uri(uri, NULL, &err);
     if (err) {
         error_report("Failed to launch %s URI: %s", uri, err->message);
+        error_report("You need a capable Spice client, "
+                     "such as virt-viewer 8.0");
         exit(1);
     }
     g_free(uri);
--=20
2.21.0.rc1
