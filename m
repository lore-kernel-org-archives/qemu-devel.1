Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD092C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7724D2072B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+e5ujur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7724D2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igymo-0003I1-GW
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igyba-0005gk-I8
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igybZ-0007m5-9a
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:42 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igybZ-0007ks-43
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:41 -0500
Received: by mail-pl1-x642.google.com with SMTP id p9so871716plk.9
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X2GZDJtWgjhwatqn2siyQYT3flCAUk5Su3sfOLoNGxk=;
 b=t+e5ujurwJrOUDpMki+lqYnE3+1m/6DAiFZyKPGMkyfwalrDOFuuxbCLxvJV9aA3Ug
 FRI7V0fGhwYMKckurFUWWesyQVqQ3BtphfSfR82juA6XkJsWWbfWV87J0bI0m1sHsrFV
 0fyCDoiW5Vg8b7cGf7TfgGFOCr6oA1PLSEQ8Y/2wDoe+QtVeUOa7vugyDTgT0yQsYzRA
 DP/6NAQLDe9zJL5vLUYwdcEnAOkvmDebYKMqI8OhY6WnRcjCGBjfuBzcGC7eyfMk6DX4
 5jNO+E8h+4F0GeONeORCIpm8lGhU3tjm7q8oBh8u/1xXDwdmu2j3nhdY4hcbYH9IerfL
 qFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X2GZDJtWgjhwatqn2siyQYT3flCAUk5Su3sfOLoNGxk=;
 b=l+PzOWfQJsx4numtfYL229eeAeu3BAQQa5EJDfYZxDMHGBzxRgHd4drE8Zc2m5245S
 oIQayqzB+qJMuNU/NiwPxe2CTDWsxKhlS5UEHrg01C84jjex782f28UBXJfuA9yVuGjV
 MJ0GvYVcRI4x+fp/sxZwctT8c4QGKVN/zqZkLBMTGEc1Ci7wORrBlInsQrjakq7ujgRO
 VVImpw9Lz7aYYoHKhf+cnZerEmVHzmjGkZPxH0c1kqgFp2Fm+nZokrSZSIoL9nsWmE7v
 ycKnLm7DpVgfKD0ETERAqDmQvw9j57IRQtizr9qbv+VDcf5Eg8Q9N05wKmB/9hpongpT
 54sQ==
X-Gm-Message-State: APjAAAUIjNIdX5ukXwVj/XmcHufCyrNHjyYhGfxgWIp1a13OdRBaFmW7
 o+BHouON2vh2FGWJbBOymQoexkdgRH8=
X-Google-Smtp-Source: APXvYqxeXSUoSTVZYffHectgSzSHiIkJ+MSXg4PrLV0/jdvdUMMeBeOYX8ayXDL/bh4KNVWtiLyx3A==
X-Received: by 2002:a17:902:b418:: with SMTP id
 x24mr18748104plr.85.1576534359856; 
 Mon, 16 Dec 2019 14:12:39 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 25/28] target/s390x: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
Date: Mon, 16 Dec 2019 12:11:55 -1000
Message-Id: <20191216221158.29572-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The generated functions aside from *_real are unused.
The *_real functions have a couple of users in mem_helper.c;
use *_mmuidx_ra instead, with MMU_REAL_IDX.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Use *_mmuidx_ra directly, without intermediate macros.
---
 target/s390x/cpu.h        |  5 -----
 target/s390x/mem_helper.c | 21 ++++++++++++---------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index aa829e954c..cfa8a81265 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -36,11 +36,6 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 2
 
-#define MMU_MODE0_SUFFIX _primary
-#define MMU_MODE1_SUFFIX _secondary
-#define MMU_MODE2_SUFFIX _home
-#define MMU_MODE3_SUFFIX _real
-
 #define MMU_USER_IDX 0
 
 #define S390_MAX_CPUS 248
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 57ce17c252..6f4a16b9b2 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2026,7 +2026,7 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
     real_addr = wrap_address(env, real_addr) & TARGET_PAGE_MASK;
 
     for (i = 0; i < TARGET_PAGE_SIZE; i += 8) {
-        cpu_stq_real_ra(env, real_addr + i, 0, ra);
+        cpu_stq_mmuidx_ra(env, real_addr + i, 0, MMU_REAL_IDX, ra);
     }
 
     return 0;
@@ -2260,11 +2260,11 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
         for (i = 0; i < entries; i++) {
             /* addresses are not wrapped in 24/31bit mode but table index is */
             raddr = table + ((index + i) & 0x7ff) * sizeof(entry);
-            entry = cpu_ldq_real_ra(env, raddr, ra);
+            entry = cpu_ldq_mmuidx_ra(env, raddr, MMU_REAL_IDX, ra);
             if (!(entry & REGION_ENTRY_I)) {
                 /* we are allowed to not store if already invalid */
                 entry |= REGION_ENTRY_I;
-                cpu_stq_real_ra(env, raddr, entry, ra);
+                cpu_stq_mmuidx_ra(env, raddr, entry, MMU_REAL_IDX, ra);
             }
         }
     }
@@ -2291,9 +2291,9 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
     pte_addr += VADDR_PAGE_TX(vaddr) * 8;
 
     /* Mark the page table entry as invalid */
-    pte = cpu_ldq_real_ra(env, pte_addr, ra);
+    pte = cpu_ldq_mmuidx_ra(env, pte_addr, MMU_REAL_IDX, ra);
     pte |= PAGE_ENTRY_I;
-    cpu_stq_real_ra(env, pte_addr, pte, ra);
+    cpu_stq_mmuidx_ra(env, pte_addr, pte, MMU_REAL_IDX, ra);
 
     /* XXX we exploit the fact that Linux passes the exact virtual
        address here - it's not obliged to! */
@@ -2333,18 +2333,21 @@ void HELPER(purge)(CPUS390XState *env)
 /* load using real address */
 uint64_t HELPER(lura)(CPUS390XState *env, uint64_t addr)
 {
-    return cpu_ldl_real_ra(env, wrap_address(env, addr), GETPC());
+    return cpu_ldl_mmuidx_ra(env, wrap_address(env, addr),
+                             MMU_REAL_IDX, GETPC());
 }
 
 uint64_t HELPER(lurag)(CPUS390XState *env, uint64_t addr)
 {
-    return cpu_ldq_real_ra(env, wrap_address(env, addr), GETPC());
+    return cpu_ldq_mmuidx_ra(env, wrap_address(env, addr),
+                             MMU_REAL_IDX, GETPC());
 }
 
 /* store using real address */
 void HELPER(stura)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 {
-    cpu_stl_real_ra(env, wrap_address(env, addr), (uint32_t)v1, GETPC());
+    cpu_stl_mmuidx_ra(env, wrap_address(env, addr), (uint32_t)v1,
+                      MMU_REAL_IDX, GETPC());
 
     if ((env->psw.mask & PSW_MASK_PER) &&
         (env->cregs[9] & PER_CR9_EVENT_STORE) &&
@@ -2357,7 +2360,7 @@ void HELPER(stura)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 
 void HELPER(sturg)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 {
-    cpu_stq_real_ra(env, wrap_address(env, addr), v1, GETPC());
+    cpu_stq_mmuidx_ra(env, wrap_address(env, addr), v1, MMU_REAL_IDX, GETPC());
 
     if ((env->psw.mask & PSW_MASK_PER) &&
         (env->cregs[9] & PER_CR9_EVENT_STORE) &&
-- 
2.20.1


