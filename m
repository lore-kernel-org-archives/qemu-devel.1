Received: from eggs.gnu.org ([2001:4830:134:3::10]:58669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dzhNP-00060g-Bl
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dzhNJ-0005GR-Sk
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:58:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39064
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dzhNJ-0005EY-Mu
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:58:01 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94ArvLK085114
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 06:57:58 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dctr6b21q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 06:57:58 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 4 Oct 2017 11:57:56 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed,  4 Oct 2017 12:57:49 +0200
Message-Id: <20171004105751.24655-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/2] s390/z14: extended TOD-clock support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>

The last last remaining z14 item on my queue.

v1->v2:
- split patches
- fix white spaces (also fixup kvm_s390_set_clock)
- single phrase error message
- use strerror

Collin L. Walling (2):
  s390/kvm: Support for get/set of extended TOD-Clock for guest
  s390/kvm: make TOD setting failures fatal for migration

 hw/s390x/s390-virtio-ccw.c |  7 ++-----
 target/s390x/cpu.c         | 26 +++++++++++++++++++-------
 target/s390x/kvm-stub.c    | 10 ++++++++++
 target/s390x/kvm.c         | 35 ++++++++++++++++++++++++++++++++++-
 target/s390x/kvm_s390x.h   |  2 ++
 5 files changed, 67 insertions(+), 13 deletions(-)

-- 
2.9.4
