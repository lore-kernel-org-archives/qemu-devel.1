Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DA0C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA65206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mvLm/EYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA65206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8ft-0006dj-UU
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zk-0002Fh-JK
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zj-00077g-Hm
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id g12so19267025wmh.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jV/qm0vfQeL36nxU7yJTC7OgWOYWmRQHmrb3r6wEVZo=;
 b=mvLm/EYlSp9S7vn4fZG5ExVSLI6oL1lGx/4b7yc0xzOxrR4g0X3FZNUfgeoy0PUVoH
 QrW/acUXvuNvmeG9tC5YpWerubCcwCpf91UkAmZKBVILy5e4Ri0UOkfEpsf9DWKLf5ZS
 7IKrZfD8ZLKBOLIcdDbavcwLlM187n3hzJRbyun1FZ8SUVlXaGzNaQmfWiPMybl16OfI
 JsyMbBg1TfXyHw+5InaL0lok1RAI26auOiGAka1GaPfiJ7fRjfNOhWV2ZmebjMqRn3Ls
 RwCy11YiTESkorSNKEsVPPkvfifzAeMfVcnsSLn6qdADQwaejg4dl3UaYHxEw4yz2WaD
 Gseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jV/qm0vfQeL36nxU7yJTC7OgWOYWmRQHmrb3r6wEVZo=;
 b=ap9N1Zkm7gANjafPvRlSRPECjA7Ekk/pblj2SCA/wnEOk8TwqNBvp95UOoU5uIoeLC
 emcysfhtkOHz3yQ8TCD2LYzorp5+P0pHFHJz6zrAKQi6hMaXJMHaN4/EqJYPIdpZ+o1d
 90lAqe3ZkLj62GZElHxiw6htUESS013vY/fLxvMBL7l3lJqv2z1miehbr6y4mQK4g7Hw
 ++Eh/IRWAdCsrZnMJvxkWr3EGB4Km0CfjColf4PfwKfDm8KolMgsL04kLWAnOlTu+owy
 53XoBxLV5H16YbdHCSiObv23k3B15uYnbxrx5/02+2iU3ZV9ypmGdbejRyvSwlURU4xk
 uNTA==
X-Gm-Message-State: AGi0PuYG9wrwiMPt9j5rm/EnZu3JGculUJVXToVXagG1BsO9/RbksyRP
 e4nbswUp237UBBN/mnAjI9soEOKmKRPV5w==
X-Google-Smtp-Source: APiQypIZHdbkpt3MEgN+PlpXQxKeOQOLNwIminoMjIrBrX/LmZkJhN51pHb5fVx0fyz3HFZzUgisbQ==
X-Received: by 2002:a7b:c08b:: with SMTP id r11mr30183455wmh.45.1589204069928; 
 Mon, 11 May 2020 06:34:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/34] target/arm: Handle watchpoints in sve_ld1_r
Date: Mon, 11 May 2020 14:33:50 +0100
Message-Id: <20200511133405.5275-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Handle all of the watchpoints for active elements all at once,
before we've modified the vector register.  This removes the
TLB_WATCHPOINT bit from page[].flags, which means that we can
use the normal fast path via RAM.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200508154359.7494-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/sve_helper.c | 72 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 6bae342a177..7992a569b0a 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4371,6 +4371,70 @@ static bool sve_cont_ldst_pages(SVEContLdSt *info, SVEContFault fault,
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
+                    cpu_check_watchpoint(env_cpu(env), addr + mem_off,
+                                         msize, info->page[0].attrs,
+                                         wp_access, retaddr);
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
+                    cpu_check_watchpoint(env_cpu(env), addr + mem_off,
+                                         msize, info->page[1].attrs,
+                                         wp_access, retaddr);
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
@@ -4412,13 +4476,19 @@ void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
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


