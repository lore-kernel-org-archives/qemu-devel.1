Received: from eggs.gnu.org ([208.118.235.92]:52940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fzFvr-0003fQ-Tz
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 02:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fzFvI-0006Dz-2a
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 02:43:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39588 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fzFvH-0006D4-Sb
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 02:43:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F9FC9BB7D
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 06:43:45 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 10 Sep 2018 08:43:39 +0200
Message-Id: <20180910064340.30745-2-kraxel@redhat.com>
In-Reply-To: <20180910064340.30745-1-kraxel@redhat.com>
References: <20180910064340.30745-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] stubs: add ramfb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Needed to make sure code using ramfb (vfio) compiles properly even on
platforms without fw_cfg (and therefore no ramfb) support.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 stubs/ramfb.c       | 13 +++++++++++++
 stubs/Makefile.objs |  1 +
 2 files changed, 14 insertions(+)
 create mode 100644 stubs/ramfb.c

diff --git a/stubs/ramfb.c b/stubs/ramfb.c
new file mode 100644
index 0000000000..48143f3354
--- /dev/null
+++ b/stubs/ramfb.c
@@ -0,0 +1,13 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/display/ramfb.h"
+
+void ramfb_display_update(QemuConsole *con, RAMFBState *s)
+{
+}
+
+RAMFBState *ramfb_setup(Error **errp)
+{
+    error_setg(errp, "ramfb support not available");
+    return NULL;
+}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 53d3f32cb2..5dd0aeeec6 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -43,3 +43,4 @@ stub-obj-y += xen-common.o
 stub-obj-y += xen-hvm.o
 stub-obj-y += pci-host-piix.o
 stub-obj-y += ram-block.o
+stub-obj-y += ramfb.o
-- 
2.9.3
