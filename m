Received: from eggs.gnu.org ([2001:4830:134:3::10]:33986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1d71ZN-0007JN-CX
	for qemu-devel@nongnu.org; Sat, 06 May 2017 11:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1d71ZM-0002tS-HM
	for qemu-devel@nongnu.org; Sat, 06 May 2017 11:24:29 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sat,  6 May 2017 17:24:11 +0200
Message-Id: <20170506152414.8704-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH 0/3] hw/arm/exynos: QOM-ify the SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>

Hi,

Convert the Exynos4210 SoC driver into QOM model.

No external dependencies, rebased on v2.9.0-363-g0de9191deb14.

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  hw/arm/exynos: Move RAM initialization next boards
  hw/arm/exynos: Declare local variables in some order
  hw/arm/exynos: QOM-ify the SoC

 hw/arm/exynos4210.c         | 40 +++++++++++++++-------------------
 hw/arm/exynos4_boards.c     | 53 +++++++++++++++++++++++++++++++++++++++------
 include/hw/arm/exynos4210.h | 11 +++++-----
 3 files changed, 69 insertions(+), 35 deletions(-)

-- 
2.9.3
