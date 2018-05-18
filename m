Received: from eggs.gnu.org ([2001:4830:134:3::10]:49412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJa9e-0000bz-IT
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJa9d-0003LJ-QV
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:50:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60826 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fJa9d-0003L0-LT
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:50:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3490B4201B05
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 07:50:21 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 18 May 2018 09:50:14 +0200
Message-Id: <20180518075015.1290-2-kraxel@redhat.com>
In-Reply-To: <20180518075015.1290-1-kraxel@redhat.com>
References: <20180518075015.1290-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] ccid-card-passthru: fix regression in
 realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Since cc847bfd16d894fd8c1a2ce25f31772f6cdbbc74, CCID card-passthru
fails to intialize, because it changed a debug line to an error,
probably by mistake. Change it back to a DPRINTF debug.

(solves Boxes creating VM with smartcard passthru failing to start)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180515153039.27514-1-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/ccid-card-passthru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 7684db0cb3..25fb19b0d7 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -345,7 +345,7 @@ static void passthru_realize(CCIDCardState *base, Err=
or **errp)
     card->vscard_in_pos =3D 0;
     card->vscard_in_hdr =3D 0;
     if (qemu_chr_fe_backend_connected(&card->cs)) {
-        error_setg(errp, "ccid-card-passthru: initing chardev");
+        DPRINTF(card, D_INFO, "ccid-card-passthru: initing chardev");
         qemu_chr_fe_set_handlers(&card->cs,
             ccid_card_vscard_can_read,
             ccid_card_vscard_read,
--=20
2.9.3
