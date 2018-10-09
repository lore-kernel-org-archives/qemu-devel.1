Received: from eggs.gnu.org ([2001:4830:134:3::10]:47146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9rhc-00081C-VV
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9rhS-00042g-SX
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:05:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1g9rhH-0003rS-Ig
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:05:13 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue,  9 Oct 2018 14:04:35 +0100
Message-Id: <20181009130442.26296-5-berrange@redhat.com>
In-Reply-To: <20181009130442.26296-1-berrange@redhat.com>
References: <20181009130442.26296-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 04/11] hw/usb: fix const-ness for string
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
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>

Various functions accepting 'char *' string parameters were missing
'const' qualifiers.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 hw/usb/dev-mtp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index f026419e47..ccbe25820b 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -372,7 +372,7 @@ static const USBDesc desc =3D {
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
@@ -454,7 +454,7 @@ static MTPObject *usb_mtp_object_lookup(MTPState *s, =
uint32_t handle)
 }
=20
 static MTPObject *usb_mtp_add_child(MTPState *s, MTPObject *o,
-                                    char *name)
+                                    const char *name)
 {
     MTPObject *child =3D
         usb_mtp_object_alloc(s, s->next_handle++, o, name);
@@ -473,7 +473,7 @@ static MTPObject *usb_mtp_add_child(MTPState *s, MTPO=
bject *o,
 }
=20
 static MTPObject *usb_mtp_object_lookup_name(MTPObject *parent,
-                                             char *name, int len)
+                                             const char *name, int len)
 {
     MTPObject *iter;
=20
@@ -640,7 +640,7 @@ static void usb_mtp_inotify_cleanup(MTPState *s)
     }
 }
=20
-static int usb_mtp_add_watch(int inotifyfd, char *path)
+static int usb_mtp_add_watch(int inotifyfd, const char *path)
 {
     uint32_t mask =3D IN_CREATE | IN_DELETE | IN_MODIFY;
=20
--=20
2.17.1
