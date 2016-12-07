Received: from eggs.gnu.org ([2001:4830:134:3::10]:40798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEXgI-0005S6-Dx
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEXgF-0001hd-8s
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:34:26 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:8120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEXgE-0001fj-U5
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:34:23 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Wed, 7 Dec 2016 16:33:42 +0800
Message-ID: <1481099622-188132-3-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1481099622-188132-1-git-send-email-longpeng2@huawei.com>
References: <1481099622-188132-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 2/2] cryptodev: add 3des-ede support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, eblake@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com
Cc: qemu-devel@nongnu.org, wu.wubin@huawei.com, jianjay.zhou@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

This patch add 3des-ede support for cryptodev. However this is effective
only when backend using libgcrypt/nettle, because cipher-builtin doesn't
support 3des-ede yet.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 backends/cryptodev-builtin.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 5fb2836..0231f51 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -205,6 +205,18 @@ static int cryptodev_builtin_create_cipher_session(
             return -1;
         }
         break;
+    case VIRTIO_CRYPTO_CIPHER_3DES_ECB:
+        mode = QCRYPTO_CIPHER_MODE_ECB;
+        algo = QCRYPTO_CIPHER_ALG_3DES_EDE;
+        break;
+    case VIRTIO_CRYPTO_CIPHER_3DES_CBC:
+        mode = QCRYPTO_CIPHER_MODE_CBC;
+        algo = QCRYPTO_CIPHER_ALG_3DES_EDE;
+        break;
+    case VIRTIO_CRYPTO_CIPHER_3DES_CTR:
+        mode = QCRYPTO_CIPHER_MODE_CTR;
+        algo = QCRYPTO_CIPHER_ALG_3DES_EDE;
+        break;
     default:
         error_setg(errp, "Unsupported cipher alg :%u",
                    sess_info->cipher_alg);
-- 
1.8.3.1
