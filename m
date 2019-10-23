Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2454CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8FC2173B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NPGPOm9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8FC2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNISG-0007Ih-SM
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8s-00086d-8t
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8q-0001Dw-OT
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:42 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:36365)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNI8o-00015R-LL
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:40 -0400
Received: by mail-qt1-x841.google.com with SMTP id d17so18125848qto.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HNW+DKXClNFoWE5mAVnYOdmYoSifNB4F8oskeNBuM9U=;
 b=NPGPOm9CWTUgQoSl2rMq7xjPhiZsh6cQc40fR2j5H7rxtL7wRftv8sHsrtaFz/L4ud
 O7VsXruMvHv7l1EDcgNnSbfeRjQtWjMEWVjSci5FMi46J23lCeQ4+7tMn86/whdBwQH2
 PmVf+ESWvCXI7XYCVyQkKArDAZ5QtJax4fm85wR8Lp0oY55H/lg2tk8EjPbVSrhRhpFI
 s9GQVP5pIDvm3c649EnPx95dcYbf+UC5MbP63l4xEQsy6ykGJLs7UK7g7mv2pUy5eSsy
 oTwDw7rGfxL+8QZ+MnWPuD9mOBmeIf+uJ5RGYg5UH6/YHmgXhu/1rTa8AtEXslUQkqBa
 Oi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HNW+DKXClNFoWE5mAVnYOdmYoSifNB4F8oskeNBuM9U=;
 b=I0sSA721Jo7rab87rtP+TAGMjSCnDCxuez9ZGwtIEKTbK5nVFZPyKVyh6ohxmVjX8p
 Tsb2o3SFhEYUaQXTNtTaCfqEY20N1mTRzRomFrj/datXMChL2oF5qdoJKl7N4D6O16nN
 nV+N2ZSM3aG3qEzasyqIEFf6Q4PLOKfTzI2eg8zIfJWhFDv8R9R1qNWcC0Drmf/Th8cu
 1NLXeluOQ12o0ttjiFx6acVUTbOIyCR/iODYGC3ojz1VYI0HSC9TojLtNHGjSBNZNC68
 ddlNTx9qDkxy/kbmK60/4v2dr8QmboMFC4sEVabE93stRpib0dpBTfzD2lXfDg38SanX
 xK1Q==
X-Gm-Message-State: APjAAAWQyyu///pIfNyB2SrRw9H4r85Z7VDnTBevT02R/MzfbmW8JDto
 6ceAfySGic5jgyemRdYMSdIBwhxbgbY=
X-Google-Smtp-Source: APXvYqy4GnStcvi0+33cwPp6vVatT5Zcn86HuxcTb0Vzx4okZ8RAXkMBtzUWuciLmn/3aV2G6TLDxw==
X-Received: by 2002:aed:3f21:: with SMTP id p30mr10025551qtf.236.1571842877297; 
 Wed, 23 Oct 2019 08:01:17 -0700 (PDT)
Received: from localhost.localdomain (198-4-20-64.static.cosmoweb.net.
 [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id l189sm11030168qke.69.2019.10.23.08.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:01:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 11/24] target/arm: Hoist computation of TBFLAG_A32.VFPEN
Date: Wed, 23 Oct 2019 11:00:44 -0400
Message-Id: <20191023150057.25731-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023150057.25731-1-richard.henderson@linaro.org>
References: <20191023150057.25731-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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

There are 3 conditions that each enable this flag.  M-profile always
enables; A-profile with EL1 as AA64 always enables.  Both of these
conditions can easily be cached.  The final condition relies on the
FPEXC register which we are not prepared to cache.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  2 +-
 target/arm/helper.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4d961474ce..9909ff89d4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3192,7 +3192,7 @@ FIELD(TBFLAG_A32, XSCALE_CPAR, 4, 2)
  * the same thing as the current security state of the processor!
  */
 FIELD(TBFLAG_A32, NS, 6, 1)
-FIELD(TBFLAG_A32, VFPEN, 7, 1)          /* Not cached. */
+FIELD(TBFLAG_A32, VFPEN, 7, 1)          /* Partially cached, minus FPEXC. */
 FIELD(TBFLAG_A32, CONDEXEC, 8, 8)       /* Not cached. */
 FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
 /* For M profile only, set if FPCCR.LSPACT is set */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 398e5f5d6d..89aa6fd933 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11088,6 +11088,9 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
 {
     uint32_t flags = 0;
 
+    /* v8M always enables the fpu.  */
+    flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
+
     if (arm_v7m_is_handler_mode(env)) {
         flags = FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
     }
@@ -11119,6 +11122,10 @@ static uint32_t rebuild_hflags_a32(CPUARMState *env, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
     uint32_t flags = rebuild_hflags_aprofile(env);
+
+    if (arm_el_is_aa64(env, 1)) {
+        flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
+    }
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
@@ -11250,14 +11257,13 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                 flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE,
                                    env->vfp.vec_stride);
             }
+            if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)) {
+                flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
+            }
         }
 
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
         flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
-        if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
-            || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
-            flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
-        }
         pstate_for_ss = env->uncached_cpsr;
     }
 
-- 
2.17.1


