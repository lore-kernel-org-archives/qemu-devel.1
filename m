Received: from eggs.gnu.org ([2001:4830:134:3::10]:60084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dy5VG-0003w3-BO
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dy5VD-0004Tg-5S
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:19:34 -0400
Received: from mail-cys01nam02on0059.outbound.protection.outlook.com
	([104.47.37.59]:2831
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dy5VC-0004Qr-TQ
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:19:31 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 29 Sep 2017 17:15:30 -0700
Message-ID: <e73e18c2d124841f63e026e9cbc026321f86aade.1506730372.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1506730372.git.alistair.francis@xilinx.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 10/47] hw/cris: Replace fprintf(stderr,
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
"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
---
V2:
 - Split hw patch into individual directories

 hw/cris/axis_dev88.c | 3 ++-
 hw/cris/boot.c       | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 5eb552bce2..d121836b69 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -349,7 +350,7 @@ void axisdev88_init(MachineState *machine)
         li.cmdline = kernel_cmdline;
         cris_load_image(cpu, &li);
     } else if (!qtest_enabled()) {
-        fprintf(stderr, "Kernel image must be specified\n");
+        error_report("Kernel image must be specified");
         exit(1);
     }
 }
diff --git a/hw/cris/boot.c b/hw/cris/boot.c
index f896ed7f86..f199a13a82 100644
--- a/hw/cris/boot.c
+++ b/hw/cris/boot.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
@@ -86,14 +87,14 @@ void cris_load_image(CRISCPU *cpu, struct cris_load_info *li)
     }
 
     if (image_size < 0) {
-        fprintf(stderr, "qemu: could not load kernel '%s'\n",
+        error_report("qemu: could not load kernel '%s'",
                 li->image_filename);
         exit(1);
     }
 
     if (li->cmdline && (kcmdline_len = strlen(li->cmdline))) {
         if (kcmdline_len > 256) {
-            fprintf(stderr, "Too long CRIS kernel cmdline (max 256)\n");
+            error_report("Too long CRIS kernel cmdline (max 256)");
             exit(1);
         }
         pstrcpy_targphys("cmdline", 0x40000000, 256, li->cmdline);
-- 
2.11.0
