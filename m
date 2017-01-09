Received: from eggs.gnu.org ([2001:4830:134:3::10]:44225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cQauI-0004OE-SI
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cQauE-00018A-0L
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:26:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cQauD-00017m-NV
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:26:37 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v09ENim2038705
	for <qemu-devel@nongnu.org>; Mon, 9 Jan 2017 09:26:36 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27vbmvsxkp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 09:26:35 -0500
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 10 Jan 2017 00:26:33 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon,  9 Jan 2017 19:56:12 +0530
Message-Id: <1483971975-5612-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/3] POWER9 TCG enablements - part10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

This series contains 11 new instructions for POWER9 ISA3.0
     VSX Scalar Convert
     VSX Scalar Add QP

Changelog:
v1: 
* xsaddqp, xscv[dpqp, qpdp] instructions use register numbering 0-31, this needs
  to be handled in the decoding. ISA 3.0 documents to use them as VSR[VRA + 32], 
  and likewise for other registers. 

v0:
   Rebase and update reviewed-by


Bharata B Rao (3):
  target-ppc: Add xsaddqp instructions
  target-ppc: Add xscvdpqp instruction
  target-ppc: Add xscvqpdp instruction

 target/ppc/fpu_helper.c             | 109 ++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |   3 +
 target/ppc/internal.h               |   1 +
 target/ppc/translate/vsx-impl.inc.c |   3 +
 target/ppc/translate/vsx-ops.inc.c  |   3 +
 5 files changed, 119 insertions(+)

-- 
2.7.4
