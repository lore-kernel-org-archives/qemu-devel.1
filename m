Received: from eggs.gnu.org ([2001:4830:134:3::10]:42284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZpvK-0003w0-Nv
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZpvH-0000G3-B0
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56519
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cZpvH-0000Fs-4I
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1428aXw086527
	for <qemu-devel@nongnu.org>; Fri, 3 Feb 2017 21:17:54 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28cy6nun0c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 21:17:54 -0500
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Sat, 4 Feb 2017 00:17:52 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id 1365F352005F
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 21:17:17 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v142HnQx4858078
	for <qemu-devel@nongnu.org>; Sat, 4 Feb 2017 00:17:49 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v142Hn5O012069
	for <qemu-devel@nongnu.org>; Sat, 4 Feb 2017 00:17:50 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Sat,  4 Feb 2017 00:17:22 -0200
In-Reply-To: <1486174642-14883-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1486174642-14883-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1486174642-14883-8-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu 7/7] risu_ppc64le: fix minor code style in
 assembly test code
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
 test_ppc64le.s | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/test_ppc64le.s b/test_ppc64le.s
index af23ea3..4af770c 100644
--- a/test_ppc64le.s
+++ b/test_ppc64le.s
@@ -12,15 +12,15 @@
  *****************************************************************************/
 
 /* Initialise the gp regs */
-li 0,0
-li 2,2
-li 3,3
-li 4,4
-li 5,5
-li 6,6
-li 7,7
-li 8,8
-li 9,9
+li 0, 0
+li 2, 2
+li 3, 3
+li 4, 4
+li 5, 5
+li 6, 6
+li 7, 7
+li 8, 8
+li 9, 9
 li 10, 10
 li 11, 11
 li 12, 12
-- 
2.7.4
