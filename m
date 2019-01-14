Received: from eggs.gnu.org ([209.51.188.92]:50105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gj2uU-0005O9-QQ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:08:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gj2uU-0001Jy-0l
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:08:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:60570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1gj2uT-0001HH-Lv
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:08:13 -0500
From: Zhang Chen <chen.zhang@intel.com >
Date: Mon, 14 Jan 2019 22:05:10 +0800
Message-Id: <20190114140510.7161-1-chen.zhang@intel.com>
Subject: [Qemu-devel] [PATCH] net/colo-compare.c: Remove duplicated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Cc: Zhang Chen <chen.zhang@intel.com>

From: Zhang Chen <chen.zhang@intel.com>

Fix duplicated code:
https://bugs.launchpad.net/qemu/+bug/1811499

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 net/colo-compare.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 9156ab3349..fa3fd0632d 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -285,14 +285,6 @@ static bool colo_mark_tcp_pkt(Packet *ppkt, Packet *spkt,
 {
     *mark = 0;
 
-    if (ppkt->tcp_seq == spkt->tcp_seq && ppkt->seq_end == spkt->seq_end) {
-        if (colo_compare_packet_payload(ppkt, spkt,
-                                        ppkt->header_size, spkt->header_size,
-                                        ppkt->payload_size)) {
-            *mark = COLO_COMPARE_FREE_SECONDARY | COLO_COMPARE_FREE_PRIMARY;
-            return true;
-        }
-    }
     if (ppkt->tcp_seq == spkt->tcp_seq && ppkt->seq_end == spkt->seq_end) {
         if (colo_compare_packet_payload(ppkt, spkt,
                                         ppkt->header_size, spkt->header_size,
-- 
2.17.GIT
