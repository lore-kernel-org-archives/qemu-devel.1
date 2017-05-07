Received: from eggs.gnu.org ([2001:4830:134:3::10]:53925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1d7KTm-0007fe-L0
	for qemu-devel@nongnu.org; Sun, 07 May 2017 07:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1d7KTl-0004WE-NL
	for qemu-devel@nongnu.org; Sun, 07 May 2017 07:35:58 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun,  7 May 2017 13:35:37 +0200
Message-Id: <20170507113540.8687-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH 0/3] hw/arm/exynos: Fix poweroff
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

Beside two minor cleanups, the patchset implements proper Exynos power off.
Still the GIC [1] fix is needed because the kernel will not reach power off
handlers without it.

[1] http://patchwork.ozlabs.org/patch/738320/

Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  hw/arm/exynos: Use type define instead of hard-coded a9mpcore_priv
    string
  hw/intc/exynos: Constify array of combiner interrupts
  hw/arm/exynos: Add support for system poweroff

 hw/arm/exynos4210.c      |  3 ++-
 hw/intc/exynos4210_gic.c |  2 +-
 hw/misc/exynos4210_pmu.c | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.9.3
