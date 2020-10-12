Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384B1C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:09:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FCD720797
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYE+9Ecv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCD720797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0Ni-0003KE-Iz
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRztm-0003kr-Rn
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:38:07 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRztf-0007mg-Hl
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:38:06 -0400
Received: by mail-wr1-x442.google.com with SMTP id b8so6479284wrn.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xt8K6d2MSfZD0aUx3007ahLfcJglQMjANJEKAe+3790=;
 b=FYE+9Ecvyaoe9jzyxtZsaIzYUKdFehhxLQhRlKWZo3PdXiNEH6joJiRvM4Kr06kFSj
 VnyWPc7y1HssryWF9Pw1v4yZlqOKvgWg7cijQO5vvvJEPYOfw83Ng1mnGqE/d8Q0sdLv
 drgrc2eCGo1tLId4USPRk5e0Oq/Z2FsCKUGslXnaVxDzaaKlTYhf1+mYJ+zkT7PxGlPB
 nnsL/+Mqp6AWqxGpSjRMMXb94z9xeKMIqIhlV+ETMMCdnPVf8Quxz5BuWcWIQsu4iDTA
 tgaatqkUs6r9S94kmaqN643cWHFcYmfS3oVoiRiDuPTR1Ws76WL7YOr5pKZB+9DAjNBN
 3N/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xt8K6d2MSfZD0aUx3007ahLfcJglQMjANJEKAe+3790=;
 b=FFdA5l+AlYJFjhC7zRTtFZd/sY0TIz9iUuiTZ6JAMcjZtAYCc+M+1NZdBH5TEb7CKI
 T/R8ZwIgOli0q+JgyF5hALcN2LJTt7v7LGmKvAzzTiockCN5hxkEFXAuY69GTkDrtkVa
 04ETt5RxyHg/S0WlbaD85Xg6D2/8dfiiz+3Et2XWJKG0Qndh/54JMChtIoQMK6akcZPX
 3yOj88cpWhpvwotG8Zpu/73kJgHanCorkeKRyTe/mSGVx8EfgGrHSfA7Tf+sCH64SuAC
 BklTEWBm6swh1pRiS8lcYtJlrcZWG+kE+E69g+ijj+bu+rWjtGlIS7AYFIa80QEXXtBb
 JoYQ==
X-Gm-Message-State: AOAM531gXED8zzMhSH5QMd/l99rtLt9eG88owqgHm04avTpxeTPGXstt
 OxC16ztlCkxqvAlVue28DTwh5A==
X-Google-Smtp-Source: ABdhPJwvDTiuOmwVXrZHDZlDncjXyM10grRVSwA7Q3/oI3pj2RrycaudQYcqfEGi9g1IDCH6lWaF3Q==
X-Received: by 2002:adf:fa0e:: with SMTP id m14mr29112212wrr.134.1602517078193; 
 Mon, 12 Oct 2020 08:37:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y66sm7095961wmd.14.2020.10.12.08.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:37:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 09/10] target/arm: Implement FPSCR.LTPSIZE for M-profile LOB
 extension
Date: Mon, 12 Oct 2020 16:37:45 +0100
Message-Id: <20201012153746.9996-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153746.9996-1-peter.maydell@linaro.org>
References: <20201012153746.9996-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the M-profile low-overhead-branch extension is implemented, FPSCR
bits [18:16] are a new field LTPSIZE.  If MVE is not implemented
(currently always true for us) then this field always reads as 4 and
ignores writes.

These bits used to be the vector-length field for the old
short-vector extension, so we need to take care that they
are not misinterpreted as setting vec_len.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c        |  5 +++++
 target/arm/vfp_helper.c | 25 +++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 186ee621a65..baae826f94f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -255,6 +255,11 @@ static void arm_cpu_reset(DeviceState *dev)
         uint8_t *rom;
         uint32_t vecbase;
 
+        if (cpu_isar_feature(aa32_lob, cpu)) {
+            /* LTPSIZE is constant 4 if MVE not implemented */
+            env->vfp.xregs[ARM_VFP_FPSCR] |= 4 << 16;
+        }
+
         if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
             env->v7m.secure = true;
         } else {
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 5666393ef79..350150adbf1 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -189,8 +189,10 @@ uint32_t vfp_get_fpscr(CPUARMState *env)
 
 void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
 {
+    ARMCPU *cpu = env_archcpu(env);
+
     /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
-    if (!cpu_isar_feature(any_fp16, env_archcpu(env))) {
+    if (!cpu_isar_feature(any_fp16, cpu)) {
         val &= ~FPCR_FZ16;
     }
 
@@ -198,8 +200,14 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
         /*
          * M profile FPSCR is RES0 for the QC, STRIDE, FZ16, LEN bits
          * and also for the trapped-exception-handling bits IxE.
+         * From v8.1M with the low-overhead-loop extension bits
+         * [18:16] are used for LTPSIZE and (since we don't implement
+         * MVE) always read as 4 and ignore writes.
          */
         val &= 0xf7c0009f;
+        if (cpu_isar_feature(aa32_lob, cpu)) {
+            val |= 4 << 16;
+        }
     }
 
     vfp_set_fpscr_to_host(env, val);
@@ -212,9 +220,18 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
      * (which are stored in fp_status), and the other RES0 bits
      * in between, then we clear all of the low 16 bits.
      */
-    env->vfp.xregs[ARM_VFP_FPSCR] = val & 0xf7c80000;
-    env->vfp.vec_len = (val >> 16) & 7;
-    env->vfp.vec_stride = (val >> 20) & 3;
+    if (cpu_isar_feature(aa32_lob, cpu)) {
+        /*
+         * M-profile low-overhead-loop extension: [18:16] are LTPSIZE
+         * and we keep them in vfp.xregs[].
+         */
+        env->vfp.xregs[ARM_VFP_FPSCR] = val & 0xf7cf0000;
+    } else {
+        /* Those bits might be the old-style short vector length/stride */
+        env->vfp.xregs[ARM_VFP_FPSCR] = val & 0xf7c80000;
+        env->vfp.vec_len = (val >> 16) & 7;
+        env->vfp.vec_stride = (val >> 20) & 3;
+    }
 
     /*
      * The bit we set within fpscr_q is arbitrary; the register as a
-- 
2.20.1


