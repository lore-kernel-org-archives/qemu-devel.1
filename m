Received: from eggs.gnu.org ([2001:4830:134:3::10]:52966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andreas@grapentin.org>) id 1cnjYV-00027p-3w
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andreas@grapentin.org>) id 1cnjYU-0004du-EK
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:19:51 -0400
From: Andreas Grapentin <andreas@grapentin.org>
Date: Tue, 14 Mar 2017 11:19:25 +0100
Message-Id: <20170314101925.16792-2-andreas@grapentin.org>
In-Reply-To: <20170314101925.16792-1-andreas@grapentin.org>
References: <20170314101925.16792-1-andreas@grapentin.org>
Subject: [Qemu-devel] [PATCH 1/1] major / minor macros are to be included
 from <sys/sysmacros.h>
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Andreas Grapentin <andreas@grapentin.org>

---
 hw/9pfs/9p.c         | 1 +
 qga/commands-posix.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 76c9247c77..d9cfa8900e 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include <sys/sysmacros.h>
 #include <glib/gprintf.h>
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 73d93eb5ce..9eecdd092c 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 #include <sys/wait.h>
+#include <sys/sysmacros.h>
 #include <dirent.h>
 #include "qga/guest-agent-core.h"
 #include "qga-qmp-commands.h"
-- 
2.12.0
