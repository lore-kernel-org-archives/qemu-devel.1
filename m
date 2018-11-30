Received: from eggs.gnu.org ([2001:4830:134:3::10]:52639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSqiG-00084J-TV
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSqiG-0007JR-19
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:40 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:32815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSqiF-0007FD-S4
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:39 -0500
Received: by mail-pf1-x432.google.com with SMTP id c123so3445760pfb.0
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 13:52:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 30 Nov 2018 13:52:17 -0800
Message-Id: <20181130215221.20554-13-richard.henderson@linaro.org>
In-Reply-To: <20181130215221.20554-1-richard.henderson@linaro.org>
References: <20181130215221.20554-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 12/16] tcg/i386: Return false on failure
 from patch_reloc
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 5c88f1f36b..28192f4608 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -175,7 +175,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     case R_386_PC32:
         value -= (uintptr_t)code_ptr;
         if (value != (int32_t)value) {
-            tcg_abort();
+            return false;
         }
         /* FALLTHRU */
     case R_386_32:
@@ -184,7 +184,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     case R_386_PC8:
         value -= (uintptr_t)code_ptr;
         if (value != (int8_t)value) {
-            tcg_abort();
+            return false;
         }
         tcg_patch8(code_ptr, value);
         break;
-- 
2.17.2
