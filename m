Received: from eggs.gnu.org ([2001:4830:134:3::10]:47373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ecRpi-00005F-V8
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:15:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ecRpe-0001oV-Mw
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:15:30 -0500
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:53082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ecRpe-0001lN-Eo
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:15:26 -0500
Received: from player158.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id CED4F189B25
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 09:15:21 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 19 Jan 2018 09:15:11 +0100
Message-Id: <20180119081511.24010-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ppc/pnv: fix PnvChip redefinition in
 <hw/ppc/pnv_xscom.h>
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

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
---
 include/hw/ppc/pnv_xscom.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index fb1bd5df095a..255b26a5aaf6 100644
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
2.13.6
