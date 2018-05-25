Received: from eggs.gnu.org ([2001:4830:134:3::10]:58438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFso-0003rX-4Q
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFsk-0002mV-Le
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:48:02 -0400
Date: Fri, 25 May 2018 19:47:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527266793-301361-12-git-send-email-mst@redhat.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527266793-301361-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/20] ppc: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, peter.maydell@linaro.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

When pulling in headers that are in the same directory as C file (as
opposed to one in include/), we should use its relative path, without a
directory.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc440_uc.c | 2 +-
 hw/ppc/sam460ex.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index e312fdb..123f4ac 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -20,7 +20,7 @@
 #include "hw/ppc/ppc.h"
 #include "hw/pci/pci.h"
 #include "sysemu/block-backend.h"
-#include "hw/ppc/ppc440.h"
+#include "ppc440.h"
 
 /*****************************************************************************/
 /* L2 Cache as SRAM */
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index a48e6e6..cb2ab1d 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -27,8 +27,8 @@
 #include "elf.h"
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
-#include "hw/ppc/ppc440.h"
-#include "hw/ppc/ppc405.h"
+#include "ppc440.h"
+#include "ppc405.h"
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
-- 
MST
