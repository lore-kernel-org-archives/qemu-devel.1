Received: from eggs.gnu.org ([2001:4830:134:3::10]:44157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cfkyZ-0000ql-Ag
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cfkyW-0002qe-4k
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:13:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cfkyV-0002qH-RA
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:13:44 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KA9u8j082287
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:13:42 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28pphv76aw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:13:41 -0500
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 20 Feb 2017 20:13:39 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon, 20 Feb 2017 15:41:51 +0530
Message-Id: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 00/10] POWER9 TCG enablements - part15
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

This series contains implentation of CA32 and OV32 bits added to the 
ISA 3.0. Various fixed-point arithmetic instructions are updated to take
care of the newer flags. 

Finally the last patch adds new instruction mcrxrx, that helps reading 
the carry (CA and CA32) and the overflow (OV and OV32) flags

Nikunj A Dadhania (10):
  target/ppc: support for 32-bit carry and overflow
  target/ppc: Update ca32 in arithmetic add
  target/ppc: move subf logic block
  target/ppc: compute ca32 for arithmetic substract
  target/ppc: update overflow flags for add/sub
  target/ppc: use tcg ops for neg instruction
  target/ppc: update ov/ov32 for nego
  target/ppc: add ov32 flag for multiply low insns
  target/ppc: add ov32 flag in divide operations
  target/ppc: add mcrxrx instruction

 target/ppc/cpu.h        |  30 +++++++++++
 target/ppc/int_helper.c |  49 ++++++------------
 target/ppc/translate.c  | 134 +++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 155 insertions(+), 58 deletions(-)

-- 
2.7.4
