Received: from eggs.gnu.org ([2001:4830:134:3::10]:46514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQcIh-00041U-Pd
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQcIh-0000oV-1k
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:32:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33752 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQcIg-0000oD-Tc
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:32:46 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  6 Jun 2018 18:32:33 +0100
Message-Id: <20180606173233.28080-4-berrange@redhat.com>
In-Reply-To: <20180606173233.28080-1-berrange@redhat.com>
References: <20180606173233.28080-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/3] util: remove redundant include of glib.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, Olaf Hering <olaf@aepfle.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

Code must only ever include glib.h indirectly via the glib-compat.h
header file, because we will need some macros set before glib.h is
pulled in. Adding extra includes of glib.h will (soon) cause compile
failures such as:

In file included from /home/berrange/src/virt/qemu/include/qemu/osdep.h:1=
07,
                 from /home/berrange/src/virt/qemu/include/qemu/iova-tree=
.h:26,
                 from util/iova-tree.c:13:
/home/berrange/src/virt/qemu/include/glib-compat.h:22: error: "GLIB_VERSI=
ON_MIN_REQUIRED" redefined [-Werror]
 #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_40

In file included from /usr/include/glib-2.0/glib/gtypes.h:34,
                 from /usr/include/glib-2.0/glib/galloca.h:32,
                 from /usr/include/glib-2.0/glib.h:30,
                 from util/iova-tree.c:12:
/usr/include/glib-2.0/glib/gversionmacros.h:237: note: this is the locati=
on of the previous definition
 # define GLIB_VERSION_MIN_REQUIRED      (GLIB_VERSION_CUR_STABLE)

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 util/iova-tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/util/iova-tree.c b/util/iova-tree.c
index 2d9cebfc89..d39cd8bb29 100644
--- a/util/iova-tree.c
+++ b/util/iova-tree.c
@@ -9,7 +9,6 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  */
=20
-#include <glib.h>
 #include "qemu/iova-tree.h"
=20
 struct IOVATree {
--=20
2.17.0
