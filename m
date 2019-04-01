Received: from eggs.gnu.org ([209.51.188.92]:42617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46y-0003UH-KW
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46w-0004qU-5F
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49204
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB46v-0004gx-V3
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:54 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4NIC017126
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:35 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rks40kg1e-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:32 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:54 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:49 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-76-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 75/97] Changes requirement for "vsubsbs"
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Paul A. Clarke" <pc@us.ibm.com>, Leonardo Bras <leonardo@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: "Paul A. Clarke" <pc@us.ibm.com>

Changes requirement for "vsubsbs" instruction, which has been supported
since ISA 2.03. (Please see section 5.9.1.2 of ISA 2.03)

Reported-by: Paul A. Clarke <pc@us.ibm.com>
Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
Signed-off-by: Leonardo Bras <leonardo@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit fcfbc18d00b10335310c9665edd6e04f2d152be8)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/ppc/translate/vmx-ops.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc.c
index 139f80cb24..84e05fb827 100644
--- a/target/ppc/translate/vmx-ops.inc.c
+++ b/target/ppc/translate/vmx-ops.inc.c
@@ -143,7 +143,7 @@ GEN_VXFORM(vaddsws, 0, 14),
 GEN_VXFORM_DUAL(vsububs, bcdadd, 0, 24, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM_DUAL(vsubuhs, bcdsub, 0, 25, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM(vsubuws, 0, 26),
-GEN_VXFORM_DUAL(vsubsbs, bcdtrunc, 0, 28, PPC_NONE, PPC2_ISA300),
+GEN_VXFORM_DUAL(vsubsbs, bcdtrunc, 0, 28, PPC_ALTIVEC, PPC2_ISA300),
 GEN_VXFORM(vsubshs, 0, 29),
 GEN_VXFORM_DUAL(vsubsws, xpnd04_2, 0, 30, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM_207(vadduqm, 0, 4),
-- 
2.17.1
