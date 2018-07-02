Received: from eggs.gnu.org ([2001:4830:134:3::10]:51786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fZvLN-0008Vz-PT
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 05:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fZvLI-0001Fj-Oo
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 05:42:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43036 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fZvLI-0001ET-K1
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 05:41:56 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon,  2 Jul 2018 11:41:52 +0200
Message-Id: <20180702094152.7882-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] machine: properly free device_memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Hildenbrand <david@redhat.com>

Machines might have inititalized device_memory if they support memory
devices, so let's properly free it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 617e5f8d75..ae3e713e90 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -674,6 +674,7 @@ static void machine_finalize(Object *obj)
     g_free(ms->dumpdtb);
     g_free(ms->dt_compatible);
     g_free(ms->firmware);
+    g_free(ms->device_memory);
 }
 
 bool machine_usb(MachineState *machine)
-- 
2.17.1
