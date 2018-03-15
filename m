Received: from eggs.gnu.org ([2001:4830:134:3::10]:40596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ewKMG-00073S-KQ
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 00:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ewKMF-00041Z-Ft
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 00:19:16 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 15 Mar 2018 15:18:56 +1100
Message-Id: <20180315041903.10046-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180315041903.10046-1-david@gibson.dropbear.id.au>
References: <20180315041903.10046-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/9] tests/boot-serial: Check the 40p machine,
 too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, lvivier@redhat.com, surajjs@au1.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

The "40p" machine is using the Open Hack'Ware BIOS, just like the "prep"
machine, so we can test it accordingly with the boot-serial tester, too.
While we're at it, also change the strings that we are using for the
"prep" machine, so that this test now also checks some CLI parameters.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/boot-serial-test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index ece25c694f..5b24cd26c1 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -75,11 +75,13 @@ typedef struct testdef {
 static testdef_t tests[] =3D {
     { "alpha", "clipper", "", "PCI:" },
     { "ppc", "ppce500", "", "U-Boot" },
-    { "ppc", "prep", "", "Open Hack'Ware BIOS" },
+    { "ppc", "prep", "-m 96", "Memory size: 96 MB" },
+    { "ppc", "40p", "-boot d", "Booting from device d" },
     { "ppc", "g3beige", "", "PowerPC,750" },
     { "ppc", "mac99", "", "PowerPC,G4" },
     { "ppc64", "ppce500", "", "U-Boot" },
-    { "ppc64", "prep", "", "Open Hack'Ware BIOS" },
+    { "ppc64", "prep", "-boot e", "Booting from device e" },
+    { "ppc64", "40p", "-m 192", "Memory size: 192 MB" },
     { "ppc64", "mac99", "", "PowerPC,970FX" },
     { "ppc64", "pseries", "", "Open Firmware" },
     { "ppc64", "powernv", "-cpu POWER8", "OPAL" },
--=20
2.14.3
