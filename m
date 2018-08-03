Received: from eggs.gnu.org ([2001:4830:134:3::10]:55462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1flOIe-0003zd-Od
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 20:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1flOId-0000E8-VT
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 20:50:36 -0400
From: John Arbuckle <programmingkidx@gmail.com>
Date: Thu,  2 Aug 2018 20:50:15 -0400
Message-Id: <20180803005015.5116-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] qemu-img.c: Add examples section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Add an examples section to the help output.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 qemu-img.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index 1acddf693c..f77c82695d 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -199,6 +199,17 @@ static void QEMU_NORETURN help(void)
 
     printf("%s\nSupported formats:", help_msg);
     bdrv_iterate_format(format_print, NULL);
+
+    printf("\n\nExamples:\n\n"
+           "Create: qemu-img create -f qcow2 image.qcow2 10G\n\n"
+           "Info: qemu-img info image.qcow2\n\n"
+           "Resize: qemu-img resize image.qcow2 20G\n\n"
+           "Convert: qemu-img convert -f raw -O qcow2 image.img image.qcow2\n\n"
+           "Check: qemu-img check image.qcow2\n\n"
+           "Map: qemu-img map -f qcow2 --output=human image.qcow2\n\n"
+           "Rebase: qemu-img rebase -b new_backing_file.qcow2 image.qcow2"
+           );
+
     printf("\n\n" QEMU_HELP_BOTTOM "\n");
     exit(EXIT_SUCCESS);
 }
-- 
2.14.3 (Apple Git-98)
