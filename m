Received: from eggs.gnu.org ([209.51.188.92]:57021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLN3Q-0001j2-V2
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLN3N-0006RP-8e
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:19:51 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 30 Apr 2019 09:14:04 +0200
Message-Id: <20190430071405.16714-30-thuth@redhat.com>
In-Reply-To: <20190430071405.16714-1-thuth@redhat.com>
References: <20190430071405.16714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 29/30] hw/arm: Express dependencies of the
 musca machines with Kconfig
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

Dependencies have been determined with trial-and-error and by
looking at the musca.c source file.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 9609caef87..af8cffde9c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -75,6 +75,12 @@ config MAINSTONE
     select PFLASH_CFI01
     select SMC91C111
=20
+config MUSCA
+    bool
+    select ARMSSE
+    select PL011
+    select PL031
+
 config MUSICPAL
     bool
     select BITBANG_I2C
@@ -427,6 +433,3 @@ config ARMSSE_CPUID
=20
 config ARMSSE_MHU
     bool
-
-config MUSCA
-    bool
--=20
2.21.0
