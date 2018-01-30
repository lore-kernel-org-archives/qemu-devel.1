Received: from eggs.gnu.org ([2001:4830:134:3::10]:59423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egT3L-000472-Fr
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egT3J-0000at-0n
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egT3I-0000aa-RZ
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:08 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A90219D385
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:22:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E2CDA5C266
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:22:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 30 Jan 2018 11:21:59 +0100
Message-Id: <20180130102202.28519-16-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-1-armbru@redhat.com>
References: <20180130102202.28519-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 15/18] Include qapi/qmp/qnull.h exactly where
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
-- 
2.13.6
