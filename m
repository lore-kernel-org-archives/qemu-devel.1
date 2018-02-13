Received: from eggs.gnu.org ([2001:4830:134:3::10]:47062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1elQj8-0001jT-43
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 21:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1elQj3-0001do-FN
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 21:53:50 -0500
Received: from [45.249.212.32] (port=50430 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1elQj3-0001Ya-33
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 21:53:45 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Tue, 13 Feb 2018 10:53:06 +0800
Message-ID: <20180213025306.16736-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] vhost-user: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, wangxinxin.wang@huawei.com, lidonglin@huawei.com, linzhecheng <linzhecheng@huawei.com>

fix memory leak

Signed-off-by: linzhecheng <linzhecheng@huawei.com>

diff --git a/net/vhost-user.c b/net/vhost-user.c
index cb45512506..d024573e45 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -109,6 +109,7 @@ static int vhost_user_start(int queues, NetClientState *ncs[], CharBackend *be)
 err:
     if (net) {
         vhost_net_cleanup(net);
+        g_free(net);
     }
     vhost_user_stop(i, ncs);
     return -1;
-- 
2.12.2.windows.2
