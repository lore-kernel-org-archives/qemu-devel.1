Received: from eggs.gnu.org ([2001:4830:134:3::10]:60094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOO0q-0001gG-O4
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOO0m-0004RP-DA
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dOO0m-0004P9-2H
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:32 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 23 Jun 2017 14:48:27 +0200
Message-Id: <20170623124829.24260-2-kraxel@redhat.com>
In-Reply-To: <20170623124829.24260-1-kraxel@redhat.com>
References: <20170623124829.24260-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] applesmc: cosmetic whitespace and
 indentation cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Gabriel L. Somlo" <gsomlo@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Gabriel L. Somlo" <gsomlo@gmail.com>

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Alexander Graf <agraf@suse.de>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Message-id: 1497639316-22202-2-git-send-email-gsomlo@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/misc/applesmc.c | 98 ++++++++++++++++++++++++++++--------------------=
------
 1 file changed, 50 insertions(+), 48 deletions(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 77fab5b9d2..6381197728 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -39,21 +39,24 @@
 /* #define DEBUG_SMC */
=20
 #define APPLESMC_DEFAULT_IOBASE        0x300
-/* data port used by Apple SMC */
-#define APPLESMC_DATA_PORT             0x0
-/* command/status port used by Apple SMC */
-#define APPLESMC_CMD_PORT              0x4
-#define APPLESMC_NR_PORTS              32
=20
-#define APPLESMC_READ_CMD              0x10
-#define APPLESMC_WRITE_CMD             0x11
-#define APPLESMC_GET_KEY_BY_INDEX_CMD  0x12
-#define APPLESMC_GET_KEY_TYPE_CMD      0x13
+enum {
+    APPLESMC_DATA_PORT               =3D 0x00,
+    APPLESMC_CMD_PORT                =3D 0x04,
+    APPLESMC_NUM_PORTS               =3D 0x20,
+};
+
+enum {
+    APPLESMC_READ_CMD                =3D 0x10,
+    APPLESMC_WRITE_CMD               =3D 0x11,
+    APPLESMC_GET_KEY_BY_INDEX_CMD    =3D 0x12,
+    APPLESMC_GET_KEY_TYPE_CMD        =3D 0x13,
+};
=20
 #ifdef DEBUG_SMC
 #define smc_debug(...) fprintf(stderr, "AppleSMC: " __VA_ARGS__)
 #else
-#define smc_debug(...) do { } while(0)
+#define smc_debug(...) do { } while (0)
 #endif
=20
 static char default_osk[64] =3D "This is a dummy key. Enter the real key=
 "
@@ -77,12 +80,11 @@ struct AppleSMCState {
     uint32_t iobase;
     uint8_t cmd;
     uint8_t status;
-    uint8_t key[4];
+    char key[4];
     uint8_t read_pos;
     uint8_t data_len;
     uint8_t data_pos;
     uint8_t data[255];
-    uint8_t charactic[4];
     char *osk;
     QLIST_HEAD(, AppleSMCData) data_def;
 };
@@ -93,10 +95,10 @@ static void applesmc_io_cmd_write(void *opaque, hwadd=
r addr, uint64_t val,
     AppleSMCState *s =3D opaque;
=20
     smc_debug("CMD Write B: %#x =3D %#x\n", addr, val);
-    switch(val) {
-        case APPLESMC_READ_CMD:
-            s->status =3D 0x0c;
-            break;
+    switch (val) {
+    case APPLESMC_READ_CMD:
+        s->status =3D 0x0c;
+        break;
     }
     s->cmd =3D val;
     s->read_pos =3D 0;
@@ -123,54 +125,54 @@ static void applesmc_io_data_write(void *opaque, hw=
addr addr, uint64_t val,
     AppleSMCState *s =3D opaque;
=20
     smc_debug("DATA Write B: %#x =3D %#x\n", addr, val);
-    switch(s->cmd) {
-        case APPLESMC_READ_CMD:
-            if(s->read_pos < 4) {
-                s->key[s->read_pos] =3D val;
-                s->status =3D 0x04;
-            } else if(s->read_pos =3D=3D 4) {
-                s->data_len =3D val;
-                s->status =3D 0x05;
-                s->data_pos =3D 0;
-                smc_debug("Key =3D %c%c%c%c Len =3D %d\n", s->key[0],
-                          s->key[1], s->key[2], s->key[3], val);
-                applesmc_fill_data(s);
-            }
-            s->read_pos++;
-            break;
+    switch (s->cmd) {
+    case APPLESMC_READ_CMD:
+        if (s->read_pos < 4) {
+            s->key[s->read_pos] =3D val;
+            s->status =3D 0x04;
+        } else if (s->read_pos =3D=3D 4) {
+            s->data_len =3D val;
+            s->status =3D 0x05;
+            s->data_pos =3D 0;
+            smc_debug("Key =3D %c%c%c%c Len =3D %d\n", s->key[0],
+                      s->key[1], s->key[2], s->key[3], val);
+            applesmc_fill_data(s);
+        }
+        s->read_pos++;
+        break;
     }
 }
=20
-static uint64_t applesmc_io_data_read(void *opaque, hwaddr addr1,
-                                      unsigned size)
+static uint64_t applesmc_io_data_read(void *opaque, hwaddr addr, unsigne=
d size)
 {
     AppleSMCState *s =3D opaque;
     uint8_t retval =3D 0;
=20
-    switch(s->cmd) {
-        case APPLESMC_READ_CMD:
-            if(s->data_pos < s->data_len) {
-                retval =3D s->data[s->data_pos];
-                smc_debug("READ_DATA[%d] =3D %#hhx\n", s->data_pos,
-                          retval);
-                s->data_pos++;
-                if(s->data_pos =3D=3D s->data_len) {
-                    s->status =3D 0x00;
-                    smc_debug("EOF\n");
-                } else
-                    s->status =3D 0x05;
+    switch (s->cmd) {
+    case APPLESMC_READ_CMD:
+        if (s->data_pos < s->data_len) {
+            retval =3D s->data[s->data_pos];
+            smc_debug("READ_DATA[%d] =3D %#hhx\n", s->data_pos,
+                      retval);
+            s->data_pos++;
+            if (s->data_pos =3D=3D s->data_len) {
+                s->status =3D 0x00;
+                smc_debug("EOF\n");
+            } else {
+                s->status =3D 0x05;
             }
+        }
     }
-    smc_debug("DATA Read b: %#x =3D %#x\n", addr1, retval);
+    smc_debug("DATA Read b: %#x =3D %#x\n", addr, retval);
=20
     return retval;
 }
=20
-static uint64_t applesmc_io_cmd_read(void *opaque, hwaddr addr1, unsigne=
d size)
+static uint64_t applesmc_io_cmd_read(void *opaque, hwaddr addr, unsigned=
 size)
 {
     AppleSMCState *s =3D opaque;
=20
-    smc_debug("CMD Read B: %#x\n", addr1);
+    smc_debug("CMD Read B: %#x\n", addr);
     return s->status;
 }
=20
--=20
2.9.3
