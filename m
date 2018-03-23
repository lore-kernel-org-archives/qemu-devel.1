Received: from eggs.gnu.org ([2001:4830:134:3::10]:41178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ezImk-0001fA-Ii
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 05:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ezImh-0001L5-8f
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 05:14:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ezImh-0001Ju-08
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 05:14:51 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2N9EQ7C101144
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 05:14:49 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gvv965rpq-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 05:14:49 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 23 Mar 2018 09:14:47 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 23 Mar 2018 09:14:39 +0000
Message-Id: <20180323091441.116971-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 0/2] s390x: Fixes for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>

Peter,

2 fixes for 2.12. Please pull

The following changes since commit d522e0bd18364f6d784d43edab35b0563d21f6f3:

  gitmodules: Use the QEMU mirror of qemu-palcode (2018-03-22 19:24:16 +0000)

are available in the Git repository at:

  git://github.com/borntraeger/qemu.git tags/s390x-20180323

for you to fetch changes up to 06a97edac172f52971d7bdca6bb56a1edcb1b8f6:

  s390x/cpumodel: fix feature groups and breakage of MSA8 (2018-03-23 09:05:42 +0000)

----------------------------------------------------------------
s390x: Fixes for 2.12

- Fix for the s390 cpumodel
- Forbid multifunction PCI devices

----------------------------------------------------------------
Christian Borntraeger (1):
      s390x/cpumodel: fix feature groups and breakage of MSA8

Yi Min Zhao (1):
      s390x/pci: forbid multifunction pci device

 hw/s390x/s390-pci-bus.c     | 10 ++++++++++
 target/s390x/cpu_features.h |  1 +
 2 files changed, 11 insertions(+)
