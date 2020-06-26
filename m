Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C30C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 04:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE6320767
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 04:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P51XTj/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE6320767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofYt-0006My-0s
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 00:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6c-0001Pp-3v
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:46 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6a-00027w-Fg
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:45 -0400
Received: by mail-pl1-x644.google.com with SMTP id d10so3756828pls.5
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=japKMCqtTJyDaS3XobN6C3/Z94MHElZymKmMsjyLpI4=;
 b=P51XTj/SdzBcw3mubVvk8ocGw8WrWb9T4Inr/K0w31Ee8sfg3XL6P9okc0GeYVxi92
 vSbw3QqvD51wl/nPx451MOHdgmj3hNJRGwQb6QB9oUGla9gw2prT12cNgpMnHhorpyH7
 IPnR7hECYnuJutxFDTPlf9APqVY9gMhXQgSbWl+i9SANVsAyg+ig1fn66k5gYIz0tBsh
 1+PWMHSMRSVbXyYU972+IpbiWe92eUMUcWTX9UqWlFvS9Vc9E+8L9mSkC/3wfPSdLIUV
 MSSQWqIYt3vRgHdiLlr9vLk1Eupvy2R38UCVIBAOhIpHOmMCvD3bCKDQlYLLEx2cbngi
 WZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=japKMCqtTJyDaS3XobN6C3/Z94MHElZymKmMsjyLpI4=;
 b=AEVbBFBu1hRRT4t4wMz+vnXV6IYj+qUO+uN0nXlHrv6lu/4gnCkd1u5fS42jsqMRNe
 zNUi9b9JTkCNkguTSC9zaelj/MnapNvq15lycx34zbE18eHPgx58HvbHYO7gEv1fRcnD
 zXJDLvtYVq6TAZWne8k/oq+IzRZEAOXkascX37cuMkLye2iXzmmEVZCI/z61tteWVSp/
 /ko5OuTndj+sjSbkb1gcm5z2tacttKvFkOWxg9KTBUpPkD9ke/sAKHllyCPBfzHMwAqm
 BPDbrcEPStj+u4EMfU13sSpF1AQ/32X/qZYOiqPfERNHmyrquicVjMFDlXplfAmLiRIm
 ID1A==
X-Gm-Message-State: AOAM5330owkvXR0DEEoJ3Uu32bwtRs2cZGxYscD2dijsFg2XaBJT12na
 LrWKhxDg68TuEsTnDU3XDGaxxPANXlc=
X-Google-Smtp-Source: ABdhPJz4qSogDsP/DXHzeA5Py174UaCDCbO9NYhSTA7H20/vWsTnq3gAX+A1UzJovrG9o58AyUsTVw==
X-Received: by 2002:a17:902:a504:: with SMTP id
 s4mr833003plq.337.1593142362784; 
 Thu, 25 Jun 2020 20:32:42 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 42/46] target/arm: Cache the Tagged bit for a page in
 MemTxAttrs
Date: Thu, 25 Jun 2020 20:31:40 -0700
Message-Id: <20200626033144.790098-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This "bit" is a particular value of the page's MemAttr.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v6: Test HCR_EL2.{DC,DCT}; test Stage2 attributes.
v8: Fill in cacheattrs for S1 disabled; retain tagging when
    combining attributes; set mte_tagging in arm_cpu_tlb_fill.
