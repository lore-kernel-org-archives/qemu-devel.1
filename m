Received: from eggs.gnu.org ([2001:4830:134:3::10]:47342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MRi-0001nM-4r
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MIg-0006Ho-35
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:21:37 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  5 Oct 2018 11:20:13 +0200
Message-Id: <20181005092024.14344-6-david@redhat.com>
In-Reply-To: <20181005092024.14344-1-david@redhat.com>
References: <20181005092024.14344-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 05/16] memory-device: use memory device
 terminology in error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Auger Eric <eric.auger@redhat.com>, David Hildenbrand <david@redhat.com>

While we rephrased most error messages, we missed these.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 0624184c40..87369ef2e1 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -87,7 +87,7 @@ static void memory_device_check_addable(MachineState *ms, uint64_t size,
     memory_device_used_region_size(OBJECT(ms), &used_region_size);
     if (used_region_size + size > ms->maxram_size - ms->ram_size) {
         error_setg(errp, "not enough space, currently 0x%" PRIx64
-                   " in use of total hot pluggable 0x" RAM_ADDR_FMT,
+                   " in use of total space for memory devices 0x" RAM_ADDR_FMT,
                    used_region_size, ms->maxram_size - ms->ram_size);
         return;
     }
@@ -145,12 +145,12 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
     if (hint) {
         new_addr = *hint;
         if (new_addr < address_space_start) {
-            error_setg(errp, "can't add memory [0x%" PRIx64 ":0x%" PRIx64
+            error_setg(errp, "can't add memory device [0x%" PRIx64 ":0x%" PRIx64
                        "] before 0x%" PRIx64, new_addr, size,
                        address_space_start);
             return 0;
         } else if ((new_addr + size) > address_space_end) {
-            error_setg(errp, "can't add memory [0x%" PRIx64 ":0x%" PRIx64
+            error_setg(errp, "can't add memory device [0x%" PRIx64 ":0x%" PRIx64
                        "] beyond 0x%" PRIx64, new_addr, size,
                        address_space_end);
             return 0;
-- 
2.17.1
