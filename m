Received: from eggs.gnu.org ([2001:4830:134:3::10]:50923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fb2vT-0000lF-UV
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fb2vT-0002i9-19
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:59:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fb2vS-0002hE-Sr
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:59:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70EE44023132
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 11:59:54 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  5 Jul 2018 13:59:37 +0200
Message-Id: <20180705115943.29402-6-david@redhat.com>
In-Reply-To: <20180705115943.29402-1-david@redhat.com>
References: <20180705115943.29402-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 05/11] memory-device: document
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>

Document the functions and when to not expect errors.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/hw/mem/memory-device.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 852fd8f98a..0c1fd66b68 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -29,9 +29,23 @@ typedef struct MemoryDeviceState {
     Object parent_obj;
 } MemoryDeviceState;
 
+/**
+ * MemoryDeviceClass:
+ * @get_addr: The address of the @md in guest physical memory. "0" means that
+ * no address has been specified by the user and that no address has been
+ * assigned yet.
+ * @get_plugged_size: The the amount of memory provided by this @md
+ * currently usable ("plugged") by the guest. Will not fail after the device
+ * was realized.
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
