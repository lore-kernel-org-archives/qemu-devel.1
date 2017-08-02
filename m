Received: from eggs.gnu.org ([2001:4830:134:3::10]:51685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dd03N-0000IS-GA
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 16:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dd03M-0006GA-Iv
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 16:15:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dd03M-0006EZ-D9
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 16:15:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A7EC85363
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 20:15:35 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
Date: Wed,  2 Aug 2017 16:15:07 -0400
Message-Id: <20170802201512.29142-2-crosa@redhat.com>
In-Reply-To: <20170802201512.29142-1-crosa@redhat.com>
References: <20170802201512.29142-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 1/6] tests/tcg/test_path.c: include
 utils/bufferiszero.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>

Which contains one specific function used by iov.c.

Without this, "make -C tests/tcg test_path" (and consequently
"make -C tests/tcg" or simply "make test") fails quite early.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/tcg/test_path.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/test_path.c b/tests/tcg/test_path.c
index 1c29bce..74dbdaf 100644
--- a/tests/tcg/test_path.c
+++ b/tests/tcg/test_path.c
@@ -3,6 +3,7 @@
 #include "util/cutils.c"
 #include "util/hexdump.c"
 #include "util/iov.c"
+#include "util/bufferiszero.c"
 #include "util/path.c"
 #include "util/qemu-timer-common.c"
 #include <stdarg.h>
-- 
2.9.4
