Received: from eggs.gnu.org ([2001:4830:134:3::10]:55212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cagZs-00037P-Jo
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cagZp-0007cD-Hl
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:31:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cagZp-0007bc-90
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:31:17 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v16ASdLC118921
	for <qemu-devel@nongnu.org>; Mon, 6 Feb 2017 05:31:13 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28emdjqw33-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 05:31:13 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 6 Feb 2017 20:31:10 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon,  6 Feb 2017 15:59:56 +0530
Message-Id: <1486377000-25701-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/4] POWER9 TCG enablements - part14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

This series contains 8 new instructions for POWER9 ISA3.0
    VSX Scalar Maximum DP
    VSX Scalar Minimum DP
    Load/Store Atomic instructions

Balamuruhan S (2):
  target-ppc: implement load atomic instruction
  target-ppc: implement store atomic instruction

Bharata B Rao (2):
  target-ppc: Add xsmaxcdp and xsmincdp instructions
  target-ppc: Add xsmaxjdp and xsminjdp instructions

 target/ppc/fpu_helper.c             | 93 +++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  4 ++
 target/ppc/internal.h               |  2 +
 target/ppc/translate.c              | 98 +++++++++++++++++++++++++++++++++++++
 target/ppc/translate/vsx-impl.inc.c |  4 ++
 target/ppc/translate/vsx-ops.inc.c  |  4 ++
 6 files changed, 205 insertions(+)

-- 
2.7.4
