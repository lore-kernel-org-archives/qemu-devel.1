Received: from eggs.gnu.org ([2001:4830:134:3::10]:37518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdv0D-0006bY-7X
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 03:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdv08-0006fg-9n
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 03:31:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cdv08-0006fY-3j
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 03:31:48 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 15 Feb 2017 16:31:43 +0800
Message-Id: <20170215083143.15897-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] net: Remove useless local var pkt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>

This has been pointless since commit 605d52e62, which was a
search-and-replace, overlooked the redundancy.

Signed-off-by: Fam Zheng <famz@redhat.com>
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
2.9.3
