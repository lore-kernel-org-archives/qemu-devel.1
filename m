Received: from eggs.gnu.org ([2001:4830:134:3::10]:51824)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dQX8k-0007A0-St
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dQX8h-00089X-8m
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:38 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:60888 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dQX8g-00087Z-V4
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:35 -0400
From: Peter Lieven <pl@kamp.de>
Date: Thu, 29 Jun 2017 12:57:07 +0200
Message-Id: <1498733831-15254-5-git-send-email-pl@kamp.de>
In-Reply-To: <1498733831-15254-1-git-send-email-pl@kamp.de>
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V2 4/8] qemu-img: add documentation for
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
 qemu-img.texi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/qemu-img.texi b/qemu-img.texi
index 5b925ec..430f0b9 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -621,6 +621,27 @@ file which is COW and has data blocks already, it couldn't be changed to NOCOW
 by setting @code{nocow=on}. One can issue @code{lsattr filename} to check if
 the NOCOW flag is set or not (Capital 'C' is NOCOW flag).
 
+@item compress.format
+Defines which compression algorithm is should be used for compressed clusters.
+The following options are available if support for the respective libraries
+has been enabled at compile time:
+
+   zlib            Uses standard zlib compression
+
+The compression algorithm can only be defined at image create time and cannot
+be changed later.
+
+Note: defining a compression format will result in the compression format
+      extension being written to the Qcow2 image. Older versions of QEMU will
+      not be able to open images with this extension.
+
+@item compress.level
+Defines which compression level is used for the selected compression format.
+The default of @code{compress.level=0} will use the default compression level
+for the format. Alternate values range from 1 for fastest compression to
+x for the best compression (x max vary between compression formats). This is
+always a trade in of compression speed against compressed size.
+
 @end table
 
 @item Other
-- 
1.9.1
