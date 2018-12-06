Received: from eggs.gnu.org ([2001:4830:134:3::10]:47912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gV252-0007lU-EC
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 17:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gV24w-00035X-Np
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 17:25:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gV24w-000354-FN
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 17:25:06 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB6MLHmp091957
	for <qemu-devel@nongnu.org>; Thu, 6 Dec 2018 17:25:05 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p79peyajw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 17:25:04 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Thu, 6 Dec 2018 22:25:04 -0000
From: Collin Walling <walling@linux.ibm.com>
Date: Thu,  6 Dec 2018 17:24:15 -0500
Message-Id: <1544135058-21380-1-git-send-email-walling@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/3] Guest Support for Diagnose 318
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, rth@twiddle.net, david@redhat.com, borntraeger@de.ibm.com, thuth@redhat.com

Changelog:

    RFC -> v1
        - introduced kvm stubs for set/get cpc
        - s/fac134/byte_134
        - moved diag318 vmstate description to diag.c
        - reduced S390_VCPU_MAX to 247

     v1 -> v2
        - split patches into header sync, cpu model feat, and diag migration / reset
        - tiny cleanups

Collin Walling (3):
  s390: linux header sync for diag318
  s390: cpu feature for diagnose 318 andlimit max VCPUs to 247
  s390: migration and reset support for diagnose 318

 hw/s390x/ipl.c                  |  3 +++
 hw/s390x/s390-virtio-ccw.c      |  3 +++
 hw/s390x/sclp.c                 |  2 ++
 include/hw/s390x/sclp.h         |  2 ++
 linux-headers/asm-s390/kvm.h    |  5 ++++
 target/s390x/cpu.h              |  2 +-
 target/s390x/cpu_features.c     |  3 +++
 target/s390x/cpu_features.h     |  1 +
 target/s390x/cpu_features_def.h |  3 +++
 target/s390x/diag.c             | 52 +++++++++++++++++++++++++++++++++++++++++
 target/s390x/gen-features.c     |  1 +
 target/s390x/internal.h         |  4 +++-
 target/s390x/kvm-stub.c         | 10 ++++++++
 target/s390x/kvm.c              | 23 ++++++++++++++++++
 target/s390x/kvm_s390x.h        |  2 ++
 15 files changed, 114 insertions(+), 2 deletions(-)

-- 
2.7.4
