Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB34EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EE920706
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9EnPJpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EE920706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqQX-0001XM-Vd
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4L-0002zC-SL
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:09 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:38034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4J-0006bk-MO
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id f18so9720091wml.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=3Yoep4sdiJr6Nl07VaQfGsAhmJmgCfg3E/7/P1j/4h8=;
 b=O9EnPJpuPv1ODtmZb5lDJ9cM5r9m6Kombq1UsiSPGWyZ0Ap7FBokFEOHIlsPtlBZWR
 26EAtO90P9sqCKl4f91lLjipjPPXbWKYz2qK+/iHQZWRF/g0fS2qhoSVvHsCm4FonWnr
 p/HsKbf+eaOpoJtrw3TDpufRdusXtVxJczZIer+3/mkbSWDb0stGsyMiYFWNnbvvMuH/
 Qfb/Bw+/ag2nS+5gn4Pi4iwiuSh95eWVpF40rPrOzFGrsMuy5CjsAO35uM54ga3WeHQb
 Lefb+C2I65KaHSPEr0DhBJMJpJeQC/gB9FIBZ0IwKCcNbuWoebLryUliO1ye6eFSeKnu
 OSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3Yoep4sdiJr6Nl07VaQfGsAhmJmgCfg3E/7/P1j/4h8=;
 b=cwT36uM4bgUYdjlJO2xeTzAJDGPofHVBlqD3yxWVDF+4pMnHXMEUj32ewyknQzsnjy
 eAeH8M7Gz43zgv5ySHh2UYE6px6i0INSsBUODMxBTZU+Tu46GWudAA7jezOnuEih2q5L
 dTxYHP/fGHp3Ct1o6MVNqJZzIZrRVbSYS1HXK0iw1VNVHLScyWowxN7lPozFn2KTB6bS
 setcvOV14r4FC0mGGX8rZGz4IIZv0bOjp3dpw7zUPCx8S81RmpuddWogDn+t+GjHqfi0
 XMHXQmO3RH/XlfXqGrBqMR8wB+wlelYozb7kX+BGCT4hb1RvUsBd0qGLSaBqg6SZrghu
 MwWA==
X-Gm-Message-State: AOAM533pg/yvgPMVjiA+TCuNFfyki8K4mho4tlpanD1/8tPOW5BvB6b2
 /ZYn9ZjptcCiT0GAZcsbEfVG513fVKUctQ==
X-Google-Smtp-Source: ABdhPJyUF8NUz4b4PDFU3qPHnUlbSZ4jxhdvhPZtLw7S7oGFr1q+YBT+i1oe4VVnfmPSlZzgx/jCGA==
X-Received: by 2002:a1c:6887:: with SMTP id d129mr3888353wmc.179.1593184505993; 
 Fri, 26 Jun 2020 08:15:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.15.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:15:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/57] target/arm: Move regime_tcr to internals.h
Date: Fri, 26 Jun 2020 16:14:01 +0100
Message-Id: <20200626151424.30117-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

We will shortly need this in mte_helper.c as well.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-23-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 9 +++++++++
 target/arm/helper.c    | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index c36fcb151b7..7c9abbabc9a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -949,6 +949,15 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     }
 }
 
+/* Return the TCR controlling this translation regime */
+static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
+{
+    if (mmu_idx == ARMMMUIdx_Stage2) {
+        return &env->cp15.vtcr_el2;
+    }
+    return &env->cp15.tcr_el[regime_el(env, mmu_idx)];
+}
+
 /* Return the FSR value for a debug exception (watchpoint, hardware
  * breakpoint or BKPT insn) targeting the specified exception level.
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d14313de664..33f902387b4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9875,15 +9875,6 @@ static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
 
 #endif /* !CONFIG_USER_ONLY */
 
-/* Return the TCR controlling this translation regime */
-static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
-{
-    if (mmu_idx == ARMMMUIdx_Stage2) {
-        return &env->cp15.vtcr_el2;
-    }
-    return &env->cp15.tcr_el[regime_el(env, mmu_idx)];
-}
-
 /* Convert a possible stage1+2 MMU index into the appropriate
  * stage 1 MMU index
  */
-- 
2.20.1


