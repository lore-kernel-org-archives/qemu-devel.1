Received: from eggs.gnu.org ([209.51.188.92]:38311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tjin@wavecomp.com>) id 1hAqP5-0008Ge-NP
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tjin@wavecomp.com>) id 1hAqP4-0005Yq-R8
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:26:43 -0400
Received: from mail-bl2nam02on0731.outbound.protection.outlook.com
	([2a01:111:f400:fe46::731]:21478
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tjin@wavecomp.com>) id 1hAqP4-0005YE-He
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:26:42 -0400
From: Tommy Jin <tjin@wavecomp.com>
Date: Mon, 1 Apr 2019 06:26:40 +0000
Message-ID: <1554099897-28606-2-git-send-email-tjin@wavecomp.com>
References: <1554099897-28606-1-git-send-email-tjin@wavecomp.com>
In-Reply-To: <1554099897-28606-1-git-send-email-tjin@wavecomp.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] Adds virtio_net as the default netcard for
 mips boston board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Tommy Jin <tjin@wavecomp.com>

Boston didn't bring up any netcard by default, this is not so convenient fo=
r users who are verifying network related functionalities on this board.
As the linux kernel has already supported virtio_net, now add a virtio netc=
ard for boston, to make virtio work properly, please:
1. set virtio net options in linux kernel, saying CONFIG_VIRTIO && CONFIG_V=
IRTIO_PCI && CONFIG_VIRTIO_NET
2. specify model=3Dvirtio when you start boston in qemu.

Signed-off-by: tjin <tjin@wavecomp.com>
---
 hw/mips/boston.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index cac0e22..5d3239e 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -428,10 +428,10 @@ static void network_init(PCIBus *bus)
 {
     PCIDevice *eth;
=20
-    /*Please set CONFIG_VIRTIO && CONFIG_VIRTIO_PCI && CONFIG_VIRTIO_NET
-        of Linux kernel.*/
+    /* Please set CONFIG_VIRTIO && CONFIG_VIRTIO_PCI && CONFIG_VIRTIO_NET =
*/
+    /* of Linux kernel. */
     eth =3D pci_create(bus,
-					 PCI_DEVFN(0, 1), "virtio-net-pci");
+                     PCI_DEVFN(0, 1), "virtio-net-pci");
=20
     qdev_set_nic_properties(&eth->qdev, &nd_table[0]);
     qdev_init_nofail(&eth->qdev);
--=20
2.7.4
