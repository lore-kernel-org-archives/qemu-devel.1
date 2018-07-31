Received: from eggs.gnu.org ([2001:4830:134:3::10]:34135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fkSL3-0003E2-4z
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fkSKy-0003pU-6v
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:57:13 -0400
Received: from 3.mo6.mail-out.ovh.net ([178.33.253.26]:42101)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fkSKx-0003mB-Vg
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:57:08 -0400
Received: from player779.ha.ovh.net (unknown [10.109.159.20])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 45ABE17146E
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 12:56:59 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 31 Jul 2018 12:56:49 +0200
Message-ID: <153303460952.379428.12331310797981914812.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH for-3.1] xics: don't include
 "target/ppc/cpu-qom.h" in "hw/ppc/xics.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The last user of the PowerPCCPU typedef in "hw/ppc/xics.h" vanished with
commit b1fd36c363d73969841468146ebfb9fd84a5ee52. It isn't necessary to
include "target/ppc/cpu-qom.h" there anymore.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 include/hw/ppc/xics.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 6ac8a9392da6..9c2916c9b23a 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -29,7 +29,6 @@
 #define XICS_H
 
 #include "hw/qdev.h"
-#include "target/ppc/cpu-qom.h"
 
 #define XICS_IPI        0x2
 #define XICS_BUID       0x1
