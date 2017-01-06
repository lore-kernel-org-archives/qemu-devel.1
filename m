Received: from eggs.gnu.org ([2001:4830:134:3::10]:47247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsi-0004fX-M6
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsh-0005DL-Q8
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsh-0005Cj-Kn
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:39 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2C9561B8E
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:39 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:25 +0000
Message-Id: <20170106155543.12827-30-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 29/47] trace: switch hw/s390x/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Switch files in the hw/s390x/ directory to include the
hw/s390x/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs          | 2 +-
 hw/s390x/Makefile.objs | 3 +++
 hw/s390x/css.c         | 2 +-
 hw/s390x/virtio-ccw.c  | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 66ffeca..8f44164 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -147,7 +147,7 @@ trace-events-subdirs += hw/i386
 trace-events-subdirs += hw/9pfs
 trace-events-subdirs += hw/ppc
 trace-events-subdirs += hw/pci
-trace-events-y += hw/s390x/trace-events
+trace-events-subdirs += hw/s390x
 trace-events-y += hw/vfio/trace-events
 trace-events-y += hw/acpi/trace-events
 trace-events-y += hw/arm/trace-events
diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 41ac4ec..ac66483 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -13,3 +13,6 @@ obj-y += ccw-device.o
 obj-y += s390-pci-bus.o s390-pci-inst.o
 obj-y += s390-skeys.o
 obj-$(CONFIG_KVM) += s390-skeys-kvm.o
+
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 0f2580d..e11ffa3 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -18,7 +18,7 @@
 #include "cpu.h"
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/css.h"
-#include "trace.h"
+#include "hw/s390x/trace.h"
 #include "hw/s390x/s390_flic.h"
 
 typedef struct CrwContainer {
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index f5c1d98..7b8c7fc 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -32,7 +32,7 @@
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/css.h"
 #include "virtio-ccw.h"
-#include "trace.h"
+#include "hw/s390x/trace.h"
 #include "hw/s390x/css-bridge.h"
 
 static void virtio_ccw_bus_new(VirtioBusState *bus, size_t bus_size,
-- 
2.9.3
