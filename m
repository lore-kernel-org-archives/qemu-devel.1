Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A63AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF81206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFFLM/rP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF81206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgIL4-0005wn-8M
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyv-0005HZ-Sa
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:14:13 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyv-0003hx-13
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:14:13 -0400
Received: by mail-pl1-x644.google.com with SMTP id y11so187605plt.12
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=665wfLrYyWEoos7hXDIalhn/FRb4JzUf+uVTCWnMdBk=;
 b=RFFLM/rPkSHJRM3cLpBsW4J6geKJtqaYvcYaPsKmbGkUSntjNheN2i6CmXaiEZDUZC
 qt5SLmlnwXT2YesWxKx0duZ5XYB1hco2WwNNUz3/GPyzOHhSLAiZov5fAi5Gs9g+8L+M
 mc6t6nmYxdr8mvCz05SOKbGo4FJdWqTYamuh4T+f7HWe9o1y97j6xG+MTPAKdNtc1Dyl
 SUFtnemT3RBwHfGMAAWSvdBmXM/Qtw3pNMM1bKteFL3wJ+j9MUqtUSXXVLXqXr1ObDWQ
 /QWFbz806gw43sw+ZfK6UVlfOHo8+tk02rwXZNjTSQkbaaTRc6DmyGkvbVo7wQk9pQwm
 LlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=665wfLrYyWEoos7hXDIalhn/FRb4JzUf+uVTCWnMdBk=;
 b=uAEWLYzTjPk8ayFnPxh4olPrZdFmb2X6aUOxbKNlNTbuJUzqny1Z5UlsPJCp/3Bohd
 2H+nR1B0qRSH7MKvOeB048V/Q0idSpibO4n6s3jJgJTK6q/y+tUcrXAMbjuVGLm9FBch
 osOTpyPbacBAxP9NCnEmGmPmo7P4hgWBhI0x6y+nshU7Q2ttPI6j1lD6twO7UOiMeA3e
 oDCKerq1qK93CthXagkCBWQgxhtLaORUMGgh5bXMtnSzhY9U127k/5cCTrcLiptyetBg
 j7/3quWBS5Xo/Hi16p6hUQjB9y+CBucKxotPETEmMQJUBIe54zlbrlEfM31BRblwhDCD
 coRA==
X-Gm-Message-State: AOAM530fGuM1lwoY7ltGWnypYYBgg+m39L3lpzhsIv0yrcE7qMbh8u68
 GPI+rfLBlxYsO6qS9ShFO25rPlOhz8I=
X-Google-Smtp-Source: ABdhPJzRWcv/W8K9djxN3gAqswxhOHrJ1c8DQYptTMX9YpbZM2mXvEWWk6PgB9FjsDN0Yq3ShCGOCQ==
X-Received: by 2002:a17:902:a412:: with SMTP id
 p18mr27270100plq.111.1591146851410; 
 Tue, 02 Jun 2020 18:14:11 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:14:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 40/42] target/arm: Cache the Tagged bit for a page in
 MemTxAttrs
Date: Tue,  2 Jun 2020 18:13:15 -0700
Message-Id: <20200603011317.473934-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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

This "bit" is a particular value of the page's MemAttr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v6: Test HCR_EL2.{DC,DCT}; test Stage2 attributes.
---
 target/arm/helper.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 50717afa4a..74925010ea 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10875,6 +10875,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
     bool guarded = false;
+    uint8_t memattr;
 
     /* TODO: This code does not support shareability levels. */
     if (aarch64) {
@@ -11099,17 +11100,32 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         txattrs->target_tlb_bit0 = true;
     }
 
-    if (cacheattrs != NULL) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
+        memattr = convert_stage2_attrs(env, extract32(attrs, 0, 4));
+    } else {
+        /* Index into MAIR registers for cache attributes */
+        uint64_t mair = env->cp15.mair_el[el];
+        memattr = extract64(mair, extract32(attrs, 0, 3) * 8, 8);
+    }
+
+    /* When MTE is enabled, remember Tagged Memory in IOTLB. */
+    if (aarch64 && cpu_isar_feature(aa64_mte, cpu)) {
         if (mmu_idx == ARMMMUIdx_Stage2) {
-            cacheattrs->attrs = convert_stage2_attrs(env,
-                                                     extract32(attrs, 0, 4));
+            /*
+             * Require Normal, I+O Shareable, WB, NT, RA, WA (0xff).
+             * If not, squash stage1 tagged normal setting.
+             */
+            if (memattr != 0xff) {
+                txattrs->target_tlb_bit1 = false;
+            }
         } else {
-            /* Index into MAIR registers for cache attributes */
-            uint8_t attrindx = extract32(attrs, 0, 3);
-            uint64_t mair = env->cp15.mair_el[regime_el(env, mmu_idx)];
-            assert(attrindx <= 7);
-            cacheattrs->attrs = extract64(mair, attrindx * 8, 8);
+            /* Tagged Normal Memory (0xf0).  */
+            txattrs->target_tlb_bit1 = (memattr == 0xf0);
         }
+    }
+
+    if (cacheattrs != NULL) {
+        cacheattrs->attrs = memattr;
         cacheattrs->shareability = extract32(attrs, 6, 2);
     }
 
@@ -12065,6 +12081,17 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
         *phys_ptr = address;
         *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         *page_size = TARGET_PAGE_SIZE;
+
+        /* Stage1 translations are Tagged or Untagged based on HCR_DCT. */
+        if (cpu_isar_feature(aa64_mte, env_archcpu(env))
+            && (mmu_idx == ARMMMUIdx_Stage1_E0 ||
+                mmu_idx == ARMMMUIdx_Stage1_E1 ||
+                mmu_idx == ARMMMUIdx_Stage1_E1_PAN)) {
+            uint64_t hcr = arm_hcr_el2_eff(env);
+            if ((hcr & (HCR_DC | HCR_DCT)) == (HCR_DC | HCR_DCT)) {
+                attrs->target_tlb_bit1 = true;
+            }
+        }
         return 0;
     }
 
-- 
2.25.1


