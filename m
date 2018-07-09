Received: from eggs.gnu.org ([2001:4830:134:3::10]:46646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fcaAn-0005PG-2w
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fcaAm-0006rY-BO
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:42:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fcaAm-0006rP-65
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:42:04 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  9 Jul 2018 14:41:53 -0300
Message-Id: <20180709174154.9470-2-ehabkost@redhat.com>
In-Reply-To: <20180709174154.9470-1-ehabkost@redhat.com>
References: <20180709174154.9470-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] machine: properly free device_memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Machines might have inititalized device_memory if they support memory
devices, so let's properly free it.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180702094152.7882-1-david@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2077328bcc..3fad6f8801 100644
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
2.18.0.rc1.1.g3f1ff2140
