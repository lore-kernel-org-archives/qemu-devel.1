Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B5EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 21:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC86214DB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 21:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="prKSL23V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC86214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTX1u-0003o9-Cg
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 17:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTWxH-0000eL-77
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 17:08:03 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTWxF-0004nW-Br
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 17:08:02 -0400
Received: by mail-pf1-x442.google.com with SMTP id 10so2192423pfp.5
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 14:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i1O+zLokmvq0z3Tswej92vaAb5atW04s8IFUi7ThT68=;
 b=prKSL23VnHl4+YXJKW/1H4TQb2rexuy1oU5YNBjZmlI73kxY4dtf77zWXvba4pFPAa
 5qzRTZh40P3h4R7UUQcepGWTQcLmZNPNUq5ROYpD2Ci6nZf550MW2eSynoSR+PerrsCX
 c07sR3WMNNYyC7frBADkhn3HPCqCfvf0gEhzRabZN9oF07Ei0xprRhWkdMQSzOsqgT+x
 TLwDHf27NKZK+VWj6DdiRGP2/OohL24iHOwnIfujzszJsw/o+B4N55aLKsrP+ubwHijU
 JriJ88NcI/U69/lwJGoqR3+fZ/9+PDBbxpSJ8sfVZgEiPHkbal27Sz/eBqWK+//7tERH
 LtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i1O+zLokmvq0z3Tswej92vaAb5atW04s8IFUi7ThT68=;
 b=jRIT1PlkyVqnp+lOdjYcECp7t9yl3AzFmZ0+VselsyTM27KVq41Gm+FdvGpPIq2RAv
 yQ1a4ZSkgcO9cpfjQaDZugGb9EMefUFr3C9H6MGZtIzLwwAcgveqfbGS5gRzA9FxLkIt
 u1aL0qadalNpryXwRb1vkyeI1pNL1DPp7urOUWg0M3S9a2GIT1YsaWrLlW7L7bFVmKer
 WV1MAwglrkmh008PDIn+/MoNys5tKiEOwOaNR+jYjQ4MM6ejBHXGw4Kz9T+GwiFeIN7R
 nB/FLHDlrsd0FS+A9pONS5uGXhOvuVgmFh7UEy2MVbZXo15tMuhpIq5LGDiWQ5wV215h
 uixw==
X-Gm-Message-State: AOAM533DldsrJqXiFvewHxICnzFN+bjxeg/6ZlWsbyeHswCU1o3KLNET
 vqUn0yaHPggvVj2MctUmhIX9fPJF+Jt42g==
X-Google-Smtp-Source: ABdhPJxdk+QvpxtQFZRjnfSWZE4QfH4MIHnddhGcb0erdzm5NGKLbUwuajhiEC355CvfOLoPNBfWlg==
X-Received: by 2002:aa7:8e9c:0:b029:152:8a25:548d with SMTP id
 a28-20020aa78e9c0000b02901528a25548dmr5610613pfr.73.1602882479566; 
 Fri, 16 Oct 2020 14:07:59 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 198sm3682324pfy.41.2020.10.16.14.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 14:07:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] target/arm: Use tlb_flush_page_bits_by_mmuidx*
Date: Fri, 16 Oct 2020 14:07:54 -0700
Message-Id: <20201016210754.818257-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016210754.818257-1-richard.henderson@linaro.org>
References: <20201016210754.818257-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Jordan Frank <jordanfrank@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When TBI is enabled in a given regime, 56 bits of the address
are significant and we need to clear out any other matching
virtual addresses with differing tags.

The other uses of tlb_flush_page (without mmuidx) in this file
are only used by aarch32 mode.

Fixes: 38d931687fa1
Reported-by: Jordan Frank <jordanfrank@fb.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 46 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index cd0779ff5f..f49b045d36 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -50,6 +50,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
 #endif
 
 static void switch_mode(CPUARMState *env, int mode);
+static int aa64_va_parameter_tbi(uint64_t tcr, ARMMMUIdx mmu_idx);
 
 static int vfp_gdb_get_reg(CPUARMState *env, GByteArray *buf, int reg)
 {
@@ -4457,6 +4458,33 @@ static int vae1_tlbmask(CPUARMState *env)
     }
 }
 
+/* Return 56 if TBI is enabled, 64 otherwise. */
+static int tlbbits_for_regime(CPUARMState *env, ARMMMUIdx mmu_idx,
+                              uint64_t addr)
+{
+    uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
+    int tbi = aa64_va_parameter_tbi(tcr, mmu_idx);
+    int select = extract64(addr, 55, 1);
+
+    return (tbi >> select) & 1 ? 56 : 64;
+}
+
+static int vae1_tlbbits(CPUARMState *env, uint64_t addr)
+{
+    ARMMMUIdx mmu_idx;
+
+    /* Only the regime of the mmu_idx below is significant. */
+    if (arm_is_secure_below_el3(env)) {
+        mmu_idx = ARMMMUIdx_SE10_0;
+    } else if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE))
+               == (HCR_E2H | HCR_TGE)) {
+        mmu_idx = ARMMMUIdx_E20_0;
+    } else {
+        mmu_idx = ARMMMUIdx_E10_0;
+    }
+    return tlbbits_for_regime(env, mmu_idx, addr);
+}
+
 static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                       uint64_t value)
 {
@@ -4593,8 +4621,9 @@ static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
     int mask = vae1_tlbmask(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
+    int bits = vae1_tlbbits(env, pageaddr);
 
-    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, mask);
+    tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
 }
 
 static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4608,11 +4637,12 @@ static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
     int mask = vae1_tlbmask(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
+    int bits = vae1_tlbbits(env, pageaddr);
 
     if (tlb_force_broadcast(env)) {
-        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, mask);
+        tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
     } else {
-        tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
+        tlb_flush_page_bits_by_mmuidx(cs, pageaddr, mask, bits);
     }
 }
 
@@ -4621,9 +4651,10 @@ static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = env_cpu(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
+    int bits = tlbbits_for_regime(env, ARMMMUIdx_E2, pageaddr);
 
-    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_E2);
+    tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr,
+                                                  ARMMMUIdxBit_E2, bits);
 }
 
 static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4631,9 +4662,10 @@ static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = env_cpu(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
+    int bits = tlbbits_for_regime(env, ARMMMUIdx_SE3, pageaddr);
 
-    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_SE3);
+    tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr,
+                                                  ARMMMUIdxBit_SE3, bits);
 }
 
 static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.25.1


