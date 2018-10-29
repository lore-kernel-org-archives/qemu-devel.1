Received: from eggs.gnu.org ([2001:4830:134:3::10]:47426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHGqU-0001Dg-3p
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHGqT-0008Or-9y
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:21:18 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 30 Oct 2018 00:20:57 +0100
Message-Id: <20181029232100.8454-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] hw/arm/exynos4: Add DMA support for
 SMDKC210 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <linux@roeck-us.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Hi, this series is another intent to salvage previous work from Guenter R=
oeck:
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06302.html

Instead of duplicate the pl330_init() from the xilinx_zynq, I factored it=
 out.

Regards,

Phil.

Guenter Roeck (1):
  arm: exynos4: Add dma support for smdkc210

Philippe Mathieu-Daud=C3=A9 (2):
  hw/arm/xilinx_zynq: Use the ARRAY_SIZE macro
  hw/dma/pl330: Factor out pl330_init() from hw/arm/xilinx_zynq.c

 MAINTAINERS             |  1 +
 hw/arm/exynos4_boards.c | 12 ++++++++++++
 hw/arm/xilinx_zynq.c    | 20 +++-----------------
 hw/dma/pl330.c          |  2 +-
 include/hw/dma/pl330.h  | 41 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 58 insertions(+), 18 deletions(-)
 create mode 100644 include/hw/dma/pl330.h

--=20
2.17.2
