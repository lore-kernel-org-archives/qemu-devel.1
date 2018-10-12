Received: from eggs.gnu.org ([2001:4830:134:3::10]:36330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAvwu-0002zY-SW
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAvwr-0000gB-FT
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:49:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gAvwp-0000TO-H7
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:49:41 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 12 Oct 2018 13:49:14 +0200
Message-Id: <20181012114916.23532-6-david@redhat.com>
In-Reply-To: <20181012114916.23532-1-david@redhat.com>
References: <20181012114916.23532-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/7] memory-device: use QEMU_IS_ALIGNED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>

Shorter and easier to read.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 7de1ccd497..996ad1490f 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -120,7 +120,7 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
     g_assert(address_space_end >= address_space_start);
 
     /* address_space_start indicates the maximum alignment we expect */
-    if (QEMU_ALIGN_UP(address_space_start, align) != address_space_start) {
+    if (!QEMU_IS_ALIGNED(address_space_start, align)) {
         error_setg(errp, "the alignment (0x%" PRIx64 ") is not supported",
                    align);
         return 0;
@@ -131,13 +131,13 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
         return 0;
     }
 
-    if (hint && QEMU_ALIGN_UP(*hint, align) != *hint) {
+    if (hint && !QEMU_IS_ALIGNED(*hint, align)) {
         error_setg(errp, "address must be aligned to 0x%" PRIx64 " bytes",
                    align);
         return 0;
     }
 
-    if (QEMU_ALIGN_UP(size, align) != size) {
+    if (!QEMU_IS_ALIGNED(size, align)) {
         error_setg(errp, "backend memory size must be multiple of 0x%"
                    PRIx64, align);
         return 0;
-- 
2.17.1
