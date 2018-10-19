Received: from eggs.gnu.org ([2001:4830:134:3::10]:38036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDUzP-0004SD-Gx
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDUzM-0000Bh-B3
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:38:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDUzL-000058-8K
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:38:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC1DD39B3E
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 13:38:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 19 Oct 2018 14:38:27 +0100
Message-Id: <20181019133835.16494-4-berrange@redhat.com>
In-Reply-To: <20181019133835.16494-1-berrange@redhat.com>
References: <20181019133835.16494-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 03/11] hw/usb: don't set IN_ISDIR for
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

IN_ISDIR is not a bit that one can request when registering a
watch with inotify_add_watch. Rather it is a bit that is set
automatically when reading events from the kernel.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 hw/usb/dev-mtp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 00a3691bae..f026419e47 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -642,8 +642,7 @@ static void usb_mtp_inotify_cleanup(MTPState *s)
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
2.17.2
