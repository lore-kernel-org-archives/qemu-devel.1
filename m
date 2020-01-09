Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024B8C33CA1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5517205F4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lOyB9FK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5517205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNzW-0004iX-IG
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNtB-0003Bi-6P
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNt9-0006aC-DX
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:36 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ipNt9-0006Xc-3X
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:35 -0500
Received: by mail-pf1-x444.google.com with SMTP id i23so2618404pfo.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7oSKIrC5QlsP+UfXWHE34ZSkgxpGtuY2yzIIDI3pxVg=;
 b=lOyB9FK9E2skyDHYPmTW/uGY8BzETIK6d+v7I7syXPz7KdzDUd4OgXo2UA1OMycb8G
 S7duWDwInokskO2azizjWsi9ui/BjBnqSmqyMwMugbNIhrxeGfUZUZNszB+j/BNCwwmP
 5YO56UtDNSIKD0mVEoRCOZf/JUWA3UHhkk9DYF4W9dRuSTy7xNA/urIn3WxzsGL2PAjO
 itTGFacu4PLcGnMPDWrmmiPAuFrMhLhn2q8YW0y5vh+1wxkPQXQzfFzlS3v9RQY5MJQD
 EYjkI1Mo87RgKjFpal4l0BeXDdTt0BhxRUYi+aj6aDKKgkifBPVuDcCHPEI7Wxvqjn3G
 /uzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7oSKIrC5QlsP+UfXWHE34ZSkgxpGtuY2yzIIDI3pxVg=;
 b=h8jH9Yh4aoHNnKyv0hvjMocfDw+NDuYY7kq9XlxoNzNL/jVYmasAb45frlSxm6HNf2
 ybeJZ+9aQYm2Tr/lcQ670qZJpqcjCZcp2mjTA5JTDWo1WeQZ03AYaTaS+CexU3ooaPdm
 TWL7fkrrFyMRD8DzEgJ0001ii4XSqVZlIcLpvoTnj00oOB1lVQ8rE0/UcDlBcMrDeSnB
 EHCwsJxORqelpWe8Nf2RNIH4zQrwayMjMuCN1F7AGoN7oaKAirOgt/3YJxJVXPqUCmqX
 XNL24XU1OTPLoANvUXBF8poJlw9NaGCdJiD0ame0MpyZWFioxuauBe5w3XiMpSJI1MZQ
 lxzA==
X-Gm-Message-State: APjAAAWp1whNkRvW8/I/NuLwbLaRXv1Pj+q3ZeaU6W0am1v/YUt//CPV
 n/k/DkJWcZDMBdUoj/uGgbouRV+1ClgFhQ==
X-Google-Smtp-Source: APXvYqxCtUctZcZdDUs528UqTphH25wZkxancVwopX33gwsIEPHrMNaEK1EFg4+oM6Y3AmhngvlCSA==
X-Received: by 2002:a63:534d:: with SMTP id t13mr8329975pgl.89.1578538173727; 
 Wed, 08 Jan 2020 18:49:33 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id b4sm5337844pfd.18.2020.01.08.18.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 18:49:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 9/9] cputlb: Hoist timestamp outside of loops over tlbs
Date: Thu,  9 Jan 2020 13:49:07 +1100
Message-Id: <20200109024907.2730-10-richard.henderson@linaro.org>
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

Do not call get_clock_realtime() in tlb_mmu_resize_locked,
but hoist outside of any loop over a set of tlbs.  This is
only two (indirect) callers, tlb_flush_by_mmuidx_async_work
and tlb_flush_page_locked, so not onerous.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 761e9d44d7..9f6cb36921 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -137,12 +137,12 @@ static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
  * high), since otherwise we are likely to have a significant amount of
  * conflict misses.
  */
-static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
+static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast,
+                                  int64_t now)
 {
     size_t old_size = tlb_n_entries(fast);
     size_t rate;
     size_t new_size = old_size;
-    int64_t now = get_clock_realtime();
     int64_t window_len_ms = 100;
     int64_t window_len_ns = window_len_ms * 1000 * 1000;
     bool window_expired = now > desc->window_begin_ns + window_len_ns;
@@ -222,12 +222,13 @@ static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
     memset(desc->vtable, -1, sizeof(desc->vtable));
 }
 
-static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
+static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx,
+                                        int64_t now)
 {
     CPUTLBDesc *desc = &env_tlb(env)->d[mmu_idx];
     CPUTLBDescFast *fast = &env_tlb(env)->f[mmu_idx];
 
-    tlb_mmu_resize_locked(desc, fast);
+    tlb_mmu_resize_locked(desc, fast, now);
     tlb_mmu_flush_locked(desc, fast);
 }
 
@@ -310,6 +311,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
     CPUArchState *env = cpu->env_ptr;
     uint16_t asked = data.host_int;
     uint16_t all_dirty, work, to_clean;
+    int64_t now = get_clock_realtime();
 
     assert_cpu_is_self(cpu);
 
@@ -324,7 +326,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 
     for (work = to_clean; work != 0; work &= work - 1) {
         int mmu_idx = ctz32(work);
-        tlb_flush_one_mmuidx_locked(env, mmu_idx);
+        tlb_flush_one_mmuidx_locked(env, mmu_idx, now);
     }
 
     qemu_spin_unlock(&env_tlb(env)->c.lock);
@@ -446,7 +448,7 @@ static void tlb_flush_page_locked(CPUArchState *env, int midx,
         tlb_debug("forcing full flush midx %d ("
                   TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
                   midx, lp_addr, lp_mask);
-        tlb_flush_one_mmuidx_locked(env, midx);
+        tlb_flush_one_mmuidx_locked(env, midx, get_clock_realtime());
     } else {
         if (tlb_flush_entry_locked(tlb_entry(env, midx, page), page)) {
             tlb_n_used_entries_dec(env, midx);
-- 
2.20.1


