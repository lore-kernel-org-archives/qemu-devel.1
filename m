Received: from eggs.gnu.org ([2001:4830:134:3::10]:54538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTZ-0005yp-BX
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTY-00046O-6s
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:21 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dTUTX-00040L-Va
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:20 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jul 2017 15:42:48 +0100
Message-Id: <1499438577-7674-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
References: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 02/11] memory: Document that the RAM MR
 initializers do not handle migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The various functions for initializing RAM MemoryRegions do not do
anything to cause the data in the MemoryRegion to be migrated.
Note in their documentation comments that this is the responsibility
of the caller.

(We will shortly add a new function that *does* do this for you.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memory.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 8503685..55cb5e7 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -412,6 +412,9 @@ void memory_region_init_io(MemoryRegion *mr,
  *        must be unique within any device
  * @size: size of the region.
  * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Note that this function does not do anything to cause the data in the
+ * RAM memory region to be migrated; that is the responsibility of the caller.
  */
 void memory_region_init_ram(MemoryRegion *mr,
                             struct Object *owner,
@@ -434,6 +437,9 @@ void memory_region_init_ram(MemoryRegion *mr,
  * @max_size: max size of the region.
  * @resized: callback to notify owner about used size change.
  * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Note that this function does not do anything to cause the data in the
+ * RAM memory region to be migrated; that is the responsibility of the caller.
  */
 void memory_region_init_resizeable_ram(MemoryRegion *mr,
                                        struct Object *owner,
@@ -457,6 +463,9 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
  * @share: %true if memory must be mmaped with the MAP_SHARED flag
  * @path: the path in which to allocate the RAM.
  * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Note that this function does not do anything to cause the data in the
+ * RAM memory region to be migrated; that is the responsibility of the caller.
  */
 void memory_region_init_ram_from_file(MemoryRegion *mr,
                                       struct Object *owner,
@@ -477,6 +486,9 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
  * @share: %true if memory must be mmaped with the MAP_SHARED flag
  * @fd: the fd to mmap.
  * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Note that this function does not do anything to cause the data in the
+ * RAM memory region to be migrated; that is the responsibility of the caller.
  */
 void memory_region_init_ram_from_fd(MemoryRegion *mr,
                                     struct Object *owner,
@@ -498,6 +510,9 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
  *        must be unique within any device
  * @size: size of the region.
  * @ptr: memory to be mapped; must contain at least @size bytes.
+ *
+ * Note that this function does not do anything to cause the data in the
+ * RAM memory region to be migrated; that is the responsibility of the caller.
  */
 void memory_region_init_ram_ptr(MemoryRegion *mr,
                                 struct Object *owner,
@@ -522,6 +537,9 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
  * @name: the name of the region.
  * @size: size of the region.
  * @ptr: memory to be mapped; must contain at least @size bytes.
+ *
+ * Note that this function does not do anything to cause the data in the
+ * RAM memory region to be migrated; that is the responsibility of the caller.
  */
 void memory_region_init_ram_device_ptr(MemoryRegion *mr,
                                        struct Object *owner,
-- 
2.7.4
