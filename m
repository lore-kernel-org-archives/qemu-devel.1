Received: from eggs.gnu.org ([2001:4830:134:3::10]:59042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fkPca-0007b0-ED
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fkPcZ-0001AC-7T
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:03:08 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:50500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fkPcZ-00019g-13
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:03:07 -0400
Received: by mail-wm0-x244.google.com with SMTP id s12-v6so2010716wmc.0
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 01:03:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 31 Jul 2018 10:02:59 +0200
Message-Id: <20180731080259.15934-5-pbonzini@redhat.com>
In-Reply-To: <20180731080259.15934-1-pbonzini@redhat.com>
References: <20180731080259.15934-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] backends/cryptodev: remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jay Zhou <jianjay.zhou@huawei.com>

From: Jay Zhou <jianjay.zhou@huawei.com>

Fix Coverity issue 1390600.

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
Message-Id: <1524894864-7492-1-git-send-email-jianjay.zhou@huawei.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/cryptodev-vhost-user.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index d52dacc..d539f14 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -157,7 +157,6 @@ static void cryptodev_vhost_user_event(void *opaque, int event)
 {
     CryptoDevBackendVhostUser *s = opaque;
     CryptoDevBackend *b = CRYPTODEV_BACKEND(s);
-    Error *err = NULL;
     int queues = b->conf.peers.queues;
 
     assert(queues < MAX_CRYPTO_QUEUE_NUM);
@@ -174,10 +173,6 @@ static void cryptodev_vhost_user_event(void *opaque, int event)
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
