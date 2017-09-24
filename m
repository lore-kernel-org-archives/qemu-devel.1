Received: from eggs.gnu.org ([2001:4830:134:3::10]:48467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEf7-0003BS-8B
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEf2-0004ln-Qj
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:42:05 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 25 Sep 2017 00:22:42 +0300
Message-Id: <596656f66f36f8859b891c9e72356d0dd0f4d242.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 24/31] target/xtensa: Use the pre-defined
 MEMTXATTRS_UNSPECIFIED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Alistair Francis <alistair.francis@xilinx.com>

Instead of using the hardcoded (MemTxAttrs){0} for no memory attributes
let's use the already defined MEMTXATTRS_UNSPECIFIED macro instead.

This is technically a change of behaviour as MEMTXATTRS_UNSPECIFIED sets
the unspecified field to 1, but it doesn't look like anything is
checking this field.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/xtensa/op_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 519fbeddd6..3d990c0caa 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -1025,11 +1025,11 @@ void HELPER(ule_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
 uint32_t HELPER(rer)(CPUXtensaState *env, uint32_t addr)
 {
     return address_space_ldl(env->address_space_er, addr,
-                             (MemTxAttrs){0}, NULL);
+                             MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 void HELPER(wer)(CPUXtensaState *env, uint32_t data, uint32_t addr)
 {
     address_space_stl(env->address_space_er, addr, data,
-                      (MemTxAttrs){0}, NULL);
+                      MEMTXATTRS_UNSPECIFIED, NULL);
 }
-- 
2.11.0
