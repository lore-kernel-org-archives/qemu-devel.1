Received: from eggs.gnu.org ([2001:4830:134:3::10]:57086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1ezDcm-0001L1-Mt
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 23:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1ezDci-0004Ny-RC
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 23:44:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1ezDci-0004N0-JD
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 23:44:12 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2N3hum9138613
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 23:44:10 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gvkmtuxtp-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 23:44:09 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Fri, 23 Mar 2018 03:44:07 -0000
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Fri, 23 Mar 2018 04:43:55 +0100
Message-Id: <20180323034356.72130-1-haoqf@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/1] iotests: fix test case 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, stefanha@redhat.com, kwolf@redhat.com, famz@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, QingFeng Hao <haoqf@linux.vnet.ibm.com>

Hi,
This patch is to fix iotest case 185 and based on the latest commit
d522e0bd18364 --- "gitmodules: Use the QEMU mirror of qemu-palcode".
Thanks!

Change Log (v2):
* Recover the change on the call to bdrv_drain_all but don't resume the
  yielded jobs according to Stefan Hajnoczi's comment.
* Change 185.out accordingly as job's status is changed as well.

Change Log (v1):
* Remove the call to bdrv_drain_all in vm_shutdown to make case 185 passed.

QingFeng Hao (1):
  iotests: fix test case 185

 blockjob.c                 | 10 +++++++++-
 include/block/blockjob.h   |  5 +++++
 tests/qemu-iotests/185.out | 11 +++++++++--
 3 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.13.5
