Received: from eggs.gnu.org ([2001:4830:134:3::10]:53513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1dCSo3-0002Gq-8k
	for qemu-devel@nongnu.org; Sun, 21 May 2017 11:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1dCSo2-0007AO-Df
	for qemu-devel@nongnu.org; Sun, 21 May 2017 11:30:07 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 21 May 2017 17:29:38 +0200
Message-Id: <20170521152949.15338-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/11] hw: arm: exynos: Bring up secondary
 CPU, QOM-ify Soc, other improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Krzysztof Kozlowski <krzk@kernel.org>


Hi,

This is a collection of three already sent patchsets [1] [2] [3].


Changes since previous versions (v2):
1. Patch 11/11: set BIT(8) in PS_HOLD to fix power off on Linux v4.12-rc1=
.
2. Add reviewed-by tags.


The first patch in set is a bugfix which also exposes problem of cpuidle.
Kernel compiled with disabled CPU_IDLE works fine (two CPUs, coming SGIs,
poweroff working) but with CPU_IDLE it behaves bad due to low-power
mode (AFTR). This was discussed at [1].

There are no external dependencies.

Patchset is also available here:
https://github.com/krzk/qemu/tree/for-next/exynos4210-gic-qom-soc-powerof=
f-v3


Best regards,
Krzysztof

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg436902.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01562.html
[3] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01553.html


Krzysztof Kozlowski (11):
  hw/intc/exynos4210_gic: Fix GIC memory mappings for secondary CPU
  hw/intc/exynos4210_gic: Use more meaningful name for local variable
  hw/timer/exynos4210_mct: Fix checkpatch style errors
  hw/timer/exynos4210_mct: Cleanup indentation and empty new lines
  hw/timer/exynos4210_mct: Remove unused defines
  hw/arm/exynos: Move DRAM initialization next boards
  hw/arm/exynos: Declare local variables in some order
  hw/arm/exynos: QOM-ify the SoC
  hw/arm/exynos: Use type define instead of hard-coded a9mpcore_priv
    string
  hw/intc/exynos4210_gic: Constify array of combiner interrupts
  hw/misc/exynos4210_pmu: Add support for system poweroff

 hw/arm/exynos4210.c         | 43 ++++++++++++++++--------------------
 hw/arm/exynos4_boards.c     | 53 +++++++++++++++++++++++++++++++++++++++=
------
 hw/intc/exynos4210_gic.c    | 35 ++++++++++++++++++------------
 hw/misc/exynos4210_pmu.c    | 20 ++++++++++++++++-
 hw/timer/exynos4210_mct.c   | 50 ++++++++++++++++++---------------------=
---
 include/hw/arm/exynos4210.h | 11 +++++-----
 6 files changed, 132 insertions(+), 80 deletions(-)

--=20
2.9.3
