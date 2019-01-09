Received: from eggs.gnu.org ([209.51.188.92]:51707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1ghC1s-0000zg-N5
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1ghC1s-0004Lf-2c
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:28:12 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:36978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1ghC1r-0004LB-Sq
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:28:12 -0500
Received: by mail-pl1-x634.google.com with SMTP id b5so3464620plr.4
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 03:28:11 -0800 (PST)
From: elohimes@gmail.com
Date: Wed,  9 Jan 2019 19:27:28 +0800
Message-Id: <20190109112728.9214-8-xieyongji@baidu.com>
In-Reply-To: <20190109112728.9214-1-xieyongji@baidu.com>
References: <20190109112728.9214-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH v4 for-4.0 7/7] contrib/vhost-user-blk: enable
 inflight I/O tracking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com, maxime.coquelin@redhat.com, yury-kotov@yandex-team.ru, wrfsh@yandex-team.ru
Cc: qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

From: Xie Yongji <xieyongji@baidu.com>

This patch enables inflight I/O tracking for
vhost-user-blk backend so that we could restart it safely.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 858221ad95..8cc033946a 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -327,7 +327,8 @@ vub_get_features(VuDev *dev)
 static uint64_t
 vub_get_protocol_features(VuDev *dev)
 {
-    return 1ull << VHOST_USER_PROTOCOL_F_CONFIG;
+    return 1ull << VHOST_USER_PROTOCOL_F_CONFIG |
+           1ull << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD;
 }
 
 static int
-- 
2.17.1
