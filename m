Received: from eggs.gnu.org ([2001:4830:134:3::10]:32967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dsyeY-0007ls-PZ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 18:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dsyeV-0005o0-PH
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 18:00:02 -0400
Received: from mail-bl2nam02on0070.outbound.protection.outlook.com
	([104.47.38.70]:19558
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dsyeV-0005nj-JN
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 17:59:59 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 15 Sep 2017 14:56:07 -0700
Message-ID: <134bcf2e2c0bb9160aa822ddfbc46d9bd51c4305.1505512474.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 1/1] target/xtensa: Use the pre-defined
 MEMTXATTRS_UNSPECIFIED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jcmvbkbc@gmail.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

Instead of using the hardcoded (MemTxAttrs){0} for no memory attributes
let's use the already defined MEMTXATTRS_UNSPECIFIED macro instead.

This is technically a change of behaviour as MEMTXATTRS_UNSPECIFIED sets
the unspecified field to 1, but it doesn't look like anything is
checking this field.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---
V2:
 - Update commit message to indicate the change in behaviour

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
