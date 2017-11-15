Received: from eggs.gnu.org ([2001:4830:134:3::10]:58884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eF2Gy-0003b1-JP
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eF2Gu-0003O4-EM
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:18:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eF2Gu-0003NT-7A
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:18:48 -0500
Date: Wed, 15 Nov 2017 20:18:37 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1510769835-31902-7-git-send-email-mst@redhat.com>
References: <1510769835-31902-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1510769835-31902-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/10] hw/pcie-pci-bridge: restrict to X86 and
 ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cornelia Huck <cohuck@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>

From: Marcel Apfelbaum <marcel@redhat.com>

The PCIE-PCI bridge is specific to "pure" PCIe systems
(on QEMU we have X86 and ARM), it does not make sense to
have it in other archs.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Yongbok Kim <yongbok.kim@mips.com>
---
 hw/pci-bridge/Makefile.objs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
index 666db37..1b05023 100644
--- a/hw/pci-bridge/Makefile.objs
+++ b/hw/pci-bridge/Makefile.objs
@@ -1,5 +1,5 @@
-common-obj-y +=3D pci_bridge_dev.o pcie_pci_bridge.o
-common-obj-$(CONFIG_PCIE_PORT) +=3D pcie_root_port.o gen_pcie_root_port.=
o
+common-obj-y +=3D pci_bridge_dev.o
+common-obj-$(CONFIG_PCIE_PORT) +=3D pcie_root_port.o gen_pcie_root_port.=
o pcie_pci_bridge.o
 common-obj-$(CONFIG_PXB) +=3D pci_expander_bridge.o
 common-obj-$(CONFIG_XIO3130) +=3D xio3130_upstream.o xio3130_downstream.=
o
 common-obj-$(CONFIG_IOH3420) +=3D ioh3420.o
--=20
MST
