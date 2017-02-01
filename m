Received: from eggs.gnu.org ([2001:4830:134:3::10]:53177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cYtsB-000611-Lo
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cYts8-0005dg-Vs
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:18:51 -0500
Received: from bran.ispras.ru ([83.149.199.196]:46122 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cYts8-0005d3-Oy
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:18:48 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Wed,  1 Feb 2017 15:18:17 +0300
Message-Id: <1485951502-28774-16-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1485951502-28774-1-git-send-email-batuzovk@ispras.ru>
References: <1485951502-28774-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH v2 15/20] tcg: introduce new TCGMemOp - MO_128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kirill Batuzov <batuzovk@ispras.ru>

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 tcg/tcg.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 5e0c6da..63a83f9 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -306,11 +306,12 @@ typedef enum TCGMemOp {
     MO_16    = 1,
     MO_32    = 2,
     MO_64    = 3,
-    MO_SIZE  = 3,   /* Mask for the above.  */
+    MO_128   = 4,
+    MO_SIZE  = 7,   /* Mask for the above.  */
 
-    MO_SIGN  = 4,   /* Sign-extended, otherwise zero-extended.  */
+    MO_SIGN  = 8,   /* Sign-extended, otherwise zero-extended.  */
 
-    MO_BSWAP = 8,   /* Host reverse endian.  */
+    MO_BSWAP = 16,   /* Host reverse endian.  */
 #ifdef HOST_WORDS_BIGENDIAN
     MO_LE    = MO_BSWAP,
     MO_BE    = 0,
@@ -342,7 +343,7 @@ typedef enum TCGMemOp {
      * - an alignment to a specified size, which may be more or less than
      *   the access size (MO_ALIGN_x where 'x' is a size in bytes);
      */
-    MO_ASHIFT = 4,
+    MO_ASHIFT = 5,
     MO_AMASK = 7 << MO_ASHIFT,
 #ifdef ALIGNED_ONLY
     MO_ALIGN = 0,
-- 
2.1.4
