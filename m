Received: from eggs.gnu.org ([2001:4830:134:3::10]:42269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZpvJ-0003uR-AK
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZpvG-0000Ff-6H
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cZpvF-0000FP-Ss
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:54 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1428box066458
	for <qemu-devel@nongnu.org>; Fri, 3 Feb 2017 21:17:52 -0500
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28crxtbvyf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 21:17:52 -0500
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Sat, 4 Feb 2017 00:17:49 -0200
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id 79E131DC006D
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 21:17:48 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v142HlQC12648698
	for <qemu-devel@nongnu.org>; Sat, 4 Feb 2017 00:17:47 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v142Hljh012053
	for <qemu-devel@nongnu.org>; Sat, 4 Feb 2017 00:17:47 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Sat,  4 Feb 2017 00:17:21 -0200
In-Reply-To: <1486174642-14883-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1486174642-14883-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1486174642-14883-7-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu 6/7] risu_ppc64le: remove fancy shell
 character cont from messages
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
 risu_reginfo_ppc64le.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/risu_reginfo_ppc64le.c b/risu_reginfo_ppc64le.c
index 7a54eab..e6bc0e0 100644
--- a/risu_reginfo_ppc64le.c
+++ b/risu_reginfo_ppc64le.c
@@ -105,9 +105,9 @@ void reginfo_dump(struct reginfo *ri, int is_master)
 {
     int i;
     if (is_master) {
-        fprintf(stderr, "  faulting insn \e[1;101;37m0x%x\e[0m\n", ri->faulting_insn);
-        fprintf(stderr, "  prev insn     \e[1;101;37m0x%x\e[0m\n", ri->prev_insn);
-        fprintf(stderr, "  prev addr     \e[1;101;37m0x%" PRIx64 "\e[0m\n\n", ri->prev_addr);
+        fprintf(stderr, "  faulting insn 0x%x\n", ri->faulting_insn);
+        fprintf(stderr, "  prev insn     0x%x\n", ri->prev_insn);
+        fprintf(stderr, "  prev addr    0x%" PRIx64 "\n\n", ri->nip);
     }
 
     for (i = 0; i < 16; i++) {
-- 
2.7.4
