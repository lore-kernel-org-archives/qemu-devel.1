Received: from eggs.gnu.org ([2001:4830:134:3::10]:54554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dLCMl-0005kH-S6
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dLCMg-00012l-Sx
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:46:03 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:36697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dLCMg-00012G-KI
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:45:58 -0400
Received: by mail-lf0-x241.google.com with SMTP id x81so956105lfb.3
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 10:45:56 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 14 Jun 2017 19:45:46 +0200
Message-Id: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 0/7] MMIO Exec pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: fred.konrad@greensocs.com, pbonzini@redhat.com, rth@twiddle.net, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Hi,

Paolo suggested offline that we send a pull request for this series.
Here it is, I've run it through my testsuite + tested the LQSPI testcase
on Zynq.

Cheers,
Edgar

The following changes since commit 3f0602927b120a480b35dcf58cf6f95435b3ae91:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170613' into staging (2017-06-13 15:49:07 +0100)

are available in the git repository at:

  git@github.com:edgarigl/qemu.git tags/edgar/mmio-exec.for-upstream

for you to fetch changes up to 63ef40dd6bc6cfdae5fa67ccac1cb11e7a5161b0:

  xilinx_spips: allow mmio execution (2017-06-14 17:31:08 +0200)

----------------------------------------------------------------
mmio-exec.for-upstream

----------------------------------------------------------------
KONRAD Frederic (7):
      cputlb: cleanup get_page_addr_code to use VICTIM_TLB_HIT
      cputlb: move get_page_addr_code
      cputlb: fix the way get_page_addr_code fills the tlb
      qdev: add MemoryRegion property
      introduce mmio_interface
      exec: allow to get a pointer for some mmio memory region
      xilinx_spips: allow mmio execution

 cputlb.c                         |  82 ++++++++++++++-----------
 hw/misc/Makefile.objs            |   1 +
 hw/misc/mmio_interface.c         | 128 +++++++++++++++++++++++++++++++++++++++
 hw/ssi/xilinx_spips.c            |  74 ++++++++++++++++------
 include/exec/memory.h            |  35 +++++++++++
 include/hw/misc/mmio_interface.h |  49 +++++++++++++++
 include/hw/qdev-properties.h     |   2 +
 memory.c                         | 111 +++++++++++++++++++++++++++++++++
 8 files changed, 428 insertions(+), 54 deletions(-)
 create mode 100644 hw/misc/mmio_interface.c
 create mode 100644 include/hw/misc/mmio_interface.h
