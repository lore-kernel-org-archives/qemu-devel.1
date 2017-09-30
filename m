Received: from eggs.gnu.org ([2001:4830:134:3::10]:60327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dy5Vj-0004Mf-Qb
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dy5Vg-0005Va-KB
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:20:03 -0400
Received: from mail-co1nam03on0047.outbound.protection.outlook.com
	([104.47.40.47]:32496
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dy5Vg-0005UB-AU
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:20:00 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 29 Sep 2017 17:16:06 -0700
Message-ID: <231156c8147daa1677d29d16d368030ea38adf62.1506730372.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1506730372.git.alistair.francis@xilinx.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 22/47] hw/m68k: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com
List-ID: <qemu-devel.nongnu.org>

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
Thomas Huth <huth@tuxfamily.org>
---
V2:
 - Split hw patch into individual directories

 hw/m68k/an5206.c  | 4 ++--
 hw/m68k/mcf5206.c | 3 ++-
 hw/m68k/mcf5208.c | 7 ++++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 9002c460e5..bdab620a02 100644
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
+        error_report("qemu: could not load kernel '%s'", kernel_filename);
         exit(1);
     }
 
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index b81901fdfd..fbf3f0f074 100644
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
index b9dde75106..2fb5037b72 100644
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
+        error_report("qemu: could not load kernel '%s'", kernel_filename);
         exit(1);
     }
 
-- 
2.11.0
