Received: from eggs.gnu.org ([209.51.188.92]:60028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0Z-0005U9-Jq
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0Y-0004St-6k
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:51 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:07 +1000
Message-Id: <20190426060627.18153-17-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/36] target/ppc: Style fixes for
 mfrom_table.inc.c & mfrom_table_gen.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/mfrom_table.inc.c | 3 +--
 target/ppc/mfrom_table_gen.c | 8 +++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/ppc/mfrom_table.inc.c b/target/ppc/mfrom_table.inc.c
index 6a1fa375c9..1653b974a4 100644
--- a/target/ppc/mfrom_table.inc.c
+++ b/target/ppc/mfrom_table.inc.c
@@ -1,5 +1,4 @@
-static const uint8_t mfrom_ROM_table[602] =3D
-{
+static const uint8_t mfrom_ROM_table[602] =3D {
      77,  77,  76,  76,  75,  75,  74,  74,
      73,  73,  72,  72,  71,  71,  70,  70,
      69,  69,  68,  68,  68,  67,  67,  66,
diff --git a/target/ppc/mfrom_table_gen.c b/target/ppc/mfrom_table_gen.c
index 631791808e..f96c4268ba 100644
--- a/target/ppc/mfrom_table_gen.c
+++ b/target/ppc/mfrom_table_gen.c
@@ -2,7 +2,7 @@
 #include "qemu/osdep.h"
 #include <math.h>
=20
-int main (void)
+int main(void)
 {
     double d;
     uint8_t n;
@@ -10,7 +10,8 @@ int main (void)
=20
     printf("static const uint8_t mfrom_ROM_table[602] =3D\n{\n    ");
     for (i =3D 0; i < 602; i++) {
-        /* Extremely decomposed:
+        /*
+         * Extremely decomposed:
          *                    -T0 / 256
          * T0 =3D 256 * log10(10          + 1.0) + 0.5
          */
@@ -23,8 +24,9 @@ int main (void)
         d +=3D 0.5;
         n =3D d;
         printf("%3d, ", n);
-        if ((i & 7) =3D=3D 7)
+        if ((i & 7) =3D=3D 7) {
             printf("\n    ");
+        }
     }
     printf("\n};\n");
=20
--=20
2.20.1
