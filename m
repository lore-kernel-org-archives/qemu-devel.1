Received: from eggs.gnu.org ([2001:4830:134:3::10]:59601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVgaI-0004R3-Lv
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVgaF-0005VA-JW
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:03:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVgaF-0005Ub-A6
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:03:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6DG33tI040071
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 12:03:17 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3rq7fr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 12:03:16 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 13 Jul 2017 17:03:12 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 13 Jul 2017 18:03:02 +0200
Message-Id: <1499961789-127874-1-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 0/7] s390: remaining patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

here is a bunch of patches that teaches recent HW features
to the CPU model and kvm code in QEMU. We also add the 
enhanced suppression on protection facility to the z12 and later
for the 2.10 machine type.

Christian Borntraeger (2):
  s390x/arch_dump: also dump guarded storage control block
  s390x/gdb: add gs registers

Fan Zhang (1):
  s390x/kvm: enable guarded storage

Farhan Ali (1):
  s390x/kvm: Enable KSS facility for nested virtualization

Jason J. Herne (3):
  s390x/cpumodel: wire up new hardware features
  s390x/cpumodel: we are always in zarchitecture mode
  s390x/cpumodel: add esop/esop2 to z12 model

 configure                          |   2 +-
 gdb-xml/s390-gs.xml                |  14 +++++
 hw/s390x/s390-virtio-ccw.c         |  21 +++++++
 include/elf.h                      |   1 +
 include/hw/s390x/s390-virtio-ccw.h |   3 +
 include/hw/s390x/sclp.h            |   3 +-
 target/s390x/arch_dump.c           |  18 ++++++
 target/s390x/cpu.h                 |   7 +++
 target/s390x/cpu_features.c        |  46 +++++++++++++-
 target/s390x/cpu_features.h        |   4 ++
 target/s390x/cpu_features_def.h    |  41 ++++++++++++-
 target/s390x/cpu_models.c          |  25 ++++++++
 target/s390x/gdbstub.c             |  24 ++++++++
 target/s390x/gen-features.c        |  42 +++++++++++++
 target/s390x/kvm.c                 | 120 +++++++++++++++++++++++++------------
 target/s390x/machine.c             |  17 ++++++
 16 files changed, 345 insertions(+), 43 deletions(-)
 create mode 100644 gdb-xml/s390-gs.xml

-- 
2.7.4
