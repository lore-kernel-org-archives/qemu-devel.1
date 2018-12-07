Received: from eggs.gnu.org ([2001:4830:134:3::10]:33956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leonardo@linux.vnet.ibm.com>) id 1gVJhT-00008R-9O
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:14:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leonardo@linux.vnet.ibm.com>) id 1gVJhP-0008Dj-O4
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:14:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <leonardo@linux.vnet.ibm.com>)
	id 1gVJhP-0008CI-E0
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:13:59 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB7H9E4O009904
	for <qemu-devel@nongnu.org>; Fri, 7 Dec 2018 12:13:58 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p7vwarrqm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 12:13:58 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <leonardo@linux.vnet.ibm.com>;
	Fri, 7 Dec 2018 17:13:56 -0000
From: Leonardo Bras <leonardo@linux.vnet.ibm.com>
Date: Fri,  7 Dec 2018 15:13:14 -0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20181207171314.30769-1-leonardo@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] Changes requirement for "vsubsbs"
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Paul A. Clarke" <pc@us.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org, Leonardo Bras <leonardo@linux.vnet.ibm.com>

From: "Paul A. Clarke" <pc@us.ibm.com>

Changes requirement for "vsubsbs" instruction, which has been supported
since ISA 2.03. (Please see section 5.9.1.2 of ISA 2.03)

Reported-by: Paul A. Clarke <pc@us.ibm.com>
Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
Signed-off-by: Leonardo Bras <leonardo@linux.vnet.ibm.com>
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
2.19.2
