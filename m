Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BA8C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC488214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VE512ieJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC488214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izh5s-0005me-0P
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izgto-0004NA-4k
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:08:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izgtm-0002YY-R4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:08:52 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:42334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izgtm-0002Xt-K3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:08:50 -0500
Received: by mail-wr1-x42d.google.com with SMTP id k11so7091053wrd.9
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 05:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ljJYpbCmEevExEOIjsAnldy/FNpgECFYwlJ5McdAh68=;
 b=VE512ieJJ6dB3WkbowjlYFC0DUTRy5cVTn3asBq/IFUeIX4LVA9J0Xsi76h2pyPyvN
 h3WmOa6imh4jrJrt3Z+KvO/qWA0o3GuW6xWL5LkajStAbV8RPAFxK9d/2rlkYQ4Sa3oP
 Udv8/9fdgNtaltNXQVMn8tFGmjHlItiZ8ZMuv6AIrkGvtuBCp8zv6GhmSQLsJUep7Y5o
 TiCaBfMAbNdSn4IxKHNztX4o5ruKje0d8qCG8dlj2e3jvJjwyEW9O9/RpkJzKcPLhNs3
 FR/9ILa7RfQYZEOztyILAliaCbnaIuPxODTgSbjCZoAqM7R4iluCleIyVrs5fbLn7PJb
 Zwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ljJYpbCmEevExEOIjsAnldy/FNpgECFYwlJ5McdAh68=;
 b=kkwczdPTU2OdGhQ0I43vk7H9QbNSWcjuTWEK/Uhzxt2oNCz6AsEIFEb+sskB4AXtJr
 M6Eic4w65NgEWAJf5ID2W4Se91isBQHSPEK3ZQY3Ixk1Qw2VFX0ZdPbDZewrvUJxyJ/p
 ynQ798aLUJUpKbP3kLtl4KwkGcya0tmeFVTvGObhex84awosUCp649uGGwC4MiYMD5ME
 GW30O8IZgaEFw/R+9kbvdTo4IXH5BoRwHdvhTYHTaEj3MxDtM2dyUb+0IfjbwQIPSwgJ
 nR3CPROBk7azp8nFANshXCzoQ4oHj0NhkcEU1SlAbZY9JEE/7cDDtyGn/Ao+Uj3VHozl
 RNJA==
X-Gm-Message-State: APjAAAW9r3BQ67fDEJdgGI0dAQu7sAbhDnKBJUKx2Yb6Q8hZ7i7/d0y1
 c+tGTn+phkb/tpWEerE1qO+H9CQiJlRKZw==
X-Google-Smtp-Source: APXvYqzpHcV0XajAR4nDninY+tTAex2pAJMUM00u63S+MfvDGX/5FjgKzRcTKXMuNwsri1ywj6fxRQ==
X-Received: by 2002:adf:f58c:: with SMTP id f12mr3635101wro.22.1580994529067; 
 Thu, 06 Feb 2020 05:08:49 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id c9sm4142155wrq.44.2020.02.06.05.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 05:08:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] target/arm: Split out aa64_va_parameter_tbi,
 aa64_va_parameter_tbid
Date: Thu,  6 Feb 2020 13:08:47 +0000
Message-Id: <20200206130847.11166-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206130847.11166-1-richard.henderson@linaro.org>
References: <20200206130847.11166-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For the purpose of rebuild_hflags_a64, we do not need to compute
all of the va parameters, only tbi.  Moreover, we can compute them
in a form that is more useful to storing in hflags.

This eliminates the need for aa64_va_parameter_both, so fold that
in to aa64_va_parameter.  The remaining calls to aa64_va_parameter
are in get_phys_addr_lpae and in pauth_helper.c.

This reduces the total cpu consumption of aa64_va_parameter in a
kernel boot plus a kvm guest kernel boot from 3% to 0.5%.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  3 --
 target/arm/helper.c    | 68 +++++++++++++++++++++++-------------------
 2 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6d4a942bde..6ac84bbca7 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1042,15 +1042,12 @@ typedef struct ARMVAParameters {
     unsigned tsz    : 8;
     unsigned select : 1;
     bool tbi        : 1;
-    bool tbid       : 1;
     bool epd        : 1;
     bool hpd        : 1;
     bool using16k   : 1;
     bool using64k   : 1;
 } ARMVAParameters;
 
-ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
-                                        ARMMMUIdx mmu_idx);
 ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
                                    ARMMMUIdx mmu_idx, bool data);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7d15d5c933..d2e9332696 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10067,12 +10067,34 @@ static uint8_t convert_stage2_attrs(CPUARMState *env, uint8_t s2attrs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
-                                        ARMMMUIdx mmu_idx)
+static int aa64_va_parameter_tbi(uint64_t tcr, ARMMMUIdx mmu_idx)
+{
+    if (regime_has_2_ranges(mmu_idx)) {
+        return extract64(tcr, 37, 2);
+    } else if (mmu_idx == ARMMMUIdx_Stage2) {
+        return 0; /* VTCR_EL2 */
+    } else {
+        return extract32(tcr, 20, 1);
+    }
+}
+
+static int aa64_va_parameter_tbid(uint64_t tcr, ARMMMUIdx mmu_idx)
+{
+    if (regime_has_2_ranges(mmu_idx)) {
+        return extract64(tcr, 51, 2);
+    } else if (mmu_idx == ARMMMUIdx_Stage2) {
+        return 0; /* VTCR_EL2 */
+    } else {
+        return extract32(tcr, 29, 1);
+    }
+}
+
+ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
+                                   ARMMMUIdx mmu_idx, bool data)
 {
     uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
-    bool tbi, tbid, epd, hpd, using16k, using64k;
-    int select, tsz;
+    bool epd, hpd, using16k, using64k;
+    int select, tsz, tbi;
 
     /*
      * Bit 55 is always between the two regions, and is canonical for
@@ -10086,11 +10108,9 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         using16k = extract32(tcr, 15, 1);
         if (mmu_idx == ARMMMUIdx_Stage2) {
             /* VTCR_EL2 */
-            tbi = tbid = hpd = false;
+            hpd = false;
         } else {
-            tbi = extract32(tcr, 20, 1);
             hpd = extract32(tcr, 24, 1);
-            tbid = extract32(tcr, 29, 1);
         }
         epd = false;
     } else if (!select) {
@@ -10098,27 +10118,29 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         epd = extract32(tcr, 7, 1);
         using64k = extract32(tcr, 14, 1);
         using16k = extract32(tcr, 15, 1);
-        tbi = extract64(tcr, 37, 1);
         hpd = extract64(tcr, 41, 1);
-        tbid = extract64(tcr, 51, 1);
     } else {
         int tg = extract32(tcr, 30, 2);
         using16k = tg == 1;
         using64k = tg == 3;
         tsz = extract32(tcr, 16, 6);
         epd = extract32(tcr, 23, 1);
-        tbi = extract64(tcr, 38, 1);
         hpd = extract64(tcr, 42, 1);
-        tbid = extract64(tcr, 52, 1);
     }
     tsz = MIN(tsz, 39);  /* TODO: ARMv8.4-TTST */
     tsz = MAX(tsz, 16);  /* TODO: ARMv8.2-LVA  */
 
+    /* Present TBI as a composite with TBID.  */
+    tbi = aa64_va_parameter_tbi(tcr, mmu_idx);
+    if (!data) {
+        tbi &= ~aa64_va_parameter_tbid(tcr, mmu_idx);
+    }
+    tbi = (tbi >> select) & 1;
+
     return (ARMVAParameters) {
         .tsz = tsz,
         .select = select,
         .tbi = tbi,
-        .tbid = tbid,
         .epd = epd,
         .hpd = hpd,
         .using16k = using16k,
@@ -10126,16 +10148,6 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
     };
 }
 
-ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
-                                   ARMMMUIdx mmu_idx, bool data)
-{
-    ARMVAParameters ret = aa64_va_parameters_both(env, va, mmu_idx);
-
-    /* Present TBI as a composite with TBID.  */
-    ret.tbi &= (data || !ret.tbid);
-    return ret;
-}
-
 #ifndef CONFIG_USER_ONLY
 static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
                                           ARMMMUIdx mmu_idx)
@@ -11955,21 +11967,15 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
 {
     uint32_t flags = rebuild_hflags_aprofile(env);
     ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
-    ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
+    uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
     uint64_t sctlr;
     int tbii, tbid;
 
     flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
 
     /* Get control bits for tagged addresses.  */
-    if (regime_has_2_ranges(mmu_idx)) {
-        ARMVAParameters p1 = aa64_va_parameters_both(env, -1, stage1);
-        tbid = (p1.tbi << 1) | p0.tbi;
-        tbii = tbid & ~((p1.tbid << 1) | p0.tbid);
-    } else {
-        tbid = p0.tbi;
-        tbii = tbid & !p0.tbid;
-    }
+    tbid = aa64_va_parameter_tbi(tcr, mmu_idx);
+    tbii = tbid & ~aa64_va_parameter_tbid(tcr, mmu_idx);
 
     flags = FIELD_DP32(flags, TBFLAG_A64, TBII, tbii);
     flags = FIELD_DP32(flags, TBFLAG_A64, TBID, tbid);
-- 
2.20.1


