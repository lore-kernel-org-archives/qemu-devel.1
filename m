Received: from eggs.gnu.org ([2001:4830:134:3::10]:42958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1enfAQ-0004gm-RW
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:43:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1enfAN-0001cx-PM
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:43:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52448
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1enfAN-0001cp-Jk
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:43:11 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1J6e0XB069243
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 01:43:10 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g7mk68998-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 01:43:09 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 06:43:08 -0000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2018 12:12:52 +0530
Message-Id: <1519022574-6817-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v0 0/2] Support for ibm,dynamic-memory-v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, imammedo@redhat.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

This is an RFC version of patchset to support the new ibm,dynamic-memory-v2
property which allows the LMB information to be represented in a more
compact form by grouping LMBs into sets.

I have tested it very lightly and observe guest crashes (during reboot)
in a few scenarios. I am still trying to figure out the reason.

Bharata B Rao (2):
  pc-dimm: Make pc_dimm_built_list() global
  spapr: Support ibm,dynamic-memory-v2 property

 docs/specs/ppc-spapr-hotplug.txt |  19 +++
 hw/mem/pc-dimm.c                 |   2 +-
 hw/ppc/spapr.c                   | 254 +++++++++++++++++++++++++++++++++------
 include/hw/mem/pc-dimm.h         |   1 +
 include/hw/ppc/spapr.h           |   1 +
 include/hw/ppc/spapr_ovec.h      |   1 +
 6 files changed, 237 insertions(+), 41 deletions(-)

-- 
2.7.4
