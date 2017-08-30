Received: from eggs.gnu.org ([2001:4830:134:3::10]:52794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dn7Na-0001LH-Or
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dn7NX-0001O6-Ha
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:06:18 -0400
Received: from mail-dm3nam03on0066.outbound.protection.outlook.com
	([104.47.41.66]:27376
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dn7NX-0001Ml-8B
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:06:15 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 30 Aug 2017 11:02:34 -0700
Message-ID: <b35860a5f4377883fd2c2942bdb524d279a91de9.1504116039.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 1/1] target/xtensa: Use the pre-defined
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

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
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
