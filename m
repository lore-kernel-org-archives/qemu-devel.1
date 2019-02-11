Received: from eggs.gnu.org ([209.51.188.92]:59785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtF9A-0001yY-Pf
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:13:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtExm-0000v2-1j
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:01:52 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:36454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtExl-0000tq-J8
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:01:45 -0500
Received: by mail-pf1-x42d.google.com with SMTP id n22so2789818pfa.3
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 09:01:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 09:01:35 -0800
Message-Id: <20190211170136.18680-4-richard.henderson@linaro.org>
In-Reply-To: <20190211170136.18680-1-richard.henderson@linaro.org>
References: <20190211170136.18680-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 3/4] exec-all: document that tlb_fill can
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20190209162745.12668-2-cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.17.2
