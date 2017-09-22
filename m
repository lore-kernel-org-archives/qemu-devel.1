Received: from eggs.gnu.org ([2001:4830:134:3::10]:41466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ4k-0004hj-0w
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ4g-0003E3-Vg
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:41:10 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 12:39:50 -0300
Message-Id: <20170922154014.29350-11-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/34] amd_iommu: avoid needless includes in
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

instead move them to the source file

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
index 334938a280..e1bf9c5329 100644
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
2.14.1
