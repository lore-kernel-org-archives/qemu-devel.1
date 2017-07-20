Received: from eggs.gnu.org ([2001:4830:134:3::10]:60150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qM-00016P-CF
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qI-0005oM-UT
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39539)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dY1qI-0005nv-Kh
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:34 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 19 Jul 2017 23:08:49 -0400
Message-Id: <1500520169-23367-4-git-send-email-cota@braap.org>
In-Reply-To: <1500520169-23367-1-git-send-email-cota@braap.org>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 03/43] exec-all: fix typos in
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
Cc: Richard Henderson <rth@twiddle.net>

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 87b1b74..69c1b36 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -370,7 +370,7 @@ struct TranslationBlock {
     /* The following data are used to directly call another TB from
      * the code of this one. This can be done either by emitting direct or
      * indirect native jump instructions. These jumps are reset so that the TB
-     * just continue its execution. The TB can be linked to another one by
+     * just continues its execution. The TB can be linked to another one by
      * setting one of the jump targets (or patching the jump instruction). Only
      * two of such jumps are supported.
      */
@@ -381,7 +381,7 @@ struct TranslationBlock {
 #else
     uintptr_t jmp_target_addr[2]; /* target address for indirect jump */
 #endif
-    /* Each TB has an assosiated circular list of TBs jumping to this one.
+    /* Each TB has an associated circular list of TBs jumping to this one.
      * jmp_list_first points to the first TB jumping to this one.
      * jmp_list_next is used to point to the next TB in a list.
      * Since each TB can have two jumps, it can participate in two lists.
-- 
2.7.4
