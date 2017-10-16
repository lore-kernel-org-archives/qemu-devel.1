Received: from eggs.gnu.org ([2001:4830:134:3::10]:55032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e45CM-0003F6-L2
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e45CK-00014Y-F0
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:12:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e45CK-00013A-6S
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:12:48 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 16 Oct 2017 15:12:40 +0200
Message-Id: <1508159564-30317-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1508159564-30317-1-git-send-email-thuth@redhat.com>
References: <1508159564-30317-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] hw/m68k: Replace fprintf(stderr,
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
Cc: peter.maydell@linaro.org, Dmitry Fleytman <dmitry@daynix.com>, Alistair Francis <alistair.francis@xilinx.com>

From: Alistair Francis <alistair.francis@xilinx.com>

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
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
[thuth: Remove "qemu:" prefix from strings]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/m68k/an5206.c  | 4 ++--
 hw/m68k/mcf5206.c | 3 ++-
 hw/m68k/mcf5208.c | 7 ++++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 9002c46..db634cb 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -66,7 +66,7 @@ static void an5206_init(MachineState *machine)
         if (qtest_enabled()) {
             return;
         }
-        fprintf(stderr, "Kernel image must be specified\n");
+        error_report("Kernel image must be specified");
         exit(1);
     }
 
@@ -83,7 +83,7 @@ static void an5206_init(MachineState *machine)
         entry = KERNEL_LOAD_ADDR;
     }
     if (kernel_size < 0) {
-        fprintf(stderr, "qemu: could not load kernel '%s'\n", kernel_filename);
+        error_report("Could not load kernel '%s'", kernel_filename);
         exit(1);
     }
 
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index b81901f..fbf3f0f 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -6,6 +6,7 @@
  * This code is licensed under the GPL
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
@@ -220,7 +221,7 @@ static void m5206_mbar_update(m5206_mbar_state *s)
                 break;
             default:
                 /* Unknown vector.  */
-                fprintf(stderr, "Unhandled vector for IRQ %d\n", irq);
+                error_report("Unhandled vector for IRQ %d", irq);
                 vector = 0xf;
                 break;
             }
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index b9dde75..c9c5f5e 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -6,6 +6,7 @@
  * This code is licensed under the GPL
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -257,7 +258,7 @@ static void mcf5208evb_init(MachineState *machine)
     mcf5208_sys_init(address_space_mem, pic);
 
     if (nb_nics > 1) {
-        fprintf(stderr, "Too many NICs\n");
+        error_report("Too many NICs");
         exit(1);
     }
     if (nd_table[0].used) {
@@ -292,7 +293,7 @@ static void mcf5208evb_init(MachineState *machine)
         if (qtest_enabled()) {
             return;
         }
-        fprintf(stderr, "Kernel image must be specified\n");
+        error_report("Kernel image must be specified");
         exit(1);
     }
 
@@ -309,7 +310,7 @@ static void mcf5208evb_init(MachineState *machine)
         entry = 0x40000000;
     }
     if (kernel_size < 0) {
-        fprintf(stderr, "qemu: could not load kernel '%s'\n", kernel_filename);
+        error_report("Could not load kernel '%s'", kernel_filename);
         exit(1);
     }
 
-- 
1.8.3.1
