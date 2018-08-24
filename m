Received: from eggs.gnu.org ([2001:4830:134:3::10]:54589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ftFVt-0005AD-OX
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ftFVs-0007w6-Jp
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:04:45 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ftFVs-0007ZW-8F
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:04:44 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 18:04:19 +0100
Message-Id: <20180824170422.5783-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] Drop old_mmio accessor support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

Hi; this patchset removes support for the old_mmio accessors
from the memory core code, now that we have fixed all the
devices that were using it.

Patch 1 does that removal.
Patch 2 fixes up a wart in fw_cfg that was only needed while
we had the old_mmio accessors (spotted because of the comment
coming up in my grep for 'old_mmio'...)
Patch 3 is a bonus that adds documentation for the _with_attrs
accessors, since I noticed while writing patch 1 that we
hadn't actually written any.

Based-on: <20180802174042.29234-1-peter.maydell@linaro.org>
("[PATCH 0/2] hw/net/pcnet-pci: Convert away from old_mmio accessors")

The pcnet-pci patches are the only "convert away from old_mmio"
patches still not yet in master; they've been reviewed, they just
haven't been picked up by anybody yet.

thanks
-- PMM

Peter Maydell (3):
  memory: Remove old_mmio accessors
  hw/nvram/fw_cfg: Use memberwise copy of MemoryRegionOps struct
  docs/devel/memory.txt: Document _with_attrs accessors

 docs/devel/memory.txt | 13 ++++++---
 include/exec/memory.h |  5 ----
 hw/nvram/fw_cfg.c     |  7 +----
 memory.c              | 64 ++-----------------------------------------
 4 files changed, 12 insertions(+), 77 deletions(-)

-- 
2.18.0
