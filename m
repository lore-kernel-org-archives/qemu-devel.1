Received: from eggs.gnu.org ([2001:4830:134:3::10]:57639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGU-00039K-JQ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGS-0003Ew-Qu
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:42 -0400
Date: Thu, 3 May 2018 22:51:39 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-60-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 59/67] hw/ppc: add target headers explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

This way they are easier to find.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/ppc/spapr.c       | 6 +++---
 hw/ppc/spapr_caps.c  | 2 +-
 hw/ppc/spapr_hcall.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a81570e..62d625c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -42,9 +42,9 @@
 #include "migration/misc.h"
 #include "migration/global_state.h"
 #include "migration/register.h"
-#include "mmu-hash64.h"
-#include "mmu-book3s-v3.h"
-#include "cpu-models.h"
+#include "target/ppc/mmu-hash64.h"
+#include "target/ppc/mmu-book3s-v3.h"
+#include "target/ppc/cpu-models.h"
 #include "qom/cpu.h"
 
 #include "hw/boards.h"
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 531e145..b950a0a 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -27,7 +27,7 @@
 #include "qapi/visitor.h"
 #include "sysemu/hw_accel.h"
 #include "target/ppc/cpu.h"
-#include "cpu-models.h"
+#include "target/ppc/cpu-models.h"
 #include "kvm_ppc.h"
 
 #include "hw/ppc/spapr.h"
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 16bccdd..f011fa9 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -6,14 +6,14 @@
 #include "qemu/error-report.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "helper_regs.h"
+#include "target/ppc/helper_regs.h"
 #include "hw/ppc/spapr.h"
 #include "mmu-hash64.h"
 #include "cpu-models.h"
 #include "trace.h"
 #include "kvm_ppc.h"
 #include "hw/ppc/spapr_ovec.h"
-#include "mmu-book3s-v3.h"
+#include "target/ppc/mmu-book3s-v3.h"
 
 struct SPRSyncState {
     int spr;
-- 
MST
