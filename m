Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A2BC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92F420725
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qThkNysg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92F420725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5VH-0003MS-Tw
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 12:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5At-0007wg-QU
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:44:31 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5Ar-0005fS-Vz
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:44:31 -0400
Received: by mail-pl1-x643.google.com with SMTP id m7so890162plt.5
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2NrE6foXFUL+vDhzqPi3FsUrqKV9Hi7b6uhKwfiWAO8=;
 b=qThkNysgvv0/1IFy+pWmlJZTAC565QVDItkGqIoYbBaM2gVPfHeJS/UHsRRRIfxCCg
 Etr5cfJIYeJ3tQY8cJfHhCXudo9lgNOWhPsiaPDGfBnKUZkLZuG3vBuifwm5NpeZirKS
 vzC8e74brDK46kS0K+bW3m76RU/pSmO5NhaKDBDnjtoGAPY7vfWGzjmjf0hcaIXk4Etf
 a7holUHZ82MLyGAXiYD+unQE6xjS/l8seWi1d/W/pJ/S53vx3+WIzXt6r07KeCS+6Ryd
 hWAjNyYU80QF5jI3LlrkG97tWIg1CaNx7/LmlFSrv12OeUIPTIGgSYHsBu9BxioCjqJA
 Z9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2NrE6foXFUL+vDhzqPi3FsUrqKV9Hi7b6uhKwfiWAO8=;
 b=tBztZwL+qBOyN8WkjYA8Ry7lxqg52/C2t2qoE3ZKgqGqAFuKjHXZwjldaHL6zwNMaO
 uz5CzPjlluUjFRQ+RymXln+mA/P8kveAKh2sigTcgPZkuIO6opnQMHWCdh/wRHYvu+Wa
 jlhAQ7tFsEfgBf8a0zRYsyXq/2BHppc4hOs7LPvkl5W/RMhQm6ko9nUdftUGZ6pL8wNp
 1uFrvtRf0EeIx+63XruY2yZUsr0YzWTCNqMOtrIMd3ucXrT06p+hODB6C27DaOPQXe7e
 y3lcGiII9W8NKzt5jZGcdHQQz3emAw8/i19xK4o8thZOPPMi2lcOYm4JCSN5i+Ejdg1r
 uFLQ==
X-Gm-Message-State: AGi0PuZT0bilNCkGublMaOg2v8yncOtvazsU9lG6bpQgINnTG/4gSb70
 6NarAzFbRmBFPEdbjNnuvGkQsBIhyb4=
X-Google-Smtp-Source: APiQypJja2HeRXt2NPiClQfATSZXTYvLplldmKX62El93Tj9XckrnOFVGVuScQBLKdfScUM4zohwWQ==
X-Received: by 2002:a17:90a:36a7:: with SMTP id
 t36mr6630249pjb.232.1588952668055; 
 Fri, 08 May 2020 08:44:28 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id o99sm2727662pjo.8.2020.05.08.08.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:44:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 17/19] target/arm: Reuse sve_probe_page for scatter stores
Date: Fri,  8 May 2020 08:43:57 -0700
Message-Id: <20200508154359.7494-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508154359.7494-1-richard.henderson@linaro.org>
References: <20200508154359.7494-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 182 ++++++++++++++++++++++++----------------
 1 file changed, 111 insertions(+), 71 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 1560129b08..ad7e10f1e7 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -5413,94 +5413,134 @@ DO_LDFF1_ZPZ_D(dd_be, zd, MO_64)
 
 /* Stores with a vector index.  */
 
