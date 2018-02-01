Received: from eggs.gnu.org ([2001:4830:134:3::10]:37950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehCtK-0006Kr-RI
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:19:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehCtI-0004zb-Ea
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:18:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehCtI-0004yv-9w
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:18:52 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  1 Feb 2018 12:18:43 +0100
Message-Id: <20180201111846.21846-17-armbru@redhat.com>
In-Reply-To: <20180201111846.21846-1-armbru@redhat.com>
References: <20180201111846.21846-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 16/19] Include qapi/qmp/qnull.h exactly
 where needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, eblake@redhat.com, f4bug@amsat.org

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/ppc/translate.c      | 1 -
 target/ppc/translate_init.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index eeaad9e91f..4132f67bb1 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -24,7 +24,6 @@
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg-op.h"
-#include "qapi/qmp/qnull.h"
 #include "qemu/host-utils.h"
 #include "exec/cpu_ldst.h"
=20
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 2913af912a..434c42731d 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -30,6 +30,7 @@
 #include "mmu-hash64.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qnull.h"
 #include "qapi/visitor.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/ppc.h"
--=20
2.13.6
