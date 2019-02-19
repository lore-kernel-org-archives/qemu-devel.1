Received: from eggs.gnu.org ([209.51.188.92]:47875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gw6LB-00070C-9H
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gw6LA-0007Gf-Gp
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:25:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gw6LA-0007DY-6F
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:25:44 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1JENu3I010167
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 09:25:42 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qrhkdq1hb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 09:25:42 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Tue, 19 Feb 2019 14:25:39 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 19 Feb 2019 15:25:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190219142530.17807-1-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ppc/xive: xive does not have a POWER7
 interrupt model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Patch "target/ppc: Add POWER9 external interrupt model" should have
removed the section covering PPC_FLAGS_INPUT_POWER7.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 425aa97ef9f6..daa7badc8492 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -481,9 +481,6 @@ static void xive_tctx_realize(DeviceState *dev, Error=
 **errp)
=20
     env =3D &cpu->env;
     switch (PPC_INPUT(env)) {
-    case PPC_FLAGS_INPUT_POWER7:
-        tctx->output =3D env->irq_inputs[POWER7_INPUT_INT];
-        break;
     case PPC_FLAGS_INPUT_POWER9:
         tctx->output =3D env->irq_inputs[POWER9_INPUT_INT];
         break;
--=20
2.20.1
