Received: from eggs.gnu.org ([2001:4830:134:3::10]:37234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fZyXC-000277-3R
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fZyXB-00070l-3G
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:06:26 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  2 Jul 2018 14:06:05 +0100
Message-Id: <20180702130605.13611-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0] boards.h: Remove doc comment reference
 to nonexistent function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Thomas Huth <huth@tuxfamily.org>, Paolo Bonzini <pbonzini@redhat.com>

commit b08199c6fbea1 accidentally added a reference to a doc
comment to a nonexistent memory_region_allocate_aux_memory().
This was a leftover from a previous version of the patchset
which defined memory_region_allocate_aux_memory() for
"allocate RAM MemoryRegion and register it for migration"
and left "memory_region_init_ram()" with its original semantics
of "allocate RAM MR but do not register for migration". In
the end we decided on the approach of "memory_region_init_ram()
registers the MR for migration, and memory_region_init_ram_nomigrate()
is a new function which does not", but this comment change
got left in by mistake. Revert that part of the commit.

Reported-by: Thomas Huth <huth@tuxfamily.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Doesn't strictly need to go into 3.0, but it's a trivial
doc comment fix...

 include/hw/boards.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 79069ddcbec..d139a431a67 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -35,8 +35,7 @@
  *
  * Smaller pieces of memory (display RAM, static RAMs, etc) don't need
  * to be backed via the -mem-path memory backend and can simply
- * be created via memory_region_allocate_aux_memory() or
- * memory_region_init_ram().
+ * be created via memory_region_init_ram().
  */
 void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
                                           const char *name,
-- 
2.17.1
