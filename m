Received: from eggs.gnu.org ([2001:4830:134:3::10]:49114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwq2u-00068n-Oi
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwq2r-0007lf-Jk
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:37:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38506
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dwq2r-0007lA-Ch
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:37:05 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8QDaX2e121203
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 09:37:01 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d7mu9nrtg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 09:37:00 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 26 Sep 2017 14:36:28 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 26 Sep 2017 15:36:22 +0200
Message-Id: <20170926133624.155394-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/2] ais fixups for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

v1->v2:
- get rid of fs->ais_supported
- update copyright

Christian Borntraeger (2):
  s390x/ais: enable ais when migration is available
  s390x/ais: disable ais for compat machines

 hw/intc/s390_flic.c                |  8 ++------
 hw/intc/s390_flic_kvm.c            | 18 +++++++++++++-----
 hw/s390x/css.c                     |  4 ++--
 hw/s390x/s390-virtio-ccw.c         | 20 +++++++++++++++++---
 include/hw/s390x/s390-virtio-ccw.h |  3 +++
 include/hw/s390x/s390_flic.h       |  1 -
 target/s390x/kvm.c                 | 10 ++--------
 7 files changed, 39 insertions(+), 25 deletions(-)

-- 
2.9.4
