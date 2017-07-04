Received: from eggs.gnu.org ([2001:4830:134:3::10]:38656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dSJGI-0004gC-L9
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dSJGE-0004aa-Mf
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:32:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56724
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1dSJGE-0004ZA-FS
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:32:42 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v648TFEh182692
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 04:32:40 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bfjk52e1n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 04:32:40 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Tue, 4 Jul 2017 09:32:38 +0100
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Tue,  4 Jul 2017 10:32:30 +0200
Message-Id: <20170704083231.98056-1-haoqf@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/1] virtio-scsi-ccw: fix iotest 068 for
 s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, stefanha@redhat.com, kwolf@redhat.com, famz@redhat.com, peterx@redhat.com, cohuck@kernel.org, QingFeng Hao <haoqf@linux.vnet.ibm.com>

This commit fixes iotest 068 for s390x as s390x uses virtio-scsi-ccw.
It's based on commit c324fd0a39c by Stefan Hajnoczi. 
Thanks!

Change history:
v3:
    Take Christian Borntraeger and Cornelia Huck's comment to check
    if kvm is enabled in s390_assign_subch_ioeventfd instead of
    kvm_s390_assign_subch_ioeventfd to as the former is a general one.

v2:
    Remove Stefan from sign-off list and change the patch's commit message 
    according to Christian Borntraeger's comment.

QingFeng Hao (1):
  virtio-scsi-ccw: use ioeventfd even when KVM is disabled

 hw/s390x/virtio-ccw.c | 2 +-
 target/s390x/cpu.h    | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.11.2
