Received: from eggs.gnu.org ([2001:4830:134:3::10]:52466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AB-0002P6-A5
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AA-0003eR-ED
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:51 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:45356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e49AA-0003e4-8O
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:50 -0400
Received: by mail-pf0-x22f.google.com with SMTP id d28so16307464pfe.2
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:26:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:44 -0700
Message-Id: <20171016172609.23422-26-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 25/50] tcg: Include CF_COUNT_MASK in
 CF_HASH_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

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
