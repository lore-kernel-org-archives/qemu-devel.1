Received: from eggs.gnu.org ([2001:4830:134:3::10]:36560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9Z-0003OI-Ad
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9X-0006We-4i
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:29 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnp9W-0006WE-Ug
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:27 -0400
Received: by mail-wr0-x242.google.com with SMTP id l37so24466327wrc.3
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:18:26 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:03 +0100
Message-Id: <1489508300-48184-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/18] memory_region: Fix name comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The 'name' parameter to memory_region_init_* had been marked as debug
only, however vmstate_region_ram uses it as a parameter to
qemu_ram_set_idstr to set RAMBlock names and these form part of the
migration stream.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170309152708.30635-1-dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 6911023..e39256a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -371,7 +371,8 @@ void memory_region_init_io(MemoryRegion *mr,
  *
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
- * @name: the name of the region.
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
  * @size: size of the region.
  * @errp: pointer to Error*, to store an error if it happens.
  */
@@ -390,7 +391,8 @@ void memory_region_init_ram(MemoryRegion *mr,
  *
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
- * @name: the name of the region.
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
  * @size: used size of the region.
  * @max_size: max size of the region.
  * @resized: callback to notify owner about used size change.
@@ -412,7 +414,8 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
  *
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
- * @name: the name of the region.
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
  * @size: size of the region.
  * @share: %true if memory must be mmaped with the MAP_SHARED flag
  * @path: the path in which to allocate the RAM.
@@ -434,7 +437,8 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
  *
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
- * @name: the name of the region.
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
  * @size: size of the region.
  * @ptr: memory to be mapped; must contain at least @size bytes.
  */
@@ -496,7 +500,8 @@ void memory_region_init_alias(MemoryRegion *mr,
  *
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
- * @name: the name of the region.
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
  * @size: size of the region.
  * @errp: pointer to Error*, to store an error if it happens.
  */
@@ -513,7 +518,8 @@ void memory_region_init_rom(MemoryRegion *mr,
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
  * @ops: callbacks for write access handling (must not be NULL).
- * @name: the name of the region.
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
  * @size: size of the region.
  * @errp: pointer to Error*, to store an error if it happens.
  */
-- 
1.8.3.1
