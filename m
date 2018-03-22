Received: from eggs.gnu.org ([2001:4830:134:3::10]:51128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ez4fB-0001gs-W2
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ez4fB-0002km-7p
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:10:09 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:45638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ez4fB-0002iy-0q
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:10:09 -0400
Received: by mail-lf0-x243.google.com with SMTP id l4-v6so10221303lfg.12
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 11:10:08 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 22 Mar 2018 11:09:40 -0700
Message-Id: <20180322180940.8253-4-jcmvbkbc@gmail.com>
In-Reply-To: <20180322180940.8253-1-jcmvbkbc@gmail.com>
References: <20180322180940.8253-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 3/3] target/xtensa/import_core.sh: fix #include
 <xtensa-isa.h>
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Change #include <xtensa-isa.h> to #include "xtensa-isa.h" in imported
files to make references to local files consistent.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/import_core.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/xtensa/import_core.sh b/target/xtensa/import_core.sh
index 58a42987d853..af6c6104792d 100755
--- a/target/xtensa/import_core.sh
+++ b/target/xtensa/import_core.sh
@@ -33,6 +33,7 @@ tar -xf "$OVERLAY" -O binutils/xtensa-modules.c | \
         -e '/^uint32 \*bypass_entry(int i)/,/}/d' \
         -e '/^#include "ansidecl.h"/d' \
         -e '/^Slot_[a-zA-Z0-9_]\+_decode (const xtensa_insnbuf insn)/,/^}/s/^  return 0;$/  return XTENSA_UNDEFINED;/' \
+        -e 's/#include <xtensa-isa.h>/#include "xtensa-isa.h"/' \
     > "$TARGET"/xtensa-modules.inc.c
 
 cat <<EOF > "${TARGET}.c"
-- 
2.11.0
