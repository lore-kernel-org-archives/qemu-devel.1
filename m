Received: from eggs.gnu.org ([2001:4830:134:3::10]:49148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1fKIKj-0005zN-3L
	for qemu-devel@nongnu.org; Sun, 20 May 2018 03:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1fKIKg-0004kE-GN
	for qemu-devel@nongnu.org; Sun, 20 May 2018 03:00:45 -0400
Received: from sauhun.de ([88.99.104.3]:54060 helo=pokefinder.org)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1fKIKg-0004je-9T
	for qemu-devel@nongnu.org; Sun, 20 May 2018 03:00:42 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Sun, 20 May 2018 09:00:36 +0200
Message-Id: <20180520070037.8593-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180520070037.8593-1-wsa+renesas@sang-engineering.com>
References: <20180520070037.8593-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 RESEND 2/3] nvram: at24c: use a sane default
 for "rom-size"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

0 as "rom-size" will lead to an error message. Let's use the size of a
small 24c01 which has 128 byte.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 hw/nvram/eeprom_at24c.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index ccf78b25e4..ab1ef686e2 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -28,6 +28,9 @@
 #define TYPE_AT24C_EE "at24c-eeprom"
 #define AT24C_EE(obj) OBJECT_CHECK(EEPROMState, (obj), TYPE_AT24C_EE)
=20
+/* default is the size of a 24c01 EEPROM */
+#define AT24C_ROMSIZE_DEFAULT 128
+
 typedef struct EEPROMState {
     I2CSlave parent_obj;
=20
@@ -171,7 +174,7 @@ void at24c_eeprom_reset(DeviceState *state)
 }
=20
 static Property at24c_eeprom_props[] =3D {
-    DEFINE_PROP_UINT32("rom-size", EEPROMState, rsize, 0),
+    DEFINE_PROP_UINT32("rom-size", EEPROMState, rsize, AT24C_ROMSIZE_DEF=
AULT),
     DEFINE_PROP_BOOL("writable", EEPROMState, writable, true),
     DEFINE_PROP_DRIVE("drive", EEPROMState, blk),
     DEFINE_PROP_END_OF_LIST()
--=20
2.11.0
