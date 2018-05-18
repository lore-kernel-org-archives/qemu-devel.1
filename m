Received: from eggs.gnu.org ([2001:4830:134:3::10]:35851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj37-0000VB-NF
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj36-0007OM-J5
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:13 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fJj36-0007NV-Au
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:12 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj34-0004jT-D3
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:20:10 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 18:19:37 +0100
Message-Id: <20180518172009.14416-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/32] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Another target-arm queue, since we're over 30 patches
already. Most of this is RTH's SVE-patches-part-1.

thanks
-- PMM


The following changes since commit d32e41a1188e929cc0fb16829ce3736046951e39:

  Merge remote-tracking branch 'remotes/famz/tags/docker-and-block-pull-request' into staging (2018-05-18 14:11:52 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180518

for you to fetch changes up to b94f8f60bd841c5b737185cd38263e26822f77ab:

  target/arm: Implement SVE Permute - Extract Group (2018-05-18 17:48:09 +0100)

----------------------------------------------------------------
target-arm queue:
 * Initial part of SVE implementation (currently disabled)
 * smmuv3: fix some minor Coverity issues
 * add model of Xilinx ZynqMP generic DMA controller
 * expose (most) Arm coprocessor/system registers to
   gdb via QEMU's gdbstub, for reads only

----------------------------------------------------------------
Abdallah Bouassida (3):
      target/arm: Add "ARM_CP_NO_GDB" as a new bit field for ARMCPRegInfo type
      target/arm: Add "_S" suffix to the secure version of a sysreg
      target/arm: Add the XML dynamic generation

Eric Auger (2):
      hw/arm/smmuv3: Fix Coverity issue in smmuv3_record_event
      hw/arm/smmu-common: Fix coverity issue in get_block_pte_address

Francisco Iglesias (2):
      xlnx-zdma: Add a model of the Xilinx ZynqMP generic DMA
      xlnx-zynqmp: Connect the ZynqMP GDMA and ADMA

Richard Henderson (25):
      target/arm: Introduce translate-a64.h
      target/arm: Add SVE decode skeleton
      target/arm: Implement SVE Bitwise Logical - Unpredicated Group
      target/arm: Implement SVE load vector/predicate
      target/arm: Implement SVE predicate test
      target/arm: Implement SVE Predicate Logical Operations Group
      target/arm: Implement SVE Predicate Misc Group
      target/arm: Implement SVE Integer Binary Arithmetic - Predicated Group
      target/arm: Implement SVE Integer Reduction Group
      target/arm: Implement SVE bitwise shift by immediate (predicated)
      target/arm: Implement SVE bitwise shift by vector (predicated)
      target/arm: Implement SVE bitwise shift by wide elements (predicated)
      target/arm: Implement SVE Integer Arithmetic - Unary Predicated Group
      target/arm: Implement SVE Integer Multiply-Add Group
      target/arm: Implement SVE Integer Arithmetic - Unpredicated Group
      target/arm: Implement SVE Index Generation Group
      target/arm: Implement SVE Stack Allocation Group
      target/arm: Implement SVE Bitwise Shift - Unpredicated Group
      target/arm: Implement SVE Compute Vector Address Group
      target/arm: Implement SVE floating-point exponential accelerator
      target/arm: Implement SVE floating-point trig select coefficient
      target/arm: Implement SVE Element Count Group
      target/arm: Implement SVE Bitwise Immediate Group
      target/arm: Implement SVE Integer Wide Immediate - Predicated Group
      target/arm: Implement SVE Permute - Extract Group

 hw/dma/Makefile.objs         |    1 +
 target/arm/Makefile.objs     |   10 +
 include/hw/arm/xlnx-zynqmp.h |    5 +
 include/hw/dma/xlnx-zdma.h   |   84 ++
 include/qom/cpu.h            |    5 +-
 target/arm/cpu.h             |   37 +-
 target/arm/helper-sve.h      |  427 +++++++++
 target/arm/helper.h          |    1 +
 target/arm/translate-a64.h   |  118 +++
 gdbstub.c                    |   10 +
 hw/arm/smmu-common.c         |    4 +-
 hw/arm/smmuv3.c              |    2 +-
 hw/arm/xlnx-zynqmp.c         |   53 ++
 hw/dma/xlnx-zdma.c           |  832 +++++++++++++++++
 target/arm/cpu.c             |    1 +
 target/arm/gdbstub.c         |   76 ++
 target/arm/helper.c          |   57 +-
 target/arm/sve_helper.c      | 1562 +++++++++++++++++++++++++++++++
 target/arm/translate-a64.c   |  119 +--
 target/arm/translate-sve.c   | 2070 ++++++++++++++++++++++++++++++++++++++++++
 .gitignore                   |    1 +
 target/arm/sve.decode        |  419 +++++++++
 22 files changed, 5778 insertions(+), 116 deletions(-)
 create mode 100644 include/hw/dma/xlnx-zdma.h
 create mode 100644 target/arm/helper-sve.h
 create mode 100644 target/arm/translate-a64.h
 create mode 100644 hw/dma/xlnx-zdma.c
 create mode 100644 target/arm/sve_helper.c
 create mode 100644 target/arm/translate-sve.c
 create mode 100644 target/arm/sve.decode
