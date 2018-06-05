Received: from eggs.gnu.org ([2001:4830:134:3::10]:53638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQBsY-0000F5-Vi
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQBsV-0006KQ-Ra
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:20:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33852 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQBsV-0006Jl-A5
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:19:59 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue,  5 Jun 2018 21:19:41 +0800
Message-Id: <20180605131944.14649-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 0/3] memory: enhance IOMMU notifier to support
 USER bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

NOTE: This is a continuous discussion in thread but in patch format:

https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg00824.html

Hi, Peter,

Please have a look on whether this tiny series will work for your TCG
work.  I only tested it with x86 with existing qtests.  No further
test is done.  I only want to show what I meant to pass in MemTxAttrs
instead of the new IOMMU index logic.

I only used the USER bit as an example.  Of course in the future we
can add more bits in the MemTxAttrs to monitor upon.  And the series
only provided the interface change, no real use case is provided.

It's very possible that I misunderstood some of the requirement of the
TCG work; please feel free to point it out where I missed.

Thanks,

Peter Xu (3):
  memory: add MemTxAttrs to translate function
  memory: add MemTxAttrs to IOMMUTLBEntry
  memory: introduce IOMMU_NOTIFIER_USER_[UN]SET

 include/exec/memory.h    | 60 ++++++++++++++++++++++++++++++++++++----
 exec.c                   |  2 +-
 hw/alpha/typhoon.c       |  3 +-
 hw/arm/smmuv3.c          |  2 +-
 hw/dma/rc4030.c          |  6 ++--
 hw/i386/amd_iommu.c      |  2 +-
 hw/i386/intel_iommu.c    |  6 ++--
 hw/ppc/spapr_iommu.c     |  3 +-
 hw/s390x/s390-pci-bus.c  |  6 ++--
 hw/sparc/sun4m_iommu.c   |  3 +-
 hw/sparc64/sun4u_iommu.c |  3 +-
 hw/virtio/vhost.c        |  2 +-
 memory.c                 | 13 ++++++++-
 13 files changed, 90 insertions(+), 21 deletions(-)

-- 
2.17.0
