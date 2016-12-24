Received: from eggs.gnu.org ([2001:4830:134:3::10]:40660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cKfa4-0002AJ-LE
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 01:13:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cKfa1-0008GS-HJ
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 01:13:20 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:39988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cKfZw-0008F9-L9
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 01:13:17 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Sat, 24 Dec 2016 14:12:26 +0800
Message-ID: <1482559948-22772-3-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1482559948-22772-1-git-send-email-arei.gonglei@huawei.com>
References: <1482559948-22772-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 2/4] cryptodev: add xts(aes) support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Longpeng(Mike)" <longpeng2@huawei.com>, Gonglei <arei.gonglei@huawei.com>

From: "Longpeng(Mike)" <longpeng2@huawei.com>

This patch add xts(aes) support.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 backends/cryptodev-builtin.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 57980cb..a4224f4 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -197,6 +197,14 @@ static int cryptodev_builtin_create_cipher_session(
             return -1;
         }
         break;
+    case VIRTIO_CRYPTO_CIPHER_AES_XTS:
+        mode = QCRYPTO_CIPHER_MODE_XTS;
+        algo = cryptodev_builtin_get_aes_algo(sess_info->key_len,
+                                                    mode, errp);
+        if (algo < 0)  {
+            return -1;
+        }
+        break;
     case VIRTIO_CRYPTO_CIPHER_DES_ECB:
         mode = QCRYPTO_CIPHER_MODE_ECB;
         algo = QCRYPTO_CIPHER_ALG_DES_RFB;
-- 
1.7.12.4
