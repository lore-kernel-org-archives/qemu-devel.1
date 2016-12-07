Received: from eggs.gnu.org ([2001:4830:134:3::10]:51654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cER5l-0002Y6-7T
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 20:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cER5h-0006Wg-AD
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 20:32:17 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:38449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cER5g-0006U4-V5
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 20:32:13 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Wed, 7 Dec 2016 09:31:25 +0800
Message-ID: <1481074285-178976-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9] cryptodev: remove single-DES support
 in cryptodev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: arei.gonglei@huawei.com, berrange@redhat.com
Cc: eblake@redhat.com, wu.wubin@huawei.com, jianjay.zhou@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

Single-DES is obsolete and it's broken/useless for decades, we should
remove it in cryptodev, as suggested by Daniel.
Guest who wants to use this obsolete cipher alg will use its built-in
implementation instead.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
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
1.8.3.1
