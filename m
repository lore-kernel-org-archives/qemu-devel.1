Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E7EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999C1206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GOj5nQRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999C1206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh3tx-0000LT-U5
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 00:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3ni-0004ce-5B
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:50 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nh-0000lC-8v
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:49 -0400
Received: by mail-pf1-x444.google.com with SMTP id j1so4152767pfe.4
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 21:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yLR2Th1A4FLiNvF9RrUXZ7U/jaonjCXwdyobyMFPwns=;
 b=GOj5nQRMVmP06GT6WO6lkqGGxSSz4XbxY1w5dXfQDWo37gkmhVehwjctG0mbtz8pU7
 3SN07v2kEzJxPXiH7fbB2XxsfjK1eqmoxo5TsOH95XuPSmvu00djLFabYcMKLS3s8tVj
 rCDSXUSyCzeFOS+x8T0dCg3N5KoqBb0RSg4ctwxko+nHtfSGfm57KdZGtL/aURWjvZrM
 Ky2h3LluNLZ2tV7ih9wAqDkGcMH+1aHJRWMz4SaybB9pj4Bt6G/yolmkR+kA/GmIAc0U
 UzxYbX3Qg/6vhH58LA6QYniDQaBu5yLD9I7oIfFyi5n+BKTg+ooRFJsPb32WNNGuioVf
 0WBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yLR2Th1A4FLiNvF9RrUXZ7U/jaonjCXwdyobyMFPwns=;
 b=EKTb79D4WSU8SJ5ChG3/AhF0WEa9sjzkOadLypvG+LUQbzbGJXRme+s/0HGi3Ne+SE
 MNNWt1VhJRgyiEaK8OlhOi41WplRaSzhuO1HutkM5MsAo8WvN4Os855hHvTdy90m7CwJ
 tjZFOHJ3teUX9wpgKjYFVqoY2Vkwsf3hTG/8j3We0YwbNC3tfUPzrULsMiHl3AxZZV0D
 7FSHJ1tycQauIsHdrS3dfdo1GRTocKKk1FMnJ9/lVoEEV7tnU3+uxrT/8GOcUI70HKhi
 AcWetrAHSHAPyXckIDj/treDB/E6Surz/we6BgUbjfa/ud7tLwYk5Pz5rcqiWCY7Rfhd
 U1xQ==
X-Gm-Message-State: AOAM531XnT46zSZ0CWnKylxqO4EP844BZLCvY8mhQjJ1dcPMvwgKjHAU
 wcImW0qgaCh0L4EY5tbtMI5Wx5X8WcY=
X-Google-Smtp-Source: ABdhPJyRoo6vgoKYh+l1dwojsZGlRP41MC9/3XeO0h07JmLMEI+JN0x+afzj1w5hDdNFPjzs//zdNw==
X-Received: by 2002:a63:a50:: with SMTP id z16mr7448730pgk.162.1591330667378; 
 Thu, 04 Jun 2020 21:17:47 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h15sm5440902pgl.12.2020.06.04.21.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 21:17:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/17] linux-user/aarch64: Implement PR_MTE_TCF and
 PR_MTE_TAG
Date: Thu,  4 Jun 2020 21:17:26 -0700
Message-Id: <20200605041733.415188-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605041733.415188-1-richard.henderson@linaro.org>
References: <20200605041733.415188-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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

These prctl fields are required for the function of MTE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_syscall.h |  9 ++++++
 linux-user/syscall.c                | 46 +++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
