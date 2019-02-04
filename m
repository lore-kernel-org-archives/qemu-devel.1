Received: from eggs.gnu.org ([209.51.188.92]:46097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfab-0006G7-SG
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:51:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfTO-0005U6-Sw
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:48 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:35841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqfTO-0005QQ-IK
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:46 -0500
Received: by mail-qt1-f177.google.com with SMTP id r9so111872qtt.3
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:43:41 -0800 (PST)
Date: Mon, 4 Feb 2019 09:43:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204142638.27021-11-mst@redhat.com>
References: <20190204142638.27021-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190204142638.27021-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 10/25] hw: virtio-pci: drop DO_UPCAST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liq3ea@163.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Li Qiang <liq3ea@163.com>

Use VIRTIO_PCI MACRO instead.

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b282109343..e978bfe760 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -591,7 +591,7 @@ virtio_address_space_read(VirtIOPCIProxy *proxy, hwaddr addr,
 static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
                                 uint32_t val, int len)
 {
-    VirtIOPCIProxy *proxy = DO_UPCAST(VirtIOPCIProxy, pci_dev, pci_dev);
+    VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
     struct virtio_pci_cfg_cap *cfg;
 
@@ -624,7 +624,7 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
 static uint32_t virtio_read_config(PCIDevice *pci_dev,
                                    uint32_t address, int len)
 {
-    VirtIOPCIProxy *proxy = DO_UPCAST(VirtIOPCIProxy, pci_dev, pci_dev);
+    VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
     struct virtio_pci_cfg_cap *cfg;
 
     if (proxy->config_cap &&
-- 
MST
