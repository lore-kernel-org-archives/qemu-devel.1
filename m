Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EEBC388F7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8840F22249
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHlezuf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8840F22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUu4T-000127-6B
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0n-0004YN-VH
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:21 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0m-0003sf-2l
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:21 -0400
Received: by mail-wr1-x443.google.com with SMTP id n6so2772777wrm.13
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZvUBhs8RA0L3oiYr8jUE+scCdZBTj6SeAlZ2duNtda0=;
 b=iHlezuf2Dmzh+kmjYhmqYYFr5xWzf/KVMuDjkqhkt8JatnldzMkAXxaWzZVJvZxslG
 mK/TChnR50enmMo3FVqUYAy2YILJ95hDEdq9Zd9eOvO9K/2PP25VySPSDgBrVM1VESRc
 2KVvB40LB08Vf0GNHb0y3kh9rDanAvquW1eApQSj6oT2m0rp//OBJicqxEJICfPK9HLp
 CnTbAFp1O2LlCYW+KAmA4QaBow7WJibOBaTiYguK9uGsgJIME+HSMAUTnwEedOYcWQi+
 mg4ej/rlPTzOyzYLGLJ90ovuC/ad3AcgR2iXqu4r6RL/ju6cnr6OlUy25TcbmdsaiV5W
 V9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZvUBhs8RA0L3oiYr8jUE+scCdZBTj6SeAlZ2duNtda0=;
 b=iDRpdn5vjvWyFw+ntNSutW3X7NcnBhuaHPfhDsgEyrwMEJte5EQ8u/vMx3xVd5Bk/a
 oime0N9UpQ7FbLyWMscNF5GQWgpAStTVb1qm4LVIlmSSiJ/drFIhc0qcgdWaXSVEiJ7x
 S8fMB87oLkoJGLks8AKyCFFh79ZmYSm/wCajzjex3HABCpBzPIgl73ka+JNOwKLjNc4d
 qedDE+j/zdtKoPs2pkft2+Vl5RuZYkNQOqQV7mbN+Ypk8L3r1s9NoT0wpqcgqqvlLFnM
 YKSPECgBaZMYL/Mx+PiYb+Ms26ZFW6DofPwh3L8wUlQdz2BST7I3w+2BbeL1HXMvq3RO
 0lAw==
X-Gm-Message-State: AOAM533/wo5lhgBYF+PZEuo1IJB5mo8VsuwmQkw140LQh5Y3K8TSMh4g
 6sL2eIObHoWWA2Ons4dUWeVGjjhXIsDjSw==
X-Google-Smtp-Source: ABdhPJzs0Pizu/S+W1UYbsc4UVF7VhlSljqfzPAih0x3zv2VlAw8am6x0QbyXUfoxV/zf5bxqdC7Ng==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr4194618wrq.129.1603209438183; 
 Tue, 20 Oct 2020 08:57:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/41] target/arm: Use tlb_flush_page_bits_by_mmuidx*
Date: Tue, 20 Oct 2020 16:56:25 +0100
Message-Id: <20201020155656.8045-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When TBI is enabled in a given regime, 56 bits of the address
are significant and we need to clear out any other matching
virtual addresses with differing tags.

The other uses of tlb_flush_page (without mmuidx) in this file
are only used by aarch32 mode.

Fixes: 38d931687fa1
Reported-by: Jordan Frank <jordanfrank@fb.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201016210754.818257-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 46 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index cd0779ff5fa..f49b045d366 100644
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
2.20.1


