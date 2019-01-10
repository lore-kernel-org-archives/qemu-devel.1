Received: from eggs.gnu.org ([209.51.188.92]:33957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ghbFe-0007CN-Gw
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ghbFd-0001Af-4x
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:24:06 -0500
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:40768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ghbFc-00018T-TY
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:24:05 -0500
Received: from player786.ha.ovh.net (unknown [10.109.143.246])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 6A2541A2529
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 15:24:02 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 10 Jan 2019 15:23:58 +0100
Message-ID: <154713023826.379171.4010754027183178230.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] target/ppc/kvm: Drop useless include directive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

It has been there since the enablement of PR KVM for PAPR, ie, commit
f61b4bedaf35 in 2011. Not sure why at that time, but it is definitely
not needed with the current code.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/kvm.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index ebbb48c42f25..d01852fe3112 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -36,7 +36,6 @@
 
 #include "hw/sysbus.h"
 #include "hw/ppc/spapr.h"
-#include "hw/ppc/spapr_vio.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/ppc.h"
 #include "sysemu/watchdog.h"
