Received: from eggs.gnu.org ([2001:4830:134:3::10]:45697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQM-0007rj-Vi
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQL-0001MP-6O
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:25:58 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 17 Jan 2018 13:25:18 +1100
Message-Id: <20180117022525.31767-16-david@gibson.dropbear.id.au>
In-Reply-To: <20180117022525.31767-1-david@gibson.dropbear.id.au>
References: <20180117022525.31767-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/22] tests/boot-serial-test: fix powernv
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Recent commit introduced the firmware image skiboot 5.9 which
has a different first line ouput.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/boot-serial-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 663b78b950..418c5b92dc 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -72,7 +72,7 @@ static testdef_t tests[] =3D {
     { "ppc64", "ppce500", "", "U-Boot" },
     { "ppc64", "prep", "", "Open Hack'Ware BIOS" },
     { "ppc64", "pseries", "", "Open Firmware" },
-    { "ppc64", "powernv", "-cpu POWER8", "SkiBoot" },
+    { "ppc64", "powernv", "-cpu POWER8", "OPAL" },
     { "i386", "isapc", "-cpu qemu32 -device sga", "SGABIOS" },
     { "i386", "pc", "-device sga", "SGABIOS" },
     { "i386", "q35", "-device sga", "SGABIOS" },
--=20
2.14.3
