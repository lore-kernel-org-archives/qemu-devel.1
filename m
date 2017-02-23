Received: from eggs.gnu.org ([2001:4830:134:3::10]:50693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cgyY9-0005mG-IU
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:55:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cgyY4-0006oF-OI
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:55:33 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cgyY4-0006o1-IV
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:55:28 -0500
Received: by mail-pf0-x243.google.com with SMTP id c193so1956793pfb.3
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 10:55:28 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 23 Feb 2017 10:53:34 -0800
Message-Id: <1487876014-23543-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: add two missing headers to core
 import script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Include qemu/osdep.h and qemu-common.h at the beginning of imported
xtensa core source file.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/import_core.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/xtensa/import_core.sh b/target/xtensa/import_core.sh
index 351bee4..cebb6e9 100755
--- a/target/xtensa/import_core.sh
+++ b/target/xtensa/import_core.sh
@@ -25,9 +25,11 @@ tar -xf "$OVERLAY" -O gdb/xtensa-config.c | \
     sed -n '1,/*\//p;/XTREG/,/XTREG_END/p' > "$TARGET"/gdb-config.c
 
 cat <<EOF > "${TARGET}.c"
+#include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
+#include "qemu-common.h"
 #include "qemu/host-utils.h"
 
 #include "core-$NAME/core-isa.h"
-- 
2.1.4