-static void sve_st1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
-                       target_ulong base, uint32_t desc, uintptr_t ra,
-                       zreg_off_fn *off_fn, sve_ldst1_tlb_fn *tlb_fn)
+static inline QEMU_ALWAYS_INLINE
+void sve_st1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
+               target_ulong base, uint32_t desc, uintptr_t retaddr,
+               int esize, int msize, zreg_off_fn *off_fn,
+               sve_ldst1_host_fn *host_fn,
+               sve_ldst1_tlb_fn *tlb_fn)
 {
     const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
-    intptr_t i, oprsz = simd_oprsz(desc);
+    const int mmu_idx = cpu_mmu_index(env, false);
+    const intptr_t reg_max = simd_oprsz(desc);
+    void *host[ARM_MAX_VQ * 4];
+    intptr_t reg_off, i;
+    SVEHostPage info, info2;
 
-    for (i = 0; i < oprsz; ) {
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
+    /*
+     * Probe all of the elements for host addresses and flags.
+     */
+    i = reg_off = 0;
+    do {
+        uint64_t pg = vg[reg_off >> 6];
         do {
-            if (likely(pg & 1)) {
-                target_ulong off = off_fn(vm, i);
-                tlb_fn(env, vd, i, base + (off << scale), ra);
+            target_ulong addr = base + (off_fn(vm, reg_off) << scale);
+            target_ulong in_page = -(addr | TARGET_PAGE_MASK);
+
+            host[i] = NULL;
+            if (likely((pg >> (reg_off & 63)) & 1)) {
+                if (likely(in_page >= msize)) {
+                    sve_probe_page(&info, false, env, addr, 0, MMU_DATA_STORE,
+                                   mmu_idx, retaddr);
+                    host[i] = info.host;
+                } else {
+                    /*
+                     * Element crosses the page boundary.
+                     * Probe both pages, but do not record the host address,
+                     * so that we use the slow path.
+                     */
+                    sve_probe_page(&info, false, env, addr, 0,
+                                   MMU_DATA_STORE, mmu_idx, retaddr);
+                    sve_probe_page(&info2, false, env, addr + in_page, 0,
+                                   MMU_DATA_STORE, mmu_idx, retaddr);
+                    info.flags |= info2.flags;
+                }
+
+                if (unlikely(info.flags & TLB_WATCHPOINT)) {
+                    cpu_check_watchpoint(env_cpu(env), addr, msize,
+                                         info.attrs, BP_MEM_WRITE, retaddr);
+                }
+                /* TODO: MTE check. */
             }
-            i += 4, pg >>= 4;
-        } while (i & 15);
-    }
-}
+            i += 1;
+            reg_off += esize;
+        } while (reg_off & 63);
+    } while (reg_off < reg_max);
 
