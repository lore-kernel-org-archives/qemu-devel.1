Received: from eggs.gnu.org ([2001:4830:134:3::10]:57488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGN-00033o-R8
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGN-00037x-00
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34360 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKGM-00037U-S8
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:34 -0400
Date: Thu, 3 May 2018 22:51:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-54-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 53/67] target/ppc: add include directory headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org

This way they are easier to find using standard rules.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/target/ppc/cpu-models.h    | 1 +
 include/target/ppc/cpu.h           | 1 +
 include/target/ppc/helper_regs.h   | 1 +
 include/target/ppc/mmu-book3s-v3.h | 1 +
 include/target/ppc/mmu-hash64.h    | 1 +
 5 files changed, 5 insertions(+)
 create mode 100644 include/target/ppc/cpu-models.h
 create mode 100644 include/target/ppc/cpu.h
 create mode 100644 include/target/ppc/helper_regs.h
 create mode 100644 include/target/ppc/mmu-book3s-v3.h
 create mode 100644 include/target/ppc/mmu-hash64.h

diff --git a/include/target/ppc/cpu-models.h b/include/target/ppc/cpu-models.h
new file mode 100644
index 0000000..2cb5fb9
--- /dev/null
+++ b/include/target/ppc/cpu-models.h
@@ -0,0 +1 @@
+#include_next "../target/ppc/cpu-models.h"
diff --git a/include/target/ppc/cpu.h b/include/target/ppc/cpu.h
new file mode 100644
index 0000000..36348ed
--- /dev/null
+++ b/include/target/ppc/cpu.h
@@ -0,0 +1 @@
+#include_next "../target/ppc/cpu.h"
diff --git a/include/target/ppc/helper_regs.h b/include/target/ppc/helper_regs.h
new file mode 100644
index 0000000..0e125b4
--- /dev/null
+++ b/include/target/ppc/helper_regs.h
@@ -0,0 +1 @@
+#include_next "../target/ppc/helper_regs.h"
diff --git a/include/target/ppc/mmu-book3s-v3.h b/include/target/ppc/mmu-book3s-v3.h
new file mode 100644
index 0000000..3d6e989
--- /dev/null
+++ b/include/target/ppc/mmu-book3s-v3.h
@@ -0,0 +1 @@
+#include_next "../target/ppc/mmu-book3s-v3.h"
diff --git a/include/target/ppc/mmu-hash64.h b/include/target/ppc/mmu-hash64.h
new file mode 100644
index 0000000..7eaddfe
--- /dev/null
+++ b/include/target/ppc/mmu-hash64.h
@@ -0,0 +1 @@
+#include_next "../target/ppc/mmu-hash64.h"
-- 
MST
