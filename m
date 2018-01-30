Received: from eggs.gnu.org ([2001:4830:134:3::10]:59522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egT3S-0004A5-2a
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egT3I-0000an-VL
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egT3I-0000aY-PX
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 26D11C0467D5
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:22:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DC6ED7C857
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:22:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 30 Jan 2018 11:22:00 +0100
Message-Id: <20180130102202.28519-17-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-1-armbru@redhat.com>
References: <20180130102202.28519-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 16/18] Drop superfluous includes of
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
-- 
2.13.6
