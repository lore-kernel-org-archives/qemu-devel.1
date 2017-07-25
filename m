Received: from eggs.gnu.org ([2001:4830:134:3::10]:36626)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1da12F-000221-2n
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1da12D-00011x-5s
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:42:07 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:52305 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1da12C-00010s-Sz
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:42:05 -0400
From: Peter Lieven <pl@kamp.de>
Date: Tue, 25 Jul 2017 16:41:33 +0200
Message-Id: <1500993699-19299-5-git-send-email-pl@kamp.de>
In-Reply-To: <1500993699-19299-1-git-send-email-pl@kamp.de>
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V5 04/10] qemu-img: add documentation for
 compress settings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com, berrange@redhat.com, Peter Lieven <pl@kamp.de>

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 qemu-img.texi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/qemu-img.texi b/qemu-img.texi
index 72dabd6..3612c59 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -676,6 +676,32 @@ file which is COW and has data blocks already, it couldn't be changed to NOCOW
 by setting @code{nocow=on}. One can issue @code{lsattr filename} to check if
 the NOCOW flag is set or not (Capital 'C' is NOCOW flag).
 
+@item compress.format
+Defines which compression algorithm is should be used for compressed clusters.
+The following options are available if support for the respective libraries
+has been enabled at compile time:
+
+   deflate        Uses standard zlib defalte compression
+
+The compression algorithm can only be defined at image create time and cannot
+be changed later.
+
+Note: defining compression format settings which are different from the old
+      default (format=deflate, level=0, window-size=12) will result in the
+      compression format extension being written to the Qcow2 image. Versions
+      of QEMU before 2.11 will not be able to open images with this extension.
+
+@item compress.level
+Valid for compress.format=deflate defines the compression level to use for
+selected compression format. The default of @code{compress.level=0} will use
+the default compression level for the format. Alternate values range from 1 for
+fastest compression to 9 for the best compression.
+
+@item compress.window-size
+Valid for compress.format=deflate defines the compression window size used
+during compression. Valid window sizes for deflate compression range from 8 to
+15 inclusively. The default is @code{compress.window-size=15}.
+
 @end table
 
 @item Other
-- 
1.9.1
