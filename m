Received: from eggs.gnu.org ([2001:4830:134:3::10]:49281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbhlJ-0003KE-AW
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:59:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbhlG-0002y5-85
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:59:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41104
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cbhlG-0002xm-3o
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:59:18 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v195wU9g060700
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 00:59:17 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28g8kg5kw1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 00:59:17 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 9 Feb 2017 11:29:13 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id AC9C4E0045
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 11:30:37 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
	by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v195xAv033226756
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 11:29:10 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
	by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v195x9qs012417
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 11:29:10 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  9 Feb 2017 11:28:48 +0530
Message-Id: <1486619931-1086-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/3] Risu PPC improvements
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

The series contains some fixes/cleanup for ppc64le

Nikunj A Dadhania (3):
  risu_ppc64le: set r23 as the comment says
  risu_ppc64le: zero the xer register
  risu_ppc64le: remove aarch64 related comments

 risugen_ppc64.pm | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.7.4
