Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F96C33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C45205F4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A64BgSml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C45205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixyfA-0002HK-Up
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySq-0007ob-7O
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySo-000710-Tb
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:56 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34657)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySo-00070C-NS
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:54 -0500
Received: by mail-pl1-x641.google.com with SMTP id j7so4184415plt.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MOQeWRomrPDFg8FXKVWMJui75ucXzLZW3uSDCABTB9c=;
 b=A64BgSml2Rn8pLxcwWWoSNTnJiW3VCCBWG8V0j6DFe4gqEoVQ0VY9hhCyKHHylr/bL
 5v15q7X7rsg97iU3wIunOjW3WdME6qHK9ftk2xo66VVvV9mvOnfS7h+YOmuab0DT3Nsl
 lzPuCZ8mOhvJGEH9yiH8yPBwEKksAI9AjyMEhksTFXrNt3Jff6ZMRO9YjY2vOvwxrO7S
 weXEU69MEyOpz8f7iOYYmF6aehkDzpupXOPIx7fbrMhTeCxHJ3eY4cJjcs+olKowQQqY
 PdcrmLnduiNGsOJSVyWna2gpl3ihkKxuaCO5Yh9R53IVZK/0NzZM9oqBc4jFMFS2RuVn
 Bn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MOQeWRomrPDFg8FXKVWMJui75ucXzLZW3uSDCABTB9c=;
 b=Yjw5lXmfYF+HxoVjsPqnfBuzL8YM1Pa6aFLFSxfmU/vmM6maTOHGUuVvqd1/A4NQEi
 7Rlid8bWBxZbG5BGm65bsu6yRPHnqzIAxfJFmiOTvQSm9mEHjq3bYw0lATllrDo5dhHg
 wM3gSqymWN2xe8VDaXJSaCNnIWUjJDQ9QZhjT+F32fc7AR2YkqO2qeeMHUXcqsZUgr7U
 TFfLh1fIA2hc9rsBJE1odCaTACoV/s8iveQbna5xmKY3+korYesl3ETPBwTweAmB6qi5
 RHuU4V86LtP7atpESXTT9UdrqSRknR1qfSlu/RJOL9u0lsIQNXREaBbuI02gH1U0ChMt
 26Ow==
X-Gm-Message-State: APjAAAUuQ0YCYazko4+KmID4rUqdMFe1aqz43x6BN9FXz75Be4DZ7vWf
 OFNnvG5yzzbEl/qh0246FwdFAe3n4/4=
X-Google-Smtp-Source: APXvYqyPGYzv5A1wRvu7n2HJQWcXwB42A0vFb0HUpvH7eMi0serrCQWidCkHdIvwP2nf2xOzz/Ertg==
X-Received: by 2002:a17:90a:a881:: with SMTP id
 h1mr19904912pjq.50.1580585393274; 
 Sat, 01 Feb 2020 11:29:53 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 30/41] target/arm: Flush tlb for ASID changes in EL2&0
 translation regime
Date: Sat,  1 Feb 2020 11:29:05 -0800
Message-Id: <20200201192916.31796-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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

Since we only support a single ASID, flush the tlb when it changes.

Note that TCR_EL2, like TCR_EL1, has the A1 bit that chooses between
the two TTBR* registers for the location of the ASID.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index cfa6ce59dc..f9be6b052f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3763,7 +3763,7 @@ static void vmsa_ttbcr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     tcr->base_mask = 0xffffc000u;
 }
 
-static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+static void vmsa_tcr_el12_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -3789,7 +3789,17 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
-    /* TODO: There are ASID fields in here with HCR_EL2.E2H */
+    /*
+     * If we are running with E2&0 regime, then an ASID is active.
+     * Flush if that might be changing.  Note we're not checking
+     * TCR_EL2.A1 to know if this is really the TTBRx_EL2 that
+     * holds the active ASID, only checking the field that might.
+     */
+    if (extract64(raw_read(env, ri) ^ value, 48, 16) &&
+        (arm_hcr_el2_eff(env) & HCR_E2H)) {
+        tlb_flush_by_mmuidx(env_cpu(env),
+                            ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E20_0);
+    }
     raw_write(env, ri, value);
 }
 
@@ -3849,7 +3859,7 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
                              offsetof(CPUARMState, cp15.ttbr1_ns) } },
     { .name = "TCR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 2,
-      .access = PL1_RW, .writefn = vmsa_tcr_el1_write,
+      .access = PL1_RW, .writefn = vmsa_tcr_el12_write,
       .resetfn = vmsa_ttbcr_reset, .raw_writefn = raw_write,
       .fieldoffset = offsetof(CPUARMState, cp15.tcr_el[1]) },
     { .name = "TTBCR", .cp = 15, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 2,
@@ -5175,10 +5185,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .resetvalue = 0 },
     { .name = "TCR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 2,
-      .access = PL2_RW,
-      /* no .writefn needed as this can't cause an ASID change;
-       * no .raw_writefn or .resetfn needed as we never use mask/base_mask
-       */
+      .access = PL2_RW, .writefn = vmsa_tcr_el12_write,
+      /* no .raw_writefn or .resetfn needed as we never use mask/base_mask */
       .fieldoffset = offsetof(CPUARMState, cp15.tcr_el[2]) },
     { .name = "VTCR", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 2,
-- 
2.20.1


