Received: from eggs.gnu.org ([2001:4830:134:3::10]:53798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cnV0v-0001RB-Cr
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cnV0u-0004jv-MI
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:48:13 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 13 Mar 2017 20:47:47 +0200
Message-Id: <20170313184750.429-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH v3 0/3] hw/arm/exynos: Minor cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eblake@redhat.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Krzysztof Kozlowski <krzk@kernel.org>

Hi,

Minor cleanups, no dependencies.

Changes since v1
================
1. Patch 1/3: Address missed Philippe's comments about error reporting
   verbosity.

Changes since v2
================
1. Patch 1/3: Address Eric's comment.
2. Patch 2/3: Address Peter's comments about "const".
3. Patch 3/3: Use "unsigned int". I had impression that no consensus was
   reached during discussion. If that is wrong impression, let me know.

Best regards,
Krzysztof



Krzysztof Kozlowski (3):
  hw/arm/exynos: Convert fprintf to qemu_log_mask/error_report
  hw/char/exynos4210_uart: Constify static array and few arguments
  hw/misc/exynos4210_pmu: Reorder local variables for readability

 hw/arm/exynos4_boards.c   |  6 +++---
 hw/char/exynos4210_uart.c |  8 ++++----
 hw/misc/exynos4210_pmu.c  |  4 ++--
 hw/timer/exynos4210_mct.c |  6 ++++--
 hw/timer/exynos4210_pwm.c | 13 +++++++------
 hw/timer/exynos4210_rtc.c | 19 ++++++++++---------
 6 files changed, 30 insertions(+), 26 deletions(-)

-- 
2.9.3
