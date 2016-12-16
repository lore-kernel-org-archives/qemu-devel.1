Received: from eggs.gnu.org ([2001:4830:134:3::10]:46092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cHkxB-0007FC-Q7
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 00:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cHkx8-00060U-MO
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 00:21:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60171
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1cHkx8-0005zx-GG
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 00:21:06 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBG5JebG009678
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 00:21:05 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27c3n75qff-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 00:21:04 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Fri, 16 Dec 2016 05:21:03 -0000
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Fri, 16 Dec 2016 06:20:39 +0100
Message-Id: <20161216052040.53067-1-haoqf@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/1] qemu: fix the bug reported by
 qemu-iotests case 055
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, liujbjl@linux.vnet.ibm.com, kwolf@redhat.com, famz@redhat.com, QingFeng Hao <haoqf@linux.vnet.ibm.com>, qemu-stable@nongnu.org

Hi all,
v3 doesn't have code change but got the reviewed-by from Fam Zheng(thanks
to Fam).
v2 includes changes due to review comments by Kevin Wolf(thanks to Kevin).

v3:
* Got reviewed-by from Fam Zheng.
* Based on master's commit:
  6a928d25b6: Update version for v2.8.0-rc4 release

v2:
* Add endian conversion for lba field in vmdk_write_extent.
* Based on master's commit:
  00227fefd205: Update version for v2.8.0-rc1 release

v1:
* Add patch to fix the bug reported by qemu-iotests case 055.
  Jing Liu and I found the cause was in vmdk and the fix is in the
  followed patch.
  Based on master's commit:
  00227fefd205: Update version for v2.8.0-rc1 release

  Upstream master's qemu-iotests case 055 reports the following error:
  +qemu-img: Error while reading offset 0 of tests/qemu-iotests/scratch/blockdev-target.img: Invalid argument
  +qemu-img: Error while reading offset 0 of tests/qemu-iotests/scratch/blockdev-target.img: Invalid argument
  +qemu-img: Error while reading offset 0 of tests/qemu-iotests/scratch/blockdev-target.img: Invalid argument
  +qemu-img: Error while reading offset 0 of tests/qemu-iotests/scratch/blockdev-target.img: Invalid argument 

Thanks!
QingFeng Hao

Cc: qemu-stable@nongnu.org

QingFeng Hao (1):
  block/vmdk: Fix the endian problem of buf_len and lba

 block/vmdk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.8.4
