Received: from eggs.gnu.org ([2001:4830:134:3::10]:33863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Ux-0004f5-6G
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Ut-0001TX-8p
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:35 -0400
Received: from [59.151.112.132] (port=46892 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Us-0001Qm-To
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:31 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 28 Apr 2017 17:47:13 +0800
Message-ID: <1493372840-24551-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V3 03/10] net/netmap.c: Add
 netmap_get_vnet_hdr_len function
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

Make netmap support get_vnet_hdr_len.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/netmap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/netmap.c b/net/netmap.c
index 2d11a8f..694c340 100644
--- a/net/netmap.c
+++ b/net/netmap.c
@@ -360,6 +360,13 @@ static bool netmap_has_vnet_hdr_len(NetClientState *nc, int len)
     return true;
 }
 
+static int netmap_get_vnet_hdr_len(NetClientState *nc)
+{
+    NetmapState *s = DO_UPCAST(NetmapState, nc, nc);
+
+    return s->vnet_hdr_len;
+}
+
 /* A netmap interface that supports virtio-net headers always
  * supports UFO, so we use this callback also for the has_ufo hook. */
 static bool netmap_has_vnet_hdr(NetClientState *nc)
@@ -409,6 +416,7 @@ static NetClientInfo net_netmap_info = {
     .has_ufo = netmap_has_vnet_hdr,
     .has_vnet_hdr = netmap_has_vnet_hdr,
     .has_vnet_hdr_len = netmap_has_vnet_hdr_len,
+    .get_vnet_hdr_len = netmap_get_vnet_hdr_len,
     .using_vnet_hdr = netmap_using_vnet_hdr,
     .set_offload = netmap_set_offload,
     .set_vnet_hdr_len = netmap_set_vnet_hdr_len,
-- 
2.7.4
