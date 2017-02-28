Received: from eggs.gnu.org ([2001:4830:134:3::10]:52921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cig0i-0007ut-TY
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 06:32:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cig0f-0002ZM-Qt
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 06:32:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57477
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cig0f-0002Z4-LK
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 06:32:01 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1SBNnSj119775
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 06:32:00 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28w79x3012-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 06:32:00 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 28 Feb 2017 11:31:58 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 28 Feb 2017 12:31:48 +0100
Message-Id: <20170228113153.23867-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL for-2.9 0/5] s390x: network boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

The following changes since commit 6181478f6395cdd9d6ffd99623d0c9f39ea53606:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-02-28 08:46:03 +0000)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20170228

for you to fetch changes up to e8ebf60f6d12aca2a4d6bb1059bbcda94ea0bbeb:

  pc-bios/s390-ccw.img: rebuild image (2017-02-28 12:04:48 +0100)

----------------------------------------------------------------
Network boot for s390x. More information (and instructions
for building a s390-netboot.img) can be found at
http://wiki.qemu-project.org/Features/S390xNetworkBoot

----------------------------------------------------------------

Cornelia Huck (1):
  pc-bios/s390-ccw.img: rebuild image

Farhan Ali (4):
  elf-loader: Allow late loading of elf
  s390x/ipl: Extend S390IPLState to support network boot
  s390x/ipl: Load network boot image
  pc-bios/s390-ccw: Use the ccw bios to start the network boot

 hw/core/loader.c           |  17 ++++++++-
 hw/s390x/ipl.c             |  90 +++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/ipl.h             |   5 ++-
 hw/s390x/s390-virtio-ccw.c |   3 +-
 hw/s390x/s390-virtio.c     |   2 +
 hw/s390x/s390-virtio.h     |   1 +
 include/hw/elf_ops.h       |  13 +++++--
 include/hw/loader.h        |  13 ++++++-
 pc-bios/s390-ccw.img       | Bin 26392 -> 26456 bytes
 pc-bios/s390-ccw/bootmap.c |   8 +++-
 pc-bios/s390-ccw/iplb.h    |   3 +-
 pc-bios/s390-ccw/main.c    |  20 +++++++---
 pc-bios/s390-ccw/virtio.c  |   1 +
 pc-bios/s390-ccw/virtio.h  |   1 +
 14 files changed, 160 insertions(+), 17 deletions(-)

-- 
2.11.0
