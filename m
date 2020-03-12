Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4690AC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1029820637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/7RAi1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1029820637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTvP-0001CC-7P
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTji-0006vp-9A
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjh-0002RE-4Z
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:18 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:53603)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTjg-0002QI-VM
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:17 -0400
Received: by mail-pj1-x1044.google.com with SMTP id l36so2968185pjb.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FqxgWRxNaOrIo80/rd7EvP+ZqoigJ+ge9JbM5ILrh50=;
 b=K/7RAi1QturA2wu+mnUAiJRDSFP6ttUS8ps8kO5kEbQcYbkkfdpiLl/sqCvp1CffMB
 LXFC1b95ipYR3Iq0L7trKv1BI7MZyioDSvX8Y6druJ6mBm5Sq5TEkH1QXM8ORL4b5iZg
 TX6vpF8s4RzuzRA2nYUO3zWV13axJExKtOEKTYqOxrSbOtzwH5lWZTlehNHJ3uJ+WRtr
 h3jEC/pptA3Zo4ME6xJ1gaEKbslG30rDF6Emp3yPr5MOQULRunwUSRyqSacJOR8Og4Tf
 ZMM2Zl6NC16F23k5rhMzU3aWodvdAPgA3Jn9NeC07HhHYo+Tem8iN/WO7+f8u2daSKEE
 mX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FqxgWRxNaOrIo80/rd7EvP+ZqoigJ+ge9JbM5ILrh50=;
 b=S4kO/SFhd+G+YuNrRQWZAeA6Wcs04QKPzUvWSKTkuEy/lKaY6jJvhJB/FiGq2DB3Ph
 hxhTEBV1BD8bsa555KSzq7RdoOIPm9Sd65L/OAHcD2MkKhG05/W334aAvEQMHltG8nng
 RBY0elHy5reBCpkZQAZzalTxWiTeKI+HzEmAPnsIHQHCRMDVIbetlaZjgxEuurFs6OLt
 AoLR34Iey3euvFiWSr8zFoR/p650zsiQkbwa944Y1lfg3nliws3D9B914I2u3PemwXC0
 ly3zeL1VdpMyakDiWdgYiObuIdG9eqKUgJKeg2gala/NcUy4BfIdYROvXOJ8TlPo41x5
 RdVg==
X-Gm-Message-State: ANhLgQ2UzU5Ay6FBFhO585JtB/MLdBUcLFG+Jz3KPK5jFjdq8p/OPsO9
 CrjokRBcbJbxQwAuQSx5jgtXPbpQOdw=
X-Google-Smtp-Source: ADFU+vudl2xEsP4dZjy2/5sVwRI0ebMp0Qk63/29HruLoZaWbdQSyiterXbB8FatlHplsY7/5CcSzw==
X-Received: by 2002:a17:902:7298:: with SMTP id
 d24mr9600552pll.134.1584042194660; 
 Thu, 12 Mar 2020 12:43:14 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:43:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 40/42] target/arm: Cache the Tagged bit for a page in
 MemTxAttrs
Date: Thu, 12 Mar 2020 12:42:17 -0700
Message-Id: <20200312194219.24406-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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

This "bit" is a particular value of the page's MemAttr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v6: Test HCR_EL2.{DC,DCT}; test Stage2 attributes.
---
 target/arm/helper.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b38dc74733..c272c48467 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10785,6 +10785,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
     bool guarded = false;
+    uint8_t memattr;
 
     /* TODO:
      * This code does not handle the different format TCR for VTCR_EL2.
@@ -11013,17 +11014,32 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
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
 
@@ -11978,6 +11994,17 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
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
2.20.1


