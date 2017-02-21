Received: from eggs.gnu.org ([2001:4830:134:3::10]:47160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cg9ZP-0002uK-1e
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cg9ZL-0006OY-3B
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:29:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cg9ZK-0006OT-T9
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:29:23 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Feb 2017 13:29:18 +0100
Message-Id: <20170221122920.16245-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] update Linux headers to 4.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cornelia.huck@de.ibm.com, mst@redhat.com

Pretty large update, requiring a few changes to the script too
(patch 1).

Paolo Bonzini (2):
  update Linux headers to 4.11
  update-linux-headers: update for 4.11

 include/standard-headers/linux/input-event-codes.h |   2 +-
 include/standard-headers/linux/pci_regs.h          |   8 +
 include/standard-headers/linux/virtio_ids.h        |   1 +
 linux-headers/asm-arm/kvm.h                        |  15 +
 linux-headers/asm-arm/unistd-common.h              | 357 ++++++++++++++++++
 linux-headers/asm-arm/unistd-eabi.h                |   5 +
 linux-headers/asm-arm/unistd-oabi.h                |  17 +
 linux-headers/asm-arm/unistd.h                     | 419 +--------------------
 linux-headers/asm-arm64/kvm.h                      |  13 +
 linux-headers/asm-powerpc/kvm.h                    |  27 ++
 linux-headers/asm-powerpc/unistd.h                 |   1 +
 linux-headers/asm-x86/kvm_para.h                   |  13 +-
 linux-headers/linux/kvm.h                          |  24 +-
 linux-headers/linux/kvm_para.h                     |   2 +
 linux-headers/linux/vfio.h                         |  10 +
 scripts/update-linux-headers.sh                    |  13 +-
 16 files changed, 506 insertions(+), 421 deletions(-)
 create mode 100644 linux-headers/asm-arm/unistd-common.h
 create mode 100644 linux-headers/asm-arm/unistd-eabi.h
 create mode 100644 linux-headers/asm-arm/unistd-oabi.h

-- 
2.9.3
