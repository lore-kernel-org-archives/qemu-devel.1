Received: from eggs.gnu.org ([2001:4830:134:3::10]:39235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUqLz-00075i-U9
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUqLw-0000TF-0M
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:21:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59394 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fUqLv-0000SC-Qz
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:21:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC090401EF00
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 09:21:34 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 18 Jun 2018 11:21:30 +0200
Message-Id: <20180618092132.7253-2-kraxel@redhat.com>
In-Reply-To: <20180618092132.7253-1-kraxel@redhat.com>
References: <20180618092132.7253-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] Revert "usb-ccid: fix bus leak"
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

The bus is not owned by the device.

This reverts commit 410a096adf991ce437d4d7dabc59b6557e6d488d.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180613172815.32738-2-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
index fa546fb3ce..13d0befd9c 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1147,7 +1147,6 @@ static void ccid_unrealize(USBDevice *dev, Error **=
errp)
     USBCCIDState *s =3D USB_CCID_DEV(dev);
=20
     ccid_bulk_in_clear(s);
-    object_unref(OBJECT(&s->bus));
 }
=20
 static void ccid_flush_pending_answers(USBCCIDState *s)
--=20
2.9.3
