Received: from eggs.gnu.org ([2001:4830:134:3::10]:59159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eb3oT-0006g1-Rp
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:24:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eb3oP-0006HH-Tr
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:24:29 -0500
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:40748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eb3oP-0006GO-Mt
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:24:25 -0500
Received: from player714.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id D540095C39
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 13:24:23 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 15 Jan 2018 13:24:17 +0100
Message-Id: <20180115122417.15871-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tests/boot-serial-test: fix powernv support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Recent commit introduced the firmware image skiboot 5.9 which
has a different first line ouput.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 tests/boot-serial-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index dd3828c49b38..0a848a1eeb6f 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -41,7 +41,7 @@ static testdef_t tests[] =3D {
     { "ppc64", "ppce500", "", "U-Boot" },
     { "ppc64", "prep", "", "Open Hack'Ware BIOS" },
     { "ppc64", "pseries", "", "Open Firmware" },
-    { "ppc64", "powernv", "-cpu POWER8", "SkiBoot" },
+    { "ppc64", "powernv", "-cpu POWER8", "OPAL" },
     { "i386", "isapc", "-cpu qemu32 -device sga", "SGABIOS" },
     { "i386", "pc", "-device sga", "SGABIOS" },
     { "i386", "q35", "-device sga", "SGABIOS" },
--=20
2.13.6
