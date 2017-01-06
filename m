Received: from eggs.gnu.org ([2001:4830:134:3::10]:47225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsh-0004cn-HE
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsd-0005AO-6Z
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsd-00059s-18
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:35 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24C587EBA9
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:35 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:22 +0000
Message-Id: <20170106155543.12827-27-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 26/47] trace: switch hw/9pfs/ directory to
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

Switch files in the hw/9pfs/ directory to include the
hw/9pfs/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs         | 2 +-
 hw/9pfs/9p.c          | 2 +-
 hw/9pfs/Makefile.objs | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 14ae798..83906e5 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -144,7 +144,7 @@ trace-events-subdirs += hw/sd
 trace-events-subdirs += hw/isa
 trace-events-subdirs += hw/mem
 trace-events-subdirs += hw/i386
-trace-events-y += hw/9pfs/trace-events
+trace-events-subdirs += hw/9pfs
 trace-events-y += hw/ppc/trace-events
 trace-events-y += hw/pci/trace-events
 trace-events-y += hw/s390x/trace-events
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index fa58877..bb9428c 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -22,7 +22,7 @@
 #include "fsdev/qemu-fsdev.h"
 #include "9p-xattr.h"
 #include "coth.h"
-#include "trace.h"
+#include "hw/9pfs/trace.h"
 #include "migration/migration.h"
 
 int open_fd_hw;
diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
index da0ae0c..28eb2e5 100644
--- a/hw/9pfs/Makefile.objs
+++ b/hw/9pfs/Makefile.objs
@@ -7,3 +7,5 @@ common-obj-$(CONFIG_OPEN_BY_HANDLE) +=  9p-handle.o
 common-obj-y += 9p-proxy.o
 
 obj-y += virtio-9p-device.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
-- 
2.9.3
