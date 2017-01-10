Received: from eggs.gnu.org ([2001:4830:134:3::10]:55472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cQs96-0000RF-Jv
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:51:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cQs93-0000jw-K7
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:51:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48565
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cQs93-0000ip-Dx
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:51:05 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0A8nNgM100121
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 03:51:02 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27vt6q4q36-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 03:51:01 -0500
Received: from localhost
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 10 Jan 2017 14:20:58 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Tue, 10 Jan 2017 14:20:32 +0530
Message-Id: <1484038243-30314-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 00/11] POWER9 TCG enablements - part11
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

This series contains 10 new instructions for POWER9 ISA3.0
    VSX Scalar Insert Exponent
    VSX Vector Insert Exponent
    VSX Vector Extract Exponent/Significand
    VSX Scalar Truncate & Convert Quad-Precision
    Couple of fixes

Bharata B Rao (2):
  softfloat: Fix the default qNAN for target-ppc
  target-ppc: Add xscvqps[d,w]z instructions

Nikunj A Dadhania (9):
  target-ppc: xscvqpdp zero VSR
  target-ppc: Add xsiexpdp instruction
  target-ppc: Add xsiexpqp instruction
  target-ppc: Add xviexpsp instruction
  target-ppc: Add xviexpdp instruction
  target-ppc: Add xvxexpsp instruction
  target-ppc: Add xvxexpdp instruction
  target-ppc: Add xvxsigsp instruction
  target-ppc: Add xvxsigdp instruction

 fpu/softfloat-specialize.h          |   2 +-
 target/ppc/fpu_helper.c             |  62 ++++++++++++-
 target/ppc/helper.h                 |   3 +
 target/ppc/translate/vsx-impl.inc.c | 172 ++++++++++++++++++++++++++++++++++++
 target/ppc/translate/vsx-ops.inc.c  |  11 +++
 5 files changed, 248 insertions(+), 2 deletions(-)

-- 
2.7.4
