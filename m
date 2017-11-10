Received: from eggs.gnu.org ([2001:4830:134:3::10]:47352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eDFNC-0005Ne-Kk
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 14:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eDFNB-0006Eu-K1
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 14:53:54 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 10 Nov 2017 14:53:41 -0500
Message-Id: <1510343626-25861-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH for 2.11 0/5] TCG/ARM fixes for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Some MachineClass changes to fix TCG initialization of some
ARM boards for 2.11. This was originally reported by Thomas Huth in [1],
where Peter suggested a way to fix it. Further discussion in
another thread [2] followed up on this.

As a result of that follow-up discussion we also got some Zynq changes from
Alistair [3], which I'm including here since in order to test them
we need the first patch in this series.

Thanks,

		Emilio

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg00078.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg00502.html
[3] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01842.html

Alistair Francis (2):
  xlnx-zynqmp: Properly support the smp command line option
  xlnx-zcu102: Add an info message deprecating the EP108

Emilio G. Cota (3):
  qom: move CPUClass.tcg_initialize to a global
  xlnx-zcu102: Specify the max number of CPUs for the EP108
  hw: add .min_cpus and .default_cpus fields to machine_class

 qemu-doc.texi           |  7 +++++++
 include/hw/boards.h     |  5 +++++
 include/qom/cpu.h       |  1 -
 exec.c                  |  5 +++--
 hw/arm/exynos4_boards.c | 12 ++++--------
 hw/arm/raspi.c          |  2 ++
 hw/arm/xlnx-zcu102.c    |  9 ++++++++-
 hw/arm/xlnx-zynqmp.c    | 26 ++++++++++++++++----------
 vl.c                    | 21 ++++++++++++++++++---
 9 files changed, 63 insertions(+), 25 deletions(-)

-- 
2.7.4
