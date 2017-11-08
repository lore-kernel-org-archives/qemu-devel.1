Received: from eggs.gnu.org ([2001:4830:134:3::10]:34063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZLL-0007km-CA
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZLI-00035n-6c
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:11 -0500
Received: from mail-dm3nam03on0069.outbound.protection.outlook.com
	([104.47.41.69]:15784
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCZLH-00035X-UT
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:08 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:56:55 -0800
Message-ID: <52a2e1755b0e8d163c2d59a77adfad48976fbbdc.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 10/45] hw/cris: Replace fprintf(stderr,
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
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Reviewed-by: Philippe Mathieu-Daud <f4bug@amsat.org>
---
V2:
 - Split hw patch into individual directories

 hw/cris/axis_dev88.c | 3 ++-
 hw/cris/boot.c       | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 9ccc4350a5..df124d5128 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -345,7 +346,7 @@ void axisdev88_init(MachineState *machine)
         li.cmdline = kernel_cmdline;
         cris_load_image(cpu, &li);
     } else if (!qtest_enabled()) {
-        fprintf(stderr, "Kernel image must be specified\n");
+        error_report("Kernel image must be specified");
         exit(1);
     }
 }
diff --git a/hw/cris/boot.c b/hw/cris/boot.c
index f896ed7f86..fda0a039b8 100644
--- a/hw/cris/boot.c
+++ b/hw/cris/boot.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
@@ -86,14 +87,13 @@ void cris_load_image(CRISCPU *cpu, struct cris_load_info *li)
     }
 
     if (image_size < 0) {
-        fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                li->image_filename);
+        error_report("could not load kernel '%s'", li->image_filename);
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
2.14.1
