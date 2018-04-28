Received: from eggs.gnu.org ([2001:4830:134:3::10]:35327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1fCIox-00031Y-DB
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 01:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1fCIou-000719-Bf
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 01:54:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2096 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1fCIou-0006zR-0Q
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 01:54:52 -0400
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Sat, 28 Apr 2018 13:54:24 +0800
Message-ID: <1524894864-7492-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] backends/cryptodev: fix coverity issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, jianjay.zhou@huawei.com

This patch removes the dead code, which fixes Coverity (CID 1390600) issue.

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 backends/cryptodev-vhost-user.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index 862d4f2..67e65c6 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -155,7 +155,6 @@ static void cryptodev_vhost_user_event(void *opaque, int event)
 {
     CryptoDevBackendVhostUser *s = opaque;
     CryptoDevBackend *b = CRYPTODEV_BACKEND(s);
-    Error *err = NULL;
     int queues = b->conf.peers.queues;
 
     assert(queues < MAX_CRYPTO_QUEUE_NUM);
@@ -172,10 +171,6 @@ static void cryptodev_vhost_user_event(void *opaque, int event)
         cryptodev_vhost_user_stop(queues, s);
         break;
     }
-
-    if (err) {
-        error_report_err(err);
-    }
 }
 
 static void cryptodev_vhost_user_init(
-- 
1.8.3.1
