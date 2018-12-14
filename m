Received: from eggs.gnu.org ([2001:4830:134:3::10]:58794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0r-0005wb-QA
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0q-0006oO-UE
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:41 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:41268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe0q-0006n9-O0
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:40 -0500
Received: by mail-oi1-x233.google.com with SMTP id j21so3458577oii.8
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:19:03 -0600
Message-Id: <20181214031923.29527-14-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/32] tcg/i386: Return false on failure from
 patch_reloc
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
