Received: from eggs.gnu.org ([2001:4830:134:3::10]:46233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwQXi-0004z5-TO
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwQXf-0003TX-E2
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:23:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49256
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dwQXf-0003T5-7e
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:23:11 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8PAJap2074928
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 06:23:08 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d6x8bx58p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 06:23:07 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 25 Sep 2017 11:23:05 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 25 Sep 2017 12:23:00 +0200
Message-Id: <20170925102302.60587-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 0/2] s390/z14: extended TOD-clock support
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

I still have this patch on my queue as the last remaining z14 item.
Since I have already rebase it several time, its time for some 
additional review.


Collin L. Walling (2):
  linux-headers: Update linux headers for extended TOD-Clock
  s390/kvm: Support for get/set of extended TOD-Clock for guest

 hw/s390x/s390-virtio-ccw.c   |  8 +++-----
 linux-headers/asm-s390/kvm.h |  6 ++++++
 target/s390x/cpu.c           | 26 +++++++++++++++++++-------
 target/s390x/kvm-stub.c      | 10 ++++++++++
 target/s390x/kvm.c           | 35 +++++++++++++++++++++++++++++++++++
 target/s390x/kvm_s390x.h     |  2 ++
 6 files changed, 75 insertions(+), 12 deletions(-)

-- 
2.9.4
