Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575CFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E60420773
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K0WC6DK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E60420773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqYx-00081q-92
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4m-0003aZ-CF
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:50452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4k-0006kx-B0
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id l17so9183057wmj.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=zJG4LmoTNrjoY6KmdBOWs3FmVPzTalAXaLQDaG1a0is=;
 b=K0WC6DK9FR2Clq5Z7yvawTFy7Do1bKY9arCV+YRnIt9a7unvfPu81MPqtPZrJRYckL
 0EsXRIhWb2ng2cgFMDhDWVIizTYZ/QCT4s7Ji9xhNvLgxdlTOs8nWXwcJ5/LAQ7DLu6k
 iGitiOei0e3HIUp58VVeBSDOZxgGH2n33If8M1EveOuZvD7Wg8wimOpHhkWxzW1DTUk4
 71Sag+7TN+pEmRERymwCaF9wsAgW8LYNjuTg3bdrC0ZvQfzOaiytvx5mhK7tQA7YvENa
 71RUguTXyDkevuB1UDiQtH8lv6rXOz7dsEcRAwPl9Q3frNf9QpjApNgGhCnU60+6KnTU
 BFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zJG4LmoTNrjoY6KmdBOWs3FmVPzTalAXaLQDaG1a0is=;
 b=UrTEFrnUNTtt9arjlJkNTLH/FCRT3NcBeqykkeAexgKd/eFzuD6EdYp/xyjJZqOtPb
 tum70GFfpS/v92771swQ0MheTLvpiWOww5xo5xUnCoYKzjgpp8vFUI5sS6TmLHXPLg32
 ZjmWPjt2ijpUYvozyh0SnjsSKFkJj6XeJFsWb5xPf/7OogUdP707tFx4vxAp/UJkq1Um
 mn3iHyQh7itwsAHyYQp0OpjDMEQH1JfsXJoh5yqTGDs1LvxBPpxkzc0ciA4fkUHuhFcv
 iaMypaXa6sKV22VLRE6eP9bqQTpOomocqVFw/cNkWYGbrRpOz2jCjLWKUGmQPmXAk+wy
 2H3g==
X-Gm-Message-State: AOAM5306VptUJTOPjYNGI4fQMBHJddvG4gFflQVRWl0DRV8AbWsZrQb4
 YTu8/OSMIHLjQcdtyvt9XySiaJEZqGc91g==
X-Google-Smtp-Source: ABdhPJzimoKSWS5nS8mFe4VsOngGit6HAgK60v0xf2ttpVFkLjAl54rteXLQfRELPIu2dJAQ7Bql5Q==
X-Received: by 2002:a1c:6887:: with SMTP id d129mr3890265wmc.179.1593184532466; 
 Fri, 26 Jun 2020 08:15:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.15.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:15:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/57] target/arm: Cache the Tagged bit for a page in MemTxAttrs
Date: Fri, 26 Jun 2020 16:14:21 +0100
Message-Id: <20200626151424.30117-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

This "bit" is a particular value of the page's MemAttr.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-43-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c     | 48 ++++++++++++++++++++++++++++++++++++++---
 target/arm/tlb_helper.c |  5 +++++
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2072db2f92d..dc9c29f998f 100644
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
index 89d90465a32..b35dc8a0118 100644
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
2.20.1


