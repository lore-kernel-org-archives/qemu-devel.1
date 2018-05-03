Received: from eggs.gnu.org ([2001:4830:134:3::10]:56196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFQ-00029M-0f
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFP-00024q-El
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:36 -0400
Date: Thu, 3 May 2018 22:50:31 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-9-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 08/67] ide: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org

When pulling in headers that are in the same directory as C file (as
opposed to one in include/), we should use its relative path, without a
directory. Directory based path works more or less by accident.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/ide/ahci-allwinner.c | 2 +-
 hw/ide/ahci.c           | 2 +-
 hw/ide/ich.c            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
index 5397483..425ddb0 100644
--- a/hw/ide/ahci-allwinner.c
+++ b/hw/ide/ahci-allwinner.c
@@ -20,7 +20,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/dma.h"
 #include "hw/ide/internal.h"
-#include "hw/ide/ahci_internal.h"
+#include "ahci_internal.h"
 
 #include "trace.h"
 
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index e22d7be..24dbad5 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -31,7 +31,7 @@
 #include "sysemu/dma.h"
 #include "hw/ide/internal.h"
 #include "hw/ide/pci.h"
-#include "hw/ide/ahci_internal.h"
+#include "ahci_internal.h"
 
 #include "trace.h"
 
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index 134478e..51c935a 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -67,7 +67,7 @@
 #include "hw/isa/isa.h"
 #include "sysemu/dma.h"
 #include "hw/ide/pci.h"
-#include "hw/ide/ahci_internal.h"
+#include "ahci_internal.h"
 
 #define ICH9_MSI_CAP_OFFSET     0x80
 #define ICH9_SATA_CAP_OFFSET    0xA8
-- 
MST
