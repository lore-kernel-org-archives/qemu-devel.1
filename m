Received: from eggs.gnu.org ([2001:4830:134:3::10]:60706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dIXgM-0000si-E2
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dIXgJ-0003W9-Na
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:55:18 -0400
Received: from [59.151.112.132] (port=5646 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dIXgJ-0003Vu-Ca
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:55:15 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Wed, 7 Jun 2017 17:55:13 +0800
Message-ID: <1496829322-17099-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1496829322-17099-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1496829322-17099-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V6 01/10] net: Add vnet_hdr_len arguments in
 NetClientState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie
	. dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Add vnet_hdr_len arguments in NetClientState
that make other module get real vnet_hdr_len easily.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
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
index 0ac3b9e..4e7a305 100644
--- a/net/net.c
+++ b/net/net.c
@@ -491,6 +491,7 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
         return;
     }
 
+    nc->vnet_hdr_len = len;
     nc->info->set_vnet_hdr_len(nc, len);
 }
 
-- 
2.7.4
