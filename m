Received: from eggs.gnu.org ([2001:4830:134:3::10]:45216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePv07-00017I-3u
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:46:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePv06-0005mF-FR
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:46:27 -0500
Received: from chuckie.co.uk ([82.165.15.123]:60866
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ePv06-0005ks-8W
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:46:26 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Dec 2017 18:41:55 +0000
Message-Id: <20171215184155.2543-14-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
References: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv3 13/13] net: remove unused compute_mcast_idx()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, sw@weilnetz.de

Now that all of the callers have been converted to compute the multicast index
inline using new net CRC functions, this function can now be dropped.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 net/net.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/net.c b/net/net.c
index 4ecaf80bd1..5bc0a343ae 100644
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
2.11.0
