Received: from eggs.gnu.org ([2001:4830:134:3::10]:38244)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dVxLU-0003fD-Hw
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dVxLS-000819-Tm
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:57:12 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:51273 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dVxLS-0007zk-L7
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:57:10 -0400
From: Peter Lieven <pl@kamp.de>
Date: Fri, 14 Jul 2017 11:56:38 +0200
Message-Id: <1500026205-15542-3-git-send-email-pl@kamp.de>
In-Reply-To: <1500026205-15542-1-git-send-email-pl@kamp.de>
References: <1500026205-15542-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V3 2/9] qapi/block-core: add Qcow2Compress
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
index c437aa5..d6703a2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2447,6 +2447,44 @@
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
