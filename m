Received: from eggs.gnu.org ([209.51.188.92]:57761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gyFQG-000511-Jh
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gyFQC-00051X-4U
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:31:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gyFQB-00050z-Ur
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:31:48 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 25 Feb 2019 12:31:03 +0000
Message-Id: <20190225123111.30363-4-berrange@redhat.com>
In-Reply-To: <20190225123111.30363-1-berrange@redhat.com>
References: <20190225123111.30363-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/11] hw/usb: don't set IN_ISDIR for inotify
 watch in MTP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

IN_ISDIR is not a bit that one can request when registering a
watch with inotify_add_watch. Rather it is a bit that is set
automatically when reading events from the kernel.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 hw/usb/dev-mtp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index f1d20fa1b9..f0c52a476a 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -653,8 +653,7 @@ static void usb_mtp_inotify_cleanup(MTPState *s)
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
2.20.1
