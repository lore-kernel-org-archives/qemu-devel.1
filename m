Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772AFC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454E32070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="swyzA96h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454E32070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCJ7-0005dp-Dz
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC3M-0001yO-DM
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC3E-0006qa-DI
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:48 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUC3C-0006k1-VS
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:39 -0400
Received: by mail-pg1-x543.google.com with SMTP id d3so2979860pgj.6
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2NrE6foXFUL+vDhzqPi3FsUrqKV9Hi7b6uhKwfiWAO8=;
 b=swyzA96hOANTc7PbvBV42AgJucDAlZr+MLeRdqk4UAKUnJDPZC0+e8CJjfbHJt4PIb
 QJimWcVSeTYIBug5iWNJymlR18dQP/1/R/CbPq5IdvN7OwUsQ0s3804ISRXxhQikl7pp
 FA28FTnoiIw1XzU4qn3tjhg8+gA9ZufIBqd/Q7N3SLRG8tZjwOEMZLIETeR+eHptVCfX
 ocNBf1Sek1Ba4KZjPm3lk8WCs75MRnYjRZJW59aPS9Xe+yeSxP9eMY5t9TUWWIkTRhVC
 ToAbkaztjY8gBf2f/vJqHLD8Om478GxSwvXmNY22zXCPaPsfccNBRvCCdoBUHGVFccOI
 tfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2NrE6foXFUL+vDhzqPi3FsUrqKV9Hi7b6uhKwfiWAO8=;
 b=oWtgpjkGHY5JH0X0x24zz5tyOWyxyxTkyMm1RBUEaC4ThCXVxT8SxzEcHcRAqq81HF
 8o/h6QXI+0tBbIVJF9mn5mfw7FHCyJSB0Vf59NZVktN+jSBAIQQjwmsD1l++KQC9j8VY
 hXx6bqoNDc6HXYbZqXOyy5ZXx8t+7IuH0g0RoguS+VENbK2k/l012JFRz2eRSCS22YZm
 P8hi3EYIdy9Z8qEL24VvlP7fd6HQWL6ivCtVQRyoIOVkEwBK9VL9edRUJEv1RzfBaI8N
 xpaOkkZcNvzKYf+PIJ2E7/NyZ3WluqdJejpB0S1L4q/a0tQ+zIpIgQ+eNvQNM1lTJWLP
 9yFg==
X-Gm-Message-State: AGi0PuZk/8qhvffZBm0CIutXcGfeJNMf4bY0VjAoTq8li4iPaij+SdMi
 ZQVd0jQKybG+gxklB2yF5WEqM7KtOMQ=
X-Google-Smtp-Source: APiQypJpoHI204LilrCprb34ijBR8O3PY2G3N7mTs0jVggZe6jqtl35JsbYfJzeGLDluSlMHI4CF2Q==
X-Received: by 2002:a62:5ec7:: with SMTP id s190mr140188pfb.130.1588264117181; 
 Thu, 30 Apr 2020 09:28:37 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j5sm243514pfh.58.2020.04.30.09.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:28:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 16/18] target/arm: Reuse sve_probe_page for scatter stores
Date: Thu, 30 Apr 2020 09:28:11 -0700
Message-Id: <20200430162813.17671-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162813.17671-1-richard.henderson@linaro.org>
References: <20200430162813.17671-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::543
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


