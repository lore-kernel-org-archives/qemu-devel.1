Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3026C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC3D2086A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXDiBiCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC3D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFM15-0000aD-GO
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlJ-0001eA-9y
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlI-0005Z8-1E
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:33 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:45916)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFLlH-0005Yd-Rm
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:31 -0400
Received: by mail-pg1-x529.google.com with SMTP id q7so10071696pgi.12
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kOQn8fqkcBbOOtc4Nsvslx7elS0LZpOm6Sn3ku0T4zo=;
 b=qXDiBiCdh6IKfSuXeURbDy3Rd8WhOYDsHula3ivJFSGO/y0pkgnN+3QEHP9VjjC3SE
 LA0e2D1YL7hXMLtwUj4uKlJlXXWV8rWh8pJt2zbaMF5TDdyqtzQbfA2Je54GoK+imCus
 bIP5+DBxetuusTsWRxd1TMRBWjHxPHWIvCe1D/TcqMrR1bWJKsOL8UcGSy1GHrNzyL09
 AS2DSm9EHdf1usskM2EQ4dv1AHW5RSmBHi0XuarIiNAHZZ7PBsqCw8mEVwbzr9ka1K+B
 y9KTn4LOMrwWupnmD6e7F6VV8WxYwdtgGE8t+6VPulK9DDVrRyOMdQZmatcFFR/4sEuG
 Uejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kOQn8fqkcBbOOtc4Nsvslx7elS0LZpOm6Sn3ku0T4zo=;
 b=lz1S2mUES9shEXzqUqlMelLoOs2OCuTwnsQqXoAx9SL+vzus84HGbqZH/GITL97txD
 uNqC+86VEQJqrIU9nyuAWQX++jj9SYcq7MJWKNmnI+YwfBoChHe5O9kpR4GR6dpx87MP
 eYPppx/kkG6qsJXXEBY9FJMBrlGshSCWsffTimW5HPU23lwx5/mNNs3GT+63Q9ZMfTh1
 suRy57CmrPfW03c/6IyJbAunwvyKT8ML53RLXAdD26GmzMkQv7JFEvsacduTAYlH1xxB
 0YfgWA5E6Np0yvxtzBnrEeWhpLRD59r10TtM7ewNTY6FcE3G3uRzX1fPxHAyz7jDXAyN
 0BTg==
X-Gm-Message-State: APjAAAVaXE41h1g/Dy/ROKEx4d72dtnYN2iHKQLgO9+SwXwbY88wECtz
 mMZW84WM8LXjKa/2w0N4Hx8z9+c66pc=
X-Google-Smtp-Source: APXvYqxwtr7FI8ps2WpfL1PJhAw2GibDiLfHREte/okN53jeE6vqohfXDr3xZz+kI/VqyyuYWXWoug==
X-Received: by 2002:a17:90a:2301:: with SMTP id
 f1mr6720391pje.121.1569950190302; 
 Tue, 01 Oct 2019 10:16:30 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w7sm2863568pjn.1.2019.10.01.10.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:16:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 11/18] target/s390x: Remove fail variable from
 s390_cpu_tlb_fill
Date: Tue,  1 Oct 2019 10:16:07 -0700
Message-Id: <20191001171614.8405-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001171614.8405-1-richard.henderson@linaro.org>
References: <20191001171614.8405-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::529
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that excp always contains a real exception number, we can
use that instead of a separate fail variable.  This allows a
redundant test to be removed.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/excp_helper.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 6a0728b65f..98a1ee8317 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -127,7 +127,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     CPUS390XState *env = &cpu->env;
     target_ulong vaddr, raddr;
     uint64_t asc, tec;
-    int prot, fail, excp;
+    int prot, excp;
 
     qemu_log_mask(CPU_LOG_MMU, "%s: addr 0x%" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
@@ -141,20 +141,18 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             vaddr &= 0x7fffffff;
         }
         excp = mmu_translate(env, vaddr, access_type, asc, &raddr, &prot, &tec);
-        fail = excp;
     } else if (mmu_idx == MMU_REAL_IDX) {
         /* 31-Bit mode */
         if (!(env->psw.mask & PSW_MASK_64)) {
             vaddr &= 0x7fffffff;
         }
         excp = mmu_translate_real(env, vaddr, access_type, &raddr, &prot, &tec);
-        fail = excp;
     } else {
         g_assert_not_reached();
     }
 
     /* check out of RAM access */
-    if (!fail &&
+    if (!excp &&
         !address_space_access_valid(&address_space_memory, raddr,
                                     TARGET_PAGE_SIZE, access_type,
                                     MEMTXATTRS_UNSPECIFIED)) {
@@ -163,10 +161,9 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       __func__, (uint64_t)raddr, (uint64_t)ram_size);
         excp = PGM_ADDRESSING;
         tec = 0; /* unused */
-        fail = 1;
     }
 
-    if (!fail) {
+    if (!excp) {
         qemu_log_mask(CPU_LOG_MMU,
                       "%s: set tlb %" PRIx64 " -> %" PRIx64 " (%x)\n",
                       __func__, (uint64_t)vaddr, (uint64_t)raddr, prot);
@@ -178,13 +175,11 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         return false;
     }
 
-    if (excp) {
-        if (excp != PGM_ADDRESSING) {
-            stq_phys(env_cpu(env)->as,
-                     env->psa + offsetof(LowCore, trans_exc_code), tec);
-        }
-        trigger_pgm_exception(env, excp, ILEN_AUTO);
+    if (excp != PGM_ADDRESSING) {
+        stq_phys(env_cpu(env)->as,
+                 env->psa + offsetof(LowCore, trans_exc_code), tec);
     }
+    trigger_pgm_exception(env, excp, ILEN_AUTO);
     cpu_restore_state(cs, retaddr, true);
 
     /*
-- 
2.17.1


