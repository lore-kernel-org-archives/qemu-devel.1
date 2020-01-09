Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F2DC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC2720705
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lr7HWUM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC2720705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNur-0004kh-6w
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNsw-0002nj-Ed
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNsv-00067W-48
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:22 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ipNsu-00065Y-Q9
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:20 -0500
Received: by mail-pf1-x441.google.com with SMTP id 195so2589679pfw.11
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XkjF5TjcwaVUPhYaDrBfE80nKWVP4BhqQaLGCvT3zwQ=;
 b=Lr7HWUM7VCKxiTjLgQgMwOiNBU0mgnsowMR2zMh+H28Vo5FlXbScP+sFveSBk/OqTl
 v5e8m7rHyVxTfLoINm6Sr/93fb4jQJMVoGLPXuu2QkTYN7q0IhDCZEP6uJ9JjGzcWivj
 fg2q+RcBTrHqXZ82otsfjgGcSVOg1me1oMIW5mMfQ8pPIJqOHaXoQcCTRBvkEOR+VCg3
 IsRa+XHQ6wA+6r3NcKdnAbGrxgt5rCFysocPq95ynmWFrPm/7OoHgEMtfuTsNjS8be2m
 0hhud7bEafAF1hI79Znes0HVC0POIrtPuDbZq9VGixq3BBMJsNFygEG1cT6NtYHsizfC
 I+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XkjF5TjcwaVUPhYaDrBfE80nKWVP4BhqQaLGCvT3zwQ=;
 b=EY4R0kSZa9E9XDaZoDDcTc1/2kWOay4yK8+0FTPb3l6ixK5GwzsObqEuPW27YaijYg
 fOEuycchqom8NE+eB5BCrWc2ZFSxLfZcjL4B2lF0xNn+FBs0LFGvY/1SYREpoQK5wxdX
 zfS3enutD4ZTmd0MuyHXxmvdMoFNvfiNf0RTIEtKUUeYLZXOWbImPIhc8dc9njOAy7wv
 cyZNWD4nn8CqGLcQ5XQM5atO/4Smfplk18vi5HeSv6ip+pyKkFytnnPgjP+ys83NneFO
 J/MBB/5BtqwVJXqFJDqUpTN2SLvzcimsXTbaQe4aPBWSEVgWZ+7lxhOMPN4sOSf2m6Qu
 kYiQ==
X-Gm-Message-State: APjAAAVTjUka/bzguuA/TDCCxTpHzIeyFPZxodbR2pBbaI/NSmsvalH7
 IP0a3cShL0DPG8ygKO4912dINeAUj3LB1w==
X-Google-Smtp-Source: APXvYqznBH/7UcJT0LnYHND0o45QpyomOB7e5fICvg/d2XHzQOEmDXjDxKvIZZ6rw7C6O+dZ7991zw==
X-Received: by 2002:a65:680f:: with SMTP id l15mr9001671pgt.307.1578538159478; 
 Wed, 08 Jan 2020 18:49:19 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id b4sm5337844pfd.18.2020.01.08.18.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 18:49:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/9] cputlb: Pass CPUTLBDescFast to tlb_n_entries and
 sizeof_tlb
Date: Thu,  9 Jan 2020 13:49:01 +1100
Message-Id: <20200109024907.2730-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109024907.2730-1-richard.henderson@linaro.org>
References: <20200109024907.2730-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

We do not need the entire CPUArchState to compute these values.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e4a8ed9534..49c605b6d8 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -80,14 +80,14 @@ QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_on_cpu_data));
 QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
-static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
+static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
 {
-    return (env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS) + 1;
+    return (fast->mask >> CPU_TLB_ENTRY_BITS) + 1;
 }
 
-static inline size_t sizeof_tlb(CPUArchState *env, uintptr_t mmu_idx)
+static inline size_t sizeof_tlb(CPUTLBDescFast *fast)
 {
-    return env_tlb(env)->f[mmu_idx].mask + (1 << CPU_TLB_ENTRY_BITS);
+    return fast->mask + (1 << CPU_TLB_ENTRY_BITS);
 }
 
 static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
@@ -156,7 +156,7 @@ static void tlb_dyn_init(CPUArchState *env)
 static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
 {
     CPUTLBDesc *desc = &env_tlb(env)->d[mmu_idx];
-    size_t old_size = tlb_n_entries(env, mmu_idx);
+    size_t old_size = tlb_n_entries(&env_tlb(env)->f[mmu_idx]);
     size_t rate;
     size_t new_size = old_size;
     int64_t now = get_clock_realtime();
@@ -236,7 +236,8 @@ static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
     env_tlb(env)->d[mmu_idx].large_page_addr = -1;
     env_tlb(env)->d[mmu_idx].large_page_mask = -1;
     env_tlb(env)->d[mmu_idx].vindex = 0;
-    memset(env_tlb(env)->f[mmu_idx].table, -1, sizeof_tlb(env, mmu_idx));
+    memset(env_tlb(env)->f[mmu_idx].table, -1,
+           sizeof_tlb(&env_tlb(env)->f[mmu_idx]));
     memset(env_tlb(env)->d[mmu_idx].vtable, -1,
            sizeof(env_tlb(env)->d[0].vtable));
 }
@@ -622,7 +623,7 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
     qemu_spin_lock(&env_tlb(env)->c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         unsigned int i;
-        unsigned int n = tlb_n_entries(env, mmu_idx);
+        unsigned int n = tlb_n_entries(&env_tlb(env)->f[mmu_idx]);
 
         for (i = 0; i < n; i++) {
             tlb_reset_dirty_range_locked(&env_tlb(env)->f[mmu_idx].table[i],
-- 
2.20.1


