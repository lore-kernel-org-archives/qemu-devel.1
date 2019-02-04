Received: from eggs.gnu.org ([209.51.188.92]:38528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8m-0000gQ-NK
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8g-0007jT-Og
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:08 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:01:09 +1100
Message-Id: <20190204090124.26191-23-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/37] MAINTAINERS: Merge the two e500 sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

There is currently a "e500" machine section and a "ppce500" device
section in the maintainers file - with some oddities: The wildcard
in the device section also covers the files from the machine section.
And hw/pci-host/ppce500.c is in the device section, while its header
is in the machine section.
This is really quite confusing, and I don't see a reason why we really
need two sections here, so let's simply merge them.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 MAINTAINERS | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d891e79faa..646e289df4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -960,9 +960,10 @@ e500
 M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
-F: hw/ppc/e500.[hc]
-F: hw/ppc/e500plat.c
+F: hw/ppc/e500*
 F: hw/gpio/mpc8xxx.c
+F: hw/net/fsl_etsec/
+F: hw/pci-host/ppce500.c
 F: include/hw/ppc/ppc_e500.h
 F: include/hw/pci-host/ppce500.h
 F: pc-bios/u-boot.e500
@@ -1319,14 +1320,6 @@ F: hw/i2c/ppc4xx_i2c.c
 F: include/hw/ppc/ppc4xx.h
 F: include/hw/i2c/ppc4xx_i2c.h
=20
-ppce500
-M: David Gibson <david@gibson.dropbear.id.au>
-L: qemu-ppc@nongnu.org
-S: Odd Fixes
-F: hw/ppc/e500*
-F: hw/pci-host/ppce500.c
-F: hw/net/fsl_etsec/
-
 Character devices
 M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
 R: Paolo Bonzini <pbonzini@redhat.com>
--=20
2.20.1
