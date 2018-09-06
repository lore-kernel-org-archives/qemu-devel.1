Received: from eggs.gnu.org ([2001:4830:134:3::10]:56780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sandipan@linux.ibm.com>) id 1fxo99-0004IJ-Vn
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 02:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sandipan@linux.ibm.com>) id 1fxo95-0002T1-CO
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 02:52:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sandipan@linux.ibm.com>)
	id 1fxo95-0002JZ-0c
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 02:52:03 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w866n46p071039
	for <qemu-devel@nongnu.org>; Thu, 6 Sep 2018 02:51:57 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2masq33vuf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Sep 2018 02:51:57 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sandipan@linux.ibm.com>;
	Thu, 6 Sep 2018 07:51:53 +0100
From: Sandipan Das <sandipan@linux.ibm.com>
Date: Thu,  6 Sep 2018 12:21:46 +0530
Message-Id: <20180906065146.2353-1-sandipan@linux.ibm.com>
Subject: [Qemu-devel] [PATCH risu] ppc64.risu: Fix pattern for darn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com

This fixes the pattern for the Deliver A Random Number (darn)
instruction to ensure that the value of the L field, which is
used to determine the type and length of the generated random
number, is never 3 which is currently reserved for future use.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 ppc64.risu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ppc64.risu b/ppc64.risu
index 2018103..a27e4fd 100644
--- a/ppc64.risu
+++ b/ppc64.risu
@@ -277,7 +277,7 @@ DADDQd PPC64LE 111111 frtp:5 frap:5 frbp:5 00000000101
 
 # format:X book:I page:79 v3.0 darn Deliver A Random Number
 DARN PPC64LE 011111 rt:5 000 l:2 0000010111100110 \
-!constraints { $rt != 1 && $rt != 13; }
+!constraints { $rt != 1 && $rt != 13 && $l != 3; }
 
 # format:X book:I page:217 v2.06 dcffix DFP Convert From Fixed
 DCFFIX PPC64LE 111011 frt:5 00000 frb:5 11001000100
-- 
2.14.4
