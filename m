Received: from eggs.gnu.org ([2001:4830:134:3::10]:41054)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dYCK0-0008Bc-LI
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dYCJx-0007tt-Mf
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:20:56 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:34530 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dYCJx-0007sz-DJ
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:20:53 -0400
From: Peter Lieven <pl@kamp.de>
Date: Thu, 20 Jul 2017 16:20:33 +0200
Message-Id: <1500560441-5670-3-git-send-email-pl@kamp.de>
In-Reply-To: <1500560441-5670-1-git-send-email-pl@kamp.de>
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V4 02/10] qapi/block-core: add Qcow2Compress
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
 qapi/block-core.json | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ff8e2ba..95e5393 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2454,6 +2454,44 @@
             '*encrypt': 'BlockdevQcow2Encryption' } }
 
 ##
+# @Qcow2CompressFormat:
+# @zlib: standard zlib deflate compression
+#
+# Since: 2.10
+##
+{ 'enum': 'Qcow2CompressFormat',
+  'data': [ 'zlib' ] }
+
+##
+# @Qcow2CompressZLib:
+#
+# Since: 2.10
+##
+{ 'struct': 'Qcow2CompressZLib',
+  'data': { } }
+
+##
+# @Qcow2Compress:
+#
+# Specifies the compression format and compression level that should
+# be used for compressed Qcow2 clusters.
+#
+# @format: specifies the compression format to use. (defaults to zlib)
+#
+# @level: specifies the compression level. 0 = default compression,
+#         1 = fastest compression, x = highest compresion (x may very between
+#         different compression formats)
+#
+# Since: 2.10
+##
+{ 'union': 'Qcow2Compress',
+  'base': { 'format': 'Qcow2CompressFormat',
+            '*level': 'uint8' },
+  'discriminator': 'format',
+  'data': { 'zlib': 'Qcow2CompressZLib' } }
+
+
+##
 # @BlockdevOptionsSsh:
 #
 # @server:              host address
-- 
1.9.1
