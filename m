Received: from eggs.gnu.org ([2001:4830:134:3::10]:49627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYA2H-0003gJ-TC
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYA2E-0003v6-MU
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:59:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51942 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYA2E-0003ur-HN
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:58:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 27 Jun 2018 13:58:44 +0100
Message-Id: <20180627125847.5413-4-stefanha@redhat.com>
In-Reply-To: <20180627125847.5413-1-stefanha@redhat.com>
References: <20180627125847.5413-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] trace: expand mem_info:size_shift to 3 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

This will allow us to trace 16B-long memory accesses.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-id: 1527028012-21888-4-git-send-email-cota@braap.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 trace/mem-internal.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/trace/mem-internal.h b/trace/mem-internal.h
index b684e2750c..a9e408eb2f 100644
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
2.17.1
