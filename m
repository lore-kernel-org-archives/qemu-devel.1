Received: from eggs.gnu.org ([209.51.188.92]:44800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4z-0005dW-HZ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4v-0007Wi-PQ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz4t-0007VC-PQ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:45 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:07 +0100
Message-Id: <1547460140-1473-13-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/25] hw/ssi: Remove SSIBus from
 "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

There are only three header files requiring this typedef, let them
include "hw/ssi/ssi.h" directly to simplify "qemu/typedefs.h".

To clean "qemu/typedefs.h", move the forward declaration
to "hw/ssi/ssi.h".

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
[thuth: slightly tweaked commit message]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/strongarm.h      | 1 +
 include/hw/arm/pxa.h    | 1 +
 include/hw/ssi/pl022.h  | 1 +
 include/hw/ssi/ssi.h    | 1 +
 include/qemu/typedefs.h | 1 -
 5 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/arm/strongarm.h b/hw/arm/strongarm.h
index e98840b..ae51a1a 100644
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
index f6dfb5c..f184349 100644
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
index a080519..1cf16f1 100644
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
index 6a0c3c3..bdbf3c5 100644
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
index 3bd9215..c026229 100644
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
1.8.3.1
