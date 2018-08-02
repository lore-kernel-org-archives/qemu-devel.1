Received: from eggs.gnu.org ([2001:4830:134:3::10]:35077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flEqH-00079D-Rs
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flEqH-00066i-67
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:44:41 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  2 Aug 2018 15:44:27 +0100
Message-Id: <20180802144430.13870-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] hw/ppc: Convert various devices away from
 old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-ppc@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

This patchset removes various uses of old_mmio from minor PPC
devices:
 * hw/ppc/prep had an entirely ifdeffed-out stub of an XCSR device,
   which we remove
 * hw/ppc/ppc_boards had ref405ep_fpga
 * hw/ppc/ppc405_uc had three minor devices

As you can see from the diffstat, the new API provides much
cleaner ways to handle the various different access sizes.

This knocks another five old_mmio uses out of the codebase,
leaving us with just five to go.

NB: Tested only with 'make check'.

thanks
-- PMM

Peter Maydell (3):
  hw/ppc/prep: Remove ifdeffed-out stub of XCSR code
  hw/ppc/ppc_boards: Don't use old_mmio for ref405ep_fpga
  hw/ppc/ppc405_uc: Convert away from old_mmio

 hw/ppc/ppc405_boards.c |  60 +++-----------
 hw/ppc/ppc405_uc.c     | 173 ++++++-----------------------------------
 hw/ppc/prep.c          |  97 +----------------------
 3 files changed, 39 insertions(+), 291 deletions(-)

-- 
2.17.1
