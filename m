Received: from eggs.gnu.org ([2001:4830:134:3::10]:60961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1dGpRn-0005Ym-G9
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1dGpRm-0002K2-Gv
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:29:11 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri,  2 Jun 2017 18:28:48 +0200
Message-Id: <20170602162857.6065-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/9] hw: arm: exynos: Improvements and
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Krzysztof Kozlowski <krzk@kernel.org>

Hi,

I split non-intrusive changes from my previous attempts [1].

This patchset contains only cleanups, minor improvements and support for
power off. Power off itself will not happen because kernel will hang
before trying it, on syncing IRQ works (fix for this is [2], but this wil=
l
be separate).

Changes since v3:
1. Rebase on current master (API for shutdown changed).
2. Apply Peter's reviewed-by tag.


Best regards,
Krzysztof


[1] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg04821.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg04818.html

Krzysztof Kozlowski (9):
  hw/intc/exynos4210_gic: Use more meaningful name for local variable
  hw/timer/exynos4210_mct: Fix checkpatch style errors
  hw/timer/exynos4210_mct: Cleanup indentation and empty new lines
  hw/timer/exynos4210_mct: Remove unused defines
  hw/arm/exynos: Move DRAM initialization next boards
  hw/arm/exynos: Declare local variables in some order
  hw/arm/exynos: Use type define instead of hard-coded a9mpcore_priv
    string
  hw/intc/exynos4210_gic: Constify array of combiner interrupts
  hw/misc/exynos4210_pmu: Add support for system poweroff

 hw/arm/exynos4210.c         | 27 +++++-------------------
 hw/arm/exynos4_boards.c     | 50 ++++++++++++++++++++++++++++++++++++++-=
------
 hw/intc/exynos4210_gic.c    | 14 ++++++-------
 hw/misc/exynos4210_pmu.c    | 20 +++++++++++++++++-
 hw/timer/exynos4210_mct.c   | 50 +++++++++++++++++++--------------------=
------
 include/hw/arm/exynos4210.h |  5 +----
 6 files changed, 96 insertions(+), 70 deletions(-)

--=20
2.9.3
