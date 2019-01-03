Received: from eggs.gnu.org ([208.118.235.92]:46521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1gf2nj-0003Ao-NB
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1gf2ni-0003B1-GL
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:12:43 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
	id 1gf2ni-0003AD-9H
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:12:42 -0500
Received: by mail-wr1-x442.google.com with SMTP id r10so33497783wrs.10
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 05:12:42 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu,  3 Jan 2019 15:12:30 +0200
Message-Id: <20190103131230.24934-3-yuri.benditovich@daynix.com>
In-Reply-To: <20190103131230.24934-1-yuri.benditovich@daynix.com>
References: <20190103131230.24934-1-yuri.benditovich@daynix.com>
Subject: [Qemu-devel] [PATCH v4 2/2] virtio-net: changed
 VIRTIO_NET_F_RSC_EXT to be 61
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, dmitry.fleytman@gmail.com, qemu-devel@nongnu.org
Cc: yan@daynix.com

Allocated feature bit changed in spec draft per TC request.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/net/virtio-net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5a3952f84b..2db80e1f71 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -66,7 +66,7 @@
 #if !defined(VIRTIO_NET_HDR_F_RSC_INFO)
 
 #define VIRTIO_NET_HDR_F_RSC_INFO  4 /* rsc_ext data in csum_ fields */
-#define VIRTIO_NET_F_RSC_EXT       38
+#define VIRTIO_NET_F_RSC_EXT       61
 
 static inline __virtio16 *virtio_net_rsc_ext_num_packets(
     struct virtio_net_hdr *hdr)
-- 
2.17.1
