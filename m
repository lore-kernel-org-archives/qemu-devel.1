Received: from eggs.gnu.org ([2001:4830:134:3::10]:60680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQr-00084H-QA
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQr-0003Mg-0t
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJjQq-0003MF-Qo
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:00 -0500
Date: Mon, 5 Nov 2018 13:16:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-28-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/33] hw/pci-bridge/ioh3420: Remove unuseful
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-bridge/ioh3420.h | 6 ------
 hw/pci-bridge/ioh3420.c | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)
 delete mode 100644 hw/pci-bridge/ioh3420.h

diff --git a/hw/pci-bridge/ioh3420.h b/hw/pci-bridge/ioh3420.h
deleted file mode 100644
index ea423cb991..0000000000
--- a/hw/pci-bridge/ioh3420.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef QEMU_IOH3420_H
-#define QEMU_IOH3420_H
-
-#include "hw/pci/pcie_port.h"
-
-#endif /* QEMU_IOH3420_H */
diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
index a451d74ee6..81f2de6f07 100644
--- a/hw/pci-bridge/ioh3420.c
+++ b/hw/pci-bridge/ioh3420.c
@@ -24,7 +24,7 @@
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
-#include "ioh3420.h"
+#include "hw/pci/pcie_port.h"
=20
 #define PCI_DEVICE_ID_IOH_EPORT         0x3420  /* D0:F0 express mode */
 #define PCI_DEVICE_ID_IOH_REV           0x2
--=20
MST
