Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF92CC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CC32071B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NQm0MU3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CC32071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTwV-0003iW-NW
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjH-0005bD-Uj
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjG-00029m-E0
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:51 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:55665)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTjG-00027e-7a
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:50 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mj6so2824831pjb.5
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OdUOrVG4+6fOcBEkk2TzuAIf4lO1j/SFFZ3HajmExks=;
 b=NQm0MU3cApmQWVJ1p95QWuiOx5XAxifQxmDkUuQZ8Gw4Th1elugQeFMOt9PvfpGsiC
 U83e/TEiJcIYtY2ZLmPh8eZ3f/xH5sLnEeokLkaacqXXtPPFnxa4vgtrVrpGkXkN3cOG
 YNljKf6M2dl4yZ9DxitGrlR6B0PuRcCDclQLoWjbLpHUlnCjQPZ1PztoO2RGE1c8EZSU
 ehB/bFm3ExrQ+ayB4Z5ZRhjqU6HFqffb/q6z9eEA2afsbR2iwhkIZQMKARxmuDNbdS9O
 e34n7aYYRn3ArD2lad7SuhqeOBgtUbbxV5WT2GWWdA9TQoa/F8XTC4bWARhKHzIc7x/0
 +ARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OdUOrVG4+6fOcBEkk2TzuAIf4lO1j/SFFZ3HajmExks=;
 b=h93fLn5IkxCAeFhxEHET5Er9nCROC06VZBaoGzkGPmpFM3kQQDv+uCZsQHwqr0UH6v
 BftfvBljdBP30WUzeHk1D+zmeZ1iE32VgWt3kNj38GHELGALRiFeU6CL5Hp7NWxfVawB
 +8GXZ1361th796gNw+UDHNaVEw39Dldm//wtG3+vKAEov/ujW6OBeoonlHtdw29jJVK9
 6ged4TudDxT78R98GLWn5gSuBhumBDkbzISL6NrR+6ltPGtv11rvPKzz49oIwXkcCaf2
 TZCy9VRlO4F97BxMOXzbf7ZBSwgF6AejbdQxROvAqECQ38Q6GNvAicCHOTmPfbxqn3Dy
 PXfA==
X-Gm-Message-State: ANhLgQ2KxTsdaM40/SefuS9N5Zgnux7bNpUuqP4oFkPXku97WdILVS+b
 /YEF1V6JkLQJHI7gttXfb6QSs03Fzps=
X-Google-Smtp-Source: ADFU+vu0oH21qXkYGhSbyxVN3lhjP0De7OnHEpOmfTReU/VfNdXwsSJEX5BYO735f5eY6gzE9Zl2/g==
X-Received: by 2002:a17:90b:94a:: with SMTP id
 dw10mr5787263pjb.89.1584042165705; 
 Thu, 12 Mar 2020 12:42:45 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 18/42] target/arm: Simplify DC_ZVA
Date: Thu, 12 Mar 2020 12:41:55 -0700
Message-Id: <20200312194219.24406-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we know that the operation is on a single page,
we need not loop over pages while probing.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.c | 94 +++++++++++------------------------------
 1 file changed, 25 insertions(+), 69 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index bc0649a44a..60a04dc880 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -1119,85 +1119,41 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
      * (which matches the usual QEMU behaviour of not implementing either
      * alignment faults or any memory attribute handling).
      */
+    int blocklen = 4 << env_archcpu(env)->dcz_blocksize;
+    uint64_t vaddr = vaddr_in & -blocklen;
+    int mmu_idx = cpu_mmu_index(env, false);
+    void *mem;
 
-    ARMCPU *cpu = env_archcpu(env);
-    uint64_t blocklen = 4 << cpu->dcz_blocksize;
-    uint64_t vaddr = vaddr_in & ~(blocklen - 1);
+    /*
+     * Trapless lookup.  In addition to actual invalid page, may
+     * return NULL for I/O, watchpoints, clean pages, etc.
+     */
+    mem = tlb_vaddr_to_host(env, vaddr, MMU_DATA_STORE, mmu_idx);
 
 #ifndef CONFIG_USER_ONLY
