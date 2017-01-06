Received: from eggs.gnu.org ([2001:4830:134:3::10]:47385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsu-0004zQ-TP
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsu-0005Oc-77
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsu-0005NE-1n
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:52 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A9294E33C
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:52 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:32 +0000
Message-Id: <20170106155543.12827-37-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 36/47] trace: switch net/ directory to
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

Switch files in the net/ directory to include the
net/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs       | 2 +-
 net/Makefile.objs   | 2 ++
 net/filter-mirror.c | 2 +-
 net/vhost-user.c    | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index dc3a51e..d6125a8 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -154,7 +154,7 @@ trace-events-subdirs += hw/arm
 trace-events-subdirs += hw/alpha
 trace-events-subdirs += ui
 trace-events-subdirs += audio
-trace-events-y += net/trace-events
+trace-events-subdirs += net
 trace-events-y += target/arm/trace-events
 trace-events-y += target/i386/trace-events
 trace-events-y += target/sparc/trace-events
diff --git a/net/Makefile.objs b/net/Makefile.objs
index 2e2fd43..9cb8f78 100644
--- a/net/Makefile.objs
+++ b/net/Makefile.objs
@@ -20,3 +20,5 @@ common-obj-y += colo-compare.o
 common-obj-y += colo.o
 common-obj-y += filter-rewriter.o
 common-obj-y += filter-replay.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index b7d6456..5e1cb16 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -19,7 +19,7 @@
 #include "qom/object.h"
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "net/trace.h"
 #include "sysemu/char.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 7aff77e..c812462 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -16,7 +16,7 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qmp-commands.h"
-#include "trace.h"
+#include "net/trace.h"
 
 typedef struct VhostUserState {
     NetClientState nc;
-- 
2.9.3
