Received: from eggs.gnu.org ([209.51.188.92]:36419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2FLB-0004th-Rz
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:15:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2FL4-0006UP-5F
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:15:07 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  8 Mar 2019 14:14:45 +0100
Message-Id: <20190308131445.17502-13-armbru@redhat.com>
In-Reply-To: <20190308131445.17502-1-armbru@redhat.com>
References: <20190308131445.17502-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 12/12] docs/interop/firmware.json: Prefer
 -machine to if=pflash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com

The previous commit added a way to configure firmware with -blockdev
rather than -drive if=pflash.  Document it as the preferred way.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/interop/firmware.json | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 28f9bc1591..ff8c2ce5f2 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -212,9 +212,13 @@
 #
 # @executable: Identifies the firmware executable. The firmware
 #              executable may be shared by multiple virtual machine
-#              definitions. The corresponding QEMU command line option
-#              is "-drive
-#              if=pflash,unit=0,readonly=on,file=@executable.@filename,format=@executable.@format".
+#              definitions. The preferred corresponding QEMU command
+#              line options are
+#                  -drive if=none,id=pflash0,readonly=on,file=@executable.@filename,format=@executable.@format
+#                  -machine pflash0=pflash0
+#              or equivalent -blockdev instead of -drive.
+#              With QEMU versions older than 4.0, you have to use
+#                  -drive if=pflash,unit=0,readonly=on,file=@executable.@filename,format=@executable.@format
 #
 # @nvram-template: Identifies the NVRAM template compatible with
 #                  @executable. Management software instantiates an
@@ -225,9 +229,13 @@
 #                  individual copies of it are. An NVRAM file is
 #                  typically used for persistently storing the
 #                  non-volatile UEFI variables of a virtual machine
-#                  definition. The corresponding QEMU command line
-#                  option is "-drive
-#                  if=pflash,unit=1,readonly=off,file=FILENAME_OF_PRIVATE_NVRAM_FILE,format=@nvram-template.@format".
+#                  definition. The preferred corresponding QEMU
+#                  command line options are
+#                      -drive if=none,id=pflash1,readonly=off,file=FILENAME_OF_PRIVATE_NVRAM_FILE,format=@nvram-template.@format
+#                      -machine pflash1=pflash1
+#                  or equivalent -blockdev instead of -drive.
+#                  With QEMU versions older than 4.0, you have to use
+#                      -drive if=pflash,unit=1,readonly=off,file=FILENAME_OF_PRIVATE_NVRAM_FILE,format=@nvram-template.@format
 #
 # Since: 3.0
 ##
-- 
2.17.2
