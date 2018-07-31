Received: from eggs.gnu.org ([2001:4830:134:3::10]:42128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fkQaU-00051g-D2
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fkQaR-0006HX-16
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:05:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fkQaQ-0006H5-Ma
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:04:58 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6V94lCY147229
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 05:04:57 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kjjfb5y9g-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 05:04:56 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 31 Jul 2018 10:04:52 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 11:04:46 +0200
Message-Id: <20180731090448.36662-1-borntraeger@de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH 0/2] etoken patch for 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

this depends on the current kvms390/next kernel tree.

Christian Borntraeger (2):
  header sync
  s390x/kvm: add etoken facility

 linux-headers/asm-s390/kvm.h    |  5 ++++-
 target/s390x/cpu.h              |  3 +++
 target/s390x/cpu_features.c     |  3 ++-
 target/s390x/cpu_features_def.h |  3 ++-
 target/s390x/gen-features.c     |  3 ++-
 target/s390x/kvm.c              | 11 +++++++++++
 target/s390x/machine.c          | 20 +++++++++++++++++++-
 7 files changed, 43 insertions(+), 5 deletions(-)

-- 
2.17.0
