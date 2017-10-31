Received: from eggs.gnu.org ([2001:4830:134:3::10]:46809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1e9YjS-0001TB-LO
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1e9YjP-0007QU-J1
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:45:38 -0400
Received: from relay2.gtri.gatech.edu ([130.207.199.168]:52289)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1e9YjP-0007P6-Em
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:45:35 -0400
From: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Date: Tue, 31 Oct 2017 11:44:05 -0400
Message-ID: <20171031154407.4184-1-michael.nawrocki@gtri.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] Add 8-byte wide AMD flash support,
 partial interleaving
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jan.kiszka@web.de, edgar.iglesias@gmail.com, alistair.francis@xilinx.com, michael@walle.cc, david@gibson.dropbear.id.au, magnus.damm@gmail.com, Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>

This patch set does a few things. First, it switches the AMD CFI flash MMIO
operations from the old MMIO API to the new one. Second, it enables 8-byte
wide flash arrays. Finally, it supports rudimentary interleaving of notional
flash "chips". It is expected that commands will be sent to all "chips"
simultaneously. See the example in the second patch for more details. This
behavior is used by drivers for the PPMC7400 PowerPC evaluation board.

Mike Nawrocki (2):
  Add 8-byte access to AMD CFI devices
  Add support for flash interleaving of AMD chips

 hw/arm/digic_boards.c    |   2 +-
 hw/arm/musicpal.c        |   4 +-
 hw/arm/xilinx_zynq.c     |   2 +-
 hw/block/pflash_cfi02.c  | 210 ++++++++++++++++++++++++++---------------------
 hw/lm32/lm32_boards.c    |   4 +-
 hw/ppc/ppc405_boards.c   |  15 ++--
 hw/sh4/r2d.c             |   2 +-
 include/hw/block/flash.h |   1 +
 8 files changed, 132 insertions(+), 108 deletions(-)

-- 
2.14.2
