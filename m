Received: from eggs.gnu.org ([2001:4830:134:3::10]:49283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbhlJ-0003KF-Gf
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:59:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbhlG-0002yE-Gc
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:59:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42370
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cbhlG-0002xu-9a
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:59:18 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v195wU3V063436
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 00:59:17 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28gburnxw9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 00:59:17 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 9 Feb 2017 11:29:14 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id A2B743940060
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 11:29:11 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
	by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v195xBRu37093622
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 11:29:11 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
	by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v195xACX012435
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 11:29:11 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  9 Feb 2017 11:28:51 +0530
In-Reply-To: <1486619931-1086-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1486619931-1086-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1486619931-1086-4-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/3] risu_ppc64le: remove aarch64 related
 comments
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
 risugen_ppc64.pm | 2 --
 1 file changed, 2 deletions(-)

diff --git a/risugen_ppc64.pm b/risugen_ppc64.pm
index 03f9317..f208a54 100644
--- a/risugen_ppc64.pm
+++ b/risugen_ppc64.pm
@@ -84,8 +84,6 @@ sub write_sxt32($$)
 
 sub write_mov_ri($$)
 {
-    # We always use a MOVW/MOVT pair, for simplicity.
-    # on aarch64, we use a MOVZ/MOVK pair.
     my ($rd, $imm) = @_;
 
     if (($imm >> 16) & 0xffff) {
-- 
2.7.4
