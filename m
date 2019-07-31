Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A08C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028F620659
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHN9Ri7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028F620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvNo-0005uS-2L
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60599)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMZ-0003vr-Kg
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMY-0003H0-6V
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:19 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46529)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvMY-0003Gh-03
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:18 -0400
Received: by mail-pf1-x444.google.com with SMTP id c3so9373387pfa.13
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3Vv1PJfuLW2Q3y6jhZwS+VA5WdsiwenJEhdiHqcPU8E=;
 b=UHN9Ri7INF29P80/b9NdjhxTy8SPM+M2VMwY0AJl5Igm1w4JA4pRaa4rdxWtUTls8r
 BwBAmwaWQPRpHk1JrvnweqW3TC0WT0YHKSW7omxdpNQh/LwLT74ok9c1Km9b2mVMcGFi
 aWmjsqG3OHPDlcbNnhfoN8JrogF0ucwsmaGTOAW63L3ZnrEXsOnKkQrJ56frq2ZdALFb
 VXQUldBYkUlfdJOpwj03UWgXB502/M6IRQ7eSzEFgbhjopCyE27+kaQm5vfACBaP7AnK
 wxMZbi0gmdttuWpCUmZx7r+5W5awZxidi4a/V9KCDsoQLbsOOwXuHGnV6M37q9xf0JjU
 szig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3Vv1PJfuLW2Q3y6jhZwS+VA5WdsiwenJEhdiHqcPU8E=;
 b=FbjiMBZvVqTrhanxeOew8wubWqiF59Lgwovf3VRJqubKsh0B9RuxkatnWCgB1LWWOj
 NPINz1Z7jqzBLcSv/xR2DdTaNk7rUCX3lkpSTAnhYdyszkQjUW5/8ZEunHS07JjJaXQd
 EZZsMPgJiJBKu17UrzSkH4EqEK3AIitKkwsidmvlsrKTbICDXBPCxOf0Jq1mSF9cb7M0
 UlSPb/++D/dq0A1ZGfPIDMKvmRBB8zj/2Bs+/FWT2xkkuONibxa3nS1AHhayt80hOd/T
 jdwim9aDMis8W8WZvjGiv6mkbJ3uvgK2g8fjtdtyyHMh5DhmpYbyYSRGTTlSDxsQ0uW0
 yP2A==
X-Gm-Message-State: APjAAAXm+Ej8vaJICjBaBm1IqEK880Bc+kJtZXqVmsyE5XLaNZtV5S3P
 eLAQdjlKC5cFmekyLPwjqluvai0muRI=
X-Google-Smtp-Source: APXvYqwDPcKf+ZZvl6tAtuy9oiYCe6HiatU4e0VHY/ab6pwUF4w0YU3MEqjLGb59jIR95iuJ8fFEjw==
X-Received: by 2002:a62:764d:: with SMTP id r74mr51255602pfc.110.1564605496727; 
 Wed, 31 Jul 2019 13:38:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:37:42 -0700
Message-Id: <20190731203813.30765-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 01/32] cputlb: Add tlb_set_asid_for_mmuidx
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although we can't do much with ASIDs except remember them, this
will allow cleanups within target/ that should make things clearer.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Assert cpu_is_self; only flush idx w/ asid mismatch.
v3: Improve asid comment.
---
 include/exec/cpu-all.h  | 11 +++++++++++
 include/exec/cpu-defs.h |  2 ++
 include/exec/exec-all.h | 19 +++++++++++++++++++
 accel/tcg/cputlb.c      | 26 ++++++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 536ea58f81..40b140cbba 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -439,4 +439,15 @@ static inline CPUTLB *env_tlb(CPUArchState *env)
     return &env_neg(env)->tlb;
 }
 
+/**
+ * cpu_tlb(env)
+ * @cpu: The generic CPUState
+ *
+ * Return the CPUTLB state associated with the cpu.
+ */
+static inline CPUTLB *cpu_tlb(CPUState *cpu)
+{
+    return &cpu_neg(cpu)->tlb;
+}
+
 #endif /* CPU_ALL_H */
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 9bc713a70b..b42986d822 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -169,6 +169,8 @@ typedef struct CPUTLBDesc {
     size_t n_used_entries;
     /* The next index to use in the tlb victim table.  */
     size_t vindex;
+    /* The current ASID for this tlb, if used; otherwise ignored.  */
+    uint32_t asid;
     /* The tlb victim table, in two parts.  */
     CPUTLBEntry vtable[CPU_VTLB_SIZE];
     CPUIOTLBEntry viotlb[CPU_VTLB_SIZE];
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 16034ee651..9c77aa5bf9 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -225,6 +225,21 @@ void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, uint16_t idxmap);
  * depend on when the guests translation ends the TB.
  */
 void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, uint16_t idxmap);
+/**
+ * tlb_set_asid_for_mmuidx:
+ * @cpu: Originating cpu
+ * @asid: Address Space Identifier
+ * @idxmap: bitmap of MMU indexes to set to @asid
+ * @depmap: bitmap of dependent MMU indexes
+ *
+ * Set an ASID for all of @idxmap.  If any previous ASID was different,
+ * then we will flush the mmu idx.  If a flush is required, then also flush
+ * all dependent mmu indicies in @depmap.  This latter is typically used
+ * for secondary page resolution, for implementing virtualization within
+ * the guest.
+ */
+void tlb_set_asid_for_mmuidx(CPUState *cpu, uint32_t asid,
+                             uint16_t idxmap, uint16_t dep_idxmap);
 /**
  * tlb_set_page_with_attrs:
  * @cpu: CPU to add this TLB entry for
@@ -310,6 +325,10 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                        uint16_t idxmap)
 {
 }
+static inline void tlb_set_asid_for_mmuidx(CPUState *cpu, uint32_t asid,
+                                           uint16_t idxmap, uint16_t depmap)
+{
+}
 #endif
 
 #define CODE_GEN_ALIGN           16 /* must be >= of the size of a icache line */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index bb9897b25a..c68f57755b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -540,6 +540,32 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, target_ulong addr)
     tlb_flush_page_by_mmuidx_all_cpus_synced(src, addr, ALL_MMUIDX_BITS);
 }
 
+void tlb_set_asid_for_mmuidx(CPUState *cpu, uint32_t asid, uint16_t idxmap,
+                             uint16_t depmap)
+{
+    CPUTLB *tlb = cpu_tlb(cpu);
+    uint16_t work, to_flush = 0;
+
+    /* It doesn't make sense to set context across cpus.  */
+    assert_cpu_is_self(cpu);
+
+    /*
+     * We don't support ASIDs except for trivially.
+     * If there is any change, then we must flush the TLB.
+     */
+    for (work = idxmap; work != 0; work &= work - 1) {
+        int mmu_idx = ctz32(work);
+        if (tlb->d[mmu_idx].asid != asid) {
+            tlb->d[mmu_idx].asid = asid;
+            to_flush |= 1 << mmu_idx;
+        }
+    }
+    if (to_flush) {
+        to_flush |= depmap;
+        tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(to_flush));
+    }
+}
+
 /* update the TLBs so that writes to code in the virtual page 'addr'
    can be detected */
 void tlb_protect_code(ram_addr_t ram_addr)
-- 
2.17.1


