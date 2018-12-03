Received: from eggs.gnu.org ([2001:4830:134:3::10]:36815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gTl7v-0004Cw-GK
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gTl7p-0004ks-Rh
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:06:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gTl7n-0004dU-Su
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:06:48 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  3 Dec 2018 18:06:07 +0800
Message-Id: <20181203100608.28538-4-jasowang@redhat.com>
In-Reply-To: <20181203100608.28538-1-jasowang@redhat.com>
References: <20181203100608.28538-1-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V4 for 3.1 3/4] virtio-net-test: remove unused
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: mst@redhat.com, ppandit@redhat.com, liq3ea@163.com, liq3ea@gmail.com, pbonzini@redhat.com, thuth@redhat.com, eblake@redhat.com, Jason Wang <jasowang@redhat.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 tests/virtio-net-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 587a043e67..bdd6af9999 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -24,7 +24,6 @@
 
 #define PCI_SLOT_HP             0x06
 #define PCI_SLOT                0x04
-#define PCI_FN                  0x00
 
 #define QVIRTIO_NET_TIMEOUT_US (30 * 1000 * 1000)
 #define VNET_HDR_SIZE sizeof(struct virtio_net_hdr_mrg_rxbuf)
-- 
2.17.1
