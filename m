Received: from eggs.gnu.org ([2001:4830:134:3::10]:51743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JQ-0003M5-OA
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JF-0008FP-LJ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:11 -0400
Received: from [185.30.24.106] (port=13490
	helo=hotspot.internet-for-guests.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JE-0008B6-Bj
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:01 -0400
Date: Tue, 23 Oct 2018 19:41:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023234112.188140-23-mst@redhat.com>
References: <20181023234112.188140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181023234112.188140-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/28] hw/pci-bridge/ioh3420: Remove unuseful
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
