Received: from eggs.gnu.org ([2001:4830:134:3::10]:33629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgi8-0001pl-S6
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgi7-0003p5-LH
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:30:56 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:29:41 -0300
Message-Id: <20171215033015.738-10-f4bug@amsat.org>
In-Reply-To: <20171215033015.738-1-f4bug@amsat.org>
References: <20171215033015.738-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 09/43] hw: use "qemu/osdep.h" as first
 #include in source files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "open list:sPAPR" <qemu-ppc@nongnu.org>, "open list:vfio-ccw" <qemu-s390x@nongnu.org>

applied using ./scripts/clean-includes

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
 
+#include "qemu/osdep.h"
 #include "hw/acpi/ipmi.h"
 
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
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
+#include "qemu/osdep.h"
 #include "hw/cpu/core.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 3a4c174012..8474f9cca8 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -6,6 +6,7 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
+#include "qemu/osdep.h"
 #include "hw/cpu/core.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "target/ppc/cpu.h"
diff --git a/hw/smbios/smbios_type_38-stub.c b/hw/smbios/smbios_type_38-stub.c
index 9528c2c28e..5b83c9b1f1 100644
--- a/hw/smbios/smbios_type_38-stub.c
+++ b/hw/smbios/smbios_type_38-stub.c
@@ -7,6 +7,7 @@
  * See the COPYING file in the top-level directory.
  */
 
+#include "qemu/osdep.h"
 #include "hw/smbios/ipmi.h"
 
 void smbios_build_type_38_table(void)
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 636729c03d..16713f2c52 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -11,11 +11,11 @@
  * directory.
  */
 
+#include "qemu/osdep.h"
 #include <linux/vfio.h>
 #include <linux/vfio_ccw.h>
 #include <sys/ioctl.h>
 
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
 
-#include <sys/ioctl.h>
 #include "qemu/osdep.h"
+#include <sys/ioctl.h>
 #include "standard-headers/linux/virtio_vsock.h"
 #include "qapi/error.h"
 #include "hw/virtio/virtio-bus.h"
-- 
2.15.1
