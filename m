Received: from eggs.gnu.org ([209.51.188.92]:34121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21d4-0007Jh-Vb
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21d2-000321-Mq
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54520
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h21cy-00028h-0l
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:36 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27MZdot039259
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 17:36:06 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r3c7u80bf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 17:36:06 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Thu, 7 Mar 2019 22:36:04 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Mar 2019 23:35:48 +0100
In-Reply-To: <20190307223548.20516-1-clg@kaod.org>
References: <20190307223548.20516-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190307223548.20516-16-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 15/15] target/ppc: add HV support for POWER9
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

We now have enough support to boot a PowerNV machine with a POWER9
processor. Allow HV mode on POWER9.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/translate_init.inc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index af70a3b78c9a..0bd555eb1913 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8895,7 +8895,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
                        PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ |
                        PPC_MEM_SYNC | PPC_MEM_EIEIO |
                        PPC_MEM_TLBSYNC |
-                       PPC_64B | PPC_64BX | PPC_ALTIVEC |
+                       PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |
                        PPC_SEGMENT_64B | PPC_SLBI |
                        PPC_POPCNTB | PPC_POPCNTWD |
                        PPC_CILDST;
@@ -8907,6 +8907,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
                         PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
                         PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL;
     pcc->msr_mask =3D (1ull << MSR_SF) |
+                    (1ull << MSR_SHV) |
                     (1ull << MSR_TM) |
                     (1ull << MSR_VR) |
                     (1ull << MSR_VSX) |
--=20
2.20.1
