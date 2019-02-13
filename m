Received: from eggs.gnu.org ([209.51.188.92]:51927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtqG1-000256-3x
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtq4w-0005zG-LA
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:39:39 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 13 Feb 2019 09:38:11 +0100
Message-Id: <1550047098-1210-19-git-send-email-thuth@redhat.com>
In-Reply-To: <1550047098-1210-1-git-send-email-thuth@redhat.com>
References: <1550047098-1210-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 18/25] hw/arm: Express dependencies of
 canon-a1100 with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, philmd@redhat.com

Add Kconfig dependencies for the DIGIC / canon-a1100 machine.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 2 +-
 hw/arm/Kconfig                  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 6605786..20fcbcb 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -28,12 +28,12 @@ CONFIG_ASPEED_SOC=3Dy
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
index bb385a5..80a3b1f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -31,6 +31,7 @@ config CUBIEBOARD
 config DIGIC
     bool
     select PTIMER
+    select PFLASH_CFI02
=20
 config EXYNOS4
     bool
--=20
1.8.3.1
