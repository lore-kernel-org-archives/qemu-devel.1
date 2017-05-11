Received: from eggs.gnu.org ([2001:4830:134:3::10]:56178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUy-0005MU-9x
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUw-0001VI-Qz
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:44 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 May 2017 14:14:22 +1000
Message-Id: <20170511041426.6488-20-david@gibson.dropbear.id.au>
In-Reply-To: <20170511041426.6488-1-david@gibson.dropbear.id.au>
References: <20170511041426.6488-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/23] ppc: xics: fix compilation with CentOS 6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Paolo Bonzini <pbonzini@redhat.com>

The PowerPCCPU typedef is included twice if a file includes
both hw/ppc/xics.h and target/ppc/cpu-qom.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/xics.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 68525c8..05e6acb 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -29,6 +29,7 @@
 #define XICS_H
=20
 #include "hw/qdev.h"
+#include "target/ppc/cpu-qom.h"
=20
 #define XICS_IPI        0x2
 #define XICS_BUID       0x1
@@ -46,7 +47,6 @@ typedef struct ICSStateClass ICSStateClass;
 typedef struct ICSState ICSState;
 typedef struct ICSIRQState ICSIRQState;
 typedef struct XICSFabric XICSFabric;
-typedef struct PowerPCCPU PowerPCCPU;
=20
 #define TYPE_ICP "icp"
 #define ICP(obj) OBJECT_CHECK(ICPState, (obj), TYPE_ICP)
--=20
2.9.3
