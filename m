Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234B7C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A598421473
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yRxo0fms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A598421473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5NU-0007b3-Ns
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5Ap-0007qb-SD
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:44:27 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5Al-0005cK-TV
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:44:27 -0400
Received: by mail-pf1-x441.google.com with SMTP id 145so1109458pfw.13
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4tSyrjuk3Om51Zcagt3t6yh4FkYKfOOT3yWLv6tJ2Vs=;
 b=yRxo0fmsPJZy3pAAxuPuQQ42lBW8toRp/JFfnGF5oG+Z+pDD8/2z44+cDvQEpIE8z3
 1zT6iHwfkaoVnrainzpPuxINdCSoao4+pyrSqaIqFMLh1OaaFnIaTxkPybEhts5YTPnW
 hBhPDaoxtg0FgeO3XW4h7N79DCXmYJut+6ayL2zjRFmIKRnPkPniiQyuhmSzX9QwL+Az
 5TrbdRx0KVkzi52NG4BrmnTBFwHY1cQKX1bLrYNf4k0HVMHci1NSIp+W/pOyVKiQeNgq
 0SOxO3dB75DSn05X2ry3pvVtEEI/TFZOX8BCn1JIceCoCl3HznBGhbP/hVqEk5FuHodB
 GJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4tSyrjuk3Om51Zcagt3t6yh4FkYKfOOT3yWLv6tJ2Vs=;
 b=Nj+3P/C0MaFN5HDId3AeRd7tTTiDNTXeoSghRQmxseLeDLUSQzIoLd6YlfaBiY0inS
 SAfvsprG6BlG57JKMEcx8u6LzK6KU//ls652cGwxEdO3x7xbrcTaHQSNUjAPAZ6I86df
 8DEGe2P2uRaBfFqrFh5j0TPbywrkUl0AUAgIEJ2BfVlTLTk2jr6sQXbeumk6AdwxvNtq
 3/Bew0ZvEeihhSi2oBu7O1nftB0tVFMs1koIBjtF0MCqt4A0BU+n6izo8C7NE/4h8Yhe
 5cK90ngKFzc7hcMS1vdDNH00OhRghOk/ErlR/McOSIFHMzbned45QOsF19DL9dj9YXfV
 YFAQ==
X-Gm-Message-State: AGi0PuY+D3QXc4GFmX1za2bYAkoX+f+BY80Cm9h6tsrbAvu/XSnhIJM1
 WuT14CSXfNaExvGkk/waKyfDNbXo+4M=
X-Google-Smtp-Source: APiQypJXOFRQoqcMrW5Jr8Mzr+5dS1X8QaEnTJ+hfJc8hBfc+vJaxaPY3dydIhJLQCWV5FAOYj8TsQ==
X-Received: by 2002:a63:3c0a:: with SMTP id j10mr2622505pga.373.1588952662227; 
 Fri, 08 May 2020 08:44:22 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id o99sm2727662pjo.8.2020.05.08.08.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:44:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 12/19] target/arm: Handle watchpoints in sve_ld1_r
Date: Fri,  8 May 2020 08:43:52 -0700
Message-Id: <20200508154359.7494-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508154359.7494-1-richard.henderson@linaro.org>
References: <20200508154359.7494-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Handle all of the watchpoints for active elements all at once,
before we've modified the vector register.  This removes the
TLB_WATCHPOINT bit from page[].flags, which means that we can
use the normal fast path via RAM.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 72 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 6bae342a17..7992a569b0 100644
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


