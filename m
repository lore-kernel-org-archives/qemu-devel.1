Received: from eggs.gnu.org ([2001:4830:134:3::10]:52945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUnHW-0001cT-Mo
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:37:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUnHR-0003di-Iv
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:37:04 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:40888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gUnHP-0003ZV-Sg
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:37:01 -0500
Received: by mail-pl1-x630.google.com with SMTP id u18so11311148plq.7
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 22:36:57 -0800 (PST)
From: elohimes@gmail.com
Date: Thu,  6 Dec 2018 14:35:52 +0800
Message-Id: <20181206063552.6701-7-xieyongji@baidu.com>
In-Reply-To: <20181206063552.6701-1-xieyongji@baidu.com>
References: <20181206063552.6701-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH for-4.0 6/6] contrib/vhost-user-blk: enable
 inflight I/O recording
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

From: Xie Yongji <xieyongji@baidu.com>

This patch tells qemu that we now support inflight I/O recording
so that qemu could offer shared memory to it.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 571f114a56..f87f9de8cd 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -328,7 +328,8 @@ vub_get_features(VuDev *dev)
 static uint64_t
 vub_get_protocol_features(VuDev *dev)
 {
-    return 1ull << VHOST_USER_PROTOCOL_F_CONFIG;
+    return 1ull << VHOST_USER_PROTOCOL_F_CONFIG |
+           1uLL << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD;
 }
 
 static int
-- 
2.17.1
