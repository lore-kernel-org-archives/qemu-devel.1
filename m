Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B15DC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2C220673
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ti82dWU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2C220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53768 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbpz0-0005MR-Cw
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55998)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkJ-0000br-A4
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkH-00031b-Uy
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:11 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpkH-00030g-OF
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:09 -0400
Received: by mail-wm1-x341.google.com with SMTP id g135so3097192wme.4
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KBrLiVlOKane3sjR6CJw/FTpjNMv1c4o2EyAw7JURhs=;
 b=Ti82dWU47HuBOveUZ5xgg1cKpf85bosw7nlQBOdaEpfiQjOzUNIX+1Iza25OljDCd7
 xIDDEi1Rg1mBLZ0wRWimallZdXE0c1qkJ00NGsJgGZv1e/5C91JTdYGd9s5rj5MBnscm
 K7DTVa+FlFdXrdjEEc71zjJYrJz14VVDmMxCtuoLbEs/SxcJZ31JQcL1gfOzjbr8WOUP
 yuLkd3SpvWIkGBmMX3lTrxqfln7CGD9v/eMiePYvtTpjFSEx7SEL6DrVWnh/SR36GKlH
 H2GURLDjfPqNVefOgM2mRfGzGxLIFn04xycgDQTFAPhECMFxkRMXWmFc/Y4gmxsz5w++
 5aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KBrLiVlOKane3sjR6CJw/FTpjNMv1c4o2EyAw7JURhs=;
 b=QLrFhZS5Uyc8JvmtYWtYhwQhBte/ndAlNN2TWm/fIy75sK1sTeVUlK5C9sDBdU3zv7
 cNoMWH2DMup//6+3yjiwp3rMAnCZ0Sf88Y3frZtJPdUddyv/hWEardYUpRix+VMW6Iqh
 VMTPqZRFYaPYwbrlxDWW1q03R90PngC6pGnR+UWVdD/z6+eyvmPruClNZIjd9VP2u+z+
 dcMQVPi36/FCZliVBLamVYjqqbMY7D/zflIW9JYX1f1Dw7XSf3PNC89gYdGOPBpQU5Hx
 a4yaU8J24V6LtCeJPF6YPnl1u/L1K9XJsBaGlzRZLcLyBhUpwvTvjPmi6Ul1CQosrzC2
 AQhw==
X-Gm-Message-State: APjAAAVwp+v4zVjvQdJseiXKBFLMX2UwoDIbgWUQ3xawFOJNeEdEYsdE
 3cpwHqZA4HzLMmNIUOfCaT+UBg==
X-Google-Smtp-Source: APXvYqxP3IrMrkPR3IWWdNzPXFGyP12Z45hHzkyRtYP2JqhuVM5asaIMlQPR5ZqGaJYNE6MdcniX2Q==
X-Received: by 2002:a1c:c003:: with SMTP id q3mr8730823wmf.42.1560532328662;
 Fri, 14 Jun 2019 10:12:08 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o126sm7656157wmo.31.2019.06.14.10.12.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:12:06 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 85C7B1FF9C;
 Fri, 14 Jun 2019 18:12:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:22 +0100
Message-Id: <20190614171200.21078-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v3 12/50] cputlb: introduce
 get_page_addr_code_hostp
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

This will be used by plugins to get the host address
of instructions.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cputlb.c      | 14 +++++++++++++-
 include/exec/exec-all.h | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3237ff4def..6a0dc438ff 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1015,7 +1015,8 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
   victim_tlb_hit(env, mmu_idx, index, offsetof(CPUTLBEntry, TY), \
                  (ADDR) & TARGET_PAGE_MASK)
 
-tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
+tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, target_ulong addr,
+                                        void **hostp)
 {
     uintptr_t mmu_idx = cpu_mmu_index(env, true);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1040,13 +1041,24 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
          *    than a target page, so we must redo the MMU check every insn
          *  - TLB_MMIO: region is not backed by RAM
          */
+        if (hostp) {
+            *hostp = NULL;
+        }
         return -1;
     }
 
     p = (void *)((uintptr_t)addr + entry->addend);
+    if (hostp) {
+        *hostp = p;
+    }
     return qemu_ram_addr_from_host_nofail(p);
 }
 
+tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
+{
+    return get_page_addr_code_hostp(env, addr, NULL);
+}
+
 /* Probe for whether the specified guest write access is permitted.
  * If it is not permitted then an exception will be taken in the same
  * way as if this were a real write access (and we will not return).
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 8b1c3d5b9d..90045e77c1 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -21,6 +21,7 @@
 #define EXEC_ALL_H
 
 #include "exec/tb-context.h"
+#include "exec/cpu_ldst.h"
 #include "sysemu/cpus.h"
 
 /* allow to see translation results - the slowdown should be negligible, so we leave it */
@@ -492,6 +493,26 @@ static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
 {
     return addr;
 }
+
+/**
+ * get_page_addr_code_hostp() - user-mode version
+ * @env: CPUArchState
+ * @addr: guest virtual address of guest code
+ *
+ * Returns @addr.
+ *
+ * If @hostp is non-NULL, sets *@hostp to the host address where @addr's content
+ * is kept.
+ */
+static inline tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env,
+                                                      target_ulong addr,
+                                                      void **hostp)
+{
+    if (hostp) {
+        *hostp = g2h(addr);
+    }
+    return addr;
+}
 #else
 static inline void mmap_lock(void) {}
 static inline void mmap_unlock(void) {}
@@ -509,6 +530,23 @@ static inline void mmap_unlock(void) {}
  */
 tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr);
 
+/**
+ * get_page_addr_code_hostp() - full-system version
+ * @env: CPUArchState
+ * @addr: guest virtual address of guest code
+ *
+ * See get_page_addr_code() (full-system version) for documentation on the
+ * return value.
+ *
+ * Sets *@hostp (when @hostp is non-NULL) as follows.
+ * If the return value is -1, sets *@hostp to NULL. Otherwise, sets *@hostp
+ * to the host address where @addr's content is kept.
+ *
+ * Note: this function can trigger an exception.
+ */
+tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, target_ulong addr,
+                                        void **hostp);
+
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
 void tlb_set_dirty(CPUState *cpu, target_ulong vaddr);
 
-- 
2.20.1


