Received: from eggs.gnu.org ([2001:4830:134:3::10]:60783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQz-0008E1-3I
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQy-0003Uo-Bo
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJjQy-0003TM-5W
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:08 -0500
Date: Mon, 5 Nov 2018 13:17:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-30-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/33] pci_bridge: fix typo in comment
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
