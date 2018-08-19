Received: from eggs.gnu.org ([2001:4830:134:3::10]:44004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYr-0000Cq-3r
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYp-0000kE-Hm
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:33 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:39327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1frjYo-0000iE-QG
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:31 -0400
Received: by mail-wm0-x235.google.com with SMTP id q8-v6so13794332wmq.4
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 05:45:28 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sun, 19 Aug 2018 23:22:59 +0300
Message-Id: <20180819202300.10590-15-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
References: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 14/15] hw/pvrdma: remove not needed include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, thuth@redhat.com, marcel.apfelbaum@gmail.com

No need to include linux/types.h, is empty anyway.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20180811171534.11917-1-marcel.apfelbaum@gmail.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/vmw/pvrdma_cmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index b74b0b48d0..4faeb21631 100644
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
