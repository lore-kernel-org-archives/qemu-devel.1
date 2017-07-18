Received: from eggs.gnu.org ([2001:4830:134:3::10]:50663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXOYX-0000Lu-PO
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXOYS-0002LI-Nd
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:12:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35120
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dXOYS-0002L4-Hd
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:12:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6I99KGK053772
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 05:12:31 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bsa8scqcr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 05:12:30 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 18 Jul 2017 10:12:28 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 18 Jul 2017 11:12:22 +0200
Message-Id: <1500369144-143949-1-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 0/2] two more s390 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Peter,
now that z14 was announced here is the z14 cpu model together with
the linux header update.

The following changes since commit ca4e667dbf431d4a2a5a619cde79d30dd2ac3eb2:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20170717-pull-request' into staging (2017-07-17 17:54:17 +0100)

are available in the git repository at:

  git://github.com/borntraeger/qemu.git tags/s390x-20170718

for you to fetch changes up to cc28a5949bb54df070c38ab505ee2c14385e53d0:

  s390x/cpumodel: z14 cpu models (2017-07-18 10:55:16 +0200)

----------------------------------------------------------------
s390: add z14 cpu model

- add a CPU model for the IBM z14 which was announced on July 17th 2017
- update linux headers to 4.13-rc0 to get a fix for an ioctl definition

----------------------------------------------------------------
Christian Borntraeger (1):
      linux header sync against v4.13-rc1

Jason J. Herne (1):
      s390x/cpumodel: z14 cpu models

 linux-headers/asm-x86/kvm_para.h |  1 +
 linux-headers/linux/kvm.h        |  4 +++-
 target/s390x/cpu_models.c        |  1 +
 target/s390x/gen-features.c      | 37 +++++++++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)
