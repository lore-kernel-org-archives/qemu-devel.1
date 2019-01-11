Received: from eggs.gnu.org ([209.51.188.92]:48240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxdw-0005j5-EU
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:18:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxX7-0005xL-Ow
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:11:38 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 11 Jan 2019 15:08:52 +0100
Message-Id: <20190111140857.4211-11-philmd@redhat.com>
In-Reply-To: <20190111140857.4211-1-philmd@redhat.com>
References: <20190111140857.4211-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/15] range: Remove Range from
 "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>

Range is only used in "hw/pci-host/q35.h" in the MCHPCIState, and
in "hw/pci/pci.h" by pci_bus_get_w64_range().  Let them include
"qemu/range.h" directly to simplify "qemu/typedefs.h".

To clean "qemu/typedefs.h", move the declaration to "qemu/range.h"
(removing the forward declaration).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/pci-host/q35.h | 1 +
 include/hw/pci/pci.h      | 1 +
 include/qemu/range.h      | 4 ++--
 include/qemu/typedefs.h   | 1 -
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index 8f4ddde393..236ff008c9 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -22,6 +22,7 @@
 #ifndef HW_Q35_H
 #define HW_Q35_H
=20
+#include "qemu/range.h"
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index d87f5f93e9..f9c020fd98 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -1,6 +1,7 @@
 #ifndef QEMU_PCI_H
 #define QEMU_PCI_H
=20
+#include "qemu/range.h"
 #include "hw/qdev.h"
 #include "exec/memory.h"
 #include "sysemu/dma.h"
diff --git a/include/qemu/range.h b/include/qemu/range.h
index 7e75f4e655..aaa09c8306 100644
--- a/include/qemu/range.h
+++ b/include/qemu/range.h
@@ -29,7 +29,7 @@
  * - Ranges must not wrap around 0, but can include UINT64_MAX.
  */
=20
-struct Range {
+typedef struct Range {
     /*
      * Do not access members directly, use the functions!
      * A non-empty range has @lob <=3D @upb.
@@ -37,7 +37,7 @@ struct Range {
      */
     uint64_t lob;        /* inclusive lower bound */
     uint64_t upb;        /* inclusive upper bound */
-};
+} Range;
=20
 static inline void range_invariant(const Range *range)
 {
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 5e9a070ff3..fb9f29d892 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -97,7 +97,6 @@ typedef struct QNum QNum;
 typedef struct QObject QObject;
 typedef struct QString QString;
 typedef struct RAMBlock RAMBlock;
-typedef struct Range Range;
 typedef struct SHPCDevice SHPCDevice;
 typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
--=20
2.17.2
