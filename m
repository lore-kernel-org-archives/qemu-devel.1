Received: from eggs.gnu.org ([2001:4830:134:3::10]:37152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUI-0003tx-Ro
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUH-0005b1-O3
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:42 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frhUH-0005XU-A4
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:41 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1frhTu-000359-1n
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:32:18 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 11:31:49 +0100
Message-Id: <20180820103212.2810-3-peter.maydell@linaro.org>
In-Reply-To: <20180820103212.2810-1-peter.maydell@linaro.org>
References: <20180820103212.2810-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 02/25] docs/generic-loader: mention U-Boot and
 Intel HEX executable formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Stefan Hajnoczi <stefanha@redhat.com>

The generic loader device supports the U-Boot and Intel HEX executable
formats in addition to the document raw and ELF formats.  Reword the
documentation to include these formats and explain how various options
depend on the executable format.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20180816145554.9814-1-stefanha@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/generic-loader.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/docs/generic-loader.txt b/docs/generic-loader.txt
index 31bbcd42f6b..a9603a2af76 100644
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
2.18.0
