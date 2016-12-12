Received: from eggs.gnu.org ([2001:4830:134:3::10]:47921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGLfC-0006GS-Vy
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 03:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGLf8-00072s-U4
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 03:08:46 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:43553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGLf8-00070p-Ja
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 03:08:42 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 12 Dec 2016 16:08:06 +0800
Message-ID: <1481530092-20240-2-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1481530092-20240-1-git-send-email-longpeng2@huawei.com>
References: <1481530092-20240-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 v2 1/7] qapi: crypto: add defination
 about HMAC algorithms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com, armbru@redhat.com, berrange@redhat.com, stefanha@redhat.com
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

This patch introduce HMAC algorithms relevant defination, they will
be used by the following patch.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 qapi/crypto.json | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index f4fd93b..e63862a 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -55,6 +55,23 @@
 
 
 ##
+# @QCryptoHmacAlgorithm:
+#
+# The supported algorithms for hash-based message authentication code
+#
+# @md5: HMAC-MD5
+# @sha1: HMAC-SHA1
+# @sha256: HMAC-SHA256
+# @sha512: HMAC-SHA512
+#
+# Since 2.9
+##
+{ 'enum': 'QCryptoHmacAlgorithm',
+  'prefix': 'QCRYPTO_HMAC_ALG',
+  'data': ['md5', 'sha1', 'sha256', 'sha512']}
+
+
+##
 # @QCryptoCipherAlgorithm:
 #
 # The supported algorithms for content encryption ciphers
-- 
1.8.3.1
