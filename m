Received: from eggs.gnu.org ([2001:4830:134:3::10]:51020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDf-0003SW-DU
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDe-0004y9-Op
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:39 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:42186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDe-0004wb-JG
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:38 -0500
Received: by mail-pl0-x242.google.com with SMTP id bd8so22521047plb.9
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:44 -0800
Message-Id: <20171229063145.29167-38-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 37/38] target/hppa: Increase number of temp regs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

HP-UX 10.20 CD contains "add r0, r0, r27" in a delay slot,
which uses at least 5 temps.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 4430a4bfdb..680a361d29 100644
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
