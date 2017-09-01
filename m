Received: from eggs.gnu.org ([2001:4830:134:3::10]:37893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnrVn-000307-Ic
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnrVj-0003Ks-1N
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:21:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnrVi-0003KI-RM
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:21:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEAAF91FCF
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 19:21:45 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Sep 2017 14:21:41 -0500
Message-Id: <20170901192141.9907-1-eblake@redhat.com>
In-Reply-To: <20170901180340.30009-15-eblake@redhat.com>
References: <20170901180340.30009-15-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 14.5/29] fixup! libqos: Use explicit
 QTestState for fw_cfg operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com

Signed-off-by: Eric Blake <eblake@redhat.com>

---
Fix older gcc duplicate typedef warning [patchew]
---
 tests/libqos/fw_cfg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
index 396dd4ee1e..0353416af0 100644
--- a/tests/libqos/fw_cfg.h
+++ b/tests/libqos/fw_cfg.h
@@ -13,9 +13,9 @@
 #ifndef LIBQOS_FW_CFG_H
 #define LIBQOS_FW_CFG_H

+#include "libqtest.h"

 typedef struct QFWCFG QFWCFG;
-typedef struct QTestState QTestState;

 struct QFWCFG
 {
-- 
2.13.5
