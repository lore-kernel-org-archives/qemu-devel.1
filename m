Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D01C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 17:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C86D920872
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 17:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TbdUyK7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86D920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbSWZ-0002zH-Uv
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 13:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbSVn-0001nY-1f
 for qemu-devel@nongnu.org; Wed, 20 May 2020 13:28:11 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbSVk-0004Jc-WF
 for qemu-devel@nongnu.org; Wed, 20 May 2020 13:28:10 -0400
Received: by mail-pg1-x542.google.com with SMTP id n11so1740960pgl.9
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 10:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HKxQYKn1u7z/RK4+55flzx7HAaMyO56swf2SUfshigE=;
 b=TbdUyK7yK4ZcXDwj/BP2LoxFLwTrffIjbVH2R87zzXBY4inMMo9OIT0QmwYuOHWI+j
 iUhoLI4y9ABCafwzhLWwHTUMPSlzaJ2S/p6Y/HpAwSsbGLtuJEUi/X4IOzHVS4M/bJk7
 GVhzXN0KyoLy8LcqeCG69lOiNm9w8iGgHd4eD0UYpKvg3gUu0p9jjsRumNmkYr/Qz+32
 jBbGLAzsRjbrpOSuRrQq1BspzqvDYYyaaqfeyQhgLfMt5sS/LdWT1VNLLVrXzoi/vVux
 abUkuZQEoNAXzFXHZ8UeCkiBEiQbtMMdtwGdV4RqcNhy+U3w2rqczZke3MWJGN1B/5FL
 JPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HKxQYKn1u7z/RK4+55flzx7HAaMyO56swf2SUfshigE=;
 b=ck3qFS8pPBXgnltwhIslGkcaA2b3ClH4sgThGOEtfwPitFDYyUPim7/YIT8m+D9sHl
 RS+B28tOyaJjrcaWtgEJJAQqrBifeJJApBkiyVNThlAOhcMUb/m5cQBPXJXLnuzbcws9
 9RBbmD8zEcmzq2rmcqGeQ0BDHhPqBRRLXpDZ9vnRqgCEA2PlstMsx2kahsHWn6QKgA2T
 w5ZzRyeqwLpirDZC+TuCgQs+VyPAZfjaw+TgfvOuW4LLg9uXqBXmjaVnUf5dzbhc4dFo
 lDMHQiAhUlmlPpzYw6NSn8GpmDDKTnLH9lew8YA62XdUCSh7BtwYe0FhTsMJjOWzE+p/
 m5SQ==
X-Gm-Message-State: AOAM531x7woEQf5nT7ZK3utnoSuKmnCmgEs7X0Hl6ElMkE7KjsRNNHdE
 5SWV+I9yTTxdfNt+UWyNYAr2kR0EhEE=
X-Google-Smtp-Source: ABdhPJwDz3hcN4rkbz1i6YDTJKsBJNNWBlfgjBvcZAV0bvYe2ww97crH+/5xchlgvVwRP+NBoQGr0A==
X-Received: by 2002:a63:6447:: with SMTP id y68mr4849670pgb.395.1589995684724; 
 Wed, 20 May 2020 10:28:04 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id k18sm2643672pfg.217.2020.05.20.10.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 10:28:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 2/5] linux-user: Set PAGE_TARGET_1 for TARGET_PROT_BTI
Date: Wed, 20 May 2020 10:27:57 -0700
Message-Id: <20200520172800.8499-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200520172800.8499-1-richard.henderson@linaro.org>
References: <20200520172800.8499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Transform the prot bit to a qemu internal page bit, and save
it in the page tables.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h     |  2 ++
 linux-user/syscall_defs.h  |  4 ++++
 linux-user/mmap.c          | 16 ++++++++++++++++
 target/arm/translate-a64.c |  6 +++---
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d14374bdd4..2bd023d692 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -276,6 +276,8 @@ extern intptr_t qemu_host_page_mask;
 /* FIXME: Code that sets/uses this is broken and needs to go away.  */
 #define PAGE_RESERVED  0x0020
 #endif
+/* Target-specific bits that will be used via page_get_flags().  */
+#define PAGE_TARGET_1  0x0080
 
 #if defined(CONFIG_USER_ONLY)
 void page_dump(FILE *f);
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 152ec637cb..36bdafb3f1 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1194,6 +1194,10 @@ struct target_winsize {
 #define TARGET_PROT_SEM         0x08
 #endif
 
+#ifdef TARGET_AARCH64
+#define TARGET_PROT_BTI         0x10
+#endif
+
 /* Common */
 #define TARGET_MAP_SHARED	0x01		/* Share changes */
 #define TARGET_MAP_PRIVATE	0x02		/* Changes are private */
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 84662c3311..40f03e3174 100644
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
+     * within QEMU's page_flags as PAGE_TARGET_1.
+     */
+    if (prot & TARGET_PROT_BTI) {
+        ARMCPU *cpu = ARM_CPU(thread_cpu);
+        if (cpu_isar_feature(aa64_bti, cpu)) {
+            valid |= TARGET_PROT_BTI;
+            page_flags |= PAGE_TARGET_1;
+        }
+    }
+#endif
+
     return prot & ~valid ? 0 : page_flags;
 }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 991e451644..59ae236c84 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13989,10 +13989,10 @@ static void disas_data_proc_simd_fp(DisasContext *s, uint32_t insn)
  */
 static bool is_guarded_page(CPUARMState *env, DisasContext *s)
 {
-#ifdef CONFIG_USER_ONLY
-    return false;  /* FIXME */
-#else
     uint64_t addr = s->base.pc_first;
+#ifdef CONFIG_USER_ONLY
+    return page_get_flags(addr) & PAGE_TARGET_1;
+#else
     int mmu_idx = arm_to_core_mmu_idx(s->mmu_idx);
     unsigned int index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-- 
2.20.1


