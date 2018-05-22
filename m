Received: from eggs.gnu.org ([2001:4830:134:3::10]:43605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fLFkB-0003Ii-T3
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fLFk7-00072I-0d
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:26:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36307)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fLFk6-00071V-QR
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:26:54 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 22 May 2018 18:26:51 -0400
Message-Id: <1527028012-21888-5-git-send-email-cota@braap.org>
In-Reply-To: <1527028012-21888-1-git-send-email-cota@braap.org>
References: <1527028012-21888-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 4/5] trace: add trace_mem_build_info_no_se_be/le
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

These will be used by the following commit.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 trace/mem-internal.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/trace/mem-internal.h b/trace/mem-internal.h
index a9e408e..f6efaf6 100644
--- a/trace/mem-internal.h
+++ b/trace/mem-internal.h
@@ -39,4 +39,16 @@ static inline uint8_t trace_mem_get_info(TCGMemOp op, bool store)
                                 op & MO_BSWAP, store);
 }
 
+static inline
+uint8_t trace_mem_build_info_no_se_be(int size_shift, bool store)
+{
+    return trace_mem_build_info(size_shift, false, MO_BE, store);
+}
+
+static inline
+uint8_t trace_mem_build_info_no_se_le(int size_shift, bool store)
+{
+    return trace_mem_build_info(size_shift, false, MO_LE, store);
+}
+
 #endif /* TRACE__MEM_INTERNAL_H */
-- 
2.7.4
