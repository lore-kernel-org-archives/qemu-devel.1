Received: from eggs.gnu.org ([2001:4830:134:3::10]:37959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cdCUe-00069G-2Q
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:00:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cdCUY-0006zc-TV
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:00:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55041
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cdCUY-0006z1-OA
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:00:14 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1D8wjG1020708
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 04:00:13 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28jh1n05d4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 04:00:12 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 13 Feb 2017 19:00:10 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id C304D2CE8046
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 20:00:07 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1D8xxIG34668596
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 20:00:07 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
	by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1D8xZM2016413
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 19:59:35 +1100
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon, 13 Feb 2017 14:29:11 +0530
Message-Id: <1486976352-549-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/2] risu_ppc64le: fix the typo nb => rb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 ppc64.risu | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ppc64.risu b/ppc64.risu
index f7fa3f4..28df9da 100644
--- a/ppc64.risu
+++ b/ppc64.risu
@@ -1029,12 +1029,12 @@ LQ PPC64LE 111000 rtp:5 ra:5 imm:12 0000 \
 !memory { reg_plus_imm($ra, $imm << 4); }
 
 # format:X book:I page:65 v:P1 lswi Load String Word Immediate
-LSWI PPC64LE 011111 rt:5 ra:5 nb:5 10010101010 \
+LSWI PPC64LE 011111 rt:5 ra:5 rb:5 10010101010 \
 !constraints { $ra != 1 && $rb != 1 && $ra != 13 && $rb != 13 && $ra != 0 && $ra != $rb; } \
 !memory { reg_plus_reg($ra, $rb); }
 
 # format:X book:I page:65 v:P1 lswx Load String Word Indexed
-LSWX PPC64LE 011111 rt:5 ra:5 nb:5 10000101010 \
+LSWX PPC64LE 011111 rt:5 ra:5 rb:5 10000101010 \
 !constraints { $ra != 1 && $rb != 1 && $ra != 13 && $rb != 13 && $ra != 0 && $ra != $rb; } \
 !memory { reg_plus_reg($ra, $rb); }
 
@@ -1705,7 +1705,7 @@ STMW PPC64BE 101111 rt:5 ra:5 imm:16 \
 
 # STSWI is not supported in little-endian mode
 # format:X book:I page:66 v:P1 stswi Store String Word Immediate
-STSWI PPC64BE 011111 rs:5 ra:5 nb:5 10110101010 \
+STSWI PPC64BE 011111 rs:5 ra:5 rb:5 10110101010 \
 !constraints { $rs != 1 && $ra != 1 && $rs != 13 && $ra != 13 && $rs != $ra && $ra != 0; } \
 !memory { reg_plus_imm($ra, 0); }
 
-- 
2.7.4
