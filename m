Received: from eggs.gnu.org ([2001:4830:134:3::10]:37867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dd473-0005h8-Oa
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 20:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dd46z-0005Jr-Dw
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 20:35:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dd46z-0005JB-4r
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 20:35:37 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v730YbaT096115
	for <qemu-devel@nongnu.org>; Wed, 2 Aug 2017 20:35:35 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c3q1m5aa0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 20:35:34 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 2 Aug 2017 20:35:33 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Thu,  3 Aug 2017 02:35:25 +0200
Message-Id: <20170803003527.86979-1-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/2] ERC cleanup and CRW bugfix
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
v2->v3:
Added Halil's R-B on both patches.
Patch #1:
  Added ERC "installed parameters restored".

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
 include/hw/s390x/ioinst.h | 12 ++++++++++--
 3 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.11.2
