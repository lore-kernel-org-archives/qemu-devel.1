Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D22CC388F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA1B20709
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aTl3CKee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA1B20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasY9-00054h-L3
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRY-0004hY-C0
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:40 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRW-0006vF-0W
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:40 -0500
Received: by mail-pg1-x543.google.com with SMTP id w4so2857760pgg.13
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FN7eaRY1DFewRq+5QytfG73XvKQyLklp5pw6gaXWtVo=;
 b=aTl3CKeeAoIXQL8RygtWkPZrXgWy7FbT9z/2AwL2LOPDwwXvDFGfKCwgr8yic5d/BI
 r0o1JcO6UMAHO++B2BedmVpNd3fMgrA1Zy+ogPfovE8GE3H/p8jrLV/999LFfDOv95U+
 k0laMeeWla6lRwqymnWj0poM5oupdClDQXAukR1eF66wx/2+VC4QEVrKbi7EU6ZRyamt
 jtrviS4eGO9wqfj06bnxxq0GoK6lQaYUY6q9fHFLPXL677xZgpBJOIe6iH2IH7ESEMrb
 42kvr+l9Bnaps/a4ZS2FEOpY2MttaZqE5cMVI4ag1lXLWiSjYck1RqF8e3IZghIZXX9x
 O8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FN7eaRY1DFewRq+5QytfG73XvKQyLklp5pw6gaXWtVo=;
 b=QZzn4aYX/Y7ltyH1wnrrp0jN0pYpBtTwVL2b1IPRKY/tpllnckx4HFPBQI6HGzI6fO
 AdmEAdIIwqn3XkyvsLEkSj+LR327E38lqIsY7KWTaTdmB9+G7HaVlyhP4Y8vAcS90yvH
 o2gknITH1MDGTgHZFjrUZu2Y4zgznxzTKBDSBiUN1zAxalPTSoMd+Mty7paiMwMv3xlb
 N2Pem2iJOWcOxdH4SAotQtJSfUMSBBh2H0bU78Ke9ODVl9wmDcJ1iQSoSL8lfPbaYQh7
 IVX+wbD0u1+rmpEm3BELc3p3/bxpdedammg4p5TUd9NV84b0UdGhqLzBf42KmoLxJKmg
 jVVA==
X-Gm-Message-State: AOAM531laPjNZ5U9utNCf/sGfb3fE/8lFpOs6S++TX3mqZkJXFkQcvPS
 b249J7Q81u06w8L1Qxu6qBJ1M+pohl0bCw==
X-Google-Smtp-Source: ABdhPJxDVVK3VFIuzD3qURUJsIXKPehOKdr1Rbx7lr84fd1KKyqMcCb2/kmDADlfX0xcWXc6qO/ZgQ==
X-Received: by 2002:a17:90a:c201:: with SMTP id e1mr177735pjt.16.1604633376114; 
 Thu, 05 Nov 2020 19:29:36 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/41] tcg: Adjust tb_target_set_jmp_target for split-wx
Date: Thu,  5 Nov 2020 19:28:50 -0800
Message-Id: <20201106032921.600200-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pass both rx and rw addresses to tb_target_set_jmp_target.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     |  2 +-
 tcg/arm/tcg-target.h         |  2 +-
 tcg/i386/tcg-target.h        |  6 +++---
 tcg/mips/tcg-target.h        |  2 +-
 tcg/ppc/tcg-target.h         |  2 +-
 tcg/riscv/tcg-target.h       |  2 +-
 tcg/s390/tcg-target.h        |  8 ++++----
 tcg/sparc/tcg-target.h       |  2 +-
 tcg/tci/tcg-target.h         |  6 +++---
 accel/tcg/cpu-exec.c         |  4 +++-
 tcg/aarch64/tcg-target.c.inc | 12 ++++++------
 tcg/mips/tcg-target.c.inc    |  8 ++++----
 tcg/ppc/tcg-target.c.inc     | 16 ++++++++--------
 tcg/sparc/tcg-target.c.inc   | 14 +++++++-------
 14 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index d0a6a059b7..91313d93be 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -158,7 +158,7 @@ static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
     __builtin___clear_cache((char *)rx, (char *)(rx + len));
 }
 
-void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
+void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 
 #ifdef CONFIG_SOFTMMU
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index fa88b24e43..b21a2fb6a1 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -144,7 +144,7 @@ static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 }
 
 /* not defined -- call should be eliminated at compile time */
-void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
+void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 
 #ifdef CONFIG_SOFTMMU
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 8323e72639..f52ba0ffec 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -211,11 +211,11 @@ static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
 }
 
