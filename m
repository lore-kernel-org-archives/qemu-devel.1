Received: from eggs.gnu.org ([2001:4830:134:3::10]:44991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRiAz-0005Ly-DA
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRiAu-00071M-BY
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:24:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cRiAu-0006z7-0o
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:24:28 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0CGLXar145166
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 11:24:25 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27x9h8jafd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 11:24:25 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 12 Jan 2017 21:54:21 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2017 21:54:04 +0530
Message-Id: <1484238251-8096-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/7] POWER9 TCG enablements - part12
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

This series contains 11 new instructions for POWER9 ISA3.0
    VSX Scalar Test Data Class
    VSX Vector Test Data Class
    VSX Vector Convert HP/SP
    VSX Scalar Multiply/Divide
    VSX Scalar Convert Unsigned/Signed Doubleword

Bharata B Rao (4):
  target-ppc: Use ppc_vsr_t.f128 in xscmp[o,u,exp]qp
  target-ppc: Add xscvsdqp and xscvudqp instructions
  target-ppc: Add xsdivqp instruction
  target-ppc: Add xsmulqp instruction

Nikunj A Dadhania (3):
  target-ppc: Add xvcv[hpsp, sphp] instructions
  target-ppc: Add xvtstdc[sp,dp] instructions
  target-ppc: Add xststdc[sp, dp, qp] instructions

 target/ppc/fpu_helper.c             | 253 +++++++++++++++++++++++++++++++++---
 target/ppc/helper.h                 |  11 ++
 target/ppc/internal.h               |   6 +-
 target/ppc/translate/vsx-impl.inc.c |  11 ++
 target/ppc/translate/vsx-ops.inc.c  |  18 +++
 5 files changed, 276 insertions(+), 23 deletions(-)

-- 
2.7.4
