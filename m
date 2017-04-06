Received: from eggs.gnu.org ([2001:4830:134:3::10]:43210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw5PP-0004HT-Fp
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw5PM-0001ZO-C1
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:16:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cw5PM-0001Yn-3E
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:16:56 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v36BE1lC059919
	for <qemu-devel@nongnu.org>; Thu, 6 Apr 2017 07:16:53 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29nm1eafwx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 07:16:53 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 6 Apr 2017 12:16:51 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu,  6 Apr 2017 13:16:36 +0200
Message-Id: <20170406111646.12624-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.10 00/10] s390x queue for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, Cornelia Huck <cornelia.huck@de.ibm.com>

Here's the first batch of s390x changes for 2.10:
- the new compat machine
- several cleanups and optimizations
- introspection for css ids

More to come; for example, the 3270 support I'd still like some
feedback on (I'll resend a rebased version).

Cornelia Huck (1):
  s390x: introduce 2.10 compat machine

Danil Antonov (2):
  s390x/kvm: make printf always compile in debug output
  s390x/pci: make printf always compile in debug output

Dong Jia Shi (3):
  s390x/css: introduce read-only property type for device ids
  s390x/css: provide introspection for virtual subchannel and device
    busid
  s390x/css: consolidate the devno property for ccw devices

Fei Li (4):
  s390x: use enum for adapter type and standardize its naming
  s390x: initialize flic before I/O subsystems
  s390x/flic: cache flic in s390_get_flic
  s390x: register I/O adapters per ISC during init

 hw/intc/s390_flic.c        |  9 +++--
 hw/s390x/ccw-device.c      | 40 ++++++++++++++++++++
 hw/s390x/ccw-device.h      |  9 ++++-
 hw/s390x/css-bridge.c      |  3 ++
 hw/s390x/css.c             | 92 ++++++++++++++++++++++++++++++----------------
 hw/s390x/s390-pci-bus.c    | 19 +++++++---
 hw/s390x/s390-pci-bus.h    |  1 -
 hw/s390x/s390-pci-inst.c   | 26 +++++++------
 hw/s390x/s390-virtio-ccw.c | 20 +++++++++-
 hw/s390x/virtio-ccw.c      | 55 ++++++++++++++-------------
 include/hw/compat.h        |  3 ++
 include/hw/s390x/css.h     | 19 ++++++++--
 target/s390x/kvm.c         | 16 ++++----
 13 files changed, 219 insertions(+), 93 deletions(-)

-- 
2.11.0
