Received: from eggs.gnu.org ([2001:4830:134:3::10]:51711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JO-0003K4-QH
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JF-0008Ey-Jz
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:10 -0400
Received: from [185.30.24.106] (port=13494
	helo=hotspot.internet-for-guests.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JE-0008B8-Dq
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:01 -0400
Date: Tue, 23 Oct 2018 19:41:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023234112.188140-25-mst@redhat.com>
References: <20181023234112.188140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181023234112.188140-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/28] pci_bridge: fix typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 08b7e44e2e..ee9dff2d3a 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -399,7 +399,7 @@ void pci_bridge_exitfn(PCIDevice *pci_dev)
=20
 /*
  * before qdev initialization(qdev_init()), this function sets bus_name =
and
- * map_irq callback which are necessry for pci_bridge_initfn() to
+ * map_irq callback which are necessary for pci_bridge_initfn() to
  * initialize bus.
  */
 void pci_bridge_map_irq(PCIBridge *br, const char* bus_name,
--=20
MST
