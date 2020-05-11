Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96318C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F31D206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k6Nkmx1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F31D206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8km-0007KF-EN
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zx-0002XH-D2
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:45 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zt-0007Bf-FW
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id u16so19266858wmc.5
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=v1dvCBxFBJBneqSkfomRaeMPdW2t+uuCs4QEcDthqJo=;
 b=k6Nkmx1dvBVAktgaKRh71EABEYboWUvng4bDeOhgH7BRjIMdId9OT1Q4+jYLjSzhzH
 2WxLM55wprliv8QM7rcSC4BKJ1Ea9Ns+xYIEBXcBz8ejl8itwcpGx45NG+VHcPdBugmv
 iGa33Ly4baX+OxNCIcQQ+2tbgomlrZTAXxJJqy6/A8Xg/ARzbxmkSXEtUA3I5UbJCb5k
 AJLhyWEy8Q84kjHStdtNvx/jX6K7AwHuu/DzNNvjiMth7iuEYhpKEPPMXuLGgEyMW1Rq
 EORGrtWZ48hjEx/BJet+00A1wglzN8HTRvd+jH7bWLnUKvW8i+B+xqB2V3KHRrJyrkvS
 VKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v1dvCBxFBJBneqSkfomRaeMPdW2t+uuCs4QEcDthqJo=;
 b=biT3NLzKWnQrcOFNPLjgPtywqg0A8OhvVD49KpUqK5ZYZ7SO5D3a8TH5oP61zAVTyX
 u7Kr1TEdvSjAvkatHxzeJR18ZchiiZfkK6FCyn8Z0+gZzTV63iJbhWFmG4uHzNNDbj4I
 9aH9bN/aqjdjUSlrs6f2gKgO1BgQ9E0exoFcA3n3OQKLAd7YnIoX9M8r9b+72ClCchrP
 8nHPqTho2czCeVQbUG+NHW+Y7WzUf4sLsbjCl5TDOBbUrqrxJv9ZOphuzXHX07E736Wn
 dHnQHB7kz4nduoRUs7oxwBc6cxrponZnmf/WiUnGYlubEIBpO3Ysd6zSJ4/jZ7Vw1OhO
 T+0w==
X-Gm-Message-State: AGi0PubUlcmQCiyUh5GBFP+QwfmArUPs8CU+ZKdCWoANnzmF8XVUE4/L
 puYWtIAeSALfojOz6/oBVB3HDS/Gxtxjtg==
X-Google-Smtp-Source: APiQypKwEJThP9sd5HLkQIDN7EvVNitCT3qaOW8ptSCi8lC1yfmhc+x5OgIPWL1FTlSr/pa93zd+yw==
X-Received: by 2002:a1c:f615:: with SMTP id w21mr30225342wmc.183.1589204079634; 
 Mon, 11 May 2020 06:34:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/34] target/arm: Reuse sve_probe_page for gather loads
Date: Mon, 11 May 2020 14:33:56 +0100
Message-Id: <20200511133405.5275-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200508154359.7494-19-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/sve_helper.c | 208 +++++++++++++++++++++-------------------
 1 file changed, 109 insertions(+), 99 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index ad7e10f1e79..f1870aabc2f 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -5124,130 +5124,140 @@ static target_ulong off_zd_d(void *reg, intptr_t reg_ofs)
     return *(uint64_t *)(reg + reg_ofs);
 }
 
