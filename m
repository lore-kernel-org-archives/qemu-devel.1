Received: from eggs.gnu.org ([209.51.188.92]:50558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH5GD-0002eu-5U
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH5GC-0004QQ-7X
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:31:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44156
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hH5GC-0004P7-2v
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:31:20 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3IBTQjC183645
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 07:31:18 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rxqyt19hd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 07:31:17 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 18 Apr 2019 12:31:16 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 18 Apr 2019 13:31:00 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190418113110.160664-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 00/10]  s390x: new guest features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Adding generation 15.

Some interesting aspects:
- conditional SSKE and bpb are deprecated. This patch set addresses that
  for csske.
- no name yet for gen15, I suggest to use the assigned numbers and
  provide an alias later on. (I have split out this into a separate
  patch)

Christian Borntraeger (10):
  linux header sync
  s390x/cpumodel: remove CSSKE from base model
  s390x/cpumodel: Miscellaneous-Instruction-Extensions Facility 3
  s390x/cpumodel: msa9 facility
  s390x/cpumodel: vector enhancements
  s390x/cpumodel: enhanced sort facility
  s390x/cpumodel: deflate
  s390x/cpumodel: add gen15 defintions
  s390x/cpumodel: wire up 8561 and 8562 as gen15 machines
  s390x/cpumodel: do not claim csske for expanded models in qmp

 hw/s390x/s390-virtio-ccw.c      |  6 +++
 linux-headers/asm-s390/kvm.h    |  5 +-
 target/s390x/cpu_features.c     | 54 +++++++++++++++++++
 target/s390x/cpu_features.h     |  3 ++
 target/s390x/cpu_features_def.h | 49 +++++++++++++++++
 target/s390x/cpu_models.c       | 35 ++++++++++++
 target/s390x/cpu_models.h       |  1 +
 target/s390x/gen-features.c     | 94 ++++++++++++++++++++++++++++++++-
 target/s390x/kvm.c              | 18 +++++++
 9 files changed, 263 insertions(+), 2 deletions(-)

-- 
2.19.1
