Received: from eggs.gnu.org ([2001:4830:134:3::10]:33597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dmFPC-0007kQ-Ri
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dmFP7-0002Ip-Vl
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:28:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45862
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dmFP7-0002ID-PV
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:28:17 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7S8Nwfg118523
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 04:28:17 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cm9ubdy6v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 04:28:16 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 28 Aug 2017 09:28:13 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 28 Aug 2017 10:28:06 +0200
Message-Id: <1503908887-67060-1-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 0/1] kernel fix for s390 postcopy hang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Andrea, David,

here is a patch that fixes my postcopy hang 
(https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04129.html)

unless there are better ideas or complains, this will go via Martins
tree.

Christian Borntraeger (1):
  s390/mm: avoid empty zero pages for KVM guests to avoid postcopy hangs

 arch/s390/include/asm/pgtable.h |  2 +-
 arch/s390/mm/gmap.c             | 41 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 35 insertions(+), 8 deletions(-)

-- 
2.7.4
