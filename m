Received: from eggs.gnu.org ([2001:4830:134:3::10]:57606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRswo-0005RK-6V
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:54:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRswk-0003rA-RL
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:54:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35310
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cRswk-0003qt-M0
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:54:34 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0D3s6Ya112897
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 22:54:33 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27xmfawdvb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 22:54:33 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 13 Jan 2017 13:54:30 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 13 Jan 2017 09:24:07 +0530
Message-Id: <1484279649-22286-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 0/2] POWER9 TCG enablements - part12
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

This series contains 5 new instructions for POWER9 ISA3.0
    VSX Scalar Test Data Class
    VSX Vector Test Data Class

Changelog:
v0:
* Concise logic for identifying data class in Scalar/Vector 
  test data class instructions

Nikunj A Dadhania (2):
  target-ppc: Add xvtstdc[sp,dp] instructions
  target-ppc: Add xststdc[sp, dp, qp] instructions

 target/ppc/fpu_helper.c             | 89 +++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  5 +++
 target/ppc/internal.h               |  6 ++-
 target/ppc/translate/vsx-impl.inc.c |  5 +++
 target/ppc/translate/vsx-ops.inc.c  | 12 +++++
 5 files changed, 115 insertions(+), 2 deletions(-)

-- 
2.7.4
