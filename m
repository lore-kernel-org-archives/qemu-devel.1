Received: from eggs.gnu.org ([2001:4830:134:3::10]:47455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWt3-0005C9-Hg
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWt1-0005Sb-JS
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWt1-0005SM-EI
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:59 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D31B81250
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:59 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:37 +0000
Message-Id: <20170106155543.12827-42-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 41/47] trace: switch target/ppc/ directory
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

Switch files in the target/ppc/ directory to include the
target/ppc/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs            | 2 +-
 target/ppc/Makefile.objs | 2 ++
 target/ppc/kvm.c         | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 5d50645..5dbbf6c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -159,7 +159,7 @@ trace-events-subdirs += target/arm
 trace-events-subdirs += target/i386
 trace-events-subdirs += target/sparc
 trace-events-subdirs += target/s390x
-trace-events-y += target/ppc/trace-events
+trace-events-subdirs += target/ppc
 trace-events-y += qom/trace-events
 trace-events-y += linux-user/trace-events
 trace-events-y += qapi/trace-events
diff --git a/target/ppc/Makefile.objs b/target/ppc/Makefile.objs
index e667e69..7a71b38 100644
--- a/target/ppc/Makefile.objs
+++ b/target/ppc/Makefile.objs
@@ -15,3 +15,5 @@ obj-y += misc_helper.o
 obj-y += mem_helper.o
 obj-$(CONFIG_USER_ONLY) += user_only_helper.o
 obj-y += gdbstub.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9c4834c..497c5a6 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -39,7 +39,7 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/ppc.h"
 #include "sysemu/watchdog.h"
-#include "trace.h"
+#include "target/ppc/trace.h"
 #include "exec/gdbstub.h"
 #include "exec/memattrs.h"
 #include "sysemu/hostmem.h"
-- 
2.9.3