-static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
-                                            uintptr_t jmp_addr, uintptr_t addr)
+static inline void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_rx,
+                                            uintptr_t jmp_rw, uintptr_t addr)
 {
     /* patch the branch destination */
-    qatomic_set((int32_t *)jmp_addr, addr - (jmp_addr + 4));
+    qatomic_set((int32_t *)jmp_rw, addr - (jmp_rx + 4));
     /* no need to flush icache explicitly */
 }
 
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 47b1226ee9..cd548dacec 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -216,7 +216,7 @@ static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
     cacheflush((void *)rx, len, ICACHE);
 }
 
-void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
+void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 
 #ifdef CONFIG_SOFTMMU
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index fbb6dc1b47..8f3e4c924a 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -176,7 +176,7 @@ extern bool have_vsx;
 #define TCG_TARGET_HAS_cmpsel_vec       0
 
 void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len);
-void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
+void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 0fa6ae358e..e03fd17427 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -169,7 +169,7 @@ static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 }
 
 /* not defined -- call should be eliminated at compile time */
-void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
+void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 
 #define TCG_TARGET_DEFAULT_MO (0)
 
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index c3dc2e8938..c5a749e425 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -150,12 +150,12 @@ static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
 }
 
-static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
-                                            uintptr_t jmp_addr, uintptr_t addr)
+static inline void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_rx,
+                                            uintptr_t jmp_rw, uintptr_t addr)
 {
     /* patch the branch destination */
-    intptr_t disp = addr - (jmp_addr - 2);
-    qatomic_set((int32_t *)jmp_addr, disp / 2);
+    intptr_t disp = addr - (jmp_rx - 2);
+    qatomic_set((int32_t *)jmp_rw, disp / 2);
     /* no need to flush icache explicitly */
 }
 
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index c27c40231e..87e2be61e6 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -178,7 +178,7 @@ static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
     }
 }
 
-void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
+void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 
 #define TCG_TARGET_NEED_POOL_LABELS
 
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 49f3291f8a..a19a6b06e5 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -201,11 +201,11 @@ static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
 
-static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
-                                            uintptr_t jmp_addr, uintptr_t addr)
+static inline void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_rx,
+                                            uintptr_t jmp_rw, uintptr_t addr)
 {
     /* patch the branch destination */
-    qatomic_set((int32_t *)jmp_addr, addr - (jmp_addr + 4));
+    qatomic_set((int32_t *)jmp_rw, addr - (jmp_rx + 4));
     /* no need to flush icache explicitly */
 }
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 1e3cb570f6..272d596e0c 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -354,7 +354,9 @@ void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr)
     if (TCG_TARGET_HAS_direct_jump) {
         uintptr_t offset = tb->jmp_target_arg[n];
         uintptr_t tc_ptr = (uintptr_t)tb->tc.ptr;
-        tb_target_set_jmp_target(tc_ptr, tc_ptr + offset, addr);
+        uintptr_t jmp_rx = tc_ptr + offset;
+        uintptr_t jmp_rw = jmp_rx - tcg_splitwx_diff;
+        tb_target_set_jmp_target(tc_ptr, jmp_rx, jmp_rw, addr);
     } else {
         tb->jmp_target_arg[n] = addr;
     }
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 9ace859db3..fea784cf75 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1340,21 +1340,21 @@ static inline void tcg_out_call(TCGContext *s, const tcg_insn_unit *target)
     }
 }
 
-void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
-                              uintptr_t addr)
+void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_rx,
+                              uintptr_t jmp_rw, uintptr_t addr)
 {
     tcg_insn_unit i1, i2;
     TCGType rt = TCG_TYPE_I64;
     TCGReg  rd = TCG_REG_TMP;
     uint64_t pair;
 
-    ptrdiff_t offset = addr - jmp_addr;
+    ptrdiff_t offset = addr - jmp_rx;
 
     if (offset == sextract64(offset, 0, 26)) {
         i1 = I3206_B | ((offset >> 2) & 0x3ffffff);
         i2 = NOP;
     } else {
-        offset = (addr >> 12) - (jmp_addr >> 12);
+        offset = (addr >> 12) - (jmp_rx >> 12);
 
         /* patch ADRP */
         i1 = I3406_ADRP | (offset & 3) << 29 | (offset & 0x1ffffc) << (5 - 2) | rd;
@@ -1362,8 +1362,8 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
         i2 = I3401_ADDI | rt << 31 | (addr & 0xfff) << 10 | rd << 5 | rd;
     }
     pair = (uint64_t)i2 << 32 | i1;
-    qatomic_set((uint64_t *)jmp_addr, pair);
-    flush_idcache_range(jmp_addr, jmp_addr, 8);
+    qatomic_set((uint64_t *)jmp_rw, pair);
+    flush_idcache_range(jmp_rx, jmp_rw, 8);
 }
 
 static inline void tcg_out_goto_label(TCGContext *s, TCGLabel *l)
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index e9c8c24741..52638e920c 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2657,11 +2657,11 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_GP);   /* global pointer */
 }
 
