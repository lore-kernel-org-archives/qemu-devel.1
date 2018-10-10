Received: from eggs.gnu.org ([2001:4830:134:3::10]:57903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAMQg-00018h-Kd
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAMQf-000191-Is
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:54:06 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:40649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAMQf-00018W-B6
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:54:05 -0400
Received: by mail-wm1-x32e.google.com with SMTP id z204-v6so7292491wmc.5
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 14:54:05 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 10 Oct 2018 23:53:54 +0200
Message-Id: <20181010215355.16221-3-f4bug@amsat.org>
In-Reply-To: <20181010215355.16221-1-f4bug@amsat.org>
References: <20181010215355.16221-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/3] hw/pci-bridge/ioh3420: Remove unuseful
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Isaku Yamahata <yamahata@valinux.co.jp>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
 
 #define PCI_DEVICE_ID_IOH_EPORT         0x3420  /* D0:F0 express mode */
 #define PCI_DEVICE_ID_IOH_REV           0x2
-- 
2.19.1
