Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47B1FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AEB02089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h5jx0zyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEB02089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5su-0001W6-HB
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5dg-00081M-Jt
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5de-0005PT-SZ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5de-0005Nq-MA
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id n14so2302635wrw.9
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lLM+xKKxPEW7VAxcx9ZcpQ8DuflKLaTBtk33YYXEM9o=;
 b=h5jx0zyIIhYP5HfBCpDxUm8pyJ3IONYuZjTk4ZJM7NQLrtWlWf4FU5AsIVuB4McQzF
 n3ZhLCAUgrcttQMc04m7ydpcNhT4LNjFXSYGXZXUoN9c8E3MHjI0yBhjAI03CN77101N
 oYiIx+c95oMT+I1ExVZQ4woT/l8Z5CeqdQ+r+gI56r5kK/I8q22RVjHPDRNbQrRQ8L5n
 8nT1q/wCq0WG8PIP+IMa7budCnHuoM90oeibe76Oriqv7ZZMt9jNZbjAM1DZpBeaQGud
 YvvtBUGknanoWmZhGAJbiHo5FgEXtJ8SuLq/UWctsHLw9MhMOOMeoPnFjlC00a1tY0b6
 1cCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lLM+xKKxPEW7VAxcx9ZcpQ8DuflKLaTBtk33YYXEM9o=;
 b=qudc9jkBWt876yeJml8VZVurEkMCAwxwd3g9jU0r3KvXN+zKh3HpWXpfbxToqZGNKU
 FTbAZoMKFIto/BSCrFvjhf9nP1EhdaibUrPDCsj/2Sw5ntLTIBG8a44+zURv6Pm/ij7o
 7p3auvSFS4CyLcqEvZb0QfwsZmhhzkvXCedTgWu+hS5AIvD5S9z43kgztGGsXmQ+U6ln
 /Rm3tck9ygBGdZlZUeGp7Bq5GvijcF1E40C0Ro76uMqsxGMzYK5okLWN4g8lEtkpXCTA
 4jMNRkpEz0PJeUxLVCIJLuZte1oHj2qnOOjUQ3/v8Bk8nGwVpiCCtcrV5SpHqfwTyNl4
 LcgA==
X-Gm-Message-State: APjAAAUTSmlilrexoJBxtaxPgzNqcZOxPNxCUhQBCYGSnV813HDMABy7
 yTxvwBgOa3zzY1KIGMdE2nDTkw==
X-Google-Smtp-Source: APXvYqwezblox7MzJdQ9JylT7e0lNnwDz5FPBcUPWCf3zHtWhYoCYEciPPmBT4zM1Xh/9uUxJIEisQ==
X-Received: by 2002:a5d:544b:: with SMTP id w11mr1444015wrv.205.1571318181510; 
 Thu, 17 Oct 2019 06:16:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z6sm2419443wro.16.2019.10.17.06.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:16:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DB3F41FF9B;
 Thu, 17 Oct 2019 14:16:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 11/54] cputlb: introduce get_page_addr_code_hostp
Date: Thu, 17 Oct 2019 14:15:32 +0100
Message-Id: <20191017131615.19660-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

This will be used by plugins to get the host address
of instructions.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c      | 14 +++++++++++++-
 include/exec/exec-all.h | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a8f9069582..82a5783a2b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1051,7 +1051,8 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
  * NOTE: This function will trigger an exception if the page is
  * not executable.
  */
-tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
+tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, target_ulong addr,
+                                        void **hostp)
 {
     uintptr_t mmu_idx = cpu_mmu_index(env, true);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1077,13 +1078,24 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
 
     if (unlikely(entry->addr_code & TLB_MMIO)) {
         /* The region is not backed by RAM.  */
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
 static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
                            CPUIOTLBEntry *iotlbentry, uintptr_t retaddr)
 {
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index e4206cb173..eadcf29d0c 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -22,6 +22,7 @@
 
 #include "cpu.h"
 #include "exec/tb-context.h"
+#include "exec/cpu_ldst.h"
 #include "sysemu/cpus.h"
 
 /* allow to see translation results - the slowdown should be negligible, so we leave it */
@@ -516,6 +517,26 @@ static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
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
@@ -533,6 +554,23 @@ static inline void mmap_unlock(void) {}
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


