Received: from eggs.gnu.org ([2001:4830:134:3::10]:41245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gU1n7-0006q7-TM
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 22:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gU1n5-0005gY-8t
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 22:54:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gU1n4-0005ed-DR
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 22:54:30 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue,  4 Dec 2018 11:53:46 +0800
Message-Id: <20181204035347.6148-5-jasowang@redhat.com>
In-Reply-To: <20181204035347.6148-1-jasowang@redhat.com>
References: <20181204035347.6148-1-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V5 for 3.1 4/5] virtio-net-test: remove unused
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
Reviewed-by: Eric Blake <eblake@redhat.com>
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
