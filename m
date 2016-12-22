Received: from eggs.gnu.org ([2001:4830:134:3::10]:48168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtp3-0006DT-SK
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:13:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtp0-0000Fc-8A
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:13:37 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:48728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtoz-00005Y-Sv
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:13:34 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Thu, 22 Dec 2016 11:12:42 +0800
Message-ID: <1482376362-13804-6-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1482376362-13804-1-git-send-email-arei.gonglei@huawei.com>
References: <1482376362-13804-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND 5/5] virtio-crypto-pci: tag
 virtio-crypto device hot pluggable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Gonglei <arei.gonglei@huawei.com>

After resolving the relationship with cryptodev backend,
the virtio crypto device supports hotplug now.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 hw/virtio/virtio-crypto-pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
index 14bd12c..422aca3 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -53,7 +53,6 @@ static void virtio_crypto_pci_class_init(ObjectClass *klass, void *data)
     k->realize = virtio_crypto_pci_realize;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->props = virtio_crypto_pci_properties;
-    dc->hotpluggable = false;
     pcidev_k->class_id = PCI_CLASS_OTHERS;
 }
 
-- 
1.8.3.1
