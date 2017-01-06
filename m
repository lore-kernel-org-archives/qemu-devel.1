Received: from eggs.gnu.org ([2001:4830:134:3::10]:47345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWss-0004rv-1O
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsn-0005HB-5d
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsn-0005GG-0k
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:45 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 151105A60
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:45 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:28 +0000
Message-Id: <20170106155543.12827-33-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 32/47] trace: switch hw/arm/ directory to
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

Switch files in the hw/arm/ directory to include the
hw/arm/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs            | 2 +-
 hw/arm/Makefile.objs     | 2 ++
 hw/arm/virt-acpi-build.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 86c62cd..6a0c033 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -150,7 +150,7 @@ trace-events-subdirs += hw/pci
 trace-events-subdirs += hw/s390x
 trace-events-subdirs += hw/vfio
 trace-events-subdirs += hw/acpi
-trace-events-y += hw/arm/trace-events
+trace-events-subdirs += hw/arm
 trace-events-y += hw/alpha/trace-events
 trace-events-y += ui/trace-events
 trace-events-y += audio/trace-events
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 4c5c4ee..0704312 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -18,3 +18,5 @@ obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
 obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
 obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 7102686..915f88d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -31,7 +31,7 @@
 #include "qemu-common.h"
 #include "hw/arm/virt-acpi-build.h"
 #include "qemu/bitmap.h"
-#include "trace.h"
+#include "hw/arm/trace.h"
 #include "qom/cpu.h"
 #include "target/arm/cpu.h"
 #include "hw/acpi/acpi-defs.h"
-- 
2.9.3
