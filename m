Received: from eggs.gnu.org ([208.118.235.92]:44309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTKo-0004gu-1G
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTKn-0001nB-4a
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:32:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gfTKm-0001mb-Vs
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:32:37 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  4 Jan 2019 21:30:34 +0400
Message-Id: <20190104173042.32714-21-marcandre.lureau@redhat.com>
In-Reply-To: <20190104173042.32714-1-marcandre.lureau@redhat.com>
References: <20190104173042.32714-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/28] include: remove compat.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The header is now empty.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/compat.h        | 4 ----
 include/hw/i386/pc.h       | 1 -
 hw/arm/virt.c              | 1 -
 hw/ppc/spapr.c             | 1 -
 hw/s390x/s390-virtio-ccw.c | 1 -
 5 files changed, 8 deletions(-)
 delete mode 100644 include/hw/compat.h

diff --git a/include/hw/compat.h b/include/hw/compat.h
deleted file mode 100644
index b2d0bdd599..0000000000
--- a/include/hw/compat.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef HW_COMPAT_H
-#define HW_COMPAT_H
-
-#endif /* HW_COMPAT_H */
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 784ea7a92c..6b7bf334cd 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -13,7 +13,6 @@
 #include "qemu/bitmap.h"
 #include "sysemu/sysemu.h"
 #include "hw/pci/pci.h"
-#include "hw/compat.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/acpi_dev_interface.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d3174f1402..99c2b6e60d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -43,7 +43,6 @@
 #include "sysemu/numa.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
-#include "hw/compat.h"
 #include "hw/loader.h"
 #include "exec/address-spaces.h"
 #include "qemu/bitops.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8aba66a32f..5671608cea 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -70,7 +70,6 @@
 #include "hw/nmi.h"
 #include "hw/intc/intc.h"
=20
-#include "hw/compat.h"
 #include "qemu/cutils.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/mem/memory-device.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index bf5f2f463c..c737507053 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -28,7 +28,6 @@
 #include "hw/s390x/storage-keys.h"
 #include "hw/s390x/storage-attributes.h"
 #include "hw/s390x/event-facility.h"
-#include "hw/compat.h"
 #include "ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/css-bridge.h"
--=20
2.20.1.2.gb21ebb671b
