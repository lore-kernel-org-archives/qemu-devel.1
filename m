Received: from eggs.gnu.org ([2001:4830:134:3::10]:58161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ckl9n-0007dk-4Z
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ckl9m-0000y6-9z
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ckl9m-0000xm-3k
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:02 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  6 Mar 2017 13:25:36 +0800
Message-Id: <1488777954-4578-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
References: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL RESEND 01/19] net: Remove useless local var pkt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Fam Zheng <famz@redhat.com>

This has been pointless since commit 605d52e62, which was a
search-and-replace, overlooked the redundancy.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/net_rx_pkt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 1019b50..7f928d7 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -159,7 +159,6 @@ void net_rx_pkt_attach_iovec_ex(struct NetRxPkt *pkt,
 void net_rx_pkt_dump(struct NetRxPkt *pkt)
 {
 #ifdef NET_RX_PKT_DEBUG
-    NetRxPkt *pkt = (NetRxPkt *)pkt;
     assert(pkt);
 
     printf("RX PKT: tot_len: %d, vlan_stripped: %d, vlan_tag: %d\n",
-- 
2.7.4