---
 target/arm/helper.c     | 48 ++++++++++++++++++++++++++++++++++++++---
 target/arm/tlb_helper.c |  5 +++++
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2072db2f92..dc9c29f998 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11834,9 +11834,19 @@ static uint8_t combine_cacheattr_nibble(uint8_t s1, uint8_t s2)
  */
 static ARMCacheAttrs combine_cacheattrs(ARMCacheAttrs s1, ARMCacheAttrs s2)
 {
-    uint8_t s1lo = extract32(s1.attrs, 0, 4), s2lo = extract32(s2.attrs, 0, 4);
-    uint8_t s1hi = extract32(s1.attrs, 4, 4), s2hi = extract32(s2.attrs, 4, 4);
+    uint8_t s1lo, s2lo, s1hi, s2hi;
     ARMCacheAttrs ret;
+    bool tagged = false;
+
+    if (s1.attrs == 0xf0) {
+        tagged = true;
+        s1.attrs = 0xff;
+    }
+
+    s1lo = extract32(s1.attrs, 0, 4);
+    s2lo = extract32(s2.attrs, 0, 4);
+    s1hi = extract32(s1.attrs, 4, 4);
+    s2hi = extract32(s2.attrs, 4, 4);
 
     /* Combine shareability attributes (table D4-43) */
     if (s1.shareability == 2 || s2.shareability == 2) {
@@ -11884,6 +11894,11 @@ static ARMCacheAttrs combine_cacheattrs(ARMCacheAttrs s1, ARMCacheAttrs s2)
         }
     }
 
+    /* TODO: CombineS1S2Desc does not consider transient, only WB, RWA. */
+    if (tagged && ret.attrs == 0xff) {
+        ret.attrs = 0xf0;
+    }
+
     return ret;
 }
 
@@ -11963,8 +11978,11 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
                  *  Normal Non-Shareable,
                  *  Inner Write-Back Read-Allocate Write-Allocate,
                  *  Outer Write-Back Read-Allocate Write-Allocate.
+                 * Do not overwrite Tagged within attrs.
                  */
-                cacheattrs->attrs = 0xff;
+                if (cacheattrs->attrs != 0xf0) {
+                    cacheattrs->attrs = 0xff;
+                }
                 cacheattrs->shareability = 0;
             }
             *cacheattrs = combine_cacheattrs(*cacheattrs, cacheattrs2);
@@ -12029,6 +12047,9 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
     /* Definitely a real MMU, not an MPU */
 
     if (regime_translation_disabled(env, mmu_idx)) {
+        uint64_t hcr;
+        uint8_t memattr;
+
         /*
          * MMU disabled.  S1 addresses within aa64 translation regimes are
          * still checked for bounds -- see AArch64.TranslateAddressS1Off.
@@ -12066,6 +12087,27 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
         *phys_ptr = address;
         *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         *page_size = TARGET_PAGE_SIZE;
+
+        /* Fill in cacheattr a-la AArch64.TranslateAddressS1Off. */
+        hcr = arm_hcr_el2_eff(env);
+        cacheattrs->shareability = 0;
+        if (hcr & HCR_DC) {
+            if (hcr & HCR_DCT) {
+                memattr = 0xf0;  /* Tagged, Normal, WB, RWA */
+            } else {
+                memattr = 0xff;  /* Normal, WB, RWA */
+            }
+        } else if (access_type == MMU_INST_FETCH) {
+            if (regime_sctlr(env, mmu_idx) & SCTLR_I) {
+                memattr = 0xee;  /* Normal, WT, RA, NT */
+            } else {
+                memattr = 0x44;  /* Normal, NC, No */
+            }
+            cacheattrs->shareability = 2; /* outer sharable */
+        } else {
+            memattr = 0x00;      /* Device, nGnRnE */
+        }
+        cacheattrs->attrs = memattr;
         return 0;
     }
 
diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
index 89d90465a3..b35dc8a011 100644
--- a/target/arm/tlb_helper.c
+++ b/target/arm/tlb_helper.c
@@ -188,6 +188,11 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             phys_addr &= TARGET_PAGE_MASK;
             address &= TARGET_PAGE_MASK;
         }
+        /* Notice and record tagged memory. */
+        if (cpu_isar_feature(aa64_mte, cpu) && cacheattrs.attrs == 0xf0) {
+            arm_tlb_mte_tagged(&attrs) = true;
+        }
+
         tlb_set_page_with_attrs(cs, address, phys_addr, attrs,
                                 prot, mmu_idx, page_size);
         return true;
-- 
2.25.1


