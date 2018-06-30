Received: from eggs.gnu.org ([2001:4830:134:3::10]:38189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96T-0004Zb-Qp
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96S-0002wr-SW
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:25 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ96S-0002tv-MU
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:24 -0400
Received: by mail-wm0-x234.google.com with SMTP id u18-v6so3959729wmc.1
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:11:24 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:33 +0200
Message-Id: <20180630061040.6018-41-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 40/47] hw/rdma: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Message-Id: <20180625124238.25339-40-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/rdma/vmw/pvrdma.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
index 0b46dc5..81e0e0e 100644
--- a/hw/rdma/vmw/pvrdma.h
+++ b/hw/rdma/vmw/pvrdma.h
@@ -16,6 +16,7 @@
 #ifndef PVRDMA_PVRDMA_H
 #define PVRDMA_PVRDMA_H
 
+#include "qemu/units.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msix.h"
 
@@ -30,7 +31,7 @@
 #define RDMA_MSIX_BAR_IDX    0
 #define RDMA_REG_BAR_IDX     1
 #define RDMA_UAR_BAR_IDX     2
-#define RDMA_BAR0_MSIX_SIZE  (16 * 1024)
+#define RDMA_BAR0_MSIX_SIZE  (16 * KiB)
 #define RDMA_BAR1_REGS_SIZE  64
 #define RDMA_BAR2_UAR_SIZE   (0x1000 * MAX_UCS) /* each uc gets page */
 
-- 
1.8.3.1