-static void sve_ld1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
-                       target_ulong base, uint32_t desc, uintptr_t ra,
-                       zreg_off_fn *off_fn, sve_ldst1_tlb_fn *tlb_fn)
+static inline QEMU_ALWAYS_INLINE
+void sve_ld1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
+               target_ulong base, uint32_t desc, uintptr_t retaddr,
+               int esize, int msize, zreg_off_fn *off_fn,
+               sve_ldst1_host_fn *host_fn,
+               sve_ldst1_tlb_fn *tlb_fn)
 {
     const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
-    intptr_t i, oprsz = simd_oprsz(desc);
-    ARMVectorReg scratch = { };
+    const int mmu_idx = cpu_mmu_index(env, false);
+    const intptr_t reg_max = simd_oprsz(desc);
+    ARMVectorReg scratch;
+    intptr_t reg_off;
+    SVEHostPage info, info2;
 
-    for (i = 0; i < oprsz; ) {
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
+    memset(&scratch, 0, reg_max);
+    reg_off = 0;
+    do {
+        uint64_t pg = vg[reg_off >> 6];
         do {
             if (likely(pg & 1)) {
-                target_ulong off = off_fn(vm, i);
-                tlb_fn(env, &scratch, i, base + (off << scale), ra);
+                target_ulong addr = base + (off_fn(vm, reg_off) << scale);
+                target_ulong in_page = -(addr | TARGET_PAGE_MASK);
+
+                sve_probe_page(&info, false, env, addr, 0, MMU_DATA_LOAD,
+                               mmu_idx, retaddr);
+
+                if (likely(in_page >= msize)) {
+                    if (unlikely(info.flags & TLB_WATCHPOINT)) {
+                        cpu_check_watchpoint(env_cpu(env), addr, msize,
+                                             info.attrs, BP_MEM_READ, retaddr);
+                    }
+                    /* TODO: MTE check */
+                    host_fn(&scratch, reg_off, info.host);
+                } else {
+                    /* Element crosses the page boundary. */
+                    sve_probe_page(&info2, false, env, addr + in_page, 0,
+                                   MMU_DATA_LOAD, mmu_idx, retaddr);
+                    if (unlikely((info.flags | info2.flags) & TLB_WATCHPOINT)) {
+                        cpu_check_watchpoint(env_cpu(env), addr,
+                                             msize, info.attrs,
+                                             BP_MEM_READ, retaddr);
+                    }
+                    /* TODO: MTE check */
+                    tlb_fn(env, &scratch, reg_off, addr, retaddr);
+                }
             }
-            i += 4, pg >>= 4;
-        } while (i & 15);
-    }
+            reg_off += esize;
+            pg >>= esize;
+        } while (reg_off & 63);
+    } while (reg_off < reg_max);
 
     /* Wait until all exceptions have been raised to write back.  */
-    memcpy(vd, &scratch, oprsz);
+    memcpy(vd, &scratch, reg_max);
 }
 