index 5fb0bf4a5d..779ca0c805 100644
--- a/linux-user/aarch64/target_syscall.h
+++ b/linux-user/aarch64/target_syscall.h
@@ -32,5 +32,14 @@ struct target_pt_regs {
 #define TARGET_PR_SET_TAGGED_ADDR_CTRL 55
 #define TARGET_PR_GET_TAGGED_ADDR_CTRL 56
 # define TARGET_PR_TAGGED_ADDR_ENABLE  (1UL << 0)
+/* MTE tag check fault modes */
+# define TARGET_PR_MTE_TCF_SHIFT       1
+# define TARGET_PR_MTE_TCF_NONE        (0UL << TARGET_PR_MTE_TCF_SHIFT)
+# define TARGET_PR_MTE_TCF_SYNC        (1UL << TARGET_PR_MTE_TCF_SHIFT)
+# define TARGET_PR_MTE_TCF_ASYNC       (2UL << TARGET_PR_MTE_TCF_SHIFT)
+# define TARGET_PR_MTE_TCF_MASK        (3UL << TARGET_PR_MTE_TCF_SHIFT)
+/* MTE tag inclusion mask */
+# define TARGET_PR_MTE_TAG_SHIFT       3
+# define TARGET_PR_MTE_TAG_MASK        (0xffffUL << TARGET_PR_MTE_TAG_SHIFT)
 
 #endif /* AARCH64_TARGET_SYSCALL_H */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e4da53c5b3..9cf3ce872d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10463,10 +10463,47 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         case TARGET_PR_SET_TAGGED_ADDR_CTRL:
             {
                 abi_ulong valid_mask = TARGET_PR_TAGGED_ADDR_ENABLE;
+                CPUARMState *env = cpu_env;
+                ARMCPU *cpu = env_archcpu(env);
+
+                if (cpu_isar_feature(aa64_mte, cpu)) {
+                    valid_mask |= TARGET_PR_MTE_TCF_MASK;
+                    valid_mask |= TARGET_PR_MTE_TAG_MASK;
+                }
 
                 if ((arg2 & ~valid_mask) || arg3 || arg4 || arg5) {
                     return -TARGET_EINVAL;
                 }
+
+                if (cpu_isar_feature(aa64_mte, cpu)) {
+                    switch (arg2 & TARGET_PR_MTE_TCF_MASK) {
+                    case TARGET_PR_MTE_TCF_NONE:
+                    case TARGET_PR_MTE_TCF_SYNC:
+                    case TARGET_PR_MTE_TCF_ASYNC:
+                        break;
+                    default:
+                        return -EINVAL;
+                    }
+
+                    /*
+                     * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
+                     * Note that the syscall values are consistent with hw.
+                     */
+                    env->cp15.sctlr_el[1] =
+                        deposit64(env->cp15.sctlr_el[1], 38, 2,
+                                  arg2 >> TARGET_PR_MTE_TCF_SHIFT);
+
+                    /*
+                     * Write PR_MTE_TAG to GCR_EL1[Exclude].
+                     * Note that the syscall uses an include mask,
+                     * and hardware uses an exclude mask -- invert.
+                     */
+                    env->cp15.gcr_el1 =
+                        deposit64(env->cp15.gcr_el1, 0, 16,
+                                  ~arg2 >> TARGET_PR_MTE_TAG_SHIFT);
+                    arm_rebuild_hflags(env);
+                }
+
                 untagged_addr_mask = (arg2 & TARGET_PR_TAGGED_ADDR_ENABLE
                                       ? MAKE_64BIT_MASK(0, 56) : -1);
                 return 0;
@@ -10474,6 +10511,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         case TARGET_PR_GET_TAGGED_ADDR_CTRL:
             {
                 abi_long ret = 0;
+                CPUARMState *env = cpu_env;
+                ARMCPU *cpu = env_archcpu(env);
 
                 if (arg2 || arg3 || arg4 || arg5) {
                     return -TARGET_EINVAL;
@@ -10481,6 +10520,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 if (~untagged_addr_mask != 0) {
                     ret |= TARGET_PR_TAGGED_ADDR_ENABLE;
                 }
+                if (cpu_isar_feature(aa64_mte, cpu)) {
+                    /* See above. */
+                    ret |= (extract64(env->cp15.sctlr_el[1], 38, 2)
+                            << TARGET_PR_MTE_TCF_SHIFT);
+                    ret = deposit64(ret, TARGET_PR_MTE_TAG_SHIFT, 16,
+                                    ~env->cp15.gcr_el1);
+                }
                 return ret;
             }
 #endif /* AARCH64 */
-- 
2.25.1


