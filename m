Received: from eggs.gnu.org ([2001:4830:134:3::10]:49628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYA2H-0003gL-TU
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYA2G-0003vp-56
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:59:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45814 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYA2G-0003vc-0f
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:59:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 27 Jun 2018 13:58:45 +0100
Message-Id: <20180627125847.5413-5-stefanha@redhat.com>
In-Reply-To: <20180627125847.5413-1-stefanha@redhat.com>
References: <20180627125847.5413-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 4/6] trace: add trace_mem_build_info_no_se_be/le
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

These will be used by the following commit.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-id: 1527028012-21888-5-git-send-email-cota@braap.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 trace/mem-internal.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/trace/mem-internal.h b/trace/mem-internal.h
index a9e408eb2f..f6efaf6d6b 100644
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
2.17.1
