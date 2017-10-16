Received: from eggs.gnu.org ([2001:4830:134:3::10]:52637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AQ-0002fy-2o
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AP-0003qj-B3
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:06 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:54602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e49AP-0003qE-4t
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:05 -0400
Received: by mail-pf0-x22d.google.com with SMTP id n89so8659477pfk.11
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:27:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:55 -0700
Message-Id: <20171016172609.23422-37-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 36/50] tcg: Add CF_LAST_IO + CF_USE_ICOUNT
 to CF_HASH_MASK
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

These flags are used by target/*/translate.c,
and affect code generation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 0fdb72bb22..a3bd3e7abd 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -327,7 +327,8 @@ struct TranslationBlock {
 #define CF_INVALID     0x80000 /* TB is stale. Setters must acquire tb_lock */
 #define CF_PARALLEL    0x100000 /* Generate code for a parallel context */
 /* cflags' mask for hashing/comparison */
-#define CF_HASH_MASK   (CF_COUNT_MASK | CF_PARALLEL)
+#define CF_HASH_MASK   \
+    (CF_COUNT_MASK | CF_LAST_IO | CF_USE_ICOUNT | CF_PARALLEL)
 
     /* Per-vCPU dynamic tracing state used to generate this TB */
     uint32_t trace_vcpu_dstate;
-- 
2.13.6
