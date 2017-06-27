Received: from eggs.gnu.org ([2001:4830:134:3::10]:52366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dPtli-0006q3-Kr
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dPsYJ-00062q-IH
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:37:22 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dPsYJ-0005yM-Au
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:37:19 -0400
Received: by mail-lf0-x241.google.com with SMTP id t72so3072987lff.0
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 08:37:19 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 27 Jun 2017 17:37:09 +0200
Message-Id: <1498577836-25883-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v2 0/7] MMIO Exec pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: frederic.konrad@adacore.com, pbonzini@redhat.com, rth@twiddle.net, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Hi,

Paolo suggested offline that we send a pull request for this series.
Here it is, I've run it through my testsuite + tested the LQSPI testcase
on Zynq.

Cheers,
Edgar

ChangeLog:

v1 -> v2:
* Add EI RB line to patch #6
* Remove changelogs from commit messages
* Add EI SoB lines to all patches


The following changes since commit 054914f6461ce9d3427af6527ef3e5b07311c86b:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-06-26 15:38:29 +0100)

are available in the git repository at:

  git@github.com:edgarigl/qemu.git tags/edgar/mmio-exec-v2.for-upstream

for you to fetch changes up to 252b99baeb9e7e86cc0ece8efcaddebf11d284f5:

  xilinx_spips: allow mmio execution (2017-06-27 15:09:15 +0200)

----------------------------------------------------------------
edgar/mmio-exec-v2.for-upstream

----------------------------------------------------------------
KONRAD Frederic (7):
      cputlb: cleanup get_page_addr_code to use VICTIM_TLB_HIT
      cputlb: move get_page_addr_code
      cputlb: fix the way get_page_addr_code fills the tlb
      qdev: add MemoryRegion property
      introduce mmio_interface
      exec: allow to get a pointer for some mmio memory region
      xilinx_spips: allow mmio execution

 accel/tcg/cputlb.c               |  82 ++++++++++++++-----------
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
