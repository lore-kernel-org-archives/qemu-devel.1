Received: from eggs.gnu.org ([2001:4830:134:3::10]:54173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fqJgw-0002rK-PO
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fqJgt-0006OD-9r
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:56:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fqJgt-0006Iu-39
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:55:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 16 Aug 2018 15:55:54 +0100
Message-Id: <20180816145554.9814-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] docs/generic-loader: mention U-Boot and Intel
 HEX executable formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair@alistair23.me, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The generic loader device supports the U-Boot and Intel HEX executable
formats in addition to the document raw and ELF formats.  Reword the
documentation to include these formats and explain how various options
depend on the executable format.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Based-on: <20180816133438.17061-1-peter.maydell@linaro.org>
(https://git.linaro.org/people/pmaydell/qemu-arm.git/ pull-target-arm-20180816)

 docs/generic-loader.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/docs/generic-loader.txt b/docs/generic-loader.txt
index 31bbcd42f6..a9603a2af7 100644
--- a/docs/generic-loader.txt
+++ b/docs/generic-loader.txt
@@ -56,25 +56,25 @@ An example of setting CPU 0's PC to 0x8000 is:
 
 Loading Files
 -------------
-The loader device also allows files to be loaded into memory. It can load raw
-files and ELF executable files.  Raw files are loaded verbatim.  ELF executable
-files are loaded by an ELF loader.  The syntax is shown below:
+The loader device also allows files to be loaded into memory. It can load ELF,
+U-Boot, and Intel HEX executable formats as well as raw images.  The syntax is
+shown below:
 
     -device loader,file=<file>[,addr=<addr>][,cpu-num=<cpu-num>][,force-raw=<raw>]
 
     <file>      - A file to be loaded into memory
-    <addr>      - The addr in memory that the file should be loaded. This is
-                  ignored if you are using an ELF (unless force-raw is true).
-                  This is required if you aren't loading an ELF.
+    <addr>      - The memory address where the file should be loaded. This is
+                  required for raw images and ignored for non-raw files.
     <cpu-num>   - This specifies the CPU that should be used. This is an
                   optional argument and will cause the CPU's PC to be set to
-                  where the image is stored or in the case of an ELF file to
-                  the value in the header. This option should only be used
-                  for the boot image.
+                  the memory address where the raw file is loaded or the entry
+                  point specified in the executable format header. This option
+                  should only be used for the boot image.
                   This will also cause the image to be written to the specified
                   CPU's address space. If not specified, the default is CPU 0.
     <force-raw> - Setting force-raw=on forces the file to be treated as a raw
-                  image.  This can be used to load ELF files as if they were raw.
+                  image.  This can be used to load supported executable formats
+                  as if they were raw.
 
 All values are parsed using the standard QemuOps parsing. This allows the user
 to specify any values in any format supported. By default the values
-- 
2.17.1
