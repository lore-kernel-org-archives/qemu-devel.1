Received: from eggs.gnu.org ([2001:4830:134:3::10]:48643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6xVE-0007bz-Hz
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6xVB-0007ZY-AM
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:03:54 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:39900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d6xVB-0007V3-4e
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:03:53 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sat,  6 May 2017 13:03:33 +0200
Message-Id: <20170506110333.11000-2-aurelien@aurel32.net>
In-Reply-To: <20170506110333.11000-1-aurelien@aurel32.net>
References: <20170506110333.11000-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 1/1] tcg/mips: fix field extraction opcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

The "msb" argument should correspond to (len - 1).

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 tcg/mips/tcg-target.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 01ac7b2c81..2a7e1c7f5b 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -2093,11 +2093,11 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
                          args[3] + args[4] - 1, args[3]);
         break;
     case INDEX_op_extract_i32:
-        tcg_out_opc_bf(s, OPC_EXT, a0, a1, a2 + args[3] - 1, a2);
+        tcg_out_opc_bf(s, OPC_EXT, a0, a1, args[3] - 1, a2);
         break;
     case INDEX_op_extract_i64:
         tcg_out_opc_bf64(s, OPC_DEXT, OPC_DEXTM, OPC_DEXTU, a0, a1,
-                         a2 + args[3] - 1, a2);
+                         args[3] - 1, a2);
         break;
 
     case INDEX_op_brcond_i32:
-- 
2.11.0
