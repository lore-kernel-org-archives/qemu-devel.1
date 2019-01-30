Received: from eggs.gnu.org ([209.51.188.92]:52122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gosdJ-0001L5-Gf
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:22:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gosdF-0001o1-Q9
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:22:36 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 30 Jan 2019 17:22:25 +0100
Message-Id: <1548865345-2638-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Merge the two e500 sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org

There is currently a "e500" machine section and a "ppce500" device
section in the maintainers file - with some oddities: The wildcard
in the device section also covers the files from the machine section.
And hw/pci-host/ppce500.c is in the device section, while its header
is in the machine section.
This is really quite confusing, and I don't see a reason why we really
need two sections here, so let's simply merge them.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eac36b6..30dbe37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -957,9 +957,10 @@ e500
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
@@ -1316,14 +1317,6 @@ F: hw/i2c/ppc4xx_i2c.c
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
1.8.3.1
