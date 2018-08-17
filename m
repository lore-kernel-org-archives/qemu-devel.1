Received: from eggs.gnu.org ([2001:4830:134:3::10]:54848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqdD3-0004Y7-L2
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 07:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqdD3-0008F1-0N
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 07:46:29 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqdD2-0008CL-PT
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 07:46:28 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Aug 2018 12:46:16 +0100
Message-Id: <20180817114619.22354-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] Drop obsolete memory system request_ptr API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <frederic.konrad@adacore.com>

Now that support has hit master for direct execution from
arbitrary MMIO regions, we can remove the MMIO request_ptr
API, which required special case support in each device that
wanted to handle it, and also had bad race conditions that
resulted in crashes if you tried to use it heavily.

This API was only ever used in one device in the source
tree, the Xilinx SPIPS. These three patches remove the
now-unneeded code from the Xilinx device and then the
core memory subsystem code.

thanks
-- PMM

Peter Maydell (3):
  hw/ssi/xilinx_spips: Remove unneeded MMIO request_ptr code
  memory: Remove MMIO request_ptr APIs
  hw/misc: Remove mmio_interface device

 hw/misc/Makefile.objs            |   1 -
 include/exec/memory.h            |  35 --------
 include/hw/misc/mmio_interface.h |  49 -----------
 hw/misc/mmio_interface.c         | 135 -------------------------------
 hw/ssi/xilinx_spips.c            |  46 -----------
 memory.c                         | 110 -------------------------
 6 files changed, 376 deletions(-)
 delete mode 100644 include/hw/misc/mmio_interface.h
 delete mode 100644 hw/misc/mmio_interface.c

-- 
2.18.0
