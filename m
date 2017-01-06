Received: from eggs.gnu.org ([2001:4830:134:3::10]:47131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsW-0004BQ-RV
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsW-000560-4d
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsV-00055e-UO
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:28 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CDE62CFC05
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:28 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:18 +0000
Message-Id: <20170106155543.12827-23-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 22/47] trace: switch hw/sd/ directory to
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

Switch files in the hw/sd/ directory to include the
hw/sd/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs             | 2 +-
 hw/sd/Makefile.objs       | 2 ++
 hw/sd/milkymist-memcard.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 6c7252f..1d9cdd0 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -140,7 +140,7 @@ trace-events-subdirs += hw/input
 trace-events-subdirs += hw/timer
 trace-events-subdirs += hw/dma
 trace-events-subdirs += hw/sparc
-trace-events-y += hw/sd/trace-events
+trace-events-subdirs += hw/sd
 trace-events-y += hw/isa/trace-events
 trace-events-y += hw/mem/trace-events
 trace-events-y += hw/i386/trace-events
diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
index 31c8330..9fe778a 100644
--- a/hw/sd/Makefile.objs
+++ b/hw/sd/Makefile.objs
@@ -6,3 +6,5 @@ common-obj-$(CONFIG_SDHCI) += sdhci.o
 obj-$(CONFIG_MILKYMIST) += milkymist-memcard.o
 obj-$(CONFIG_OMAP) += omap_mmc.o
 obj-$(CONFIG_PXA2XX) += pxa2xx_mmci.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 1f2f0ed..ce93fc2 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -25,7 +25,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "hw/sd/trace.h"
 #include "qemu/error-report.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
-- 
2.9.3
