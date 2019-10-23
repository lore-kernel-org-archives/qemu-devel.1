Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECA1CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA3E22064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PgnrO0uP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3E22064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIiO-0005gN-Am
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8w-0008F8-Sj
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8s-0001In-CY
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:46 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:34018)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNI8r-0000zn-Ux
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:42 -0400
Received: by mail-qk1-x741.google.com with SMTP id f18so19439027qkm.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+UgAJ6EhcwGdb7pezBRTrZ79eaC+NjRs0dqrTWfzTFo=;
 b=PgnrO0uPpTiYTYsbXPpY87h8Z0eBFe3G++ZOjFoT6Wu3rV+AblsG3Jrtl/PhuHdYq8
 DplElLgxVtc81TN7i+dBHdKGP/hcZZqP64CmIX8TqdP7rV4V6p3Begod0zD7ceggmlQC
 RXxeCK1syyeLApzjg17+yPc0D6vOcJnCflqlR7YeboQbls0QJJVCp/wFtvBH2ReJ6lM+
 vkJ67izP6YTWzKKXwtbPIEDPZRc5gTjKxs9u0ngb2+02A9KASpBkc5b09ZRH6/APzcAV
 QmrLUlVbmej/KoVE3QWUJ2vlWNiAljtW5ZoPOkJjdg+JDgwjC8Y096KCS1VTDONvpVqy
 2D5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+UgAJ6EhcwGdb7pezBRTrZ79eaC+NjRs0dqrTWfzTFo=;
 b=gD8wRZ6h4mP4TRABoH1RNfLpM92goPq/5r1v2td4koFg1lQVmeaEoiItOQDMWxTH5c
 VdL4psg8mzmHoUSD7ZjL/7sq7rAgTYrB2kQI9OXDYZGzi0jlN17ySQoU2O9EcPNahC9f
 0fqnKEzqGgH6UEM220skpSAWmsWoSebG2i1s8sP7JgdV2mDJU/shWkJT+9c+S9g5lV4h
 bWGgYQsfaYxD+DT6lyMlatLCvYL0Hid2hFK/AfOUVsEorEVxX+o++VZiScdPUzaTvOhu
 Xf9Kjrfc+7615mzV9AlLQlQSZo1bdDmIHOtnuziTmyptBDZpeUcSTdb3+CmfIkYQhjVO
 mEDg==
X-Gm-Message-State: APjAAAXg+ZefMM1FPaLc5+wR3hk1L3nl061TIPLW2N9570ZddM2TRYEv
 qerEzA0cYDNCTUULshWvuNl1CZrhudg=
X-Google-Smtp-Source: APXvYqxwajp22hz9pigHcDSFodqeZVJKfpWySpzLn/4csgkugNTic0oO3Kt4fpKn18wLg3v8s8/63w==
X-Received: by 2002:a37:4dca:: with SMTP id a193mr8751748qkb.292.1571842865717; 
 Wed, 23 Oct 2019 08:01:05 -0700 (PDT)
Received: from localhost.localdomain (198-4-20-64.static.cosmoweb.net.
 [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id l189sm11030168qke.69.2019.10.23.08.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:01:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 03/24] target/arm: Split out rebuild_hflags_common_32
Date: Wed, 23 Oct 2019 11:00:36 -0400
Message-Id: <20191023150057.25731-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023150057.25731-1-richard.henderson@linaro.org>
References: <20191023150057.25731-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create a function to compute the values of the TBFLAG_A32 bits
that will be cached, and are used by all profiles.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 69da04786e..f05d042474 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11070,6 +11070,15 @@ static uint32_t rebuild_hflags_common(CPUARMState *env, int fp_el,
     return flags;
 }
 
+static uint32_t rebuild_hflags_common_32(CPUARMState *env, int fp_el,
+                                         ARMMMUIdx mmu_idx, uint32_t flags)
+{
+    flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
+    flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
+
+    return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
+}
+
 static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
@@ -11141,7 +11150,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
     int current_el = arm_current_el(env);
     int fp_el = fp_exception_el(env, current_el);
-    uint32_t flags = 0;
+    uint32_t flags;
 
     if (is_a64(env)) {
         *pc = env->pc;
@@ -11151,12 +11160,11 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         }
     } else {
         *pc = env->regs[15];
+        flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
         flags = FIELD_DP32(flags, TBFLAG_A32, VECLEN, env->vfp.vec_len);
         flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE, env->vfp.vec_stride);
         flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
-        flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
-        flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
         if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
             || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
             flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
@@ -11166,8 +11174,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             flags = FIELD_DP32(flags, TBFLAG_A32,
                                XSCALE_CPAR, env->cp15.c15_cpar);
         }
-
-        flags = rebuild_hflags_common(env, fp_el, mmu_idx, flags);
     }
 
     /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
-- 
2.17.1


