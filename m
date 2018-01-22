Received: from eggs.gnu.org ([2001:4830:134:3::10]:60462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0r-0005y0-Ec
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0q-0006oy-S2
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:13 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edT0q-0006og-Lw
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:12 -0500
Received: by mail-pg0-x244.google.com with SMTP id r19so6096368pgn.1
	for <qemu-devel@nongnu.org>; Sun, 21 Jan 2018 19:43:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 21 Jan 2018 19:42:09 -0800
Message-Id: <20180122034217.19593-36-richard.henderson@linaro.org>
In-Reply-To: <20180122034217.19593-1-richard.henderson@linaro.org>
References: <20180122034217.19593-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 35/43] target/hppa: Increase number of temp regs
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

HP-UX 10.20 CD contains "add r0, r0, r27" in a delay slot,
which uses at least 5 temps.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c064c9d17b..6cf4e37062 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -273,7 +273,7 @@ typedef struct DisasContext {
     TCGv_reg iaoq_n_var;
 
     int ntempr, ntempl;
-    TCGv_reg tempr[4];
+    TCGv_reg tempr[8];
     TCGv_tl  templ[4];
 
     DisasCond null_cond;
-- 
2.14.3
