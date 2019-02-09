Received: from eggs.gnu.org ([209.51.188.92]:42001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gsVTw-0003h9-CB
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 11:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gsVTu-0000kW-F2
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 11:27:56 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gsVTs-0000id-Gv
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 11:27:52 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat,  9 Feb 2019 11:27:44 -0500
Message-Id: <20190209162745.12668-2-cota@braap.org>
In-Reply-To: <20190209162745.12668-1-cota@braap.org>
References: <20190209162745.12668-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 1/2] exec-all: document that tlb_fill can
 trigger a TLB resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index aa7b81aaf0..97b90cb0db 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -475,6 +475,11 @@ static inline void assert_no_pages_locked(void)
 struct MemoryRegionSection *iotlb_to_section(CPUState *cpu,
                                              hwaddr index, MemTxAttrs attrs);
 
+/*
+ * Note: tlb_fill() can trigger a resize of the TLB. This means that all of the
+ * caller's prior references to the TLB table (e.g. CPUTLBEntry pointers) must
+ * be discarded and looked up again (e.g. via tlb_entry()).
+ */
 void tlb_fill(CPUState *cpu, target_ulong addr, int size,
               MMUAccessType access_type, int mmu_idx, uintptr_t retaddr);
 
-- 
2.17.1
