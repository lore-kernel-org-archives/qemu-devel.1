Received: from eggs.gnu.org ([209.51.188.92]:56326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLN20-0000UK-6q
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLN1z-0005dQ-DX
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:18:24 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 30 Apr 2019 09:13:57 +0200
Message-Id: <20190430071405.16714-23-thuth@redhat.com>
In-Reply-To: <20190430071405.16714-1-thuth@redhat.com>
References: <20190430071405.16714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 22/30] hw/arm: Express dependencies of
 canon-a1100 with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: Beniamino Galvani <b.galvani@gmail.com>, Rob Herring <robh@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Cedric Le Goater <clg@kaod.org>, Jan Kiszka <jan.kiszka@web.de>, qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, John Snow <jsnow@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Joel Stanley <joel@jms.id.au>, Peter Chubb <peter.chubb@nicta.com.au>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Antony Pavlov <antonynpavlov@gmail.com>, qemu-block@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude <f4bug@amsat.org>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Andrew Jeffery <andrew@aj.id.au>, Andrey Smirnov <andrew.smirnov@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

Add Kconfig dependencies for the DIGIC / canon-a1100 machine.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 2 +-
 hw/arm/Kconfig                  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 22bff20b32..76508e3910 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -32,12 +32,12 @@ CONFIG_ASPEED_SOC=3Dy
 CONFIG_NETDUINO2=3Dy
 CONFIG_MPS2=3Dy
 CONFIG_RASPI=3Dy
+CONFIG_DIGIC=3Dy
=20
 CONFIG_VGA=3Dy
 CONFIG_SSI_M25P80=3Dy
 CONFIG_IMX_FEC=3Dy
=20
-CONFIG_DIGIC=3Dy
 CONFIG_NRF51_SOC=3Dy
=20
 CONFIG_FSL_IMX6=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 40be78303c..abf2af0967 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -32,6 +32,7 @@ config CUBIEBOARD
 config DIGIC
     bool
     select PTIMER
+    select PFLASH_CFI02
=20
 config EXYNOS4
     bool
--=20
2.21.0
