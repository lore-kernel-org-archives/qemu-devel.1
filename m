Received: from eggs.gnu.org ([209.51.188.92]:45707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gjjV1-0005UM-Mp
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gjjV0-0000k3-W7
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:36:47 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 16 Jan 2019 12:35:23 +0100
Message-Id: <20190116113523.9213-11-david@redhat.com>
In-Reply-To: <20190116113523.9213-1-david@redhat.com>
References: <20190116113523.9213-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 10/10] pc: Enable support for virtio-pmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Collin Walling <walling@linux.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

As we can now properly hotplug PCI based memory devices on x86, we can
now unlock support for virtio-pmem (which will unlock virtio-pmem-pci).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 default-configs/i386-softmmu.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 64c998c4c8..3f63e95a55 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -52,6 +52,7 @@ CONFIG_APIC=y
 CONFIG_IOAPIC=y
 CONFIG_PVPANIC=y
 CONFIG_MEM_DEVICE=y
+CONFIG_VIRTIO_PMEM=y
 CONFIG_DIMM=y
 CONFIG_NVDIMM=y
 CONFIG_ACPI_NVDIMM=y
-- 
2.17.2
