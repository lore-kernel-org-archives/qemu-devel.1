Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B94C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C5A208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iY6j3nvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C5A208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBvBx-0006DG-MZ
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6b-0006F9-MV
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6Z-0001xe-Q9
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:37 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42707)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBv6Z-0001vs-Jf
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:35 -0400
Received: by mail-pl1-x643.google.com with SMTP id t3so613231plz.9
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Tz6r3+bMnyO04HqqXq5aHLFFiU4Amy53tPfIpPhOcd0=;
 b=iY6j3nvVY5+1mQagFTmecA511o9b0ILObTCimvRrrl3YbKGbCuEWO9y0TAksf9STzJ
 Jhc005Jx+vL3VyAm9GUq08M8WxBGQX/pMAqbJeCLUlLFY5KNytNBFNqfyRehExCwvYgC
 4PTaZs7w8Rxs/yonODh+eY3QRjdVBmaXaoocQgugj5bpyRKiANwoG6paPfVmEiFJbKeb
 mLtYEg0SLg2Kl8EL+Gz19pF1lAmdFLA/6pGW0MouAdPS0yXuyYClmLQa2Mjyl0/cgEah
 IML880+wuN3TmdARqkKLmKC7gbbYJvOdXuNNnUN9mRfWxOpd6sYXDcW67uqkXonBAJWQ
 CFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tz6r3+bMnyO04HqqXq5aHLFFiU4Amy53tPfIpPhOcd0=;
 b=SvRecTS1Jm9+h/iSS2baDfsrki1W4DKIFMu+jDnXuP9aK+pNh9x9C1o2lgV7/Vr05c
 xotaku8K4rccIDgDJLWxVe+IFZq49Q2nqzsJGJRqv6j8iL+g7c+90Bm7sW4cgVjtuknv
 ehwD5oRZozGjG1MTPLBzCNM6oIyJ/GkBDHzwlY65PnnmhWD3KB3FsqCrPw7QG66jqIL6
 iDXgkRuaSnZTwo6XtlLx5bqNgaGTlsIn/AFjnbq/ofwSINpE2p1RuxlXh4kCkVtl5vAO
 8dfOE9OMcVr8GZjh1zabVx4uCy4qq/K7TZ+yI+dXgOJnPTaMwURBPkZSMF+480BmM3jf
 /OBw==
X-Gm-Message-State: ANhLgQ2J/hf2cOnonC17a0Aw8YtGbHta0gv1rWSMdUynZKRxxFck4NI2
 Hd852ffcYNYH2CQLb8ivbVau6f2+J/Q=
X-Google-Smtp-Source: ADFU+vtbUuD/CUGb6wvvwD6jmbSIU78VhoSeyfEvrrkp/Qh/tGMvJCPfyW/FpF0PFwHpvpEWfjA0zg==
X-Received: by 2002:a17:90b:3653:: with SMTP id
 nh19mr1896194pjb.41.1583909073613; 
 Tue, 10 Mar 2020 23:44:33 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id z3sm50137807pfz.155.2020.03.10.23.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 23:44:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/16] target/arm: Handle watchpoints in sve_ld1_r
Date: Tue, 10 Mar 2020 23:44:13 -0700
Message-Id: <20200311064420.30606-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311064420.30606-1-richard.henderson@linaro.org>
References: <20200311064420.30606-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Handle all of the watchpoints for active elements all at once,
before we've modified the vector register.  This removes the
TLB_WATCHPOINT bit from page[].flags, which means that we can
use the normal fast path via RAM.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 70 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index b827900a4e..2c0e838ed3 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4377,6 +4377,68 @@ static bool sve_cont_ldst_pages(SVEContLdSt *info, SVEContFault fault,
     return have_work;
 }
 
+static void sve_cont_ldst_watchpoints(SVEContLdSt *info, CPUARMState *env,
+                                      uint64_t *vg, target_ulong addr,
+                                      int esize, int msize, int wp_access,
+                                      uintptr_t retaddr)
+{
+#ifndef CONFIG_USER_ONLY
+    intptr_t mem_off, reg_off, reg_last;
+    int flags0 = info->page[0].flags;
+    int flags1 = info->page[1].flags;
+
+    if (likely(!((flags0 | flags1) & TLB_WATCHPOINT))) {
+        return;
+    }
+
+    /* Indicate that watchpoints are handled. */
+    info->page[0].flags = flags0 & ~TLB_WATCHPOINT;
+    info->page[1].flags = flags1 & ~TLB_WATCHPOINT;
+
+    if (flags0 & TLB_WATCHPOINT) {
+        mem_off = info->mem_off_first[0];
+        reg_off = info->reg_off_first[0];
+        reg_last = info->reg_off_last[0];
+
+        while (reg_off <= reg_last) {
+            uint64_t pg = vg[reg_off >> 6];
+            do {
+                if ((pg >> (reg_off & 63)) & 1) {
+                    cpu_check_watchpoint(env_cpu(env), addr + mem_off, msize,
+                                         info->page[0].attrs, wp_access, retaddr);
+                }
+                reg_off += esize;
+                mem_off += msize;
+            } while (reg_off <= reg_last && (reg_off & 63));
+        }
+    }
+
+    mem_off = info->mem_off_split;
+    if (mem_off >= 0) {
+        cpu_check_watchpoint(env_cpu(env), addr + mem_off, msize,
+                             info->page[0].attrs, wp_access, retaddr);
+    }
+
+    mem_off = info->mem_off_first[1];
+    if ((flags1 & TLB_WATCHPOINT) && mem_off >= 0) {
+        reg_off = info->reg_off_first[1];
+        reg_last = info->reg_off_last[1];
+
+        do {
+            uint64_t pg = vg[reg_off >> 6];
+            do {
+                if ((pg >> (reg_off & 63)) & 1) {
+                    cpu_check_watchpoint(env_cpu(env), addr + mem_off, msize,
+                                         info->page[1].attrs, wp_access, retaddr);
+                }
+                reg_off += esize;
+                mem_off += msize;
+            } while (reg_off & 63);
+        } while (reg_off <= reg_last);
+    }
+#endif
+}
+
 /*
  * The result of tlb_vaddr_to_host for user-only is just g2h(x),
  * which is always non-null.  Elide the useless test.
@@ -4418,13 +4480,19 @@ void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
     /* Probe the page(s).  Exit with exception for any invalid page. */
     sve_cont_ldst_pages(&info, FAULT_ALL, env, addr, MMU_DATA_LOAD, retaddr);
 
+    /* Handle watchpoints for all active elements. */
+    sve_cont_ldst_watchpoints(&info, env, vg, addr, 1 << esz, 1 << msz,
+                              BP_MEM_READ, retaddr);
+
+    /* TODO: MTE check. */
+
     flags = info.page[0].flags | info.page[1].flags;
     if (unlikely(flags != 0)) {
 #ifdef CONFIG_USER_ONLY
         g_assert_not_reached();
 #else
         /*
-         * At least one page includes MMIO (or watchpoints).
+         * At least one page includes MMIO.
          * Any bus operation can fail with cpu_transaction_failed,
          * which for ARM will raise SyncExternal.  Perform the load
          * into scratch memory to preserve register state until the end.
-- 
2.20.1


