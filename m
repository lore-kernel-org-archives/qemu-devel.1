Received: from eggs.gnu.org ([2001:4830:134:3::10]:56266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFX-0002Fa-Gj
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFS-00026N-FM
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:43 -0400
Date: Thu, 3 May 2018 22:50:35 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-13-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 12/67] ppc: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org

When pulling in headers that are in the same directory as C file (as
opposed to one in include/), we should use its relative path, without a
directory. Directory based path works more or less by accident.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
index dfff262..4a66e1d 100644
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
