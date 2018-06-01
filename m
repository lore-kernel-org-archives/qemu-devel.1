Received: from eggs.gnu.org ([2001:4830:134:3::10]:38841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtY-0002OZ-4d
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtX-0007P3-Bc
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:16 -0400
Date: Fri, 1 Jun 2018 19:27:07 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-16-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/31] ide: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org

When pulling in headers that are in the same directory as the C file (as
opposed to one in include/), we should use its relative path, without a
directory.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/ide/ahci-allwinner.c | 2 +-
 hw/ide/ahci.c           | 2 +-
 hw/ide/ich.c            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
index 2fd95078ba..f98e6cb3d4 100644
--- a/hw/ide/ahci-allwinner.c
+++ b/hw/ide/ahci-allwinner.c
@@ -20,7 +20,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/dma.h"
 #include "hw/ide/internal.h"
-#include "hw/ide/ahci_internal.h"
+#include "ahci_internal.h"
=20
 #include "trace.h"
=20
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index e22d7be05f..24dbad5125 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -31,7 +31,7 @@
 #include "sysemu/dma.h"
 #include "hw/ide/internal.h"
 #include "hw/ide/pci.h"
-#include "hw/ide/ahci_internal.h"
+#include "ahci_internal.h"
=20
 #include "trace.h"
=20
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index 134478ebb2..51c935a0da 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -67,7 +67,7 @@
 #include "hw/isa/isa.h"
 #include "sysemu/dma.h"
 #include "hw/ide/pci.h"
-#include "hw/ide/ahci_internal.h"
+#include "ahci_internal.h"
=20
 #define ICH9_MSI_CAP_OFFSET     0x80
 #define ICH9_SATA_CAP_OFFSET    0xA8
--=20
MST
