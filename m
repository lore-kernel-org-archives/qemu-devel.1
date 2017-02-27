Received: from eggs.gnu.org ([2001:4830:134:3::10]:49607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ciRBC-0003mC-P2
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ciRB8-0003bM-Ry
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:41:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1ciRB8-0003aN-IG
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:41:50 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RJdE6q114691
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:41:48 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28vm1vv2r7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:41:47 -0500
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Mon, 27 Feb 2017 16:41:45 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id 9F5CD352005F
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:41:09 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1RJfhIe29884568
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:41:43 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1RJfg5m006394
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:41:43 -0300
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Mon, 27 Feb 2017 16:41:29 -0300
In-Reply-To: <1488224492-20316-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1488224492-20316-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1488224492-20316-3-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu 2/5] risu_reginfo_ppc64le: Remove unused
 code from PPC64 register comparison
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nikunj@linux.vnet.ibm.com

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 risu_reginfo_ppc64le.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/risu_reginfo_ppc64le.c b/risu_reginfo_ppc64le.c
index e6bc0e0..a76f296 100644
--- a/risu_reginfo_ppc64le.c
+++ b/risu_reginfo_ppc64le.c
@@ -86,14 +86,6 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a, ucontext_t *uc)
                 m->vrregs.vrregs[i][1] != a->vrregs.vrregs[i][1] ||
                 m->vrregs.vrregs[i][2] != a->vrregs.vrregs[i][2] ||
                 m->vrregs.vrregs[i][3] != a->vrregs.vrregs[i][3]) {
-
-            if (uc != NULL && (m->gregs[CCR] & 0x10)) {
-                uc->uc_mcontext.v_regs->vrregs[i][0] = a->vrregs.vrregs[i][0];
-                uc->uc_mcontext.v_regs->vrregs[i][1] = a->vrregs.vrregs[i][1];
-                uc->uc_mcontext.v_regs->vrregs[i][2] = a->vrregs.vrregs[i][2];
-                uc->uc_mcontext.v_regs->vrregs[i][3] = a->vrregs.vrregs[i][3];
-                return 1;
-            }
             return 0;
         }
     }
-- 
2.7.4
