Received: from eggs.gnu.org ([2001:4830:134:3::10]:47130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsW-0004BP-RM
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsU-000551-Eb
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsU-00054j-83
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:26 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4327561B8E
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:26 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:17 +0000
Message-Id: <20170106155543.12827-22-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 21/47] trace: switch hw/sparc/ directory to
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

Switch files in the hw/sparc/ directory to include the
hw/sparc/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs          | 2 +-
 hw/sparc/Makefile.objs | 2 ++
 hw/sparc/leon3.c       | 2 +-
 hw/sparc/sun4m.c       | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 2d56890..6c7252f 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -139,7 +139,7 @@ trace-events-subdirs += hw/display
 trace-events-subdirs += hw/input
 trace-events-subdirs += hw/timer
 trace-events-subdirs += hw/dma
-trace-events-y += hw/sparc/trace-events
+trace-events-subdirs += hw/sparc
 trace-events-y += hw/sd/trace-events
 trace-events-y += hw/isa/trace-events
 trace-events-y += hw/mem/trace-events
diff --git a/hw/sparc/Makefile.objs b/hw/sparc/Makefile.objs
index c987b5b..f509dc7 100644
--- a/hw/sparc/Makefile.objs
+++ b/hw/sparc/Makefile.objs
@@ -1 +1,3 @@
 obj-y += sun4m.o leon3.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 6e16478..2cc29d4 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -34,7 +34,7 @@
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "trace.h"
+#include "hw/sparc/trace.h"
 #include "exec/address-spaces.h"
 
 #include "hw/sparc/grlib.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index f5b6efd..5b0c31e 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -46,7 +46,7 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "sysemu/block-backend.h"
-#include "trace.h"
+#include "hw/sparc/trace.h"
 #include "qemu/cutils.h"
 
 /*
-- 
2.9.3
