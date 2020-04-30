Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF57C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17DAA2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lRytBLdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DAA2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCGW-0005eR-8s
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC3C-0001se-Es
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC38-0006fe-CR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:38 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUC36-0006dy-Es
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:32 -0400
Received: by mail-pl1-x643.google.com with SMTP id c21so2428864plz.4
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4tSyrjuk3Om51Zcagt3t6yh4FkYKfOOT3yWLv6tJ2Vs=;
 b=lRytBLdHoJENE73egrty/xfy33fiJkqQRxA1qlwzv4pwf/ATDMFu2uxhF7hTQqkEv6
 rToeiJGDVgWuRjFteCaHjFpqQWj4ep6MTy0iaZlKrt1woLJOSoPrg1kFU0KYH5j6BZxv
 O3p+V6qXVPD6MwVxQXV8iv1GIT5+4Vst/bE85XiO+qVEPZ3VPmmAnuEI/rkrO3lCFEDy
 sXgamO25mmnOfWvU7sFZEDFS1BTaL0CROXCU/qc8DOHCmSStSoka7Kgu5hoV27bjD7Um
 rKz4nB9x5zO/yk7fPF58Q3XduLfvaVEwF644bmub2fsCgpogvBnPelU1t/aoKKhxqUJu
 T0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4tSyrjuk3Om51Zcagt3t6yh4FkYKfOOT3yWLv6tJ2Vs=;
 b=rg7dRGxQv0SpF1T6QK0aiWw0QrGo6TGFzJ8Td1y2udbFIAKcMynE4SfG1ed3gJq3Kh
 DgcanVeYRHyAOmCcqZGmFhBeVCKQ/ltsZ8kwUAFUKWmZpWrVc2UTSvXmGWTqLghqNhRO
 FLpog1avUumctQRJGgGJWexj4NAZ5OPIxnYezbnZHvnSOb/7alteEIDhBe7vsGO+GcwI
 wLTLBNOIqw3p3IG4hC+BZaNNnfg3J1XDmsJjNNUhjtlMkPJAi1JgwsqRfcqxblSa1Nc2
 iSTxY/vzvPILpEDqzUIbsGIC5wCfj5HCvX+D7CP0ttjPMZGcW7VfZbxuSfhjPo6egJWx
 ETJw==
X-Gm-Message-State: AGi0PuZgDirN8W+E6nkPRX6YKSIg5XzJivzrF3uGa5xr16hz9duJtHNH
 nnOlIhd46qtfnXjH1TwwCW0i/2XZ7j0=
X-Google-Smtp-Source: APiQypJHuIMjRTCKLhQ6XeKpzUAMJ5YWzqXJ5y9yJ4UIGpX8wH9zy9czFYPYAmHqz9aDXrAZXtunDg==
X-Received: by 2002:a17:902:9697:: with SMTP id
 n23mr4482672plp.150.1588264110686; 
 Thu, 30 Apr 2020 09:28:30 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j5sm243514pfh.58.2020.04.30.09.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:28:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/18] target/arm: Handle watchpoints in sve_ld1_r
Date: Thu, 30 Apr 2020 09:28:06 -0700
Message-Id: <20200430162813.17671-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162813.17671-1-richard.henderson@linaro.org>
References: <20200430162813.17671-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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


