Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1DDC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D2F2184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gty7Py4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D2F2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoa2Z-0003e3-IZ
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54872)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa2O-0003Ep-VV
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa2N-00055N-GI
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:03:32 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoa2N-00054h-6x
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:03:31 -0400
Received: by mail-pg1-x542.google.com with SMTP id f5so6143368pgu.5
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uNqQ9lhJM4Cw6pjXD4tcjNYk/0atel4QP7/6xSx+c1w=;
 b=Gty7Py4FM4Nsvd3jQBFJqDSQcOAjlbFD2IJZxj2B+rmYnb7PgsR5ubdG7dmPuvDbi5
 ibwpK8dI9V3spLzHMwiBj2zPDuWQEUkKpGaVroazWfpNfbC+WJYelBz1MZHQdloccLIP
 ZXV4zwpkPkdUnXYnnhTr3JZy6NIRtQBOv8CNtiKefiEAxD4PYmn7mlfgZKxjkw3XQcew
 rNeZbiaIRKXm54wnHf0dQW41TpagJu5HBgnlF7Ym4kXtax3KrLfe0nUZbzVaLiTa5ODk
 /O/pkHQkJ7FaUvSqrJf1nxBwagnTg7wZe61AgHznBE6RCTbcXWKxu87nBPUyDp+dK+4Y
 VRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uNqQ9lhJM4Cw6pjXD4tcjNYk/0atel4QP7/6xSx+c1w=;
 b=ekwsdgCIp8SgGR5dRSaY40wxhYUG4fo8SKUtTiXa8niER6YXUknmiEpjbowS2CHRhm
 oZeJUIR7CKcViai+JWAEGoUQrT330pRQKhN0S7QFNf1hpo7IjWxQ1nKCC/ILzyO37nDh
 mFL0HFkguxdxy+bVz4OufIPxS2Z17cRu6HDO1OMiBnwtNyZ2gal2wUpgKUTimmYTza15
 fXduldIDcTFFeui5mszgd6rEe7eS+ZCBUM/+485umycioDwiAmWVRvJbixtgdOr5y8oT
 Hy8ds3F7y/59a0agkN1yZ6ppEgD0Aab3tgkuKrSQeKHvZJA7m5BBUX7yBHoBlpmSVUHc
 ZuiQ==
X-Gm-Message-State: APjAAAUK5pMrP//WLZqukB7nWI2PWxTldq7V0Q5ECdlB/XgxSxviiR77
 G4Vu61pZqIjL75slPMjiaBje9ahStt0=
X-Google-Smtp-Source: APXvYqww+GhM8TFvzkeyjkCsxT45cumUAro9ZB6CRFGyNYOaFgsbCeCWp1Ba9ZGdgpVhSZX2H/Niuw==
X-Received: by 2002:a17:90a:a116:: with SMTP id
 s22mr59569583pjp.47.1563570209719; 
 Fri, 19 Jul 2019 14:03:29 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id i6sm32724751pgi.40.2019.07.19.14.03.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 14:03:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:03:03 -0700
Message-Id: <20190719210326.15466-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719210326.15466-1-richard.henderson@linaro.org>
References: <20190719210326.15466-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH for-4.2 01/24] cputlb: Add
 tlb_set_asid_for_mmuidx
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although we can't do much with ASIDs except remember them, this
will allow cleanups within target/ that should make things clearer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
v2: Assert cpu_is_self; only flush idx w/ asid mismatch.
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
index 9bc713a70b..73584841c0 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -169,6 +169,8 @@ typedef struct CPUTLBDesc {
     size_t n_used_entries;
     /* The next index to use in the tlb victim table.  */
     size_t vindex;
+    /* The current ASID for this tlb.  */
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


