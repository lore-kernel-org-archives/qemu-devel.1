Received: from eggs.gnu.org ([209.51.188.92]:42939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guNVA-0000cA-L3
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1guNV8-00066I-O6
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1guNV6-0005vy-SI
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:20:53 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 14 Feb 2019 21:19:39 +0100
Message-Id: <20190214201939.494-10-philmd@redhat.com>
In-Reply-To: <20190214201939.494-1-philmd@redhat.com>
References: <20190214201939.494-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 9/9] ccid-card-passthru: Use size_t for index
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

The variable 'opt_bytes' is an index to the data[] array.
Use size_t for indexes.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/usb/ccid-card-passthru.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 083eb5ca08..664e8a1b54 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -152,7 +152,7 @@ static void ccid_card_vscard_handle_init(
 static int check_atr(PassthruState *card, uint8_t *data, size_t len)
 {
     size_t historical_length;
-    int opt_bytes;
+    size_t opt_bytes;
     int td_count =3D 0;
     int td;
=20
@@ -192,12 +192,13 @@ static int check_atr(PassthruState *card, uint8_t *=
data, size_t len)
     }
     if (len > 2 + historical_length + opt_bytes) {
         DPRINTF(card, D_WARN,
-            "atr too long: len %zu, but hist/opt %zu/%d, T1 0x%X\n",
+            "atr too long: len %zu, but hist/opt %zu/%zu, T1 0x%X\n",
             len, historical_length, opt_bytes, data[1]);
         /* let it through */
     }
     DPRINTF(card, D_VERBOSE,
-            "atr passes check: %zu total length, %zu historical, %d opti=
onal\n",
+            "atr passes check: %zu total length,"
+            " %zu historical, %zu optional\n",
             len, historical_length, opt_bytes);
=20
     return 1;
--=20
2.20.1
