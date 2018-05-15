Received: from eggs.gnu.org ([2001:4830:134:3::10]:33614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIaJk-0002sd-Ms
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIaJj-0005dq-Ug
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:48:40 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fIaJj-0005dD-Nq
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:48:39 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 14:48:35 +0100
Message-Id: <20180515134835.3409-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] memory.h: Fix typo in documentation comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 525619a5f4..4fa1227f13 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -679,7 +679,7 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
  * memory_region_init_reservation: Initialize a memory region that reserves
  *                                 I/O space.
  *
- * A reservation region primariy serves debugging purposes.  It claims I/O
+ * A reservation region primarily serves debugging purposes.  It claims I/O
  * space that is not supposed to be handled by QEMU itself.  Any access via
  * the memory API will cause an abort().
  * This function is deprecated. Use memory_region_init_io() with NULL
-- 
2.17.0
