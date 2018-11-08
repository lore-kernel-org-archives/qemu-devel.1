Received: from eggs.gnu.org ([2001:4830:134:3::10]:54012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gKjo3-00032T-00
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gKjny-0003U4-MJ
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:53:04 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gKjny-0003Qu-Ao
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:53:02 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  8 Nov 2018 12:52:56 +0000
Message-Id: <20181108125256.30986-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] tcg/tcg-op.h: Add multiple include guard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

The tcg-op.h header was missing the usual guard against multiple
inclusion; add it.

(Spotted by lgtm.com's static analyzer.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tcg/tcg-op.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 7513c1eb7c5..db4e9188f42 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -22,6 +22,9 @@
  * THE SOFTWARE.
  */
 
+#ifndef TCG_TCG_OP_H
+#define TCG_TCG_OP_H
+
 #include "tcg.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
@@ -1267,3 +1270,5 @@ static inline void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a)
 
 #undef PTR
 #undef NAT
+
+#endif /* TCG_TCG_OP_H */
-- 
2.19.1
