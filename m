Received: from eggs.gnu.org ([2001:4830:134:3::10]:50668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gC6nN-0002zu-Fr
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gC6nK-0003Hu-5A
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:36:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gC6nJ-0003HM-UN
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:36:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4196F811A4
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 17:36:41 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 15 Oct 2018 11:36:37 -0600
Message-ID: <153962499744.21502.6529748287138377116.stgit@gimli.home>
In-Reply-To: <153962488126.21502.17134983449941187881.stgit@gimli.home>
References: <153962488126.21502.17134983449941187881.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 1/6] stubs: add ramfb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

From: Gerd Hoffmann <kraxel@redhat.com>

Needed to make sure code using ramfb (vfio) compiles properly even on
platforms without fw_cfg (and therefore no ramfb) support.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 stubs/Makefile.objs |    1 +
 stubs/ramfb.c       |   13 +++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 stubs/ramfb.c

diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 53d3f32cb258..5dd0aeeec69c 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -43,3 +43,4 @@ stub-obj-y += xen-common.o
 stub-obj-y += xen-hvm.o
 stub-obj-y += pci-host-piix.o
 stub-obj-y += ram-block.o
+stub-obj-y += ramfb.o
diff --git a/stubs/ramfb.c b/stubs/ramfb.c
new file mode 100644
index 000000000000..48143f33542f
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
