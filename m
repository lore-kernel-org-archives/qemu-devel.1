Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0F0C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE502212CC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDvBaa/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE502212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTUqS-0001Mv-Om
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 14:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgS-0000VK-0t
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:32 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:50760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgC-00025s-N1
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:29 -0400
Received: by mail-pj1-x1042.google.com with SMTP id p21so1853258pju.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 11:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mmx0CSTu1RTijUU9ATLSsRFrO7J82mzvN7XFVAPyzh0=;
 b=UDvBaa/2+KKhPbT4/iNfv5XE+B7/uNC7eM98tlHjPuMTzjib2VBF04WADHBc5uw36s
 xlwjsnUpC2Wjk4qWoN1v4ujscN4hOqA8IpB3wpWQcgNyC7LvRS2fUxuCWWYtoztd4gv4
 EAycsoFCnxOb9ni1jgXYaQKM9mgieHnhvz3x+v53B2e329Y3NPAzLfWXVMfxO6bxb1aq
 qRDn0bU4giEfrygHkcTzQU2ZFKiHeb8xJhTAA+oFgrRaY7zannZb2aQ69Tkc0g4JQgx0
 PAiHPobqzh/yxvBTsQYQMHA91i/tkCzLoKN5DIwOJDl8wi5BTvnRfYMwaADc3VgEYdf+
 CodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mmx0CSTu1RTijUU9ATLSsRFrO7J82mzvN7XFVAPyzh0=;
 b=ucc3MUAbcMqCEkAeA2fb4fCD+WjBzE9crgtT1tkyOm4PkWCdPeuvWWHrrLvXC/N6Cu
 Cir2Th53ceWuxQlq1U9gG0TZMQScdVxq4PH6Nzo/oth38la9vjYCcppo/cxfvq0YZP+K
 JSozNqDxu/5vHCP2nt1HsXVGIPOo4dqJevMnVhAsigtZBLCYyVdO8YvIGVQq215YJOpt
 hJF/vG3kbL6k1c6bFX5gAXlLm2BYgCf6iQVKf2B3+YJXsP+t/rFTxuAYrlTq/bAzCami
 GHCzkOkmKjnp+k56VBQzhf70uNosK6y8qzVB1XFKrff3mzxF0ZAmlFgtZzIUFNvmOF1J
 FOTg==
X-Gm-Message-State: AOAM530+EhAacUXTQbqi5Ahk8iDvAPQOISAYApdAhmdZFQaeyKWiwr8s
 67BSWINfVQYIDja4V18wl3xHw58gfPDgmA==
X-Google-Smtp-Source: ABdhPJyxKkUTKpLTA/YU83qDPCL5iTjtWDkm6nmQEH+Pgy5X+GeRJ6VdpjBFhwXEy3pjnrIjal1iLg==
X-Received: by 2002:a17:90a:6541:: with SMTP id
 f1mr5433416pjs.46.1602873733577; 
 Fri, 16 Oct 2020 11:42:13 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c15sm3426011pgg.77.2020.10.16.11.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 11:42:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 02/12] linux-user: Set PAGE_TARGET_1 for TARGET_PROT_BTI
Date: Fri, 16 Oct 2020 11:41:57 -0700
Message-Id: <20201016184207.786698-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016184207.786698-1-richard.henderson@linaro.org>
References: <20201016184207.786698-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Transform the prot bit to a qemu internal page bit, and save
it in the page tables.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v10: Add PAGE_BTI define (pmm).
---
 include/exec/cpu-all.h     |  2 ++
 linux-user/syscall_defs.h  |  4 ++++
 target/arm/cpu.h           |  5 +++++
 linux-user/mmap.c          | 16 ++++++++++++++++
 target/arm/translate-a64.c |  6 +++---
 5 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 61e13b5038..656a2a8788 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -274,6 +274,8 @@ extern intptr_t qemu_host_page_mask;
 /* FIXME: Code that sets/uses this is broken and needs to go away.  */
 #define PAGE_RESERVED  0x0020
 #endif
+/* Target-specific bits that will be used via page_get_flags().  */
+#define PAGE_TARGET_1  0x0080
 
 #if defined(CONFIG_USER_ONLY)
 void page_dump(FILE *f);
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 731c3d5341..cabbfb762d 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1277,6 +1277,10 @@ struct target_winsize {
 #define TARGET_PROT_SEM         0x08
 #endif
 
+#ifdef TARGET_AARCH64
+#define TARGET_PROT_BTI         0x10
+#endif
+
 /* Common */
 #define TARGET_MAP_SHARED	0x01		/* Share changes */
 #define TARGET_MAP_PRIVATE	0x02		/* Changes are private */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cfff1b5c8f..e8efe21a1b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3443,6 +3443,11 @@ static inline MemTxAttrs *typecheck_memtxattrs(MemTxAttrs *x)
 #define arm_tlb_bti_gp(x) (typecheck_memtxattrs(x)->target_tlb_bit0)
 #define arm_tlb_mte_tagged(x) (typecheck_memtxattrs(x)->target_tlb_bit1)
 
+/*
+ * AArch64 usage of the PAGE_TARGET_* bits for linux-user.
+ */
+#define PAGE_BTI  PAGE_TARGET_1
+
 /*
  * Naming convention for isar_feature functions:
  * Functions which test 32-bit ID registers should have _aa32_ in
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index f261563420..00c05e6a0f 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -83,6 +83,22 @@ static int validate_prot_to_pageflags(int *host_prot, int prot)
     *host_prot = (prot & (PROT_READ | PROT_WRITE))
                | (prot & PROT_EXEC ? PROT_READ : 0);
 
+#ifdef TARGET_AARCH64
+    /*
+     * The PROT_BTI bit is only accepted if the cpu supports the feature.
+     * Since this is the unusual case, don't bother checking unless
+     * the bit has been requested.  If set and valid, record the bit
+     * within QEMU's page_flags.
+     */
+    if (prot & TARGET_PROT_BTI) {
+        ARMCPU *cpu = ARM_CPU(thread_cpu);
+        if (cpu_isar_feature(aa64_bti, cpu)) {
+            valid |= TARGET_PROT_BTI;
+            page_flags |= PAGE_BTI;
+        }
+    }
+#endif
+
     return prot & ~valid ? 0 : page_flags;
 }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7188808341..072754fa24 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14507,10 +14507,10 @@ static void disas_data_proc_simd_fp(DisasContext *s, uint32_t insn)
  */
 static bool is_guarded_page(CPUARMState *env, DisasContext *s)
 {
-#ifdef CONFIG_USER_ONLY
-    return false;  /* FIXME */
-#else
     uint64_t addr = s->base.pc_first;
+#ifdef CONFIG_USER_ONLY
+    return page_get_flags(addr) & PAGE_BTI;
+#else
     int mmu_idx = arm_to_core_mmu_idx(s->mmu_idx);
     unsigned int index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-- 
2.25.1


