Received: from eggs.gnu.org ([2001:4830:134:3::10]:58731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e20EG-0000V1-J3
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e20EF-0004wk-FB
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:12 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:47076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e20EF-0004w9-93
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:11 -0400
Received: by mail-pf0-x231.google.com with SMTP id p87so9224354pfj.3
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 12:30:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 10 Oct 2017 12:29:46 -0700
Message-Id: <20171010193003.28857-4-richard.henderson@linaro.org>
In-Reply-To: <20171010193003.28857-1-richard.henderson@linaro.org>
References: <20171010193003.28857-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v2 03/20] exec-all: fix typos in
 TranslationBlock's documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 673fc066d0..a9a8bb6f83 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -332,7 +332,7 @@ struct TranslationBlock {
     /* The following data are used to directly call another TB from
      * the code of this one. This can be done either by emitting direct or
      * indirect native jump instructions. These jumps are reset so that the TB
-     * just continue its execution. The TB can be linked to another one by
+     * just continues its execution. The TB can be linked to another one by
      * setting one of the jump targets (or patching the jump instruction). Only
      * two of such jumps are supported.
      */
@@ -340,7 +340,7 @@ struct TranslationBlock {
 #define TB_JMP_RESET_OFFSET_INVALID 0xffff /* indicates no jump generated */
     uintptr_t jmp_target_arg[2];  /* target address or offset */
 
-    /* Each TB has an assosiated circular list of TBs jumping to this one.
+    /* Each TB has an associated circular list of TBs jumping to this one.
      * jmp_list_first points to the first TB jumping to this one.
      * jmp_list_next is used to point to the next TB in a list.
      * Since each TB can have two jumps, it can participate in two lists.
-- 
2.13.6
