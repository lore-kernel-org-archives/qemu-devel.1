Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB2EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 14:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7AEB20671
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 14:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oGaGIc1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7AEB20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jagl9-0001tO-Qo
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 10:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jagkR-000115-D7
 for qemu-devel@nongnu.org; Mon, 18 May 2020 10:28:07 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jagkQ-0000jI-66
 for qemu-devel@nongnu.org; Mon, 18 May 2020 10:28:06 -0400
Received: by mail-wm1-x344.google.com with SMTP id w64so10680102wmg.4
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=00ShRuslEy4BzxQbUPtydgOGX+tNRA8D9prQR/vuBmQ=;
 b=oGaGIc1yKjjinsdSJN0pLzgqeHqmiS0wV9ugknNs3rBNChoDkYU2wOOYezL4Ge5TUD
 SNnUhwOwt6fBnopm1t7/PkwszWVZcztGmagwPVOrPUJ7a35TAG9+yTICvjfNsdbUz6RX
 BaovrDLsB/rfInxbmKrCR8ShXvMRhfTiX4fY/Gdi8t8CSsbK4tStSgYVm3xvC7inh1Jk
 gO6Nh8PeCt2lX0pWV+kMgnsPAx0AsU16oX8+zuv873UHZcHPGQHvBEcvpuTaQS0CPjli
 2zaqbX6aC+X4nizZL363BU4i0fBXo0xWt/6jFmukB0ox5y2cGNqmMuL/jccQ268xDkwH
 PoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=00ShRuslEy4BzxQbUPtydgOGX+tNRA8D9prQR/vuBmQ=;
 b=BuMOGE1Y7z0gFMImkmkkax9Ngg/5hpJNOst+vyNsTLbILT4ZwBO9K2o4h9ngLzFrKw
 AterqV3TY7qjJgLdQ1FdkDsRUOEpnccdTjZ6p072ka5Vbn+dkSQZPjf6pzWTvywDJl1Z
 JTCT3t596BhSfwqjet/5bzTl3TQz8x21hrOa/+iiDLDhwQCo749AT4gv6JN9UfdEfbjO
 IfnnxwYmZq4vLQc/WJIeL9DBJk1xNlrU3ZBPja/jAmkdtkfm0gKotdmhP6yI+9ZH4iBH
 sFxaDC7gjNVkdZOr5/RpXpblI01TU6hLwRWpWutV+JCUq787cKARknlGbs4J+GBvDEXd
 iDpg==
X-Gm-Message-State: AOAM532N1oDHXQA/7uPDu6mZmVF023AaH0jqOok3PRkGfV+vxWydknNI
 Hfwe27pRwfnRPm7qZ4xEFuFe7A==
X-Google-Smtp-Source: ABdhPJzQp8C/IS0dCZS2ebPA8VFvQCFV+P/vnoxOu1YW+2ewHyG56vkzVoWEh4h7RlHFKtuua0TGBw==
X-Received: by 2002:a1c:7410:: with SMTP id p16mr20520201wmc.134.1589812084155; 
 Mon, 18 May 2020 07:28:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p17sm211245wmi.3.2020.05.18.07.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 07:28:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2] target/arm: Allow user-mode code to write CPSR.E via MSR
Date: Mon, 18 May 2020 15:28:01 +0100
Message-Id: <20200518142801.20503-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: Amanieu d'Antras <amanieu@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using the MSR instruction to write to CPSR.E is deprecated, but it is
required to work from any mode including unprivileged code.  We were
incorrectly forbidding usermode code from writing it because
CPSR_USER did not include the CPSR_E bit.

We use CPSR_USER in only three places:
 * as the mask of what to allow userspace MSR to write to CPSR
 * when deciding what bits a linux-user signal-return should be
   able to write from the sigcontext structure
 * in target_user_copy_regs() when we set up the initial
   registers for the linux-user process

In the first two cases not being able to update CPSR.E is a bug, and
in the third case it doesn't matter because CPSR.E is always 0 there.
So we can fix both bugs by adding CPSR_E to CPSR_USER.

Because the cpsr_write() in restore_sigcontext() is now changing
a CPSR bit which is cached in hflags, we need to add an
arm_rebuild_hflags() call there; the callsite in
target_user_copy_regs() was already rebuilding hflags for other
reasons.

(The recommended way to change CPSR.E is to use the 'SETEND'
instruction, which we do correctly allow from usermode code.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v2 changes:
 * fixed wrong variable name in commit message
 * added arm_rebuild_hflags() call in restore_sigcontext()
---
 target/arm/cpu.h        | 2 +-
 linux-user/arm/signal.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5d995368d4f..677584e5da0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1230,7 +1230,7 @@ void pmu_init(ARMCPU *cpu);
 #define CACHED_CPSR_BITS (CPSR_T | CPSR_AIF | CPSR_GE | CPSR_IT | CPSR_Q \
     | CPSR_NZCV)
 /* Bits writable in user mode.  */
-#define CPSR_USER (CPSR_NZCV | CPSR_Q | CPSR_GE)
+#define CPSR_USER (CPSR_NZCV | CPSR_Q | CPSR_GE | CPSR_E)
 /* Execution state bits.  MRS read as zero, MSR writes ignored.  */
 #define CPSR_EXEC (CPSR_T | CPSR_IT | CPSR_J | CPSR_IL)
 
diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index a475a103e97..698985a647e 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -552,6 +552,7 @@ restore_sigcontext(CPUARMState *env, struct target_sigcontext *sc)
 #ifdef TARGET_CONFIG_CPU_32
     __get_user(cpsr, &sc->arm_cpsr);
     cpsr_write(env, cpsr, CPSR_USER | CPSR_EXEC, CPSRWriteByInstr);
+    arm_rebuild_hflags(env);
 #endif
 
     err |= !valid_user_regs(env);
-- 
2.20.1


