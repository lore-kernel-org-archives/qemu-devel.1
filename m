Received: from eggs.gnu.org ([2001:4830:134:3::10]:45550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1foXUO-0002C1-Bw
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 13:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1foXUJ-0004Zg-Db
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 13:15:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1foXUJ-0004ZA-6m
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 13:15:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id e7-v6so10793198wrs.9
	for <qemu-devel@nongnu.org>; Sat, 11 Aug 2018 10:15:39 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 11 Aug 2018 20:15:34 +0300
Message-Id: <20180811171534.11917-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel]  [PATCH] hw/pvrdma: remove not needed include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yuval.shaia@oracle.com, thuth@redhat.com

No need to include linux/types.h, is empty anyway.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_cmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 14255d609f..3f697c8db7 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -16,7 +16,6 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "cpu.h"
-#include <linux/types.h>
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_ids.h"
-- 
2.17.1
