Received: from eggs.gnu.org ([2001:4830:134:3::10]:38376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCtB-0007uY-6g
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCtA-00013l-9s
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eSCtA-00013D-3d
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:44 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Dec 2017 10:15:34 +0800
Message-Id: <1513908937-16034-16-git-send-email-jasowang@redhat.com>
In-Reply-To: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 15/18] net: remove unused compute_mcast_idx()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Jason Wang <jasowang@redhat.com>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Now that all of the callers have been converted to compute the multicast index
inline using new net CRC functions, this function can now be dropped.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/net.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/net.c b/net/net.c
index 4ecaf80..5bc0a34 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1625,11 +1625,6 @@ uint32_t net_crc32_le(const uint8_t *p, int len)
     return crc;
 }
 
-unsigned compute_mcast_idx(const uint8_t *ep)
-{
-    return net_crc32(ep, ETH_ALEN) >> 26;
-}
-
 QemuOptsList qemu_netdev_opts = {
     .name = "netdev",
     .implied_opt_name = "type",
-- 
2.7.4
