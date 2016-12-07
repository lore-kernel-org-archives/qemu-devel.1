Received: from eggs.gnu.org ([2001:4830:134:3::10]:52207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cEguC-0004h9-Lp
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cEgu7-0001lm-OS
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:24 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:36067
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cEgu7-0001lY-FJ
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:19 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB7IJuc2057245
	for <qemu-devel@nongnu.org>; Wed, 7 Dec 2016 13:25:17 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
	by mx0a-001b2d01.pphosted.com with ESMTP id 276m5xku3y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 13:25:16 -0500
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 7 Dec 2016 23:55:13 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed,  7 Dec 2016 23:54:53 +0530
Message-Id: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 ppc-for-2.9 0/9] POWER9 TCG enablements -
 part9
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

This series contains 12 new instructions for POWER9 ISA3.0
     Couple of consolidation patches
     VSX Vector Insert/Extract Word
     VSX Vector Permute
     VSX Load/Store with length
     VSX Scalar Quad-Precision Move Instructions

Changelog:
v0:
* Fixed lxvl/lxvll and stxvl/stxvll as suggested by Richard
* Dropped mask_u128, which is not needed anymore
* Prevent UIMM > 12 in xxextractuw
* Drop xori from xsnegqp
* Rewrite xxperm/xxpermr without double copy

Bharata B Rao (1):
  target-ppc: Add xxperm and xxpermr instructions

Nikunj A Dadhania (8):
  target-ppc: implement lxvl instruction
  target-ppc: implement lxvll instruction
  target-ppc: implement stxvl instruction
  target-ppc: implement stxvll instructions
  target-ppc: implement xxextractuw instruction
  target-ppc: implement xxinsertw instruction
  target-ppc: implement xsnegqp instruction
  target-ppc: implement xscpsgnqp instruction

 target-ppc/fpu_helper.c             | 23 +++++++++
 target-ppc/helper.h                 |  8 ++++
 target-ppc/int_helper.c             | 61 ++++++++++++++++++++++++
 target-ppc/mem_helper.c             | 94 +++++++++++++++++++++++++++++++++++++
 target-ppc/translate/vsx-impl.inc.c | 76 +++++++++++++++++++++++++++++-
 target-ppc/translate/vsx-ops.inc.c  | 14 ++++++
 6 files changed, 275 insertions(+), 1 deletion(-)

-- 
2.7.4
