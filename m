Received: from eggs.gnu.org ([2001:4830:134:3::10]:41371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUv6H-0001n6-M1
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUv6G-0000Pc-8l
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:25:45 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Jun 2018 16:25:25 +0200
Message-Id: <20180618142536.23995-2-david@redhat.com>
In-Reply-To: <20180618142536.23995-1-david@redhat.com>
References: <20180618142536.23995-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 01/12] pc-dimm: remove leftover "struct
 pc_dimms_capacity"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Not needed anymore, let's drop it.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/pc-dimm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 12da89d562..62b34a992e 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -27,11 +27,6 @@
 #include "sysemu/numa.h"
 #include "trace.h"
 
-typedef struct pc_dimms_capacity {
-     uint64_t size;
-     Error    **errp;
-} pc_dimms_capacity;
-
 void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
                          uint64_t align, Error **errp)
 {
-- 
2.17.1
