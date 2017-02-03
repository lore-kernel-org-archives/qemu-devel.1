Received: from eggs.gnu.org ([2001:4830:134:3::10]:60732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cZhKR-0004b9-Cw
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:07:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cZhKN-0002cJ-E3
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:07:19 -0500
Received: from greensocs.com ([193.104.36.180]:38977)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cZhKN-0002at-5F
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:07:15 -0500
From: fred.konrad@greensocs.com
Date: Fri,  3 Feb 2017 18:06:32 +0100
Message-Id: <1486141597-13941-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [RFC 0/5] execute code from mmio area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com, alistair.francis@xilinx.com, pbonzini@redhat.com, clg@kaod.org, mark.burton@greensocs.com, fred.konrad@greensocs.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

This patch-set allows to execute code from mmio areas.
The main goal of this is to be able to run code for example from an SPI device.

The three first patch fixes the way get_page_addr_code fills the TLB.

The fourth patch implements the mmio execution helpers: the device must
implement the request_ptr callback of the MemoryRegion and will be notified when
the guest wants to execute code from it.

The fifth patch implements the execution from the SPI memories in the
xilinx_spips model.

Thanks,
Fred

KONRAD Frederic (5):
  cputlb: cleanup get_page_addr_code to use VICTIM_TLB_HIT
  cputlb: move get_page_addr_code
  cputlb: fix the way get_page_addr_code fills the tlb
  exec: allow to get a pointer for some mmio memory region
  xilinx_spips: allow mmio execution

 cputlb.c              | 81 ++++++++++++++++++++++++++++-----------------------
 hw/ssi/xilinx_spips.c | 74 ++++++++++++++++++++++++++++++++++------------
 include/exec/memory.h | 35 ++++++++++++++++++++++
 memory.c              | 45 ++++++++++++++++++++++++++++
 4 files changed, 180 insertions(+), 55 deletions(-)

-- 
1.8.3.1