-void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
-                              uintptr_t addr)
+void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_rx,
+                              uintptr_t jmp_rw, uintptr_t addr)
 {
-    qatomic_set((uint32_t *)jmp_addr, deposit32(OPC_J, 0, 26, addr >> 2));
-    flush_idcache_range(jmp_addr, jmp_addr, 4);
+    qatomic_set((uint32_t *)jmp_rw, deposit32(OPC_J, 0, 26, addr >> 2));
+    flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
 typedef struct {
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index ff667b1531..bc0057eedf 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1722,13 +1722,13 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
     tcg_out32(s, insn);
 }
 
-void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
-                              uintptr_t addr)
+void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_rx,
+                              uintptr_t jmp_rw, uintptr_t addr)
 {
     if (TCG_TARGET_REG_BITS == 64) {
         tcg_insn_unit i1, i2;
         intptr_t tb_diff = addr - tc_ptr;
-        intptr_t br_diff = addr - (jmp_addr + 4);
+        intptr_t br_diff = addr - (jmp_rx + 4);
         uint64_t pair;
 
         /* This does not exercise the range of the branch, but we do
@@ -1752,13 +1752,13 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
 
         /* As per the enclosing if, this is ppc64.  Avoid the _Static_assert
            within qatomic_set that would fail to build a ppc32 host.  */
-        qatomic_set__nocheck((uint64_t *)jmp_addr, pair);
-        flush_idcache_range(jmp_addr, jmp_addr, 8);
+        qatomic_set__nocheck((uint64_t *)jmp_rw, pair);
+        flush_idcache_range(jmp_rx, jmp_rw, 8);
     } else {
-        intptr_t diff = addr - jmp_addr;
+        intptr_t diff = addr - jmp_rx;
         tcg_debug_assert(in_range_b(diff));
-        qatomic_set((uint32_t *)jmp_addr, B | (diff & 0x3fffffc));
-        flush_idcache_range(jmp_addr, jmp_addr, 4);
+        qatomic_set((uint32_t *)jmp_rw, B | (diff & 0x3fffffc));
+        flush_idcache_range(jmp_rx, jmp_rw, 4);
     }
 }
 
diff --git a/tcg/sparc/tcg-target.c.inc b/tcg/sparc/tcg-target.c.inc
index 4c81d5f1c2..d599ae27b5 100644
--- a/tcg/sparc/tcg-target.c.inc
+++ b/tcg/sparc/tcg-target.c.inc
@@ -1821,11 +1821,11 @@ void tcg_register_jit(const void *buf, size_t buf_size)
     tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame));
 }
 
-void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
-                              uintptr_t addr)
+void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_rx,
+                              uintptr_t jmp_rw, uintptr_t addr)
 {
     intptr_t tb_disp = addr - tc_ptr;
-    intptr_t br_disp = addr - jmp_addr;
+    intptr_t br_disp = addr - jmp_rx;
     tcg_insn_unit i1, i2;
 
     /* We can reach the entire address space for ILP32.
@@ -1834,9 +1834,9 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
     tcg_debug_assert(br_disp == (int32_t)br_disp);
 
     if (!USE_REG_TB) {
-        qatomic_set((uint32_t *)jmp_addr,
+        qatomic_set((uint32_t *)jmp_rw,
 		    deposit32(CALL, 0, 30, br_disp >> 2));
-        flush_idcache_range(jmp_addr, jmp_addr, 4);
+        flush_idcache_range(jmp_rx, jmp_rw, 4);
         return;
     }
 
@@ -1859,6 +1859,6 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
               | INSN_IMM13((tb_disp & 0x3ff) | -0x400));
     }
 
-    qatomic_set((uint64_t *)jmp_addr, deposit64(i2, 32, 32, i1));
-    flush_idcache_range(jmp_addr, jmp_addr, 8);
+    qatomic_set((uint64_t *)jmp_rw, deposit64(i2, 32, 32, i1));
+    flush_idcache_range(jmp_rx, jmp_rw, 8);
 }
-- 
2.25.1


