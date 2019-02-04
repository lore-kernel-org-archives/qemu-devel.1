Received: from eggs.gnu.org ([209.51.188.92]:38172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8X-0000U8-A9
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8O-0007EX-Dk
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:01:49 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:00:56 +1100
Message-Id: <20190204090124.26191-10-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/37] target/ppc/kvm: Drop useless include
 directive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

It has been there since the enablement of PR KVM for PAPR, ie, commit
f61b4bedaf35 in 2011. Not sure why at that time, but it is definitely
not needed with the current code.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index ebbb48c42f..d01852fe31 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -36,7 +36,6 @@
=20
 #include "hw/sysbus.h"
 #include "hw/ppc/spapr.h"
-#include "hw/ppc/spapr_vio.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/ppc.h"
 #include "sysemu/watchdog.h"
--=20
2.20.1
