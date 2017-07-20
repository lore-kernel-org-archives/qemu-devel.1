Received: from eggs.gnu.org ([2001:4830:134:3::10]:35355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY6ms-0006Al-Nf
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY6mr-0004qZ-U1
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:26:22 -0400
Received: from manul.sfritsch.de ([2a01:4f8:172:195f:112::2]:36942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sf@sfritsch.de>) id 1dY6mr-0004qR-NB
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:26:21 -0400
From: Stefan Fritsch <sf@sfritsch.de>
Date: Thu, 20 Jul 2017 10:25:22 +0200
Message-Id: <1500539123-23884-8-git-send-email-sf@sfritsch.de>
In-Reply-To: <1500539123-23884-1-git-send-email-sf@sfritsch.de>
References: <1500539123-23884-1-git-send-email-sf@sfritsch.de>
Subject: [Qemu-devel] [PATCH 7/8] usb-ccid: Increase ccid max APDU size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Fritsch <stefan_fritsch@genua.de>

From: Stefan Fritsch <stefan_fritsch@genua.de>

The emulated ccid smartcard reader has a fixed limit for APDUs from the
card. Increase this to 1024. We have seen software that tries to use 768
byte APDUs.

Signed-off-by: Stefan Fritsch <stefan_fritsch@genua.de>
---
 hw/usb/dev-smartcard-reader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 974ecad18d..dff856d456 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -82,7 +82,7 @@ static void usb_packet_dump(int lvl, const char *dir, uint8_t *buf, size_t len)
 #define BULK_OUT_DATA_SIZE 65536
 #define PENDING_ANSWERS_NUM 128
 
-#define BULK_IN_BUF_SIZE 384
+#define BULK_IN_BUF_SIZE 1024
 #define BULK_IN_PENDING_NUM 8
 
 #define CCID_MAX_PACKET_SIZE                64
-- 
2.11.0
