Received: from eggs.gnu.org ([2001:4830:134:3::10]:41248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1erbex-0000YB-EX
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 22:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1erbew-0000vi-HV
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 22:47:03 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1]:55714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jbaron@akamai.com>) id 1erbew-0000vB-BS
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 22:47:02 -0500
From: Jason Baron <jbaron@akamai.com>
Date: Thu,  1 Mar 2018 22:46:33 -0500
Message-Id: <864430f2a613c4d3c82b591ed7bc27068ddad369.1519961667.git.jbaron@akamai.com>
In-Reply-To: <cover.1519961667.git.jbaron@akamai.com>
References: <cover.1519961667.git.jbaron@akamai.com>
In-Reply-To: <cover.1519961667.git.jbaron@akamai.com>
References: <cover.1519961667.git.jbaron@akamai.com>
Subject: [Qemu-devel] [PATCH 1/4] eth: add speed and duplex definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

Pull in definitions for SPEED_UNKNOWN, DUPLEX_UNKNOWN, DUPLEX_HALF,
and DUPLEX_FULL.

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
---
 include/net/eth.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/eth.h b/include/net/eth.h
index 09054a5..9843678 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -417,4 +417,11 @@ bool
 eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
                    size_t ip6hdr_off, eth_ip6_hdr_info *info);
 
+/* ethtool defines - from linux/ethtool.h */
+#define SPEED_UNKNOWN           -1
+
+#define DUPLEX_HALF             0x00
+#define DUPLEX_FULL             0x01
+#define DUPLEX_UNKNOWN          0xff
+
 #endif
-- 
2.7.4
