Received: from eggs.gnu.org ([2001:4830:134:3::10]:43682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cRlgI-000347-Tt
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cRlgF-0001B7-VB
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:09:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cRlgF-0001AF-Mv
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:09:03 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0CK41q6131588
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 15:09:00 -0500
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27xfyrhedw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 15:09:00 -0500
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Thu, 12 Jan 2017 18:08:57 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2017 18:08:31 -0200
Message-Id: <1484251713-25560-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v6 0/2] POWER9 TCG enablements - BCD functions
 - final part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com

v6:
 - improves bcdtrunc/bcdutrunc overflow comparison
 - removes bcds/bcdus/bcdsr applied patches

v5:
 - removes 'unlikely' gcc branch pred. hints from not unlikely places
 - adds comments in host-utils functions
 - adds more test cases for shift functions
 - handles "shift backwards" with signed shifts
 - rebases branch

v4:
 - improves functions to behave exactly like the target

v3:
 - moves shift functions to host-utils.c and added config_int128 guard
 - changes Makefile to always compile host-utils.c
 - redesigns bcd[u]trunc to use bitwise operations
 - removes "target-ppc: Implement bcd_is_valid function" (merged)

v2:
 - bcd[s,sr,us] uses 1 byte for shifting instead of 4 bytes
 - left/right functions in host-utils are out of CONFIG_INT128
 - fixes overflowing issue in left shift and added a testcase

This serie contains 5 new instructions for POWER9 ISA3.0, left/right shifts for 
unsigned quadwords and a small improvement to check whether a bcd value is 
valid or not.

bcdtrunc.: Decimal signed trucate
bcdutrunc.: Decimal unsigned truncate

Jose Ricardo Ziviani (2):
  ppc: Implement bcdtrunc. instruction
  ppc: Implement bcdutrunc. instruction

 target/ppc/helper.h                 |  2 +
 target/ppc/int_helper.c             | 88 +++++++++++++++++++++++++++++++++++++
 target/ppc/translate/vmx-impl.inc.c |  9 ++++
 target/ppc/translate/vmx-ops.inc.c  |  6 +--
 4 files changed, 102 insertions(+), 3 deletions(-)

-- 
2.7.4
