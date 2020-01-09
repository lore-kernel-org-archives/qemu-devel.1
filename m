Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09807C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75E3206F0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E1tAra96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75E3206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNxB-0007gT-En
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:53:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNt6-00033Z-Ht
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNt2-0006Lt-13
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:32 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:33202)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ipNt1-0006Kj-RR
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:49:27 -0500
Received: by mail-pj1-x1041.google.com with SMTP id u63so419218pjb.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1VRoVhZMUP15Xyp0yHS0XscMugYSBb6H/DPjAw3Df78=;
 b=E1tAra96EUHgHi+KJO21T1AirUAe6GZFAKnUsAVcFKP1/M+HHoKD1Otxq1iWqHOneA
 mZibz45Uu1qD5Z8INAjj+p2TcYJLh1AAU/M3GckfV6nkfd4exO8aKTzEWR2wgvQr3OAB
 1M8zA51Y/StRudHRtagL/EMWDfcDUJAD09WURTmfX2xMkN75cJW6LjQkn6WE2THL8pc2
 pelvn9ubIpPR1PLyN/WNQdHcE9tK9+0VU5rF4lHS95svfCj0UDzI1847M03+QUfSkLaU
 eKIc6K85h1Xojljy7iNqD1mWbL2i7ubhnRd2RCJbyIVUcc4vUDllL2o6guY/RQC5QrMM
 gxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1VRoVhZMUP15Xyp0yHS0XscMugYSBb6H/DPjAw3Df78=;
 b=VEOd+vBsYaT5NJfItNKVSCmxyC0HlA1F8e+3BiySNtXkdXYyj/cIB9gEUnWZzDj359
 D2GbI6MXyV2QDUichRaN2be2RVriVcfLu1fTtp5nJPjuT6yZ4tbF4wq0lsZ905JycYCR
 BGPkNziUqUwyw8cGAfKOUdajq2c2tRKNvFtman6SDFXMP9cmEklkq2FRE2F5Y7jhVm+s
 ERyvxC1uZRtK1jSo6gUrc+JqjMKX8DAb5C4xIgBJWgEeIiytR4fJLcwUUvOfh4ZxRV/K
 ahhj2wu3rKzXa6bW/g0t+aWIAaLss4SAowzdBcH+zrIaE/ADhYgfB+gLwCAbRCBcO9yo
 TtvA==
X-Gm-Message-State: APjAAAV+mC1NPTPnl2m1rR4kPNaVMwhGLfSPARxFUOxn6BM4tFG0t9MB
 BImCWKQZfEoXGBLnQp7xs/xyzcotQqa8SQ==
X-Google-Smtp-Source: APXvYqwg8fNb+G1AFZWW9c0xRfPTI6FVWVbXhxW60vSAjwAvIj4afLCHBgtMKtR0xtXsxwY8CxvMIA==
X-Received: by 2002:a17:90a:868b:: with SMTP id
 p11mr2444509pjn.60.1578538166609; 
 Wed, 08 Jan 2020 18:49:26 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id b4sm5337844pfd.18.2020.01.08.18.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 18:49:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/9] cputlb: Split out tlb_mmu_flush_locked
Date: Thu,  9 Jan 2020 13:49:04 +1100
Message-Id: <20200109024907.2730-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109024907.2730-1-richard.henderson@linaro.org>
References: <20200109024907.2730-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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

We will want to be able to flush a tlb without resizing.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index eff427f137..e60e501334 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -228,12 +228,8 @@ static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
     }
 }
 
-static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
+static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
 {
-    CPUTLBDesc *desc = &env_tlb(env)->d[mmu_idx];
-    CPUTLBDescFast *fast = &env_tlb(env)->f[mmu_idx];
-
-    tlb_mmu_resize_locked(desc, fast);
     desc->n_used_entries = 0;
     desc->large_page_addr = -1;
     desc->large_page_mask = -1;
@@ -242,6 +238,15 @@ static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
     memset(desc->vtable, -1, sizeof(desc->vtable));
 }
 
+static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
+{
+    CPUTLBDesc *desc = &env_tlb(env)->d[mmu_idx];
+    CPUTLBDescFast *fast = &env_tlb(env)->f[mmu_idx];
+
+    tlb_mmu_resize_locked(desc, fast);
+    tlb_mmu_flush_locked(desc, fast);
+}
+
 static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t mmu_idx)
 {
     env_tlb(env)->d[mmu_idx].n_used_entries++;
-- 
2.20.1


