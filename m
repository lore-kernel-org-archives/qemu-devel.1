Received: from eggs.gnu.org ([2001:4830:134:3::10]:40376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6e-0000ht-31
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6d-0007Di-3r
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:08 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:16 -0600
Message-Id: <20180301194245.29854-2-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/30] Include qapi/qmp/qerror.h exactly where
 needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180211093607.27351-2-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi-visit.py   | 2 +-
 block.c                 | 1 -
 block/qcow2.c           | 1 -
 chardev/char-fe.c       | 1 +
 chardev/char.c          | 1 +
 qom/object_interfaces.c | 1 +
 6 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 7e1cfc13f08..bc2b8b581a0 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -371,13 +371,13 @@ fdef.write(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
 #include "%(prefix)sqapi-visit.h"
 ''',
                  prefix=3Dprefix))

 fdecl.write(mcgen('''
 #include "qapi/visitor.h"
-#include "qapi/qmp/qerror.h"
 #include "%(prefix)sqapi-types.h"

 ''',
diff --git a/block.c b/block.c
index 814e5a02da6..628910f6382 100644
--- a/block.c
+++ b/block.c
@@ -32,7 +32,6 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
 #include "sysemu/block-backend.h"
diff --git a/block/qcow2.c b/block/qcow2.c
index 57a517e2bdd..fd79c0ebaaf 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -30,7 +30,6 @@
 #include "block/qcow2.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi-event.h"
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index c611b3fa3e0..e5f870e4d21 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
 #include "qapi-visit.h"
 #include "sysemu/replay.h"

diff --git a/chardev/char.c b/chardev/char.c
index 01d979a1da5..c9a4da55163 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -32,6 +32,7 @@
 #include "qmp-commands.h"
 #include "qapi-visit.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
 #include "sysemu/replay.h"
 #include "qemu/help_option.h"
 #include "qemu/option.h"
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 80d09139be0..43d9aa0946d 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qerror.h"
 #include "qom/object_interfaces.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
--=20
2.14.3
