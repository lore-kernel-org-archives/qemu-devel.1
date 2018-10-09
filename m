Received: from eggs.gnu.org ([2001:4830:134:3::10]:60657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g9p8o-0002ZB-6n
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 06:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g9p8j-0004Tb-3W
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 06:21:24 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1g9p8h-0004NL-0Z
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 06:21:20 -0400
Received: by mail-pl1-x644.google.com with SMTP id y15-v6so593759plr.12
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 03:21:15 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Tue,  9 Oct 2018 03:21:07 -0700
Message-Id: <1539080467-2976-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] memory.h: fix types in comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 include/exec/memory.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 3a427aa..1fbbdaf 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -935,7 +935,7 @@ uint64_t memory_region_size(MemoryRegion *mr);
 /**
  * memory_region_is_ram: check whether a memory region is random access
  *
- * Returns %true is a memory region is random access.
+ * Returns %true if a memory region is random access.
  *
  * @mr: the memory region being queried
  */
@@ -947,7 +947,7 @@ static inline bool memory_region_is_ram(MemoryRegion *mr)
 /**
  * memory_region_is_ram_device: check whether a memory region is a ram device
  *
- * Returns %true is a memory region is a device backed ram region
+ * Returns %true if a memory region is a device backed ram region
  *
  * @mr: the memory region being queried
  */
@@ -1161,7 +1161,7 @@ uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr);
 /**
  * memory_region_is_rom: check whether a memory region is ROM
  *
- * Returns %true is a memory region is read-only memory.
+ * Returns %true if a memory region is read-only memory.
  *
  * @mr: the memory region being queried
  */
-- 
1.8.3.1
