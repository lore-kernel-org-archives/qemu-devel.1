Received: from eggs.gnu.org ([2001:4830:134:3::10]:58638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8b-0003gT-Cj
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8a-0000Fp-HE
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41024 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8a-0000FS-Cr
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:20 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:27 +0200
Message-Id: <20180531171253.21012-28-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 27/53] memory.h: Fix typo in documentation
 comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180515134835.3409-1-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
