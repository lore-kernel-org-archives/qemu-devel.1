Received: from eggs.gnu.org ([2001:4830:134:3::10]:37983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehCtL-0006Lf-MJ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehCtI-0004zi-HX
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:18:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehCtI-0004yw-BT
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:18:52 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  1 Feb 2018 12:18:44 +0100
Message-Id: <20180201111846.21846-18-armbru@redhat.com>
In-Reply-To: <20180201111846.21846-1-armbru@redhat.com>
References: <20180201111846.21846-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 17/19] Drop superfluous includes of
 qapi/qmp/dispatch.h
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
 monitor.c                 | 1 -
 qga/main.c                | 1 -
 tests/test-qmp-commands.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/monitor.c b/monitor.c
index 02d9dd8708..6f70c8db9a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -79,7 +79,6 @@
 #include "sysemu/qtest.h"
 #include "sysemu/cpus.h"
 #include "qemu/cutils.h"
-#include "qapi/qmp/dispatch.h"
=20
 #if defined(TARGET_S390X)
 #include "hw/s390x/storage-keys.h"
diff --git a/qga/main.c b/qga/main.c
index 64e0776bf2..30aa7f92f7 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -27,7 +27,6 @@
 #include "qga-qmp-commands.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/error.h"
-#include "qapi/qmp/dispatch.h"
 #include "qga/channel.h"
 #include "qemu/bswap.h"
 #include "qemu/help_option.h"
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index b5a3d88775..24660d0868 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -5,7 +5,6 @@
 #include "qapi/qmp/qstring.h"
 #include "test-qmp-commands.h"
 #include "qapi/error.h"
-#include "qapi/qmp/dispatch.h"
 #include "qemu/module.h"
 #include "qapi/qobject-input-visitor.h"
 #include "tests/test-qapi-types.h"
--=20
2.13.6
