Received: from eggs.gnu.org ([2001:4830:134:3::10]:40634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cKfZy-000272-8o
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 01:13:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cKfZv-0008FZ-42
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 01:13:14 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:50640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cKfZu-0008Ey-O5
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 01:13:11 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Sat, 24 Dec 2016 14:12:27 +0800
Message-ID: <1482559948-22772-4-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1482559948-22772-1-git-send-email-arei.gonglei@huawei.com>
References: <1482559948-22772-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 3/4] cryptodev: remove single-DES support in
 cryptodev
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

Single-DES is obsolete and it's broken/useless for decades, we should
remove it in cryptodev, as suggested by Daniel.
Guest who wants to use this obsolete cipher alg will use its built-in
implementation instead.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 backends/cryptodev-builtin.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index a4224f4..5fb2836 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -205,10 +205,6 @@ static int cryptodev_builtin_create_cipher_session(
             return -1;
         }
         break;
-    case VIRTIO_CRYPTO_CIPHER_DES_ECB:
-        mode = QCRYPTO_CIPHER_MODE_ECB;
-        algo = QCRYPTO_CIPHER_ALG_DES_RFB;
-        break;
     default:
         error_setg(errp, "Unsupported cipher alg :%u",
                    sess_info->cipher_alg);
-- 
1.7.12.4
