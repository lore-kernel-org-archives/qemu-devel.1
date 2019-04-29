Received: from eggs.gnu.org ([209.51.188.92]:33382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hL2GX-0001YM-FU
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hL2Bf-0000Lo-Lb
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:03:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34690
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hL2Bf-0000LA-GR
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:02:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3T8rauS193912
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:02:56 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s5vh6md90-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:02:55 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 29 Apr 2019 10:02:54 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 29 Apr 2019 05:02:41 -0400
Message-Id: <20190429090250.7648-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/9] s390x: new guest features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>

Adding gen15.

v2->v3: - merge  deprecation patch into gen 15 patch
	- fix comments
	- use gen15a and gen15b instead of cpuid
v1->v2: - rework csske deprecation
	- white space fixes
	- also require msa4 for msa9

Christian Borntraeger (9):
  linux header sync
  s390x/cpumodel: ignore csske for expansion
  s390x/cpumodel: Miscellaneous-Instruction-Extensions Facility 3
  s390x/cpumodel: msa9 facility
  s390x/cpumodel: vector enhancements
  s390x/cpumodel: enhanced sort facility
  s390x/cpumodel: add Deflate-conversion facility
  s390x/cpumodel: add gen15 defintions
  s390x/cpumodel: wire up 8561 and 8562 as gen15 machines

 linux-headers/asm-s390/kvm.h    |   5 +-
 target/s390x/cpu_features.c     |  54 ++++++++++++++++
 target/s390x/cpu_features.h     |   3 +
 target/s390x/cpu_features_def.h |  49 +++++++++++++++
 target/s390x/cpu_models.c       |  13 ++--
 target/s390x/gen-features.c     | 105 ++++++++++++++++++++++++++++++++
 target/s390x/kvm.c              |  18 ++++++
 7 files changed, 242 insertions(+), 5 deletions(-)

-- 
2.17.1
