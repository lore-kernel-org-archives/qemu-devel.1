Received: from eggs.gnu.org ([209.51.188.92]:47924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gk2Ul-00023k-P3
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gk2Uh-0005Qf-Vd
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:53:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52554
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gk2Uh-0005Oz-FN
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:53:43 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0H7rewm040239
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 02:53:40 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q2n4p987g-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 02:53:40 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Thu, 17 Jan 2019 07:53:38 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 17 Jan 2019 08:53:27 +0100
In-Reply-To: <20190117075327.22194-1-clg@kaod.org>
References: <20190117075327.22194-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190117075327.22194-5-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] ppc: remove the interrupt presenters from
 under PowerPCCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index bde4dff1ba80..2c22292e7f41 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -23,11 +23,6 @@
 #include "qemu-common.h"
 #include "qemu/int128.h"
=20
-#ifndef CONFIG_USER_ONLY
-#include "hw/ppc/xive.h" /* for XiveTCTX */
-#include "hw/ppc/xics.h" /* for ICPState */
-#endif
-
 //#define PPC_EMULATE_32BITS_HYPV
=20
 #if defined (TARGET_PPC64)
@@ -1203,10 +1198,6 @@ struct PowerPCCPU {
     void *machine_data;
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
-#ifndef CONFIG_USER_ONLY
-    ICPState *icp;
-    XiveTCTX *tctx;
-#endif
=20
     /* Fields related to migration compatibility hacks */
     bool pre_2_8_migration;
--=20
2.20.1
