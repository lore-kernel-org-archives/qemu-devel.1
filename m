Received: from eggs.gnu.org ([2001:4830:134:3::10]:54007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCP2-0003J7-L3
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCP1-0006rk-Ie
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:50:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXCP1-0006qU-72
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:50:47 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6979830A01F6
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 21:50:45 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 01:48:42 +0400
Message-Id: <20181212214850.29953-21-marcandre.lureau@redhat.com>
In-Reply-To: <20181212214850.29953-1-marcandre.lureau@redhat.com>
References: <20181212214850.29953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 20/28] include: remove compat.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com

The header is now empty.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
index ec59819a91..34b847c88a 100644
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
index 1c5b0e40b1..653a4528ac 100644
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
index 0b62f1dec9..e66824e2fd 100644
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
2.20.0
