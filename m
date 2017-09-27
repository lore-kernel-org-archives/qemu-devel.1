Received: from eggs.gnu.org ([2001:4830:134:3::10]:43905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dx6eD-0001G6-CO
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dx6eA-0007cW-8L
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:20:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dx6e9-0007bw-V2
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:20:42 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8R7JUCX098274
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 03:20:38 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d83qrad81-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 03:20:37 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 27 Sep 2017 08:20:34 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 27 Sep 2017 09:20:27 +0200
Message-Id: <20170927072030.35737-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/3] more ais fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Michael Roth <mdroth@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

I think Patches 1 and 2 are undisputed.
Patch 1 needs to go into 2.10.1 as well.
Patch 2 is for 2.11
Patch 3 is still under discussion if this is the right solution

v2->v3: 
- add the ais removal from the z14 cpu model
- fix indent



Christian Borntraeger (3):
  s390x/cpumodel: remove ais from z14 default model-> also for 2.10.1
  s390x/ais: enable ais when migration is available
  s390x/ais: disable ais for compat machines

 hw/intc/s390_flic.c                |  8 ++------
 hw/intc/s390_flic_kvm.c            | 18 +++++++++++++-----
 hw/s390x/css.c                     |  4 ++--
 hw/s390x/s390-virtio-ccw.c         | 20 +++++++++++++++++---
 include/hw/s390x/s390-virtio-ccw.h |  3 +++
 include/hw/s390x/s390_flic.h       |  1 -
 target/s390x/gen-features.c        |  1 -
 target/s390x/kvm.c                 | 10 ++--------
 8 files changed, 39 insertions(+), 26 deletions(-)

-- 
2.9.4
