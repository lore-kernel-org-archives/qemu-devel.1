Received: from eggs.gnu.org ([2001:4830:134:3::10]:37740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clZEa-00005d-Sq
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clZEX-0003TS-P3
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:54:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1clZEX-0003TI-JB
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:54:17 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  8 Mar 2017 10:54:09 +0000
Message-Id: <20170308105409.18183-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] memory_region: Fix name comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The 'name' parameter to memory_region_init_* had been marked as debug
only, however vmstate_region_ram uses it as a parameter to
qemu_ram_set_idstr to set RAMBlock names and these form part of the
migration stream.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/exec/memory.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 6911023..de8f69e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -307,7 +307,7 @@ struct MemoryRegionSection {
  *
  * @mr: the #MemoryRegion to be initialized
  * @owner: the object that tracks the region's reference count
- * @name: used for debugging; not visible to the user or ABI
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
  * @size: size of the region; any subregions beyond this size will be clipped
  */
 void memory_region_init(MemoryRegion *mr,
@@ -355,7 +355,7 @@ void memory_region_unref(MemoryRegion *mr);
  * @ops: a structure containing read and write callbacks to be used when
  *       I/O is performed on the region.
  * @opaque: passed to the read and write callbacks of the @ops structure.
- * @name: used for debugging; not visible to the user or ABI
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
  * @size: size of the region.
  */
 void memory_region_init_io(MemoryRegion *mr,
@@ -474,7 +474,7 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
  *
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
- * @name: used for debugging; not visible to the user or ABI
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
  * @orig: the region to be referenced; @mr will be equivalent to
  *        @orig between @offset and @offset + @size - 1.
  * @offset: start of the section in @orig to be referenced.
@@ -537,7 +537,7 @@ void memory_region_init_rom_device(MemoryRegion *mr,
  *
  * @mr: the #MemoryRegion to be initialized
  * @owner: the object that tracks the region's reference count
- * @name: used for debugging; not visible to the user or ABI
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
  * @size: size of the region.
  */
 static inline void memory_region_init_reservation(MemoryRegion *mr,
@@ -558,7 +558,7 @@ static inline void memory_region_init_reservation(MemoryRegion *mr,
  * @mr: the #MemoryRegion to be initialized
  * @owner: the object that tracks the region's reference count
  * @ops: a function that translates addresses into the @target region
- * @name: used for debugging; not visible to the user or ABI
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
  * @size: size of the region.
  */
 void memory_region_init_iommu(MemoryRegion *mr,
-- 
2.9.3
