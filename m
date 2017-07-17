Received: from eggs.gnu.org ([2001:4830:134:3::10]:48218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52E-0000Xt-IK
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52D-0007o0-KM
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:21:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dX52D-0007nD-EA
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:21:57 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jul 2017 20:21:32 +0800
Message-Id: <1500294105-13713-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
References: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 01/14] net: Add vnet_hdr_len arguments in
 NetClientState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Add vnet_hdr_len arguments in NetClientState
that make other module get real vnet_hdr_len easily.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/net/net.h | 1 +
 net/net.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 99b28d5..9a92c70 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -100,6 +100,7 @@ struct NetClientState {
     unsigned int queue_index;
     unsigned rxfilter_notify_enabled:1;
     int vring_enable;
+    int vnet_hdr_len;
     QTAILQ_HEAD(NetFilterHead, NetFilterState) filters;
 };
 
diff --git a/net/net.c b/net/net.c
index 6235aab..b62ce10 100644
--- a/net/net.c
+++ b/net/net.c
@@ -492,6 +492,7 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
         return;
     }
 
+    nc->vnet_hdr_len = len;
     nc->info->set_vnet_hdr_len(nc, len);
 }
 
-- 
2.7.4
