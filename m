Received: from eggs.gnu.org ([2001:4830:134:3::10]:60410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iq9-0002AB-Nr
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iq8-0004JT-US
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:09 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:52377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1iq8-0004IB-PK
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:08 -0400
Received: by mail-pf0-x236.google.com with SMTP id a1so12238474pfj.9
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 17:56:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  9 Oct 2017 17:55:40 -0700
Message-Id: <20171010005600.28735-4-richard.henderson@linaro.org>
In-Reply-To: <20171010005600.28735-1-richard.henderson@linaro.org>
References: <20171010005600.28735-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 03/23] exec-all: fix typos in TranslationBlock's
 documentation
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
