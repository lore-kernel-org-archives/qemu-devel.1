Received: from eggs.gnu.org ([2001:4830:134:3::10]:47414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsx-00053U-Of
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsx-0005Qs-14
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsw-0005QV-R4
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:54 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D84D97F748
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:54 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:34 +0000
Message-Id: <20170106155543.12827-39-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 38/47] trace: switch target/i386/ directory
 to modular trace.h file
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

Switch files in the target/i386/ directory to include the
target/i386/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs             | 2 +-
 target/i386/Makefile.objs | 2 ++
 target/i386/kvm.c         | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index dda2c04..a1161be 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -156,7 +156,7 @@ trace-events-subdirs += ui
 trace-events-subdirs += audio
 trace-events-subdirs += net
 trace-events-subdirs += target/arm
-trace-events-y += target/i386/trace-events
+trace-events-subdirs += target/i386
 trace-events-y += target/sparc/trace-events
 trace-events-y += target/s390x/trace-events
 trace-events-y += target/ppc/trace-events
diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index b223d79..a73e6f3 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -5,3 +5,5 @@ obj-y += gdbstub.o
 obj-$(CONFIG_SOFTMMU) += machine.o arch_memory_mapping.o arch_dump.o monitor.o
 obj-$(CONFIG_KVM) += kvm.o hyperv.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 10a9cd8..87f4eae 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -44,7 +44,7 @@
 #include "hw/pci/msi.h"
 #include "migration/migration.h"
 #include "exec/memattrs.h"
-#include "trace.h"
+#include "target/i386/trace.h"
 
 //#define DEBUG_KVM
 
-- 
2.9.3
