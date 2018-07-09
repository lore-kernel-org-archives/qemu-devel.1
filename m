Received: from eggs.gnu.org ([2001:4830:134:3::10]:48246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWco-0007jA-Bc
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcn-00054W-Hz
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:46 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fcWcn-00053K-AM
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:45 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcm-0000l2-0r
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:54:44 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jul 2018 14:54:34 +0100
Message-Id: <20180709135435.836-11-peter.maydell@linaro.org>
In-Reply-To: <20180709135435.836-1-peter.maydell@linaro.org>
References: <20180709135435.836-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/11] boards.h: Remove doc comment reference to
 nonexistent function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Message-id: 20180702130605.13611-1-peter.maydell@linaro.org
---
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
