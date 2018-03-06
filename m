Received: from eggs.gnu.org ([2001:4830:134:3::10]:50388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sandipan@linux.vnet.ibm.com>) id 1et6Iu-0004RD-Az
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:42:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sandipan@linux.vnet.ibm.com>) id 1et6Iq-00084V-6d
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:42:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sandipan@linux.vnet.ibm.com>)
	id 1et6Ip-000841-VS
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:42:24 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w266do9S077129
	for <qemu-devel@nongnu.org>; Tue, 6 Mar 2018 01:42:22 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ghnrerdp5-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 01:42:22 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sandipan@linux.vnet.ibm.com>;
	Tue, 6 Mar 2018 06:42:20 -0000
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
Date: Tue,  6 Mar 2018 12:12:10 +0530
In-Reply-To: <20180306064210.26157-1-sandipan@linux.vnet.ibm.com>
References: <20180306064210.26157-1-sandipan@linux.vnet.ibm.com>
Message-Id: <20180306064210.26157-3-sandipan@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH risu 3/3] risu_reginfo_ppc64.c: Fix register
 name prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, joserz@linux.vnet.ibm.com
Cc: nikunj@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, qemu-devel@nongnu.org

Use 'f' instead of 'r' as the prefix when dumping the values
of floating-point registers.

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 risu_reginfo_ppc64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index eb9c12b..5f33648 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -122,7 +122,7 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
     fprintf(f, "\tdscr   : %16lx\n\n", ri->gregs[44]);
 
     for (i = 0; i < 16; i++) {
-        fprintf(f, "\tf%2d: %.4f\tr%2d: %.4f\n", i, ri->fpregs[i],
+        fprintf(f, "\tf%2d: %.4f\tf%2d: %.4f\n", i, ri->fpregs[i],
                 i + 16, ri->fpregs[i + 16]);
     }
     fprintf(f, "\tfpscr: %f\n\n", ri->fpregs[32]);
@@ -167,7 +167,7 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
         }
 
         if (m->fpregs[i] != a->fpregs[i]) {
-            fprintf(f, "Mismatch: Register r%d\n", i);
+            fprintf(f, "Mismatch: Register f%d\n", i);
             fprintf(f, "m: [%f] != a: [%f]\n", m->fpregs[i], a->fpregs[i]);
         }
     }
-- 
2.14.3
