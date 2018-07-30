Received: from eggs.gnu.org ([2001:4830:134:3::10]:43025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fk3tn-0001ue-A1
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fk3tk-0003lr-85
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:51:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42040 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fk3tk-0003la-3h
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:51:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AECC5402315B
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 08:51:22 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-217.ams2.redhat.com
	[10.36.116.217])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 36C02100295C
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 08:51:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 30 Jul 2018 10:51:21 +0200
Message-Id: <20180730085121.12523-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] cryptodev: remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reported by Coverity as CID 1390600.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/cryptodev-vhost-user.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index d52daccfcd..d539f14d59 100644
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
2.17.1
