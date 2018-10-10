Received: from eggs.gnu.org ([2001:4830:134:3::10]:34528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gA7iY-00027n-LO
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 02:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gA7iV-0008Eo-Gh
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 02:11:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gA7iV-0007dz-8r
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 02:11:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A139AA989
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 06:11:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EAABA17A63
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 06:11:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 10 Oct 2018 08:11:11 +0200
Message-Id: <20181010061113.6057-4-armbru@redhat.com>
In-Reply-To: <20181010061113.6057-1-armbru@redhat.com>
References: <20181010061113.6057-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] tests: Restore check-qdict unit test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit 0bcc8e5bd8d accidentally dropped check-qdict from the list of
unit tests (again, see commit 4429532b48a).  Put it back, and fix up
the test.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180926122309.30631-1-armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 2 +-
 tests/check-qdict.c    | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 7a3059bf6c..8264af64a8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -40,7 +40,7 @@ SYSEMU_TARGET_LIST := $(subst -softmmu.mak,,$(notdir \
 
 check-unit-y = tests/check-qdict$(EXESUF)
 gcov-files-check-qdict-y = qobject/qdict.c
-check-unit-y = tests/check-block-qdict$(EXESUF)
+check-unit-y += tests/check-block-qdict$(EXESUF)
 gcov-files-check-block-qdict-y = qobject/block-qdict.c
 check-unit-y += tests/test-char$(EXESUF)
 gcov-files-check-qdict-y = chardev/char.c
diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index 86e9fe7dc4..a1e8305066 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -12,6 +12,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qstring.h"
 
 /*
  * Public Interface test-cases
-- 
2.17.1
