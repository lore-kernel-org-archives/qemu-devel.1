Received: from eggs.gnu.org ([209.51.188.92]:42704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guNUX-00007x-GN
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guNUV-0005Tc-T4
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1guNUV-0005PY-E0
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:15 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 14 Feb 2019 21:19:33 +0100
Message-Id: <20190214201939.494-4-philmd@redhat.com>
In-Reply-To: <20190214201939.494-1-philmd@redhat.com>
References: <20190214201939.494-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/9] ccid-card-passthru: Assert on a
 stricter expression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/usb/ccid-card-passthru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 1676b5fc05..0c44b38fc2 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -270,7 +270,7 @@ static void ccid_card_vscard_read(void *opaque, const=
 uint8_t *buf, int size)
     VSCMsgHeader *hdr;
=20
     assert(size <=3D VSCARD_IN_SIZE - card->vscard_in_pos);
-    assert(card->vscard_in_hdr < VSCARD_IN_SIZE);
+    assert(card->vscard_in_hdr < card->vscard_in_pos);
     memcpy(card->vscard_in_data + card->vscard_in_pos, buf, size);
     card->vscard_in_pos +=3D size;
     hdr =3D (VSCMsgHeader *)(card->vscard_in_data + card->vscard_in_hdr)=
;
--=20
2.20.1
