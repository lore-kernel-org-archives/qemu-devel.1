Received: from eggs.gnu.org ([2001:4830:134:3::10]:36447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cYqqX-0001jZ-Lo
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cYqqU-0004Ir-Hq
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:04:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60143
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cYqqU-0004IV-DV
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:04:54 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1194909006051
	for <qemu-devel@nongnu.org>; Wed, 1 Feb 2017 04:04:52 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28apxr7y82-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 04:04:51 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 1 Feb 2017 09:04:50 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed,  1 Feb 2017 10:04:41 +0100
Message-Id: <1485939884-39956-1-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 0/3] s390x fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>

Peter,

The following changes since commit a0def594286d9110a6035e02eef558cf3cf5d847:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-01-30 10:23:20 +0000)

are available in the git repository at:

  git://github.com/borntraeger/qemu.git tags/s390x-20170201

for you to fetch changes up to d8923bc75479cd3fdcc72b7647f4877f91950b01:

  target/s390x: use "qemu" cpu model in user mode (2017-02-01 09:15:17 +0100)

----------------------------------------------------------------
s390x fixes

- build error with old gcc versions
- race between cmma reset and rom/loader resets
- linux-user vs. cpu model

----------------------------------------------------------------
Christian Borntraeger (1):
      s390x/kvm: fix small race reboot vs. cmma

David Hildenbrand (1):
      target/s390x: use "qemu" cpu model in user mode

Paolo Bonzini (1):
      s390-pci: fix compilation on older GCC versions

 hw/s390x/s390-pci-bus.h | 4 ++--
 hw/s390x/s390-virtio.c  | 2 +-
 linux-user/main.c       | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)
