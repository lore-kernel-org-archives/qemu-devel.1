Received: from eggs.gnu.org ([2001:4830:134:3::10]:54315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZR-0006Nc-VN
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZR-0008Sn-1E
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58498 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ejrZQ-0008SL-Qa
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:20 -0500
Date: Thu, 8 Feb 2018 21:09:20 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1518116908-10852-25-git-send-email-mst@redhat.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518116908-10852-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 24/26] lpc: drop pcie host dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>

Doesn't look like that header is used.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/lpc_ich9.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index adcf077..e692b9f 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -39,7 +39,6 @@
 #include "hw/isa/apm.h"
 #include "hw/i386/ioapic.h"
 #include "hw/pci/pci.h"
-#include "hw/pci/pcie_host.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/i386/ich9.h"
 #include "hw/acpi/acpi.h"
-- 
MST
