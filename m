Received: from eggs.gnu.org ([2001:4830:134:3::10]:35456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gMcAl-0006qZ-Fl
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gMbwf-0003wM-KJ
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:53:51 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Tue, 13 Nov 2018 17:52:34 +0100
Message-Id: <20181113165247.4806-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/13] Support disabling TCG on ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org, qemu-arm@nongnu.org

This patchset allows for building and running ARM targets with TCG
disabled. It splits the target/arm/helper.c file into logical TCG and
non TCG dependent files so that one can build and run QEMU binaries with
or without TCG enabled.

The rationale behind this work comes from the NEMU project where we're
trying to only support x86 and ARM 64-bit architectures, without
including the TCG code base. We can only do so if we can build and run
ARM binaries with TCG disabled.

The patches are also available here:
https://github.com/intel/nemu/tree/topic/upstream/arm-tcg-disable

Philippe Mathieu-Daudé (2):
  target: arm: Add copyright boilerplate
  target: arm: Remove unused headers

Samuel Ortiz (11):
  target: arm: Move all v7m helpers into their own file
  target: arm: Move all interrupt and exception handlers into their own
    file
  target: arm: Move the DC ZVA helper into op_helper
  target: arm: Make ARM TLB filling routine static
  target: arm: Remove the LDST headers
  target: arm: Move all VFP helpers into their own file
  target: arm: Move CPU state dumping routines to helper.c
  target: arm: Move watchpoints APIs to helper.c
  target: arm: Define TCG dependent functions when TCG is enabled
  target: arm: Makefile cleanup
  target: arm: Do not build TCG objects when TCG is off

 target/arm/internals.h     |   60 +-
 target/arm/translate.h     |    7 -
 target/arm/cpu.c           |    8 +-
 target/arm/excp_helper.c   |  550 +++
 target/arm/helper.c        | 8467 ++++++++++++------------------------
 target/arm/m_helper.c      | 1892 ++++++++
 target/arm/op_helper.c     |  326 +-
 target/arm/translate-a64.c |  125 -
 target/arm/translate.c     |   87 -
 target/arm/vfp_helper.c    |  893 ++++
 target/arm/Makefile.objs   |   19 +-
 11 files changed, 6262 insertions(+), 6172 deletions(-)
 create mode 100644 target/arm/excp_helper.c
 create mode 100644 target/arm/m_helper.c
 create mode 100644 target/arm/vfp_helper.c

-- 
2.19.1
