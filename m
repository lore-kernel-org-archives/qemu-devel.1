Received: from eggs.gnu.org ([2001:4830:134:3::10]:59558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejP1M-0001OK-BQ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejP1K-0004jo-6D
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50752 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ejP1K-0004j4-2B
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94CF78A9E8
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 12:40:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 714EFAE7D1
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 12:40:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  7 Feb 2018 13:40:07 +0100
Message-Id: <20180207124009.12376-19-armbru@redhat.com>
In-Reply-To: <20180207124009.12376-1-armbru@redhat.com>
References: <20180207124009.12376-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/20] Drop superfluous includes of
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

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180201111846.21846-18-armbru@redhat.com>
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
