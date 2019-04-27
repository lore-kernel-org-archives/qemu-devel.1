Received: from eggs.gnu.org ([209.51.188.92]:39426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKO6i-0006E9-Ey
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKO6h-0000WM-Jz
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:15:12 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sat, 27 Apr 2019 16:14:56 +0200
Message-Id: <20190427141459.19728-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] hw/microblaze: Kconfig cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi Edgar, Peter,

Few fixes while cleaning Kconfig, trying to optimize builds.

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (3):
  hw/Kconfig: Move the generic XLNX_ZYNQMP to the root hw/Kconfig
  hw/intc: Only build the xlnx-iomod-intc device for the MicroBlaze PMU
  hw/dma: Do not build the xlnx_dpdma device for the MicroBlaze machines

 hw/Kconfig            | 3 +++
 hw/dma/Makefile.objs  | 1 -
 hw/intc/Makefile.objs | 2 +-
 hw/timer/Kconfig      | 3 ---
 4 files changed, 4 insertions(+), 5 deletions(-)

--=20
2.20.1
