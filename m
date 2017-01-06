Received: from eggs.gnu.org ([2001:4830:134:3::10]:47344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWss-0004rs-10
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsp-0005Ih-0q
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWso-0005IK-Qg
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:46 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF1FFC04B311
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:46 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:29 +0000
Message-Id: <20170106155543.12827-34-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 33/47] trace: switch hw/alpha/ directory to
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

Switch files in the hw/alpha/ directory to include the
hw/alpha/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs          | 2 +-
 hw/alpha/Makefile.objs | 2 ++
 hw/alpha/pci.c         | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 6a0c033..3a4abc7 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -151,7 +151,7 @@ trace-events-subdirs += hw/s390x
 trace-events-subdirs += hw/vfio
 trace-events-subdirs += hw/acpi
 trace-events-subdirs += hw/arm
-trace-events-y += hw/alpha/trace-events
+trace-events-subdirs += hw/alpha
 trace-events-y += ui/trace-events
 trace-events-y += audio/trace-events
 trace-events-y += net/trace-events
diff --git a/hw/alpha/Makefile.objs b/hw/alpha/Makefile.objs
index 5c74275..e8e0573 100644
--- a/hw/alpha/Makefile.objs
+++ b/hw/alpha/Makefile.objs
@@ -1 +1,3 @@
 obj-y += dp264.o pci.o typhoon.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/alpha/pci.c b/hw/alpha/pci.c
index 8dde637..3fafb1b 100644
--- a/hw/alpha/pci.c
+++ b/hw/alpha/pci.c
@@ -11,7 +11,7 @@
 #include "alpha_sys.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "hw/alpha/trace.h"
 
 
 /* Fallback for unassigned PCI I/O operations.  Avoids MCHK.  */
-- 
2.9.3
