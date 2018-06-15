Received: from eggs.gnu.org ([2001:4830:134:3::10]:56432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTqrd-00010B-Ia
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTqrc-0000W6-Mv
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:42:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fTqrc-0000VD-IV
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:42:12 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 15 Jun 2018 16:41:55 +0100
Message-Id: <20180615154203.11347-4-berrange@redhat.com>
In-Reply-To: <20180615154203.11347-1-berrange@redhat.com>
References: <20180615154203.11347-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/11] hw/usb: don't set IN_ISDIR for
 inotify watch in MTP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

IN_ISDIR is not a bit that one can request when registering a
watch with inotify_add_watch. Rather it is a bit that is set
automatically when reading events from the kernel.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 hw/usb/dev-mtp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 1ded7ac9a3..80f88e40fa 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -638,8 +638,7 @@ static void usb_mtp_inotify_cleanup(MTPState *s)
=20
 static int usb_mtp_add_watch(int inotifyfd, char *path)
 {
-    uint32_t mask =3D IN_CREATE | IN_DELETE | IN_MODIFY |
-        IN_ISDIR;
+    uint32_t mask =3D IN_CREATE | IN_DELETE | IN_MODIFY;
=20
     return inotify_add_watch(inotifyfd, path, mask);
 }
--=20
2.17.0
