Received: from eggs.gnu.org ([2001:4830:134:3::10]:49099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQoEY-0003jS-8d
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:45:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQoEU-0003oK-9t
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:45:02 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:33 +0300
Message-Id: <87c1fc04a1cf0e983407f24ad0529cf8bf4150a0.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/61] hw: use "qemu/osdep.h" as first #include
 in source files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

applied using ./scripts/clean-includes

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/acpi/ipmi-stub.c             | 1 +
 hw/audio/fmopl.c                | 1 -
 hw/cpu/core.c                   | 1 +
 hw/ppc/spapr_cpu_core.c         | 1 +
 hw/smbios/smbios_type_38-stub.c | 1 +
 hw/vfio/ccw.c                   | 2 +-
 hw/virtio/vhost-vsock.c         | 2 +-
 7 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/ipmi-stub.c b/hw/acpi/ipmi-stub.c
index 98b6dcee0d..f525f71c2d 100644
--- a/hw/acpi/ipmi-stub.c
+++ b/hw/acpi/ipmi-stub.c
@@ -7,6 +7,7 @@
  * See the COPYING file in the top-level directory.
  */
=20
+#include "qemu/osdep.h"
 #include "hw/acpi/ipmi.h"
=20
 void build_acpi_ipmi_devices(Aml *table, BusState *bus)
diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 5cfb6a96dd..9f50a89b4a 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -34,7 +34,6 @@
 #include <math.h>
 //#include "driver.h"		/* use M.A.M.E. */
 #include "fmopl.h"
-#include "qemu/osdep.h"
 #ifndef PI
 #define PI 3.14159265358979323846
 #endif
diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index bd578ab80c..7e42e2c87a 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -6,6 +6,7 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
+#include "qemu/osdep.h"
 #include "hw/cpu/core.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 032438b9ce..ac19b2e0b7 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -6,6 +6,7 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
+#include "qemu/osdep.h"
 #include "hw/cpu/core.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "target/ppc/cpu.h"
diff --git a/hw/smbios/smbios_type_38-stub.c b/hw/smbios/smbios_type_38-s=
tub.c
index 9528c2c28e..5b83c9b1f1 100644
--- a/hw/smbios/smbios_type_38-stub.c
+++ b/hw/smbios/smbios_type_38-stub.c
@@ -7,6 +7,7 @@
  * See the COPYING file in the top-level directory.
  */
=20
+#include "qemu/osdep.h"
 #include "hw/smbios/ipmi.h"
=20
 void smbios_build_type_38_table(void)
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 636729c03d..16713f2c52 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -11,11 +11,11 @@
  * directory.
  */
=20
+#include "qemu/osdep.h"
 #include <linux/vfio.h>
 #include <linux/vfio_ccw.h>
 #include <sys/ioctl.h>
=20
-#include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/vfio/vfio.h"
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 5ec1c6a2a2..aa5af927e1 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -11,8 +11,8 @@
  * top-level directory.
  */
=20
-#include <sys/ioctl.h>
 #include "qemu/osdep.h"
+#include <sys/ioctl.h>
 #include "standard-headers/linux/virtio_vsock.h"
 #include "qapi/error.h"
 #include "hw/virtio/virtio-bus.h"
--=20
2.11.0
