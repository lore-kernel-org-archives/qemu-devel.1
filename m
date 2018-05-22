Received: from eggs.gnu.org ([2001:4830:134:3::10]:43608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fLFkB-0003Ik-TE
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fLFk6-000720-Vb
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:26:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42963)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fLFk6-00071U-QI
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:26:54 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 22 May 2018 18:26:50 -0400
Message-Id: <1527028012-21888-4-git-send-email-cota@braap.org>
In-Reply-To: <1527028012-21888-1-git-send-email-cota@braap.org>
References: <1527028012-21888-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 3/5] trace: expand mem_info:size_shift to 3 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This will allow us to trace 16B-long memory accesses.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 trace/mem-internal.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/trace/mem-internal.h b/trace/mem-internal.h
index b684e27..a9e408e 100644
--- a/trace/mem-internal.h
+++ b/trace/mem-internal.h
@@ -10,10 +10,10 @@
 #ifndef TRACE__MEM_INTERNAL_H
 #define TRACE__MEM_INTERNAL_H
 
-#define TRACE_MEM_SZ_SHIFT_MASK 0x3 /* size shift mask */
-#define TRACE_MEM_SE (1ULL << 2)    /* sign extended (y/n) */
-#define TRACE_MEM_BE (1ULL << 3)    /* big endian (y/n) */
-#define TRACE_MEM_ST (1ULL << 4)    /* store (y/n) */
+#define TRACE_MEM_SZ_SHIFT_MASK 0x7 /* size shift mask */
+#define TRACE_MEM_SE (1ULL << 3)    /* sign extended (y/n) */
+#define TRACE_MEM_BE (1ULL << 4)    /* big endian (y/n) */
+#define TRACE_MEM_ST (1ULL << 5)    /* store (y/n) */
 
 static inline uint8_t trace_mem_build_info(
     int size_shift, bool sign_extend, TCGMemOp endianness, bool store)
-- 
2.7.4
