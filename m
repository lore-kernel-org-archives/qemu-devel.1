Received: from eggs.gnu.org ([208.118.235.92]:50450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtn3-00072L-AP
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtmz-0000n2-D2
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:01 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:39605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtmz-0000l1-76
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:58:57 -0500
Received: by mail-pg1-x532.google.com with SMTP id w6so6819782pgl.6
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:58:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:13 +1100
Message-Id: <20181225205529.10874-27-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 26/42] tcg: Renumber TCG_CALL_* flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Previously, the low 4 bits were used for TCG_CALL_TYPE_MASK,
which was removed in 6a18ae2d2947532d5c26439548afa0481c4529f9.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index ade692fdf5..d9b101e2f8 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -462,11 +462,11 @@ typedef TCGv_ptr TCGv_env;
 /* call flags */
 /* Helper does not read globals (either directly or through an exception). It
    implies TCG_CALL_NO_WRITE_GLOBALS. */
-#define TCG_CALL_NO_READ_GLOBALS    0x0010
+#define TCG_CALL_NO_READ_GLOBALS    0x0001
 /* Helper does not write globals */
-#define TCG_CALL_NO_WRITE_GLOBALS   0x0020
+#define TCG_CALL_NO_WRITE_GLOBALS   0x0002
 /* Helper can be safely suppressed if the return value is not used. */
-#define TCG_CALL_NO_SIDE_EFFECTS    0x0040
+#define TCG_CALL_NO_SIDE_EFFECTS    0x0004
 
 /* convenience version of most used call flags */
 #define TCG_CALL_NO_RWG         TCG_CALL_NO_READ_GLOBALS
-- 
2.17.2
