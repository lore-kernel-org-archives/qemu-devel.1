Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F14DC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A8D20705
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oRzVwyZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A8D20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNui-0004Yn-Uq
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNss-0002m5-Lo
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNsr-0005wc-6b
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:18 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ipNsq-0005sx-T6
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:17 -0500
Received: by mail-pg1-x543.google.com with SMTP id b9so2460128pgk.12
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lOjnREAHRE3NSpPGGVT2torwOdj/k63lQwetVtnWUzc=;
 b=oRzVwyZ1BFwOC6oV6r2a33BMgVDUrI+d71bbIGtIaj9tTyuJagJ7Xv42HYzxrst7eM
 5VDh4g0Kwwxwn4U2nffJfA6idrrod4G64Bpg9TXxwKc1DGc3OZiWhnw40pAHstU9DKZC
 93gmmSHTgPXY49yhiTgHE7EDlXYtRoN02qfkox6oblblXx87lF3rs7CiYqgYnjrpLq2y
 ipSkmNk+fRXdmVdF0kvcuV1uqwTrd3oC/RnPrZo4Q6lu8aXiMeenqpDOTUQhiOlQAmcM
 IxoWOS28FKf3th7U7fcmSLBlThlmxXWd7SCm5NzQQHXnwsS6hsdtACVlgT2JSEglwTlV
 msvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lOjnREAHRE3NSpPGGVT2torwOdj/k63lQwetVtnWUzc=;
 b=qWimyTeLkccy2QprtxuMcYzS69CckFSnrTVllCeGnbSLGmy3myN/dCDaNs4tnL+p0h
 i1pTciK2sStq9QZSJJiIIBxd+TjqEHwraM7lV3+Ao4zmoFrb7Ih0Ia7hGHbqzspnHyGN
 sCqKigByqlr3TCU/BboPs1erHjVGTiISOZYSDKTAjMZFQgtho18PcYNzja+gdZX+l57f
 +vPVSB+RgpR4HViBt1u1GQjfsy3ZttqeaE81oZQb7H1w15CCQQyOFW6skUnaD3KhxfsI
 iiMduvzU2UbLoc9dCilEaEeNVOqYGe3NhUtUg6wU//bOXB7jOV6UVdMlZnld20mfhiRB
 FXSA==
X-Gm-Message-State: APjAAAXCfE9cy+yusbJksAn2VUBH8VrSXGsS9V+RauHKxiVbdzk28m1H
 sw4GPXlJU7JfQROdOqoqoCfhzkrbOuzeDA==
X-Google-Smtp-Source: APXvYqyM3ixX06a5lwqw9cLoRCKzz9z1XMZKmGDQCPiGctMju6u+HKIPCtIRivtFPaerjQFBv6m6Gg==
X-Received: by 2002:a62:b418:: with SMTP id h24mr9103623pfn.192.1578538155085; 
 Wed, 08 Jan 2020 18:49:15 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id b4sm5337844pfd.18.2020.01.08.18.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 18:49:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/9] cputlb: Merge tlb_table_flush_by_mmuidx into
 tlb_flush_one_mmuidx_locked
Date: Thu,  9 Jan 2020 13:48:59 +1100
Message-Id: <20200109024907.2730-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109024907.2730-1-richard.henderson@linaro.org>
References: <20200109024907.2730-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

There is only one caller for tlb_table_flush_by_mmuidx.  Place
the result at the earlier line number, due to an expected user
in the near future.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a991ea2964..1a81886e58 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -224,11 +224,16 @@ static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
     }
 }
 
-static inline void tlb_table_flush_by_mmuidx(CPUArchState *env, int mmu_idx)
+static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
 {
     tlb_mmu_resize_locked(env, mmu_idx);
-    memset(env_tlb(env)->f[mmu_idx].table, -1, sizeof_tlb(env, mmu_idx));
     env_tlb(env)->d[mmu_idx].n_used_entries = 0;
+    env_tlb(env)->d[mmu_idx].large_page_addr = -1;
+    env_tlb(env)->d[mmu_idx].large_page_mask = -1;
+    env_tlb(env)->d[mmu_idx].vindex = 0;
+    memset(env_tlb(env)->f[mmu_idx].table, -1, sizeof_tlb(env, mmu_idx));
+    memset(env_tlb(env)->d[mmu_idx].vtable, -1,
+           sizeof(env_tlb(env)->d[0].vtable));
 }
 
 static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t mmu_idx)
@@ -289,16 +294,6 @@ void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
     *pelide = elide;
 }
 
-static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
-{
-    tlb_table_flush_by_mmuidx(env, mmu_idx);
-    env_tlb(env)->d[mmu_idx].large_page_addr = -1;
-    env_tlb(env)->d[mmu_idx].large_page_mask = -1;
-    env_tlb(env)->d[mmu_idx].vindex = 0;
-    memset(env_tlb(env)->d[mmu_idx].vtable, -1,
-           sizeof(env_tlb(env)->d[0].vtable));
-}
-
 static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 {
     CPUArchState *env = cpu->env_ptr;
-- 
2.20.1


