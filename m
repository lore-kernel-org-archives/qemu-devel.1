Received: from eggs.gnu.org ([2001:4830:134:3::10]:58943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIAHk-0003tn-Kf
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIAHg-00052C-QY
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:00:52 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 14 May 2018 12:00:12 +0200
Message-Id: <20180514100023.12542-8-david@redhat.com>
In-Reply-To: <20180514100023.12542-1-david@redhat.com>
References: <20180514100023.12542-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 07/18] spapr: route all memory devices
 through the machine hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Hildenbrand <david@redhat.com>

Necessary to hotplug them cleanly later.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/ppc/spapr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b7c5c95f7a..2f315f963b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3666,6 +3666,7 @@ static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
                                                  DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE) ||
         object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
         return HOTPLUG_HANDLER(machine);
     }
-- 
2.14.3
