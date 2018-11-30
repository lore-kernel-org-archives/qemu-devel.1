Received: from eggs.gnu.org ([2001:4830:134:3::10]:52487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSqi5-0007qk-5h
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSqi3-0006Kl-PC
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:29 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSqi3-0006HN-II
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:27 -0500
Received: by mail-pg1-x543.google.com with SMTP id w6so3050204pgl.6
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 13:52:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 30 Nov 2018 13:52:07 -0800
Message-Id: <20181130215221.20554-3-richard.henderson@linaro.org>
In-Reply-To: <20181130215221.20554-1-richard.henderson@linaro.org>
References: <20181130215221.20554-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 02/16] tcg/i386: Move TCG_REG_CALL_STACK
 from define to enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

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
