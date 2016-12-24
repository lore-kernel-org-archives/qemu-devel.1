Received: from eggs.gnu.org ([2001:4830:134:3::10]:40633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cKfZy-000271-8m
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 01:13:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cKfZv-0008Fk-5q
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 01:13:14 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:50646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cKfZu-0008F6-PG
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 01:13:11 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Sat, 24 Dec 2016 14:12:28 +0800
Message-ID: <1482559948-22772-5-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1482559948-22772-1-git-send-email-arei.gonglei@huawei.com>
References: <1482559948-22772-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 4/4] cryptodev: add 3des-ede support
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

This patch add 3des-ede support for cryptodev. However this is effective
only when backend using libgcrypt/nettle, because cipher-builtin doesn't
support 3des-ede yet.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 backends/cryptodev-builtin.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 5fb2836..486b4a6 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -205,6 +205,18 @@ static int cryptodev_builtin_create_cipher_session(
             return -1;
         }
         break;
+    case VIRTIO_CRYPTO_CIPHER_3DES_ECB:
+        mode = QCRYPTO_CIPHER_MODE_ECB;
+        algo = QCRYPTO_CIPHER_ALG_3DES;
+        break;
+    case VIRTIO_CRYPTO_CIPHER_3DES_CBC:
+        mode = QCRYPTO_CIPHER_MODE_CBC;
+        algo = QCRYPTO_CIPHER_ALG_3DES;
+        break;
+    case VIRTIO_CRYPTO_CIPHER_3DES_CTR:
+        mode = QCRYPTO_CIPHER_MODE_CTR;
+        algo = QCRYPTO_CIPHER_ALG_3DES;
+        break;
     default:
         error_setg(errp, "Unsupported cipher alg :%u",
                    sess_info->cipher_alg);
-- 
1.7.12.4
