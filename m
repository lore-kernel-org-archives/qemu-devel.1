Received: from eggs.gnu.org ([2001:4830:134:3::10]:47683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dRvwe-0005sD-Ak
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dRvwb-0000qz-9z
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:38:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54985
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1dRvwb-0000qY-2j
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:38:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v637YJH3028368
	for <qemu-devel@nongnu.org>; Mon, 3 Jul 2017 03:38:52 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bf15w4g5s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 03:38:51 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Mon, 3 Jul 2017 08:38:49 +0100
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Mon,  3 Jul 2017 09:38:35 +0200
Message-Id: <20170703073836.72092-1-haoqf@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/1] virtio-scsi-ccw: fix iotest 068 on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, stefanha@redhat.com, kwolf@redhat.com, famz@redhat.com, peterx@redhat.com, QingFeng Hao <haoqf@linux.vnet.ibm.com>

This commit fixes iotest 068 for s390x as s390x uses virtio-scsi-ccw.
The related commit is c324fd0a39c for other platforms by Stefan Hajnoczi. 
Thanks!

QingFeng Hao (1):
  virtio-scsi-ccw: use ioeventfd even when KVM is disabled

 hw/s390x/virtio-ccw.c | 2 +-
 target/s390x/kvm.c    | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.11.2
