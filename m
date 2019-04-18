Received: from eggs.gnu.org ([209.51.188.92]:51218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDnw-0001Gw-Fc
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDnv-0002d5-DC
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHDnv-0002bw-78
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2FCC28553A
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:38:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0053F60852
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:38:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 18 Apr 2019 22:38:34 +0200
Message-Id: <20190418203840.10528-4-armbru@redhat.com>
In-Reply-To: <20190418203840.10528-1-armbru@redhat.com>
References: <20190418203840.10528-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-4.1 3/9] authz: Normalize #include
 "authz/trace.h" to "trace.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Include the generated trace.h the same way as we do everywhere else.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190315145123.28030-3-armbru@redhat.com>
Acked-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 authz/base.c     | 2 +-
 authz/list.c     | 2 +-
 authz/listfile.c | 2 +-
 authz/pamacct.c  | 2 +-
 authz/simple.c   | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/authz/base.c b/authz/base.c
index 110dfa4195..baf39fff25 100644
--- a/authz/base.c
+++ b/authz/base.c
@@ -20,7 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "authz/base.h"
-#include "authz/trace.h"
+#include "trace.h"
=20
 bool qauthz_is_allowed(QAuthZ *authz,
                        const char *identity,
diff --git a/authz/list.c b/authz/list.c
index dc6b0fec13..831da936fe 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -20,7 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "authz/list.h"
-#include "authz/trace.h"
+#include "trace.h"
 #include "qom/object_interfaces.h"
 #include "qapi/qapi-visit-authz.h"
=20
diff --git a/authz/listfile.c b/authz/listfile.c
index bc2b58ef6d..d74bbd1048 100644
--- a/authz/listfile.c
+++ b/authz/listfile.c
@@ -20,7 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "authz/listfile.h"
-#include "authz/trace.h"
+#include "trace.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/sockets.h"
diff --git a/authz/pamacct.c b/authz/pamacct.c
index 5038358cdc..7539867923 100644
--- a/authz/pamacct.c
+++ b/authz/pamacct.c
@@ -20,7 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "authz/pamacct.h"
-#include "authz/trace.h"
+#include "trace.h"
 #include "qom/object_interfaces.h"
=20
 #include <security/pam_appl.h>
diff --git a/authz/simple.c b/authz/simple.c
index 8ab718803e..c409ce7efc 100644
--- a/authz/simple.c
+++ b/authz/simple.c
@@ -20,7 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "authz/simple.h"
-#include "authz/trace.h"
+#include "trace.h"
 #include "qom/object_interfaces.h"
=20
 static bool qauthz_simple_is_allowed(QAuthZ *authz,
--=20
2.17.2
