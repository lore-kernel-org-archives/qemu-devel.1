Received: from eggs.gnu.org ([2001:4830:134:3::10]:50685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dIJEP-0006MC-Fe
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dIJEK-00032X-Hn
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:29:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dIJEK-00031z-7I
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:29:24 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v56IT6R5096570
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 14:29:22 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2awxj2258n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 14:29:22 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 6 Jun 2017 19:29:20 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue,  6 Jun 2017 20:29:10 +0200
Message-Id: <1496773755-53343-1-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 0/5] s390x/kvm: various fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Here is a bunch of fixes. Most have been on the list already,
"fence off MIDA" was not posted before. I plan to submit a
pull request on Thursday or Friday.

Cornelia Huck (1):
  s390x/css: fence off MIDA

David Hildenbrand (2):
  s390x/cpumodel: take care of the cpuid format bit for KVM
  s390x/cpumodel: improve defintion search without an IBC

Greg Kurz (1):
  pc-bios/s390-ccw: use STRIP variable in Makefile

Halil Pasic (1):
  s390x/css: catch section mismatch on load

 hw/s390x/css.c            | 19 +++++++++++++++++++
 hw/s390x/virtio-ccw.c     |  6 +++++-
 include/hw/s390x/ioinst.h |  1 +
 pc-bios/s390-ccw/Makefile |  4 +++-
 target/s390x/cpu_models.c | 10 ++++++++++
 target/s390x/cpu_models.h | 10 +++++++---
 target/s390x/ioinst.c     |  4 ++++
 target/s390x/kvm.c        |  1 +
 8 files changed, 50 insertions(+), 5 deletions(-)

-- 
2.7.4
