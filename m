Received: from eggs.gnu.org ([2001:4830:134:3::10]:53307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZCBu-0007yV-N3
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZCBp-0001xg-4p
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:01:30 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:37016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gZCBj-0001pw-0O
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:01:20 -0500
Received: by mail-pf1-x429.google.com with SMTP id y126so7904420pfb.4
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 02:01:07 -0800 (PST)
From: elohimes@gmail.com
Date: Tue, 18 Dec 2018 18:00:02 +0800
Message-Id: <20181218100002.11219-8-xieyongji@baidu.com>
In-Reply-To: <20181218100002.11219-1-xieyongji@baidu.com>
References: <20181218100002.11219-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH v2 for-4.0 7/7] contrib/vhost-user-blk: enable
 inflight I/O recording
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, yury-kotov@yandex-team.ru, maxime.coquelin@redhat.com
Cc: qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

From: Xie Yongji <xieyongji@baidu.com>

This patch enables inflight I/O recording for
vhost-user-blk backend so that we could restart it safely.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 571f114a56..b144490fd6 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -328,7 +328,8 @@ vub_get_features(VuDev *dev)
 static uint64_t
 vub_get_protocol_features(VuDev *dev)
 {
-    return 1ull << VHOST_USER_PROTOCOL_F_CONFIG;
+    return 1ull << VHOST_USER_PROTOCOL_F_CONFIG |
+           1ull << VHOST_USER_PROTOCOL_F_SLAVE_SHMFD;
 }
 
 static int
-- 
2.17.1