-static void sve_st1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
-                       target_ulong base, uint32_t desc, uintptr_t ra,
-                       zreg_off_fn *off_fn, sve_ldst1_tlb_fn *tlb_fn)
-{
-    const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
-    intptr_t i, oprsz = simd_oprsz(desc) / 8;
-
-    for (i = 0; i < oprsz; i++) {
-        uint8_t pg = *(uint8_t *)(vg + H1(i));
-        if (likely(pg & 1)) {
-            target_ulong off = off_fn(vm, i * 8);
-            tlb_fn(env, vd, i * 8, base + (off << scale), ra);
+    /*
+     * Now that we have recognized all exceptions except SyncExternal
+     * (from TLB_MMIO), which we cannot avoid, perform all of the stores.
+     *
+     * Note for the common case of an element in RAM, not crossing a page
+     * boundary, we have stored the host address in host[].  This doubles
+     * as a first-level check against the predicate, since only enabled
+     * elements have non-null host addresses.
+     */
+    i = reg_off = 0;
+    do {
+        void *h = host[i];
+        if (likely(h != NULL)) {
+            host_fn(vd, reg_off, h);
+        } else if ((vg[reg_off >> 6] >> (reg_off & 63)) & 1) {
+            target_ulong addr = base + (off_fn(vm, reg_off) << scale);
+            tlb_fn(env, vd, reg_off, addr, retaddr);
         }
-    }
+        i += 1;
+        reg_off += esize;
+    } while (reg_off < reg_max);
 }
 
-#define DO_ST1_ZPZ_S(MEM, OFS) \
-void QEMU_FLATTEN HELPER(sve_st##MEM##_##OFS) \
-    (CPUARMState *env, void *vd, void *vg, void *vm,         \
-     target_ulong base, uint32_t desc)                       \
-{                                                            \
-    sve_st1_zs(env, vd, vg, vm, base, desc, GETPC(),         \
-              off_##OFS##_s, sve_st1##MEM##_tlb);            \
+#define DO_ST1_ZPZ_S(MEM, OFS, MSZ) \
+void HELPER(sve_st##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
+                                 void *vm, target_ulong base, uint32_t desc) \
+{                                                                            \
+    sve_st1_z(env, vd, vg, vm, base, desc, GETPC(), 4, 1 << MSZ,             \
+              off_##OFS##_s, sve_st1##MEM##_host, sve_st1##MEM##_tlb);       \
 }
 
-#define DO_ST1_ZPZ_D(MEM, OFS) \
-void QEMU_FLATTEN HELPER(sve_st##MEM##_##OFS) \
-    (CPUARMState *env, void *vd, void *vg, void *vm,         \
-     target_ulong base, uint32_t desc)                       \
-{                                                            \
-    sve_st1_zd(env, vd, vg, vm, base, desc, GETPC(),         \
-               off_##OFS##_d, sve_st1##MEM##_tlb);           \
+#define DO_ST1_ZPZ_D(MEM, OFS, MSZ) \
+void HELPER(sve_st##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
+                                 void *vm, target_ulong base, uint32_t desc) \
+{                                                                            \
+    sve_st1_z(env, vd, vg, vm, base, desc, GETPC(), 8, 1 << MSZ,             \
+              off_##OFS##_d, sve_st1##MEM##_host, sve_st1##MEM##_tlb);       \
 }
 
-DO_ST1_ZPZ_S(bs, zsu)
-DO_ST1_ZPZ_S(hs_le, zsu)
-DO_ST1_ZPZ_S(hs_be, zsu)
-DO_ST1_ZPZ_S(ss_le, zsu)
-DO_ST1_ZPZ_S(ss_be, zsu)
+DO_ST1_ZPZ_S(bs, zsu, MO_8)
+DO_ST1_ZPZ_S(hs_le, zsu, MO_16)
+DO_ST1_ZPZ_S(hs_be, zsu, MO_16)
+DO_ST1_ZPZ_S(ss_le, zsu, MO_32)
+DO_ST1_ZPZ_S(ss_be, zsu, MO_32)
 
-DO_ST1_ZPZ_S(bs, zss)
-DO_ST1_ZPZ_S(hs_le, zss)
-DO_ST1_ZPZ_S(hs_be, zss)
-DO_ST1_ZPZ_S(ss_le, zss)
-DO_ST1_ZPZ_S(ss_be, zss)
+DO_ST1_ZPZ_S(bs, zss, MO_8)
+DO_ST1_ZPZ_S(hs_le, zss, MO_16)
+DO_ST1_ZPZ_S(hs_be, zss, MO_16)
+DO_ST1_ZPZ_S(ss_le, zss, MO_32)
+DO_ST1_ZPZ_S(ss_be, zss, MO_32)
 
-DO_ST1_ZPZ_D(bd, zsu)
-DO_ST1_ZPZ_D(hd_le, zsu)
-DO_ST1_ZPZ_D(hd_be, zsu)
-DO_ST1_ZPZ_D(sd_le, zsu)
-DO_ST1_ZPZ_D(sd_be, zsu)
-DO_ST1_ZPZ_D(dd_le, zsu)
-DO_ST1_ZPZ_D(dd_be, zsu)
+DO_ST1_ZPZ_D(bd, zsu, MO_8)
+DO_ST1_ZPZ_D(hd_le, zsu, MO_16)
+DO_ST1_ZPZ_D(hd_be, zsu, MO_16)
+DO_ST1_ZPZ_D(sd_le, zsu, MO_32)
+DO_ST1_ZPZ_D(sd_be, zsu, MO_32)
+DO_ST1_ZPZ_D(dd_le, zsu, MO_64)
+DO_ST1_ZPZ_D(dd_be, zsu, MO_64)
 
-DO_ST1_ZPZ_D(bd, zss)
-DO_ST1_ZPZ_D(hd_le, zss)
-DO_ST1_ZPZ_D(hd_be, zss)
-DO_ST1_ZPZ_D(sd_le, zss)
-DO_ST1_ZPZ_D(sd_be, zss)
-DO_ST1_ZPZ_D(dd_le, zss)
-DO_ST1_ZPZ_D(dd_be, zss)
+DO_ST1_ZPZ_D(bd, zss, MO_8)
+DO_ST1_ZPZ_D(hd_le, zss, MO_16)
+DO_ST1_ZPZ_D(hd_be, zss, MO_16)
+DO_ST1_ZPZ_D(sd_le, zss, MO_32)
+DO_ST1_ZPZ_D(sd_be, zss, MO_32)
+DO_ST1_ZPZ_D(dd_le, zss, MO_64)
+DO_ST1_ZPZ_D(dd_be, zss, MO_64)
 
-DO_ST1_ZPZ_D(bd, zd)
-DO_ST1_ZPZ_D(hd_le, zd)
-DO_ST1_ZPZ_D(hd_be, zd)
-DO_ST1_ZPZ_D(sd_le, zd)
-DO_ST1_ZPZ_D(sd_be, zd)
-DO_ST1_ZPZ_D(dd_le, zd)
-DO_ST1_ZPZ_D(dd_be, zd)
+DO_ST1_ZPZ_D(bd, zd, MO_8)
+DO_ST1_ZPZ_D(hd_le, zd, MO_16)
+DO_ST1_ZPZ_D(hd_be, zd, MO_16)
+DO_ST1_ZPZ_D(sd_le, zd, MO_32)
+DO_ST1_ZPZ_D(sd_be, zd, MO_32)
+DO_ST1_ZPZ_D(dd_le, zd, MO_64)
+DO_ST1_ZPZ_D(dd_be, zd, MO_64)
 
 #undef DO_ST1_ZPZ_S
 #undef DO_ST1_ZPZ_D
-- 
2.20.1


