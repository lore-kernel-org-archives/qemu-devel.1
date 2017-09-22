Received: from eggs.gnu.org ([2001:4830:134:3::10]:40699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ4A-00048S-HG
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ49-0002lf-9w
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:40:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 12:39:41 -0300
Message-Id: <20170922154014.29350-2-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/34] hw: use "qemu/osdep.h" as first #include
 in source files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

applied using ./scripts/clean-includes

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
index c08ee7571a..4a4f0c60fe 100644
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
index a8baadf57a..4810fa0b50 100644
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
index 49e0022533..c11c1eb83e 100644
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
2.14.1
