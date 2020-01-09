Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DB2C33CA2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51984206F0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r6JgBjCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51984206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNxC-0007iq-0U
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:53:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNt2-0002xK-FS
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNsx-0006ET-MF
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:28 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ipNsx-0006C3-DO
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:23 -0500
Received: by mail-pf1-x444.google.com with SMTP id 2so2588376pfg.12
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XoAjYNfihA3pIGGqUIgB1dF/4sSPCxOSmNDHQZwJ7Ug=;
 b=r6JgBjCbX+iAzAo3az7wVE6MO56Fl41zL8f5lLPDlelxnsfbcv9zpjRwgCc+fFSQA7
 d/jdcCGQddvlYHvcxKN4edPMVptyqwRTpI25DCVZ5DH2scbJBJgvDBdZcEFlHFIUlrhI
 7FfJmXuTg3AsMWtpfY84WirAf3DOO+cihzG0r9LWmO1EKg1DXpY9dFLe682cAvsdUQOk
 Y9u24WdlLDLfn8Mja0K1y5Bngx47rbSGu/HkH+FWKfWgxKrQAyGp9L5cOdQPzoI1qgQK
 edfzClUhlkh/FrqQ+++Q0FWhdJmTsgtBWlI4gnWHW84ctDD39qvc+ng+Qzyq9tE8V6jO
 zaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XoAjYNfihA3pIGGqUIgB1dF/4sSPCxOSmNDHQZwJ7Ug=;
 b=Yhrd5sPgRq7OOWWPbElbt/Egh7pFm5QVCEuiUoCWvBCGwNjVgyOD6rgROuWUPi6VqB
 +66jw9vevUYFyNvVyFvOV3Hbge6pEbuKqQxM7i8WJlaTgFXQ78x2L7ZfDnIN8YwGBzr9
 /yEMRUNqPOpfNPQICgleQB3VCHYEfT59VNX0QVZjQwIPR1cxaoZf/fm1Vjx4CVj4tPb1
 jDU5diUJYWY5+Yq6+0D3ALX43SDCSH5x6mQsv7KHx+3XfnW/TEjnTOFaaj3C0vEmLHio
 PwP+zE/KnRMsfOwY4RrmuOem+++zDhgqIzFL9iFdjSmRxoni5yMUvIEXIz0ouJcvmWXV
 ZPjg==
X-Gm-Message-State: APjAAAX6zk6CnG3zusgxg4Ifc0GENbQhaZxb3J0IxnjeHgWQb01et9BR
 E66lPCk+Lm+MdDCnQsyU2KdbBygfxvLQxA==
X-Google-Smtp-Source: APXvYqwHSCGZtSusFZHT8Z0439TTfSajYojF25z5nOtewuLCnhLdhI7mCe6phd7CBQhQmzwyQl+y7w==
X-Received: by 2002:a63:ed4a:: with SMTP id m10mr7793045pgk.99.1578538161944; 
 Wed, 08 Jan 2020 18:49:21 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id b4sm5337844pfd.18.2020.01.08.18.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 18:49:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/9] cputlb: Hoist tlb portions in tlb_mmu_resize_locked
Date: Thu,  9 Jan 2020 13:49:02 +1100
Message-Id: <20200109024907.2730-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109024907.2730-1-richard.henderson@linaro.org>
References: <20200109024907.2730-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No functional change, but the smaller expressions make
the code easier to read.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 49c605b6d8..c7dc1dc85a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -115,8 +115,8 @@ static void tlb_dyn_init(CPUArchState *env)
 
 /**
  * tlb_mmu_resize_locked() - perform TLB resize bookkeeping; resize if necessary
- * @env: CPU that owns the TLB
- * @mmu_idx: MMU index of the TLB
+ * @desc: The CPUTLBDesc portion of the TLB
+ * @fast: The CPUTLBDescFast portion of the same TLB
  *
  * Called with tlb_lock_held.
  *
@@ -153,10 +153,9 @@ static void tlb_dyn_init(CPUArchState *env)
  * high), since otherwise we are likely to have a significant amount of
  * conflict misses.
  */
-static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
+static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
 {
-    CPUTLBDesc *desc = &env_tlb(env)->d[mmu_idx];
-    size_t old_size = tlb_n_entries(&env_tlb(env)->f[mmu_idx]);
+    size_t old_size = tlb_n_entries(fast);
     size_t rate;
     size_t new_size = old_size;
     int64_t now = get_clock_realtime();
@@ -198,14 +197,15 @@ static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
         return;
     }
 
-    g_free(env_tlb(env)->f[mmu_idx].table);
-    g_free(env_tlb(env)->d[mmu_idx].iotlb);
+    g_free(fast->table);
+    g_free(desc->iotlb);
 
     tlb_window_reset(desc, now, 0);
     /* desc->n_used_entries is cleared by the caller */
-    env_tlb(env)->f[mmu_idx].mask = (new_size - 1) << CPU_TLB_ENTRY_BITS;
-    env_tlb(env)->f[mmu_idx].table = g_try_new(CPUTLBEntry, new_size);
-    env_tlb(env)->d[mmu_idx].iotlb = g_try_new(CPUIOTLBEntry, new_size);
+    fast->mask = (new_size - 1) << CPU_TLB_ENTRY_BITS;
+    fast->table = g_try_new(CPUTLBEntry, new_size);
+    desc->iotlb = g_try_new(CPUIOTLBEntry, new_size);
+
     /*
      * If the allocations fail, try smaller sizes. We just freed some
      * memory, so going back to half of new_size has a good chance of working.
@@ -213,25 +213,24 @@ static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
      * allocations to fail though, so we progressively reduce the allocation
      * size, aborting if we cannot even allocate the smallest TLB we support.
      */
-    while (env_tlb(env)->f[mmu_idx].table == NULL ||
-           env_tlb(env)->d[mmu_idx].iotlb == NULL) {
+    while (fast->table == NULL || desc->iotlb == NULL) {
         if (new_size == (1 << CPU_TLB_DYN_MIN_BITS)) {
             error_report("%s: %s", __func__, strerror(errno));
             abort();
         }
         new_size = MAX(new_size >> 1, 1 << CPU_TLB_DYN_MIN_BITS);
-        env_tlb(env)->f[mmu_idx].mask = (new_size - 1) << CPU_TLB_ENTRY_BITS;
+        fast->mask = (new_size - 1) << CPU_TLB_ENTRY_BITS;
 
-        g_free(env_tlb(env)->f[mmu_idx].table);
-        g_free(env_tlb(env)->d[mmu_idx].iotlb);
-        env_tlb(env)->f[mmu_idx].table = g_try_new(CPUTLBEntry, new_size);
-        env_tlb(env)->d[mmu_idx].iotlb = g_try_new(CPUIOTLBEntry, new_size);
+        g_free(fast->table);
+        g_free(desc->iotlb);
+        fast->table = g_try_new(CPUTLBEntry, new_size);
+        desc->iotlb = g_try_new(CPUIOTLBEntry, new_size);
     }
 }
 
 static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
 {
-    tlb_mmu_resize_locked(env, mmu_idx);
+    tlb_mmu_resize_locked(&env_tlb(env)->d[mmu_idx], &env_tlb(env)->f[mmu_idx]);
     env_tlb(env)->d[mmu_idx].n_used_entries = 0;
     env_tlb(env)->d[mmu_idx].large_page_addr = -1;
     env_tlb(env)->d[mmu_idx].large_page_mask = -1;
-- 
2.20.1


