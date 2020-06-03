Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAA9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A4720663
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VycdNoSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A4720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgI3i-0005vB-Jm
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyW-00044w-V2
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:48 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyT-0003aF-0J
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:48 -0400
Received: by mail-pg1-x541.google.com with SMTP id e9so532640pgo.9
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o1+JkLvr5wpvNs6tBAnE0GN83gyiuk70hCD7c+aSnks=;
 b=VycdNoSdZyQzr3hcpjbmuYAreGJnWyoVh2a/xWLcsMnXjePsroXZii2ddG3Q0rjAVb
 PuVK6s8IiwGtLvNEsiXU1LC5v73AjXNRRr3FBDFJaWDUCLzsjSKl121cjHCopc/4y4OV
 ezGhVp/vZxMdm9QvHVggbPvTR/rdDBY1amJcShxqJB1hWYT07wMSNLS8zZfszTPAEMav
 jejRvlD7caBUEzwaKrJ45OFQMMCr0nY5xg1Ld9nf6LB/UO+u2n8QRQ/6IpOSfAkR8I5M
 tcOkJHA8XSxCkR7ERjjv2kU3wf0KfQac7i5VQKYk8BwrxR7HqwgmQ7lNfwhEUSj+vuw8
 enCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o1+JkLvr5wpvNs6tBAnE0GN83gyiuk70hCD7c+aSnks=;
 b=g21BePuBDSpYUez1spc+tlIDlDxY8Vv6CrX+NXCgwL5s30PQ2o4C28zeWracGW37fb
 Cr/epPUw5aFjAljCuyjHkHYkDBxmQOxoZvVwD5ZvuCCBfUgI3T6Ej7NfW7NsAVoSArrv
 RaL9utK/rfZOjDmqsolK14xQxMMZUXFmnlxL3An2hsnM17oviPwIdjMiJB+uLRmQG6eI
 WRtw8TMC3ET8kmtpXvIaekS80vnzvHl3OvErTcegUcHGJv659i+04AddtiK5/J27jRmd
 Im9vx4Hz1VnhK3FwgvRV7C+vsqJcpPjBD+P81Iy8GwQSoaSlDO0z+AM8Psf/CvhCUo3z
 ETqg==
X-Gm-Message-State: AOAM531uBukh6Kd8qlk/LhU/h6jbCjtrkxmlhJMAHGbQ1s2/WSgQd3qj
 21YkjDKavgeg2mBw7bg8xzZtfRShONA=
X-Google-Smtp-Source: ABdhPJwNavlFzIWQEb7nFfZ90WkS0huer++fVrDz9F8dyd037bbk6b7tQFETIYoTGz/14/4sMpFbdA==
X-Received: by 2002:a63:f54f:: with SMTP id e15mr14570507pgk.234.1591146822101; 
 Tue, 02 Jun 2020 18:13:42 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 18/42] target/arm: Simplify DC_ZVA
Date: Tue,  2 Jun 2020 18:12:53 -0700
Message-Id: <20200603011317.473934-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
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
2.25.1


