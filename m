Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AC7C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:10:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439942075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EovjxdH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439942075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50117 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYdBE-00080O-E5
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 17:10:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYcyF-0006E6-Nq
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYcyD-0008JM-QM
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:57:19 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYcyD-0008FC-GF
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:57:17 -0400
Received: by mail-ot1-x342.google.com with SMTP id b7so2050481otl.11
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ZCHRkKij7pQF0R23SJZo3xfE1Nbsenr9fc05DQb889w=;
	b=EovjxdH3T/hFo28fwmEY4teqysvGF3kpTosbWNfLqUUzpCL/8VbOr3ZGjDF1pTpI8B
	oPHN+5wO3+zDIAIxJRJsvvbX9gAgMWjpbzFADf9Lz5j9VO0UzuruG3h8PqUiUw1Zrt1f
	y5vuroM/lNzamL3UIV0WTJCsP1I3I3uy+wp9ctYDAGfNBw9ceHa4QzpkjTbsf5uderb6
	97i3uUECZOUwXgKhu0RFjLZc6jrzMTogEwJhpyzDTujT6CbfcZi3HNljgukKMl8k4tZt
	IC2bgX9MZ3N5Y+mnhjF+D5pROkgOhWcOUBHAmwbcjaOjDCjP/JplwRwQ1zaLjJ7DoTCc
	ze2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ZCHRkKij7pQF0R23SJZo3xfE1Nbsenr9fc05DQb889w=;
	b=LKP7UWYACCwNELBUfW+g6tZRzCOrijQTCTOoqpoBGLvZkFZN/k3kyVXqfhdSQiwMRM
	a3p6uwoqyrRcOxZKIBVVvyut/3yFzq4AA/+4QoLbOpp1NxxohV1/NElDbrCOaQczBJe9
	rRUPrqa/tXvEvoBvkWuLttsTMjJi5jMoe2Hstv1ArxhaQ3KwouA+r6MdiuS3tfeKbt4O
	6qO5keWJsiBDjThYplC8Phu0USGW5/mwxy+ksOvNPBiJ1pqwZVOvgLXMoDu80B776zQb
	YWIMDlZmpSxuY/r6J37PiYICSN5Nd5C8oPhdl1ElsnX2BaHLAfOF7FvpiI2nyiwI1mrf
	oZUQ==
X-Gm-Message-State: APjAAAUUOEO6w/LBCyTVLkJsBSu5xLmgCveuoipJYHDThs+QhOPBWKQU
	h/DsR3F7PEAWEfDQVdU+u7Or10kAyZ5Ucg==
X-Google-Smtp-Source: APXvYqy18XEoP8fT2E9NlREr0NTN1kEIaLyYkvPqMMbn+29/iX9lk1cEw+LcEtEBCitX6HwiJPOtow==
X-Received: by 2002:a9d:7c8b:: with SMTP id q11mr4161202otn.161.1559768236302; 
	Wed, 05 Jun 2019 13:57:16 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id f5sm7414155otl.51.2019.06.05.13.57.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 13:57:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 15:57:03 -0500
Message-Id: <20190605205706.569-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605205706.569-1-richard.henderson@linaro.org>
References: <20190605205706.569-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: [Qemu-devel] [PATCH v6 3/6] linux-user: Set PAGE_TARGET_1 for
 TARGET_PROT_BTI
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, Dave.Martin@arm.com
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
index da07ce311f..e65530acae 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -249,6 +249,8 @@ extern intptr_t qemu_host_page_mask;
 /* FIXME: Code that sets/uses this is broken and needs to go away.  */
 #define PAGE_RESERVED  0x0020
 #endif
+/* Target-specific bits that will be used via page_get_flags().  */
+#define PAGE_TARGET_1  0x0080
 
 #if defined(CONFIG_USER_ONLY)
 void page_dump(FILE *f);
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 7f141f699c..9a8a14e81e 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1097,6 +1097,10 @@ struct target_winsize {
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
index 3117f57fd8..def64a41d5 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -85,6 +85,22 @@ static int validate_prot_to_pageflags(int *host_prot, int prot)
      */
     *host_prot = prot & (PROT_READ | PROT_WRITE | PROT_EXEC);
 
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
index 092f0df3c4..5043344eba 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14115,10 +14115,10 @@ static void disas_data_proc_simd_fp(DisasContext *s, uint32_t insn)
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
2.17.1


