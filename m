Received: from eggs.gnu.org ([2001:4830:134:3::10]:43765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCif-0007yQ-Qt
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCia-00036Z-SU
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:09 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCia-00035e-Mh
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:04 -0500
Received: by mail-wr1-x442.google.com with SMTP id v13so9116944wrw.5
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:23 +0100
Message-Id: <20181123144558.5048-3-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 02/37] tcg/i386: Move
 TCG_REG_CALL_STACK from define to enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 7488c3d869..2441658865 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -86,10 +86,10 @@ typedef enum {
     TCG_REG_RDI = TCG_REG_EDI,
 
     TCG_AREG0 = TCG_REG_EBP,
+    TCG_REG_CALL_STACK = TCG_REG_ESP
 } TCGReg;
 
 /* used for function call generation */
-#define TCG_REG_CALL_STACK TCG_REG_ESP 
 #define TCG_TARGET_STACK_ALIGN 16
 #if defined(_WIN64)
 #define TCG_TARGET_CALL_STACK_OFFSET 32
-- 
2.17.2