-static void sve_ld1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
-                       target_ulong base, uint32_t desc, uintptr_t ra,
-                       zreg_off_fn *off_fn, sve_ldst1_tlb_fn *tlb_fn)
-{
-    const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
-    intptr_t i, oprsz = simd_oprsz(desc) / 8;
-    ARMVectorReg scratch = { };
-
-    for (i = 0; i < oprsz; i++) {
-        uint8_t pg = *(uint8_t *)(vg + H1(i));
-        if (likely(pg & 1)) {
-            target_ulong off = off_fn(vm, i * 8);
-            tlb_fn(env, &scratch, i * 8, base + (off << scale), ra);
-        }
-    }
-
-    /* Wait until all exceptions have been raised to write back.  */
-    memcpy(vd, &scratch, oprsz * 8);
+#define DO_LD1_ZPZ_S(MEM, OFS, MSZ) \
+void HELPER(sve_ld##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
+                                 void *vm, target_ulong base, uint32_t desc) \
+{                                                                            \
+    sve_ld1_z(env, vd, vg, vm, base, desc, GETPC(), 4, 1 << MSZ,             \
+              off_##OFS##_s, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);       \
 }
 
-#define DO_LD1_ZPZ_S(MEM, OFS) \
-void QEMU_FLATTEN HELPER(sve_ld##MEM##_##OFS) \
-    (CPUARMState *env, void *vd, void *vg, void *vm,         \
-     target_ulong base, uint32_t desc)                       \
-{                                                            \
-    sve_ld1_zs(env, vd, vg, vm, base, desc, GETPC(),         \
-              off_##OFS##_s, sve_ld1##MEM##_tlb);            \
+#define DO_LD1_ZPZ_D(MEM, OFS, MSZ) \
+void HELPER(sve_ld##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
+                                 void *vm, target_ulong base, uint32_t desc) \
+{                                                                            \
+    sve_ld1_z(env, vd, vg, vm, base, desc, GETPC(), 8, 1 << MSZ,             \
+              off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);       \
 }
 
-#define DO_LD1_ZPZ_D(MEM, OFS) \
-void QEMU_FLATTEN HELPER(sve_ld##MEM##_##OFS) \
-    (CPUARMState *env, void *vd, void *vg, void *vm,         \
-     target_ulong base, uint32_t desc)                       \
-{                                                            \
-    sve_ld1_zd(env, vd, vg, vm, base, desc, GETPC(),         \
-               off_##OFS##_d, sve_ld1##MEM##_tlb);           \
-}
+DO_LD1_ZPZ_S(bsu, zsu, MO_8)
+DO_LD1_ZPZ_S(bsu, zss, MO_8)
+DO_LD1_ZPZ_D(bdu, zsu, MO_8)
+DO_LD1_ZPZ_D(bdu, zss, MO_8)
+DO_LD1_ZPZ_D(bdu, zd, MO_8)
 
-DO_LD1_ZPZ_S(bsu, zsu)
-DO_LD1_ZPZ_S(bsu, zss)
-DO_LD1_ZPZ_D(bdu, zsu)
-DO_LD1_ZPZ_D(bdu, zss)
-DO_LD1_ZPZ_D(bdu, zd)
+DO_LD1_ZPZ_S(bss, zsu, MO_8)
+DO_LD1_ZPZ_S(bss, zss, MO_8)
+DO_LD1_ZPZ_D(bds, zsu, MO_8)
+DO_LD1_ZPZ_D(bds, zss, MO_8)
+DO_LD1_ZPZ_D(bds, zd, MO_8)
 
-DO_LD1_ZPZ_S(bss, zsu)
-DO_LD1_ZPZ_S(bss, zss)
-DO_LD1_ZPZ_D(bds, zsu)
-DO_LD1_ZPZ_D(bds, zss)
-DO_LD1_ZPZ_D(bds, zd)
+DO_LD1_ZPZ_S(hsu_le, zsu, MO_16)
+DO_LD1_ZPZ_S(hsu_le, zss, MO_16)
+DO_LD1_ZPZ_D(hdu_le, zsu, MO_16)
+DO_LD1_ZPZ_D(hdu_le, zss, MO_16)
+DO_LD1_ZPZ_D(hdu_le, zd, MO_16)
 
-DO_LD1_ZPZ_S(hsu_le, zsu)
-DO_LD1_ZPZ_S(hsu_le, zss)
-DO_LD1_ZPZ_D(hdu_le, zsu)
-DO_LD1_ZPZ_D(hdu_le, zss)
-DO_LD1_ZPZ_D(hdu_le, zd)
+DO_LD1_ZPZ_S(hsu_be, zsu, MO_16)
+DO_LD1_ZPZ_S(hsu_be, zss, MO_16)
+DO_LD1_ZPZ_D(hdu_be, zsu, MO_16)
+DO_LD1_ZPZ_D(hdu_be, zss, MO_16)
+DO_LD1_ZPZ_D(hdu_be, zd, MO_16)
 
-DO_LD1_ZPZ_S(hsu_be, zsu)
-DO_LD1_ZPZ_S(hsu_be, zss)
-DO_LD1_ZPZ_D(hdu_be, zsu)
-DO_LD1_ZPZ_D(hdu_be, zss)
-DO_LD1_ZPZ_D(hdu_be, zd)
+DO_LD1_ZPZ_S(hss_le, zsu, MO_16)
+DO_LD1_ZPZ_S(hss_le, zss, MO_16)
+DO_LD1_ZPZ_D(hds_le, zsu, MO_16)
+DO_LD1_ZPZ_D(hds_le, zss, MO_16)
+DO_LD1_ZPZ_D(hds_le, zd, MO_16)
 
-DO_LD1_ZPZ_S(hss_le, zsu)
-DO_LD1_ZPZ_S(hss_le, zss)
-DO_LD1_ZPZ_D(hds_le, zsu)
-DO_LD1_ZPZ_D(hds_le, zss)
-DO_LD1_ZPZ_D(hds_le, zd)
+DO_LD1_ZPZ_S(hss_be, zsu, MO_16)
+DO_LD1_ZPZ_S(hss_be, zss, MO_16)
+DO_LD1_ZPZ_D(hds_be, zsu, MO_16)
+DO_LD1_ZPZ_D(hds_be, zss, MO_16)
+DO_LD1_ZPZ_D(hds_be, zd, MO_16)
 
-DO_LD1_ZPZ_S(hss_be, zsu)
-DO_LD1_ZPZ_S(hss_be, zss)
-DO_LD1_ZPZ_D(hds_be, zsu)
-DO_LD1_ZPZ_D(hds_be, zss)
-DO_LD1_ZPZ_D(hds_be, zd)
+DO_LD1_ZPZ_S(ss_le, zsu, MO_32)
+DO_LD1_ZPZ_S(ss_le, zss, MO_32)
+DO_LD1_ZPZ_D(sdu_le, zsu, MO_32)
+DO_LD1_ZPZ_D(sdu_le, zss, MO_32)
+DO_LD1_ZPZ_D(sdu_le, zd, MO_32)
 
-DO_LD1_ZPZ_S(ss_le, zsu)
-DO_LD1_ZPZ_S(ss_le, zss)
-DO_LD1_ZPZ_D(sdu_le, zsu)
-DO_LD1_ZPZ_D(sdu_le, zss)
-DO_LD1_ZPZ_D(sdu_le, zd)
+DO_LD1_ZPZ_S(ss_be, zsu, MO_32)
+DO_LD1_ZPZ_S(ss_be, zss, MO_32)
+DO_LD1_ZPZ_D(sdu_be, zsu, MO_32)
+DO_LD1_ZPZ_D(sdu_be, zss, MO_32)
+DO_LD1_ZPZ_D(sdu_be, zd, MO_32)
 
-DO_LD1_ZPZ_S(ss_be, zsu)
-DO_LD1_ZPZ_S(ss_be, zss)
-DO_LD1_ZPZ_D(sdu_be, zsu)
-DO_LD1_ZPZ_D(sdu_be, zss)
-DO_LD1_ZPZ_D(sdu_be, zd)
+DO_LD1_ZPZ_D(sds_le, zsu, MO_32)
+DO_LD1_ZPZ_D(sds_le, zss, MO_32)
+DO_LD1_ZPZ_D(sds_le, zd, MO_32)
 
-DO_LD1_ZPZ_D(sds_le, zsu)
-DO_LD1_ZPZ_D(sds_le, zss)
-DO_LD1_ZPZ_D(sds_le, zd)
+DO_LD1_ZPZ_D(sds_be, zsu, MO_32)
+DO_LD1_ZPZ_D(sds_be, zss, MO_32)
+DO_LD1_ZPZ_D(sds_be, zd, MO_32)
 
-DO_LD1_ZPZ_D(sds_be, zsu)
-DO_LD1_ZPZ_D(sds_be, zss)
-DO_LD1_ZPZ_D(sds_be, zd)
+DO_LD1_ZPZ_D(dd_le, zsu, MO_64)
+DO_LD1_ZPZ_D(dd_le, zss, MO_64)
+DO_LD1_ZPZ_D(dd_le, zd, MO_64)
 
-DO_LD1_ZPZ_D(dd_le, zsu)
-DO_LD1_ZPZ_D(dd_le, zss)
-DO_LD1_ZPZ_D(dd_le, zd)
-
-DO_LD1_ZPZ_D(dd_be, zsu)
-DO_LD1_ZPZ_D(dd_be, zss)
-DO_LD1_ZPZ_D(dd_be, zd)
+DO_LD1_ZPZ_D(dd_be, zsu, MO_64)
+DO_LD1_ZPZ_D(dd_be, zss, MO_64)
+DO_LD1_ZPZ_D(dd_be, zd, MO_64)
 
 #undef DO_LD1_ZPZ_S
 #undef DO_LD1_ZPZ_D
-- 
2.20.1


