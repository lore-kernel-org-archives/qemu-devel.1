Received: from eggs.gnu.org ([209.51.188.92]:43477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gvgAd-0000ND-LV
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gvgAb-0006WG-UK
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:29:07 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gvgAb-0006CO-GK
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:29:05 -0500
Received: by mail-pl1-x642.google.com with SMTP id c4so3551772pls.11
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 02:28:35 -0800 (PST)
From: elohimes@gmail.com
Date: Mon, 18 Feb 2019 18:27:48 +0800
Message-Id: <20190218102748.2242-8-xieyongji@baidu.com>
In-Reply-To: <20190218102748.2242-1-xieyongji@baidu.com>
References: <20190218102748.2242-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH v6 7/7] contrib/vhost-user-blk: enable inflight
 I/O tracking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, stefanha@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com, maxime.coquelin@redhat.com, yury-kotov@yandex-team.ru, wrfsh@yandex-team.ru
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
index 43583f2659..86a3987744 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -398,7 +398,8 @@ vub_get_features(VuDev *dev)
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
