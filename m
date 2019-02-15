Received: from eggs.gnu.org ([209.51.188.92]:46762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gufsC-00050i-0p
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gufs9-0002rm-Ve
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:57:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gufs8-0002mB-4s
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:57:53 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 15 Feb 2019 15:57:02 +0000
Message-Id: <20190215155709.15777-5-berrange@redhat.com>
In-Reply-To: <20190215155709.15777-1-berrange@redhat.com>
References: <20190215155709.15777-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 04/11] hw/usb: fix const-ness for string
 params in MTP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Various functions accepting 'char *' string parameters were missing
'const' qualifiers.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 hw/usb/dev-mtp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index f0c52a476a..169ee50c02 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -383,7 +383,7 @@ static const USBDesc desc =3D {
 /* ---------------------------------------------------------------------=
-- */
=20
 static MTPObject *usb_mtp_object_alloc(MTPState *s, uint32_t handle,
-                                       MTPObject *parent, char *name)
+                                       MTPObject *parent, const char *na=
me)
 {
     MTPObject *o =3D g_new0(MTPObject, 1);
=20
@@ -465,7 +465,7 @@ static MTPObject *usb_mtp_object_lookup(MTPState *s, =
uint32_t handle)
 }
=20
 static MTPObject *usb_mtp_add_child(MTPState *s, MTPObject *o,
-                                    char *name)
+                                    const char *name)
 {
     MTPObject *child =3D
         usb_mtp_object_alloc(s, s->next_handle++, o, name);
@@ -484,7 +484,7 @@ static MTPObject *usb_mtp_add_child(MTPState *s, MTPO=
bject *o,
 }
=20
 static MTPObject *usb_mtp_object_lookup_name(MTPObject *parent,
-                                             char *name, int len)
+                                             const char *name, int len)
 {
     MTPObject *iter;
=20
@@ -651,7 +651,7 @@ static void usb_mtp_inotify_cleanup(MTPState *s)
     }
 }
=20
-static int usb_mtp_add_watch(int inotifyfd, char *path)
+static int usb_mtp_add_watch(int inotifyfd, const char *path)
 {
     uint32_t mask =3D IN_CREATE | IN_DELETE | IN_MODIFY;
=20
--=20
2.20.1
