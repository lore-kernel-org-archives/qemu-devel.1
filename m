Received: from eggs.gnu.org ([2001:4830:134:3::10]:58653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0i-0005pZ-0m
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0g-0006F5-94
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:31 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:40818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe0g-0006Di-3a
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:30 -0500
Received: by mail-oi1-x236.google.com with SMTP id t204so3457319oie.7
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:18:53 -0600
Message-Id: <20181214031923.29527-4-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/32] tcg/i386: Move TCG_REG_CALL_STACK from
 define to enum
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
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
