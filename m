Received: from eggs.gnu.org ([209.51.188.92]:34408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21dU-0007j7-Jg
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:37:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21dT-0003id-PA
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:37:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h21dR-00028E-1v
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:37:07 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27MIapU103629
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 17:36:06 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r39vpensp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 17:36:05 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Thu, 7 Mar 2019 22:36:03 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Mar 2019 23:35:45 +0100
In-Reply-To: <20190307223548.20516-1-clg@kaod.org>
References: <20190307223548.20516-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190307223548.20516-13-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/15] ppc/pnv: activate XSCOM tests for
 POWER9
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

We now have enough support to let the XSCOM test run on POWER9.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 tests/pnv-xscom-test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/pnv-xscom-test.c b/tests/pnv-xscom-test.c
index 974f8da5b240..63d464048d53 100644
--- a/tests/pnv-xscom-test.c
+++ b/tests/pnv-xscom-test.c
@@ -39,7 +39,6 @@ static const PnvChip pnv_chips[] =3D {
         .cfam_id    =3D 0x120d304980000000ull,
         .first_core =3D 0x1,
     },
-#if 0 /* POWER9 support is not ready yet */
     {
         .chip_type  =3D PNV_CHIP_POWER9,
         .cpu_model  =3D "POWER9",
@@ -47,7 +46,6 @@ static const PnvChip pnv_chips[] =3D {
         .cfam_id    =3D 0x220d104900008000ull,
         .first_core =3D 0x0,
     },
-#endif
 };
=20
 static uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
--=20
2.20.1
