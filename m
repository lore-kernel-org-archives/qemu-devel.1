Received: from eggs.gnu.org ([2001:4830:134:3::10]:44583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1dLwP8-0004UC-0B
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1dLwP4-0006Vn-VT
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:55:34 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gsomlo@gmail.com>) id 1dLwP4-0006VT-Oa
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:55:30 -0400
Received: by mail-qt0-x243.google.com with SMTP id x58so12311428qtc.2
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 11:55:30 -0700 (PDT)
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
Date: Fri, 16 Jun 2017 14:55:14 -0400
Message-Id: <1497639316-22202-2-git-send-email-gsomlo@gmail.com>
In-Reply-To: <1497639316-22202-1-git-send-email-gsomlo@gmail.com>
References: <1497639316-22202-1-git-send-email-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/3] applesmc: cosmetic whitespace and
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
Cc: agraf@suse.de, pbonzini@redhat.com, f4bug@amsat.org, eshelton@pobox.com

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Alexander Graf <agraf@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/misc/applesmc.c | 98 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 50 insertions(+), 48 deletions(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 77fab5b..6381197 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -39,21 +39,24 @@
 /* #define DEBUG_SMC */
 
 #define APPLESMC_DEFAULT_IOBASE        0x300
-/* data port used by Apple SMC */
-#define APPLESMC_DATA_PORT             0x0
-/* command/status port used by Apple SMC */
-#define APPLESMC_CMD_PORT              0x4
-#define APPLESMC_NR_PORTS              32
 
-#define APPLESMC_READ_CMD              0x10
-#define APPLESMC_WRITE_CMD             0x11
-#define APPLESMC_GET_KEY_BY_INDEX_CMD  0x12
-#define APPLESMC_GET_KEY_TYPE_CMD      0x13
+enum {
+    APPLESMC_DATA_PORT               = 0x00,
+    APPLESMC_CMD_PORT                = 0x04,
+    APPLESMC_NUM_PORTS               = 0x20,
+};
+
+enum {
+    APPLESMC_READ_CMD                = 0x10,
+    APPLESMC_WRITE_CMD               = 0x11,
+    APPLESMC_GET_KEY_BY_INDEX_CMD    = 0x12,
+    APPLESMC_GET_KEY_TYPE_CMD        = 0x13,
+};
 
 #ifdef DEBUG_SMC
 #define smc_debug(...) fprintf(stderr, "AppleSMC: " __VA_ARGS__)
 #else
-#define smc_debug(...) do { } while(0)
+#define smc_debug(...) do { } while (0)
 #endif
 
 static char default_osk[64] = "This is a dummy key. Enter the real key "
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
@@ -93,10 +95,10 @@ static void applesmc_io_cmd_write(void *opaque, hwaddr addr, uint64_t val,
     AppleSMCState *s = opaque;
 
     smc_debug("CMD Write B: %#x = %#x\n", addr, val);
-    switch(val) {
-        case APPLESMC_READ_CMD:
-            s->status = 0x0c;
-            break;
+    switch (val) {
+    case APPLESMC_READ_CMD:
+        s->status = 0x0c;
+        break;
     }
     s->cmd = val;
     s->read_pos = 0;
@@ -123,54 +125,54 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
     AppleSMCState *s = opaque;
 
     smc_debug("DATA Write B: %#x = %#x\n", addr, val);
-    switch(s->cmd) {
-        case APPLESMC_READ_CMD:
-            if(s->read_pos < 4) {
-                s->key[s->read_pos] = val;
-                s->status = 0x04;
-            } else if(s->read_pos == 4) {
-                s->data_len = val;
-                s->status = 0x05;
-                s->data_pos = 0;
-                smc_debug("Key = %c%c%c%c Len = %d\n", s->key[0],
-                          s->key[1], s->key[2], s->key[3], val);
-                applesmc_fill_data(s);
-            }
-            s->read_pos++;
-            break;
+    switch (s->cmd) {
+    case APPLESMC_READ_CMD:
+        if (s->read_pos < 4) {
+            s->key[s->read_pos] = val;
+            s->status = 0x04;
+        } else if (s->read_pos == 4) {
+            s->data_len = val;
+            s->status = 0x05;
+            s->data_pos = 0;
+            smc_debug("Key = %c%c%c%c Len = %d\n", s->key[0],
+                      s->key[1], s->key[2], s->key[3], val);
+            applesmc_fill_data(s);
+        }
+        s->read_pos++;
+        break;
     }
 }
 
-static uint64_t applesmc_io_data_read(void *opaque, hwaddr addr1,
-                                      unsigned size)
+static uint64_t applesmc_io_data_read(void *opaque, hwaddr addr, unsigned size)
 {
     AppleSMCState *s = opaque;
     uint8_t retval = 0;
 
-    switch(s->cmd) {
-        case APPLESMC_READ_CMD:
-            if(s->data_pos < s->data_len) {
-                retval = s->data[s->data_pos];
-                smc_debug("READ_DATA[%d] = %#hhx\n", s->data_pos,
-                          retval);
-                s->data_pos++;
-                if(s->data_pos == s->data_len) {
-                    s->status = 0x00;
-                    smc_debug("EOF\n");
-                } else
-                    s->status = 0x05;
+    switch (s->cmd) {
+    case APPLESMC_READ_CMD:
+        if (s->data_pos < s->data_len) {
+            retval = s->data[s->data_pos];
+            smc_debug("READ_DATA[%d] = %#hhx\n", s->data_pos,
+                      retval);
+            s->data_pos++;
+            if (s->data_pos == s->data_len) {
+                s->status = 0x00;
+                smc_debug("EOF\n");
+            } else {
+                s->status = 0x05;
             }
+        }
     }
-    smc_debug("DATA Read b: %#x = %#x\n", addr1, retval);
+    smc_debug("DATA Read b: %#x = %#x\n", addr, retval);
 
     return retval;
 }
 
-static uint64_t applesmc_io_cmd_read(void *opaque, hwaddr addr1, unsigned size)
+static uint64_t applesmc_io_cmd_read(void *opaque, hwaddr addr, unsigned size)
 {
     AppleSMCState *s = opaque;
 
-    smc_debug("CMD Read B: %#x\n", addr1);
+    smc_debug("CMD Read B: %#x\n", addr);
     return s->status;
 }
 
-- 
2.7.4
