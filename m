Received: from eggs.gnu.org ([2001:4830:134:3::10]:54991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e5DYE-00048G-Rr
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e5DYB-0000uN-IZ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:20:06 -0400
Received: from mail-bn3nam01on0080.outbound.protection.outlook.com
	([104.47.33.80]:65476
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1e5DYB-0000tw-C1
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:20:03 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 19 Oct 2017 09:16:03 -0700
Message-ID: <136f534d6337e148924913a06c43b2e06fcebb4c.1508390588.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1508390588.git.alistair.francis@xilinx.com>
References: <cover.1508390588.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 08/46] hw/char: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
V2:
 - Split hw patch into individual directories

 hw/char/mcf_uart.c  | 5 +++--
 hw/char/sh_serial.c | 9 +++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 56fa402b58..14cb051be9 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -6,6 +6,7 @@
  * This code is licensed under the GPL
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/m68k/mcf.h"
@@ -174,7 +175,7 @@ static void mcf_do_command(mcf_uart_state *s, uint8_t cmd)
         mcf_uart_do_tx(s);
         break;
     case 3: /* Reserved.  */
-        fprintf(stderr, "mcf_uart: Bad TX command\n");
+        error_report("mcf_uart: Bad TX command");
         break;
     }
 
@@ -189,7 +190,7 @@ static void mcf_do_command(mcf_uart_state *s, uint8_t cmd)
         s->rx_enabled = 0;
         break;
     case 3: /* Reserved.  */
-        fprintf(stderr, "mcf_uart: Bad RX command\n");
+        error_report("mcf_uart: Bad RX command");
         break;
     }
 }
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 835b5378a0..7bb3f3c70b 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -25,6 +25,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/sh4/sh.h"
 #include "chardev/char-fe.h"
@@ -190,8 +191,8 @@ static void sh_serial_write(void *opaque, hwaddr offs,
         }
     }
 
-    fprintf(stderr, "sh_serial: unsupported write to 0x%02"
-            HWADDR_PRIx "\n", offs);
+    error_report("sh_serial: unsupported write to 0x%02"
+                 HWADDR_PRIx "", offs);
     abort();
 }
 
@@ -290,8 +291,8 @@ static uint64_t sh_serial_read(void *opaque, hwaddr offs,
 #endif
 
     if (ret & ~((1 << 16) - 1)) {
-        fprintf(stderr, "sh_serial: unsupported read from 0x%02"
-                HWADDR_PRIx "\n", offs);
+        error_report("sh_serial: unsupported read from 0x%02"
+                     HWADDR_PRIx "", offs);
         abort();
     }
 
-- 
2.11.0
