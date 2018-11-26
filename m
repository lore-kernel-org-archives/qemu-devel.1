Received: from eggs.gnu.org ([2001:4830:134:3::10]:43060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRPw3-0002ZO-Rx
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 18:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRPw0-0000Gk-BB
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 18:04:59 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gRPw0-0000Gc-69
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 18:04:56 -0500
Received: by mail-pg1-x541.google.com with SMTP id s198so6879865pgs.2
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 15:04:56 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-170-180.tukw.qwest.net.
	[97.113.170.180]) by smtp.gmail.com with ESMTPSA id
	o13sm1798703pfk.57.2018.11.26.15.04.53 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 26 Nov 2018 15:04:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 26 Nov 2018 15:04:47 -0800
Message-Id: <20181126230450.672-2-richard.henderson@linaro.org>
In-Reply-To: <20181126230450.672-1-richard.henderson@linaro.org>
References: <20181126230450.672-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/4] tcg: Renumber TCG_CALL_* flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Previously, the low 4 bits were used for TCG_CALL_TYPE_MASK,
which was removed in 6a18ae2d2947532d5c26439548afa0481c4529f9.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 73737dc671..e94f805370 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -464,11 +464,11 @@ typedef TCGv_ptr TCGv_env;
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
