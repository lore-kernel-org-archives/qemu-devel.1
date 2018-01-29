Received: from eggs.gnu.org ([2001:4830:134:3::10]:34783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eg07Y-0004SV-2e
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eg07U-0001bl-WA
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:28:36 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 29 Jan 2018 14:28:15 +1100
Message-Id: <20180129032826.16876-2-david@gibson.dropbear.id.au>
In-Reply-To: <20180129032826.16876-1-david@gibson.dropbear.id.au>
References: <20180129032826.16876-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/12] ppc/pnv: fix PnvChip redefinition in
 <hw/ppc/pnv_xscom.h>
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, surajjs@au1.ibm.com, groug@kaod.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

This redefinition generates warnings on some clang compilers and older
gcc4.4.

...include/hw/ppc/pnv_xscom.h:24:24: warning: redefinition of typedef 'Pn=
vChip' is a C11
      feature [-Wtypedef-redefinition]
typedef struct PnvChip PnvChip;
                       ^
...include/hw/ppc/pnv.h:65:3: note: previous definition is here
} PnvChip;
  ^
1 warning generated.
  CC      ppc64-softmmu/hw/ppc/pnv_xscom.o

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/pnv_xscom.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index fb1bd5df09..255b26a5aa 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -21,8 +21,6 @@
=20
 #include "qom/object.h"
=20
-typedef struct PnvChip PnvChip;
-
 typedef struct PnvXScomInterface {
     Object parent;
 } PnvXScomInterface;
--=20
2.14.3
