Received: from eggs.gnu.org ([2001:4830:134:3::10]:35500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dcS3p-0008JN-WA
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dcS3m-0006A4-UN
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:57:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dcS3m-00068y-Iu
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:57:46 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v717s7eF038301
	for <qemu-devel@nongnu.org>; Tue, 1 Aug 2017 03:57:45 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c2c2tekh8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 03:57:43 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 1 Aug 2017 03:57:42 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Tue,  1 Aug 2017 09:57:25 +0200
Message-Id: <20170801075727.31335-1-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/2] ERC cleanup and CRW bugfix (was:
 Channel Path realted CRW generation)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, bjsdjshi@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

This series is trying to:
1. clear up ERC related code
2. bugfix for channel path related CRW generation

Change log
----------
v1->v2:
Patch #1:
  Add all ERCs.
  Commit message update.
Patch #2:
  Rename the new added parameter to more speaking name -- solicited.

Dong Jia Shi (2):
  s390x/css: use macro for event-information pending error recover code
  s390x/css: generate solicited crw for rchp completion signaling

 hw/s390x/css.c            | 16 ++++++++++------
 include/hw/s390x/css.h    |  3 ++-
 include/hw/s390x/ioinst.h | 11 +++++++++--
 3 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.11.2
