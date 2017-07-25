Received: from eggs.gnu.org ([2001:4830:134:3::10]:36338)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1da121-0001nB-Fy
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1da11z-0000sJ-AG
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:53 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:45610 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1da11z-0000r8-0E
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:51 -0400
From: Peter Lieven <pl@kamp.de>
Date: Tue, 25 Jul 2017 16:41:31 +0200
Message-Id: <1500993699-19299-3-git-send-email-pl@kamp.de>
In-Reply-To: <1500993699-19299-1-git-send-email-pl@kamp.de>
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V5 02/10] qapi/block-core: add Qcow2Compress
 parameters
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
 qapi/block-core.json | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 833c602..f652206 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2455,6 +2455,46 @@
             '*encrypt': 'BlockdevQcow2Encryption' } }
 
 ##
+# @Qcow2CompressFormat:
+#
+# @deflate: standard zlib deflate compression
+#
+# Since: 2.11
+##
+{ 'enum': 'Qcow2CompressFormat',
+  'data': [ 'deflate' ] }
+
+##
+# @Qcow2CompressDeflate:
+#
+# @level: specifies the compression level. 0 = default compression,
+#         1 = fastest compression, 9 = best compresion
+# @window-size: specifies the window size used for deflate compression.
+#               8...15 = window size of 2^8 to 2^15 byte (default)
+#
+# Since: 2.11
+##
+{ 'struct': 'Qcow2CompressDeflate',
+  'data': { '*level': 'uint8',
+            '*window-size': 'uint8' } }
+
+##
+# @Qcow2Compress:
+#
+# Specifies the compression format and compression level that should
+# be used for compressed Qcow2 clusters.
+#
+# @format: specifies the compression format to use. (defaults to zlib)
+#
+# Since: 2.11
+##
+{ 'union': 'Qcow2Compress',
+  'base': { 'format': 'Qcow2CompressFormat' },
+  'discriminator': 'format',
+  'data': { 'deflate': 'Qcow2CompressDeflate' } }
+
+
+##
 # @BlockdevOptionsSsh:
 #
 # @server:              host address
-- 
1.9.1
