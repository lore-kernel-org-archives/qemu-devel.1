Received: from eggs.gnu.org ([2001:4830:134:3::10]:47529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cFK7e-0005ig-Jb
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cFK7Y-0002xD-Gn
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:17:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44935
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cFK7Y-0002wt-AO
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:17:48 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB9CFPmt038042
	for <qemu-devel@nongnu.org>; Fri, 9 Dec 2016 07:17:47 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
	by mx0a-001b2d01.pphosted.com with ESMTP id 277rtjk8uk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 07:17:47 -0500
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 9 Dec 2016 17:47:43 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri,  9 Dec 2016 17:47:19 +0530
Message-Id: <1481285845-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 ppc-for-2.9 0/6] POWER9 TCG enablements -
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

This series contains 6 new instructions for POWER9 ISA3.0
     VSX Vector Insert/Extract Word
     VSX Load/Store with length

Although, lxvl/lxvll and stxvl/stxvll can be combined as single patch,
have left it for detailed commit log for instruction explanation.

Changelog:
v1:
* Combine helpers of lxvl and lxvll
* Combine helpers of stxvl and stxvll
* Rework xxextractuw and xxinsertw to simplify helper

v0:
* Fixed lxvl/lxvll and stxvl/stxvll as suggested by Richard
* Dropped mask_u128, which is not needed anymore
* Prevent UIMM > 12 in xxextractuw
* Drop xori from xsnegqp
* Rewrite xxperm/xxpermr without double copy

Nikunj A Dadhania (6):
  target-ppc: implement lxvl instruction
  target-ppc: implement lxvll instruction
  target-ppc: implement stxvl instruction
  target-ppc: implement stxvll instructions
  target-ppc: implement xxextractuw instruction
  target-ppc: implement xxinsertw instruction

 target-ppc/helper.h                 |  8 +++++
 target-ppc/int_helper.c             | 42 +++++++++++++++++++++++
 target-ppc/mem_helper.c             | 66 +++++++++++++++++++++++++++++++++++++
 target-ppc/translate/vsx-impl.inc.c | 60 +++++++++++++++++++++++++++++++++
 target-ppc/translate/vsx-ops.inc.c  | 14 ++++++++
 5 files changed, 190 insertions(+)

-- 
2.7.4
