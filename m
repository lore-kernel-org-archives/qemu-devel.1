Received: from eggs.gnu.org ([2001:4830:134:3::10]:60901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjRW-0000WQ-JG
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjRQ-0003v9-Jr
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJjRL-0003kq-7m
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:32 -0500
Date: Mon, 5 Nov 2018 13:17:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-33-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/33] piix_pci: fix i440fx data sheet link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liq3ea@163.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Li Qiang <liq3ea@163.com>

It seems that the intel link is unavailable, change it to point to the
qemu site.

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-host/piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 761a8158d7..d9c70f7ce6 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -40,7 +40,7 @@
=20
 /*
  * I440FX chipset data sheet.
- * http://download.intel.com/design/chipsets/datashts/29054901.pdf
+ * https://wiki.qemu.org/File:29054901.pdf
  */
=20
 #define I440FX_PCI_HOST_BRIDGE(obj) \
--=20
MST
