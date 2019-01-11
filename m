Received: from eggs.gnu.org ([209.51.188.92]:48384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxe4-0005uM-B3
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:18:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxVK-00016C-Vq
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:09:48 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 11 Jan 2019 15:08:45 +0100
Message-Id: <20190111140857.4211-4-philmd@redhat.com>
In-Reply-To: <20190111140857.4211-1-philmd@redhat.com>
References: <20190111140857.4211-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/15] hw/ssi: Remove SSIBus from
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Andrzej Zaborowski <balrogg@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

There are only three files requiring this typedef, let them
include "hw/ssi/ssi.h" directly to simplify "qemu/typedefs.h".

To clean "qemu/typedefs.h", move the forward declaration
to "hw/ssi/ssi.h".

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/arm/strongarm.h      | 1 +
 include/hw/arm/pxa.h    | 1 +
 include/hw/ssi/pl022.h  | 1 +
 include/hw/ssi/ssi.h    | 1 +
 include/qemu/typedefs.h | 1 -
 5 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/arm/strongarm.h b/hw/arm/strongarm.h
index e98840b461..ae51a1ae34 100644
--- a/hw/arm/strongarm.h
+++ b/hw/arm/strongarm.h
@@ -3,6 +3,7 @@
=20
 #include "exec/memory.h"
 #include "target/arm/cpu-qom.h"
+#include "hw/ssi/ssi.h"
=20
 #define SA_CS0          0x00000000
 #define SA_CS1          0x08000000
diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index f6dfb5c0cf..f184349f02 100644
--- a/include/hw/arm/pxa.h
+++ b/include/hw/arm/pxa.h
@@ -13,6 +13,7 @@
 #include "exec/memory.h"
 #include "target/arm/cpu-qom.h"
 #include "hw/pcmcia.h"
+#include "hw/ssi/ssi.h"
=20
 /* Interrupt numbers */
 # define PXA2XX_PIC_SSP3	0
diff --git a/include/hw/ssi/pl022.h b/include/hw/ssi/pl022.h
index a080519366..1cf16f1539 100644
--- a/include/hw/ssi/pl022.h
+++ b/include/hw/ssi/pl022.h
@@ -22,6 +22,7 @@
 #define HW_SSI_PL022_H
=20
 #include "hw/sysbus.h"
+#include "hw/ssi/ssi.h"
=20
 #define TYPE_PL022 "pl022"
 #define PL022(obj) OBJECT_CHECK(PL022State, (obj), TYPE_PL022)
diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
index 6a0c3c3cdb..bdbf3c51f5 100644
--- a/include/hw/ssi/ssi.h
+++ b/include/hw/ssi/ssi.h
@@ -13,6 +13,7 @@
=20
 #include "hw/qdev.h"
=20
+typedef struct SSIBus SSIBus;
 typedef struct SSISlave SSISlave;
 typedef struct SSISlaveClass SSISlaveClass;
 typedef enum SSICSMode SSICSMode;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 3bd9215d55..c026229573 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -108,7 +108,6 @@ typedef struct Range Range;
 typedef struct SerialState SerialState;
 typedef struct SHPCDevice SHPCDevice;
 typedef struct SMBusDevice SMBusDevice;
-typedef struct SSIBus SSIBus;
 typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
--=20
2.17.2
