Received: from eggs.gnu.org ([2001:4830:134:3::10]:60386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gVQ6n-0002vW-EQ
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:04:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gVQ6m-0002xI-Lp
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:04:37 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gVQ6m-0002tX-DQ
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:04:36 -0500
Received: by mail-lj1-x244.google.com with SMTP id x85-v6so4997328ljb.2
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 16:04:36 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri,  7 Dec 2018 16:04:23 -0800
Message-Id: <20181208000423.2807-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa/import_core.sh: don't add
 duplicate 'static'
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

xtensa-modules.c produced by recent Tensilica tools have
Opcode_*_encode_fns arrays defined as static. Don't add extra 'static'
in front of them when importing.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/import_core.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/import_core.sh b/target/xtensa/import_core.sh
index 039406bf28fa..e4a2e39f6353 100755
--- a/target/xtensa/import_core.sh
+++ b/target/xtensa/import_core.sh
@@ -27,7 +27,7 @@ tar -xf "$OVERLAY" -O gdb/xtensa-config.c | \
 # Fix up known issues in the xtensa-modules.c
 #
 tar -xf "$OVERLAY" -O binutils/xtensa-modules.c | \
-    sed -e 's/\(xtensa_opcode_encode_fn.*\[\] =\)/static \1/' \
+    sed -e 's/^\(xtensa_opcode_encode_fn.*\[\] =\)/static \1/' \
         -e '/^int num_bypass_groups()/,/}/d' \
         -e '/^int num_bypass_group_chunks()/,/}/d' \
         -e '/^uint32 \*bypass_entry(int i)/,/}/d' \
-- 
2.11.0
