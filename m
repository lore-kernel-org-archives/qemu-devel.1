Received: from eggs.gnu.org ([2001:4830:134:3::10]:47155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsY-0004DY-Ro
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsY-00057T-2m
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsX-00056v-TN
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:30 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2B227FD41
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:29 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:19 +0000
Message-Id: <20170106155543.12827-24-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 23/47] trace: switch hw/isa/ directory to
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

Switch files in the hw/isa/ directory to include the
hw/isa/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs        | 2 +-
 hw/isa/Makefile.objs | 2 ++
 hw/isa/pc87312.c     | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 1d9cdd0..a901f5d 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -141,7 +141,7 @@ trace-events-subdirs += hw/timer
 trace-events-subdirs += hw/dma
 trace-events-subdirs += hw/sparc
 trace-events-subdirs += hw/sd
-trace-events-y += hw/isa/trace-events
+trace-events-subdirs += hw/isa
 trace-events-y += hw/mem/trace-events
 trace-events-y += hw/i386/trace-events
 trace-events-y += hw/9pfs/trace-events
diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
index 9164556..a273afd 100644
--- a/hw/isa/Makefile.objs
+++ b/hw/isa/Makefile.objs
@@ -6,3 +6,5 @@ common-obj-$(CONFIG_PIIX4) += piix4.o
 common-obj-$(CONFIG_VT82C686) += vt82c686.o
 
 obj-$(CONFIG_LPC_ICH9) += lpc_ich9.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index b1c1a0a..d1d13f3 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -31,7 +31,7 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/char.h"
-#include "trace.h"
+#include "hw/isa/trace.h"
 
 
 #define REG_FER 0
-- 
2.9.3
