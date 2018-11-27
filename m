Received: from eggs.gnu.org ([2001:4830:134:3::10]:46842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZfq-0002jm-Qi
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZfn-0004VB-Ma
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gRZfn-0004Un-HZ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:51 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 13:27:39 +0400
Message-Id: <20181127092801.21777-7-marcandre.lureau@redhat.com>
In-Reply-To: <20181127092801.21777-1-marcandre.lureau@redhat.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v4 06/28] MAINTAINERS: Assign some more
 files in the hw/arm/ directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Thomas Huth <thuth@redhat.com>

I apparently missed some more files and even a complete machine (the
"imx25-pdk") in my previous patch... but now we should hopefully have
a completely coverage for all available ARM boards.

Fixes: 95a5db3ae5698b49c63144610ad02913e780c828
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 1542782568-20059-1-git-send-email-thuth@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4a7e453c0..43d0d9d578 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -535,6 +535,17 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/gumstix.c
=20
+i.MX25 PDK
+M: Peter Maydell <peter.maydell@linaro.org>
+R: Jean-Christophe Dubois <jcd@tribudubois.net>
+L: qemu-arm@nongnu.org
+S: Odd Fixes
+F: hw/arm/fsl-imx25.c
+F: hw/arm/imx25_pdk.c
+F: hw/misc/imx25_ccm.c
+F: include/hw/arm/fsl-imx25.h
+F: include/hw/misc/imx25_ccm.h
+
 i.MX31 (kzm)
 M: Peter Chubb <peter.chubb@nicta.com.au>
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -617,6 +628,7 @@ R: Andrew Baumann <Andrew.Baumann@microsoft.com>
 R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+F: hw/arm/raspi.c
 F: hw/arm/raspi_platform.h
 F: hw/*/bcm283*
 F: include/hw/arm/raspi*
@@ -641,8 +653,12 @@ F: hw/arm/spitz.c
 F: hw/arm/tosa.c
 F: hw/arm/z2.c
 F: hw/*/pxa2xx*
+F: hw/display/tc6393xb.c
+F: hw/gpio/max7310.c
+F: hw/gpio/zaurus.c
 F: hw/misc/mst_fpga.c
 F: include/hw/arm/pxa.h
+F: include/hw/arm/sharpsl.h
=20
 SABRELITE / i.MX6
 M: Peter Maydell <peter.maydell@linaro.org>
--=20
2.20.0.rc1
