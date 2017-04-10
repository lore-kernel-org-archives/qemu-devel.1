Received: from eggs.gnu.org ([2001:4830:134:3::10]:46871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cxSTt-0000Cp-RS
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 02:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cxSTo-0000tc-PZ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 02:07:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cxSTo-0000tL-F6
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 02:07:12 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3A63nvn023537
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 02:07:10 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29r01yhba8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 02:07:10 -0400
Received: from localhost
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 10 Apr 2017 11:37:07 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v3A675cU15728860
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 11:37:05 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v3A6737f024834
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 11:37:05 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon, 10 Apr 2017 11:36:55 +0530
Message-Id: <20170410060655.32289-1-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH fix for-2.9] cpus: fix wrong define name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, rth@twiddle.net
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, david@gibson.dropbear.id.au, alex.bennee@linaro.org, nikunj@linux.vnet.ibm.com

While the configure script generates TARGET_SUPPORTS_MTTCG define, one
of the define is cpus.c is checking wrong name: TARGET_SUPPORT_MTTCG

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 cpus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 68fdbc4..58d90aa 100644
--- a/cpus.c
+++ b/cpus.c
@@ -202,7 +202,7 @@ void qemu_tcg_configure(QemuOpts *opts, Error **errp)
             } else if (use_icount) {
                 error_setg(errp, "No MTTCG when icount is enabled");
             } else {
-#ifndef TARGET_SUPPORT_MTTCG
+#ifndef TARGET_SUPPORTS_MTTCG
                 error_report("Guest not yet converted to MTTCG - "
                              "you may get unexpected results");
 #endif
-- 
2.9.3
