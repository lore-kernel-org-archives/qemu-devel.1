Received: from eggs.gnu.org ([2001:4830:134:3::10]:34709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgj2-0002gO-6k
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgj1-0005J3-Bv
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:31:52 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:29:55 -0300
Message-Id: <20171215033015.738-24-f4bug@amsat.org>
In-Reply-To: <20171215033015.738-1-f4bug@amsat.org>
References: <20171215033015.738-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 23/43] amd_iommu: avoid needless includes in
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>

instead move them to the source file

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/amd_iommu.h | 5 -----
 hw/i386/amd_iommu.c | 5 ++++-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index d370ae3549..aeef802364 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -23,11 +23,6 @@
 
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
-#include "hw/pci/msi.h"
-#include "hw/sysbus.h"
-#include "sysemu/dma.h"
-#include "hw/i386/pc.h"
-#include "hw/pci/pci_bus.h"
 #include "hw/i386/x86-iommu.h"
 
 /* Capability registers */
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index ad8155ca4c..eeaf0e0aa8 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -20,7 +20,10 @@
  * Cache implementation inspired by hw/i386/intel_iommu.c
  */
 #include "qemu/osdep.h"
-#include "hw/i386/amd_iommu.h"
+#include "hw/i386/pc.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/pci_bus.h"
+#include "amd_iommu.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "trace.h"
-- 
2.15.1
