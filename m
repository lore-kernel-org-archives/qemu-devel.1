Received: from eggs.gnu.org ([2001:4830:134:3::10]:45677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6c-0008NT-JT
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6b-0008Ks-OH
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:10 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:47346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6b-0008KA-Ir
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:09 -0400
Received: by mail-wr0-x242.google.com with SMTP id y39so23336959wrd.4
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:08 +0200
Message-Id: <20171025093535.10175-25-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 24/51] tcg: Include CF_COUNT_MASK in CF_HASH_MASK
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

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 352abc7450..0fdb72bb22 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -327,7 +327,7 @@ struct TranslationBlock {
 #define CF_INVALID     0x80000 /* TB is stale. Setters must acquire tb_lock */
 #define CF_PARALLEL    0x100000 /* Generate code for a parallel context */
 /* cflags' mask for hashing/comparison */
-#define CF_HASH_MASK (CF_PARALLEL)
+#define CF_HASH_MASK   (CF_COUNT_MASK | CF_PARALLEL)
 
     /* Per-vCPU dynamic tracing state used to generate this TB */
     uint32_t trace_vcpu_dstate;
-- 
2.13.6
