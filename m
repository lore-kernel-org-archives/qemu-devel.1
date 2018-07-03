Received: from eggs.gnu.org ([2001:4830:134:3::10]:49307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fa9q1-000831-6h
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fa9pw-0003VC-O7
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:10:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fa9pw-0003UM-HR
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:10:32 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  2 Jul 2018 22:10:26 -0300
Message-Id: <20180703011026.18650-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] pc: Fix typo on PC_COMPAT_2_12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Babu Moger <babu.moger@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

I forgot a hyphen when amending the compat code on commit
e0051647 ("i386: Enable TOPOEXT feature on AMD EPYC CPU").

Fixes: e00516475c270dcb6705753da96063f95699abf2
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Bug detected by compat_checker:
https://github.com/ehabkost/gdb-qemu
---
 include/hw/i386/pc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 4d99d69681..654003f44c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -309,7 +309,7 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .property = "xlevel",\
         .value    = stringify(0x8000000a),\
     },{\
-        .driver   = "EPYC-IBPB" TYPE_X86_CPU,\
+        .driver   = "EPYC-IBPB-" TYPE_X86_CPU,\
         .property = "xlevel",\
         .value    = stringify(0x8000000a),\
     },
-- 
2.18.0.rc1.1.g3f1ff2140
