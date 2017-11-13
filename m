Received: from eggs.gnu.org ([2001:4830:134:3::10]:47304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFSF-00045A-SQ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFSA-0007d1-6t
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:15 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eEFSA-0007Yd-0J
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:10 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFS2-00021k-C1
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 14:11:02 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 14:11:35 +0000
Message-Id: <1510582304-27058-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/9] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

ARM bugfixes for rc1...


The following changes since commit f291910db61b5812e68f1e76afb3ade41d567bea:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2017-11-09' into staging (2017-11-13 13:13:12 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20171113

for you to fetch changes up to d25f2a72272b9ffe0d06710d6217d1169bc2cc7d:

  accel/tcg/translate-all: expand cpu_restore_state addr check (2017-11-13 13:55:27 +0000)

----------------------------------------------------------------
target-arm queue:
 * translate-a64.c: silence gcc5 warning
 * highbank: validate register offset before access
 * MAINTAINERS: Add entries for Smartfusion2
 * accel/tcg/translate-all: expand cpu_restore_state addr check
   (so usermode insn aborts don't crash with an assertion failure)
 * fix TCG initialization of some Arm boards by allowing them
   to specify min/default number of CPUs to create

----------------------------------------------------------------
Alex Bennée (1):
      accel/tcg/translate-all: expand cpu_restore_state addr check

Alistair Francis (2):
      xlnx-zynqmp: Properly support the smp command line option
      xlnx-zcu102: Add an info message deprecating the EP108

Emilio G. Cota (4):
      arm/translate-a64: mark path as unreachable to eliminate warning
      qom: move CPUClass.tcg_initialize to a global
      xlnx-zcu102: Specify the max number of CPUs for the EP108
      hw: add .min_cpus and .default_cpus fields to machine_class

Prasad J Pandit (1):
      highbank: validate register offset before access

Subbaraya Sundeep (1):
      MAINTAINERS: Add entries for Smartfusion2

 include/exec/exec-all.h    | 11 ++++++++++
 include/hw/boards.h        |  5 +++++
 include/qom/cpu.h          |  1 -
 accel/tcg/translate-all.c  | 52 ++++++++++++++++++++++++++--------------------
 exec.c                     |  5 +++--
 hw/arm/exynos4_boards.c    | 12 ++++-------
 hw/arm/highbank.c          | 17 +++++++++++++--
 hw/arm/raspi.c             |  2 ++
 hw/arm/xlnx-zcu102.c       |  9 +++++++-
 hw/arm/xlnx-zynqmp.c       | 26 ++++++++++++++---------
 target/arm/translate-a64.c |  2 ++
 vl.c                       | 21 ++++++++++++++++---
 MAINTAINERS                | 17 +++++++++++++++
 qemu-doc.texi              |  7 +++++++
 14 files changed, 137 insertions(+), 50 deletions(-)
