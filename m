Received: from eggs.gnu.org ([209.51.188.92]:35504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyn-00081N-T3
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyR-0003Qk-1B
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:11797)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUyP-00035H-Fl
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:10 -0500
Date: Tue, 15 Jan 2019 15:05:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-33-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 32/49] virtio: split virtio crypto bits from
 virtio-pci.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Gonglei <arei.gonglei@huawei.com>

From: Juan Quintela <quintela@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.h        | 14 --------------
 hw/virtio/virtio-crypto-pci.c | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 2f7605590d..bd223a6e3b 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -17,10 +17,8 @@
 
 #include "hw/pci/msi.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/virtio/virtio-crypto.h"
 
 typedef struct VirtIOPCIProxy VirtIOPCIProxy;
-typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
 
 /* virtio-pci-bus */
 
@@ -182,18 +180,6 @@ static inline void virtio_pci_disable_modern(VirtIOPCIProxy *proxy)
  */
 #define TYPE_VIRTIO_INPUT_PCI "virtio-input-pci"
 
-/*
- * virtio-crypto-pci: This extends VirtioPCIProxy.
- */
-#define TYPE_VIRTIO_CRYPTO_PCI "virtio-crypto-pci"
-#define VIRTIO_CRYPTO_PCI(obj) \
-        OBJECT_CHECK(VirtIOCryptoPCI, (obj), TYPE_VIRTIO_CRYPTO_PCI)
-
-struct VirtIOCryptoPCI {
-    VirtIOPCIProxy parent_obj;
-    VirtIOCrypto vdev;
-};
-
 /* Virtio ABI version, if we increment this, we break the guest driver. */
 #define VIRTIO_PCI_ABI_VERSION          0
 
diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
index 8cc3fa3ef7..90a6e0dc2e 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -19,6 +19,20 @@
 #include "hw/virtio/virtio-crypto.h"
 #include "qapi/error.h"
 
+typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
+
+/*
+ * virtio-crypto-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_CRYPTO_PCI "virtio-crypto-pci"
+#define VIRTIO_CRYPTO_PCI(obj) \
+        OBJECT_CHECK(VirtIOCryptoPCI, (obj), TYPE_VIRTIO_CRYPTO_PCI)
+
+struct VirtIOCryptoPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOCrypto vdev;
+};
+
 static Property virtio_crypto_pci_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
-- 
MST
