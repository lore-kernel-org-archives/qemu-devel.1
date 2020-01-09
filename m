Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461B6C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09019205F4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NoY5F58w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09019205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNzV-0004jk-Vt
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNt2-0002xu-Rn
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNsz-0006Ho-SA
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:28 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38161)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ipNsz-0006GR-LI
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:25 -0500
Received: by mail-pl1-x644.google.com with SMTP id f20so1924747plj.5
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=taUAUKC6BKYXJEWWKuFwpPcKa1boShSWsRP/UsHn9jc=;
 b=NoY5F58wu95p5ldgu3bNBAWK5JMbnfBU3g+F+E1zD/Q+rq0MYLKV7uOWPmxGEOkwZU
 PMXYV59UHLZMwm/2yRf/HvYnKLHDqeqzSWlKvm2LlknbhSbvCvJQ4ZSBZPNy9/AIUeAC
 8RgCfFdDRmL/fCvQgf8allmpWdNqYNcO44rOGKuIM1S3SabFgZc2HpGo7LZIwWe+ay+R
 EbkHvLLKCt10jLb326PsJI8FP1MVEo/xZT8rLZuW4dNBNLsbNrMlJwaxMTAbOYGQ7MxK
 1Sn5N2xDxoye/2QetoZVRKA+8SNqX9eA+u3oVy3xCD/ja6ABDKpDFWuUrexEjpxQeblj
 M9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=taUAUKC6BKYXJEWWKuFwpPcKa1boShSWsRP/UsHn9jc=;
 b=DpWToTPPo38bTjvbE2ufh6ScwinEGEz+bHKBkSvQkOP1cQfVDn+h0nlvvNw/vX3tTb
 /FQkn2QPWSx5fIvHTBVpsk5W2rr6csmkSVH84f1MuvRVpP6NorrNOHT/5Gnx1PlfWuse
 /i7md5u92COCdyBC/TYawxUWmqSHAJy7Gz04bPDGosvZPW/QyiLDGjXZsshK+9/7w9RV
 rRcNtV9z1Y4pPjAFHYraT/Rg2k2gIzqvMIhDx5ASbQ5Jx8xqhleemylkX1UCzkYWTvHA
 2gffHAaV3tGtFTGfo3s0O9CeC1xfpgTLyDiRJeYH2IniFTbtefHD3vgVbRSZ4Bwmsg8C
 2urA==
X-Gm-Message-State: APjAAAUcMC5EFo5XQTY4fMKHQf3QgQ1HO7ptvuyqLgMUoNkPvKT6Kviw
 O/r3wx4M+Q8pfugH7Ti07ewhT6I3XoI2cQ==
X-Google-Smtp-Source: APXvYqywWaeSXJAIrdRZfSmM8cQ2aNPP+hL3PNUgcenuAxXjAf1Z9dnvwjP3m4G8g7OGPfdTZaSbOA==
X-Received: by 2002:a17:90a:b904:: with SMTP id
 p4mr2496940pjr.62.1578538164395; 
 Wed, 08 Jan 2020 18:49:24 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id b4sm5337844pfd.18.2020.01.08.18.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 18:49:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/9] cputlb: Hoist tlb portions in tlb_flush_one_mmuidx_locked
Date: Thu,  9 Jan 2020 13:49:03 +1100
Message-Id: <20200109024907.2730-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109024907.2730-1-richard.henderson@linaro.org>
References: <20200109024907.2730-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
 accel/tcg/cputlb.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c7dc1dc85a..eff427f137 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -230,15 +230,16 @@ static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
 
 static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
 {
-    tlb_mmu_resize_locked(&env_tlb(env)->d[mmu_idx], &env_tlb(env)->f[mmu_idx]);
-    env_tlb(env)->d[mmu_idx].n_used_entries = 0;
-    env_tlb(env)->d[mmu_idx].large_page_addr = -1;
-    env_tlb(env)->d[mmu_idx].large_page_mask = -1;
-    env_tlb(env)->d[mmu_idx].vindex = 0;
-    memset(env_tlb(env)->f[mmu_idx].table, -1,
-           sizeof_tlb(&env_tlb(env)->f[mmu_idx]));
-    memset(env_tlb(env)->d[mmu_idx].vtable, -1,
-           sizeof(env_tlb(env)->d[0].vtable));
+    CPUTLBDesc *desc = &env_tlb(env)->d[mmu_idx];
+    CPUTLBDescFast *fast = &env_tlb(env)->f[mmu_idx];
+
+    tlb_mmu_resize_locked(desc, fast);
+    desc->n_used_entries = 0;
+    desc->large_page_addr = -1;
+    desc->large_page_mask = -1;
+    desc->vindex = 0;
+    memset(fast->table, -1, sizeof_tlb(fast));
+    memset(desc->vtable, -1, sizeof(desc->vtable));
 }
 
 static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t mmu_idx)
-- 
2.20.1


