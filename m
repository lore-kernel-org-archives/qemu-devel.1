Received: from eggs.gnu.org ([2001:4830:134:3::10]:34955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2Wb-0004US-4T
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2Wa-000208-DE
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:36:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57510 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fv2Wa-000202-8K
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:36:52 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Aug 2018 17:36:10 +0200
Message-Id: <20180829153624.12299-7-david@redhat.com>
In-Reply-To: <20180829153624.12299-1-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/20] memory-device: document
 MemoryDeviceClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Hildenbrand <david@redhat.com>

Document the functions and when to not expect errors.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/hw/mem/memory-device.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 852fd8f98a..d353564faf 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -29,9 +29,22 @@ typedef struct MemoryDeviceState {
     Object parent_obj;
 } MemoryDeviceState;
 
+/**
+ * MemoryDeviceClass:
+ * @get_addr: The address of the @md in guest physical memory. "0" means that
+ * no address has been specified by the user and that no address has been
+ * assigned yet.
+ * @get_plugged_size: The amount of memory provided by this @md currently
+ * usable ("plugged") by the guest. Will not fail after the device was realized.
+ * @get_memory_region: The memory region of the @md to mapped in guest
+ * physical memory at @get_addr. Will not fail after the device was realized.
+ * @fill_device_info: Fill out #MemoryDeviceInfo with @md specific information.
+ */
 typedef struct MemoryDeviceClass {
+    /* private */
     InterfaceClass parent_class;
 
+    /* public */
     uint64_t (*get_addr)(const MemoryDeviceState *md);
     uint64_t (*get_plugged_size)(const MemoryDeviceState *md, Error **errp);
     MemoryRegion *(*get_memory_region)(MemoryDeviceState *md, Error **errp);
-- 
2.17.1
