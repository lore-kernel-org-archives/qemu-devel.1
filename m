Received: from eggs.gnu.org ([2001:4830:134:3::10]:52673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1d7Qml-0001ex-G1
	for qemu-devel@nongnu.org; Sun, 07 May 2017 14:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1d7Qmk-00007Q-NE
	for qemu-devel@nongnu.org; Sun, 07 May 2017 14:19:59 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun,  7 May 2017 20:19:37 +0200
Message-Id: <20170507181940.25882-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] hw/arm/exynos: QOM-ify the SoC
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

Changes since v1:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. s/RAM/DRAM/ in commit msg of first patch (as suggested by Philippe).
2. Add Philippe's reviewed-by.


Convert the Exynos4210 SoC driver into QOM model.

No external dependencies, rebased on v2.9.0-363-g0de9191deb14.

Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  hw/arm/exynos: Move DRAM initialization next boards
  hw/arm/exynos: Declare local variables in some order
  hw/arm/exynos: QOM-ify the SoC

 hw/arm/exynos4210.c         | 40 +++++++++++++++-------------------
 hw/arm/exynos4_boards.c     | 53 +++++++++++++++++++++++++++++++++++++++=
------
 include/hw/arm/exynos4210.h | 11 +++++-----
 3 files changed, 69 insertions(+), 35 deletions(-)

--=20
2.9.3