-    {
+    if (unlikely(!mem)) {
+        uintptr_t ra = GETPC();
+
         /*
-         * Slightly awkwardly, QEMU's TARGET_PAGE_SIZE may be less than
-         * the block size so we might have to do more than one TLB lookup.
-         * We know that in fact for any v8 CPU the page size is at least 4K
-         * and the block size must be 2K or less, but TARGET_PAGE_SIZE is only
-         * 1K as an artefact of legacy v5 subpage support being present in the
-         * same QEMU executable. So in practice the hostaddr[] array has
-         * two entries, given the current setting of TARGET_PAGE_BITS_MIN.
+         * Trap if accessing an invalid page.  DC_ZVA requires that we supply
+         * the original pointer for an invalid page.  But watchpoints require
+         * that we probe the actual space.  So do both.
          */
-        int maxidx = DIV_ROUND_UP(blocklen, TARGET_PAGE_SIZE);
-        void *hostaddr[DIV_ROUND_UP(2 * KiB, 1 << TARGET_PAGE_BITS_MIN)];
-        int try, i;
-        unsigned mmu_idx = cpu_mmu_index(env, false);
-        TCGMemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
+        (void) probe_write(env, vaddr_in, 1, mmu_idx, ra);
+        mem = probe_write(env, vaddr, blocklen, mmu_idx, ra);
 
-        assert(maxidx <= ARRAY_SIZE(hostaddr));
-
-        for (try = 0; try < 2; try++) {
-
-            for (i = 0; i < maxidx; i++) {
-                hostaddr[i] = tlb_vaddr_to_host(env,
-                                                vaddr + TARGET_PAGE_SIZE * i,
-                                                1, mmu_idx);
-                if (!hostaddr[i]) {
-                    break;
-                }
-            }
-            if (i == maxidx) {
-                /*
-                 * If it's all in the TLB it's fair game for just writing to;
-                 * we know we don't need to update dirty status, etc.
-                 */
-                for (i = 0; i < maxidx - 1; i++) {
-                    memset(hostaddr[i], 0, TARGET_PAGE_SIZE);
-                }
-                memset(hostaddr[i], 0, blocklen - (i * TARGET_PAGE_SIZE));
-                return;
-            }
+        if (unlikely(!mem)) {
             /*
-             * OK, try a store and see if we can populate the tlb. This
-             * might cause an exception if the memory isn't writable,
-             * in which case we will longjmp out of here. We must for
-             * this purpose use the actual register value passed to us
-             * so that we get the fault address right.
+             * The only remaining reason for mem == NULL is I/O.
+             * Just do a series of byte writes as the architecture demands.
              */
-            helper_ret_stb_mmu(env, vaddr_in, 0, oi, GETPC());
-            /* Now we can populate the other TLB entries, if any */
-            for (i = 0; i < maxidx; i++) {
-                uint64_t va = vaddr + TARGET_PAGE_SIZE * i;
-                if (va != (vaddr_in & TARGET_PAGE_MASK)) {
-                    helper_ret_stb_mmu(env, va, 0, oi, GETPC());
-                }
+            for (int i = 0; i < blocklen; i++) {
+                cpu_stb_mmuidx_ra(env, vaddr + i, 0, mmu_idx, ra);
             }
-        }
-
-        /*
-         * Slow path (probably attempt to do this to an I/O device or
-         * similar, or clearing of a block of code we have translations
-         * cached for). Just do a series of byte writes as the architecture
-         * demands. It's not worth trying to use a cpu_physical_memory_map(),
-         * memset(), unmap() sequence here because:
-         *  + we'd need to account for the blocksize being larger than a page
-         *  + the direct-RAM access case is almost always going to be dealt
-         *    with in the fastpath code above, so there's no speed benefit
-         *  + we would have to deal with the map returning NULL because the
-         *    bounce buffer was in use
-         */
-        for (i = 0; i < blocklen; i++) {
-            helper_ret_stb_mmu(env, vaddr + i, 0, oi, GETPC());
+            return;
         }
     }
-#else
-    memset(g2h(vaddr), 0, blocklen);
 #endif
+
+    memset(mem, 0, blocklen);
 }
-- 
2.20.1


