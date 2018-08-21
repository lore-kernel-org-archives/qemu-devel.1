Received: from eggs.gnu.org ([2001:4830:134:3::10]:56498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMt-0004Bf-MM
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMo-0000MF-Sw
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:08 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:29 +1000
Message-Id: <20180821043343.7514-13-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 12/26] xics: don't include
 "target/ppc/cpu-qom.h" in "hw/ppc/xics.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The last user of the PowerPCCPU typedef in "hw/ppc/xics.h" vanished with
commit b1fd36c363d73969841468146ebfb9fd84a5ee52. It isn't necessary to
include "target/ppc/cpu-qom.h" there anymore.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/xics.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 6ac8a9392d..9c2916c9b2 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -29,7 +29,6 @@
 #define XICS_H
 
 #include "hw/qdev.h"
-#include "target/ppc/cpu-qom.h"
 
 #define XICS_IPI        0x2
 #define XICS_BUID       0x1
-- 
2.17.1
