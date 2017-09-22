Received: from eggs.gnu.org ([2001:4830:134:3::10]:51346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dvJUL-0005SE-Dh
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dvJUI-0003tg-Az
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:39:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41432
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dvJUI-0003tK-5U
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:39:06 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8M8cvD7087362
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 04:39:00 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d4x3ek6g8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 04:39:00 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 22 Sep 2017 09:38:58 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 22 Sep 2017 10:38:52 +0200
Message-Id: <20170922083855.102341-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH/RFC 0/3] ais fixups for 2.11
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

Conny, this seem to work on KVM (needs more testing and review).
Can you check what happens with TCG?

Patch 1 is the known base patch,
Patch 2 fixes the ais detection to be based on the flic interfaces
Patch 3 disables ais for all compat machines <= 2.10



Christian Borntraeger (3):
  s390x/ais: disable ais facility as it is broken
  s390x/ais: enable ais when migration is available
  s390x/ais: disable ais for compat machines

 hw/intc/s390_flic.c                | 11 +++++++++--
 hw/intc/s390_flic_kvm.c            | 10 +++++++++-
 hw/s390x/s390-virtio-ccw.c         | 18 ++++++++++++++++--
 include/hw/s390x/s390-virtio-ccw.h |  3 +++
 include/hw/s390x/s390_flic.h       |  1 +
 target/s390x/cpu_models.c          |  6 ++++++
 target/s390x/kvm.c                 |  3 +--
 7 files changed, 45 insertions(+), 7 deletions(-)

-- 
2.9.4
