Received: from eggs.gnu.org ([2001:4830:134:3::10]:53130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSOUu-00088k-0g
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSOUq-0003Xt-Kx
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:08:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50983
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dSOUq-0003XT-Es
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:08:08 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v64E4WVq019474
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 10:08:07 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bg6bh367w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 10:08:07 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 4 Jul 2017 15:08:04 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue,  4 Jul 2017 16:07:52 +0200
Message-Id: <1499177279-131407-1-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 0/7] s390x/kvm: pending patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

This is what I have queued for s390x.

Cornelia Huck (1):
  s390x/MAINTAINERS: Update my email address

Dong Jia Shi (1):
  s390x/3270: fix instruction interception handler

Halil Pasic (3):
  s390x: vmstatify config migration for virtio-ccw
  s390x: fix error propagation in kvm-flic's realize
  s390x: fix realize inheritance for kvm-flic

QingFeng Hao (1):
  virtio-scsi-ccw: use ioeventfd even when KVM is disabled

Viktor Mihajlovski (1):
  s390x: return unavailable features via query-cpu-definitions

 MAINTAINERS                  |   8 +-
 hw/intc/s390_flic.c          |  32 +++-
 hw/intc/s390_flic_kvm.c      |  31 +++-
 hw/s390x/3270-ccw.c          |   1 +
 hw/s390x/ccw-device.c        |  10 ++
 hw/s390x/ccw-device.h        |   4 +
 hw/s390x/css.c               | 378 +++++++++++++++++++++++++------------------
 hw/s390x/virtio-ccw.c        | 160 +++++++++---------
 include/hw/s390x/css.h       |  12 +-
 include/hw/s390x/s390_flic.h |   5 +
 target/s390x/cpu.h           |   6 +-
 target/s390x/cpu_models.c    |  62 ++++++-
 12 files changed, 456 insertions(+), 253 deletions(-)

-- 
2.7.4
