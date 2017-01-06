Received: from eggs.gnu.org ([2001:4830:134:3::10]:52109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPNoE-0006fv-Jy
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:15:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPNoC-0002lW-33
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:15:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cPNoB-0002lE-Ob
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:15:24 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v066DwvP085558
	for <qemu-devel@nongnu.org>; Fri, 6 Jan 2017 01:15:21 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27sydqdgw1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 01:15:21 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 6 Jan 2017 16:15:19 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri,  6 Jan 2017 11:44:42 +0530
Message-Id: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 00/14] POWER9 TCG enablements - part10
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
     VSX Vector Insert/Extract Word
     VSX Scalar Extract Exponent/Significand
     VSX Scalar Convert
     VSX Scalar Add QP
     Various float related improvements

Changelog:
v0:
   Rebase and update reviewed-by

Bharata B Rao (8):
  target-ppc: Use float64 arg in helper_compute_fprf()
  target-ppc: Replace isden by float64_is_zero_or_denormal
  target-ppc: Rename helper_compute_fprf to helper_compute_fprf_float64
  target-ppc: Add xsaddqp instructions
  target-ppc: Add xscvdphp, xscvhpdp
  target-ppc: Use correct precision for FPRF setting
  target-ppc: Add xscvdpqp instruction
  target-ppc: Add xscvqpdp instruction

Nikunj A Dadhania (6):
  target-ppc: Add xxextractuw instruction
  target-ppc: Add xxinsertw instruction
  target-ppc: Add xsxexpdp instruction
  target-ppc: Add xsxexpqp instruction
  target-ppc: Add xsxsigdp instruction
  target-ppc: Add xsxsigqp instructions

 include/fpu/softfloat.h             |  20 +++
 target/ppc/fpu_helper.c             | 241 +++++++++++++++++++++++++-----------
 target/ppc/helper.h                 |   9 +-
 target/ppc/int_helper.c             |  51 ++++++++
 target/ppc/internal.h               |   6 +
 target/ppc/translate/fp-impl.inc.c  |  20 +--
 target/ppc/translate/vsx-impl.inc.c | 122 ++++++++++++++++++
 target/ppc/translate/vsx-ops.inc.c  |  18 +++
 8 files changed, 405 insertions(+), 82 deletions(-)

-- 
2.7.4
