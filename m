Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615ABC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 14:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD17207D8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 14:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmKgEizO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD17207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jagWa-00039E-BN
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 10:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jagW2-0002c3-NC
 for qemu-devel@nongnu.org; Mon, 18 May 2020 10:13:14 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38685)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jagW1-0004my-PX
 for qemu-devel@nongnu.org; Mon, 18 May 2020 10:13:14 -0400
Received: by mail-wm1-x343.google.com with SMTP id m185so5742124wme.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qO0DEQsgPpTJ3W4/yS4w/C15HNNzg8b4HlcX8EpUruc=;
 b=XmKgEizOBA1chni4ASZaRYuql3iwXDMa7UlnILXK2ermaciojwvuDedMYpVfDQI+Qq
 cJz9LaZqXPOD2VOO+tNge51ZKsr6MBkBU5DmyMeR5kjsfZtdJi92hxE62LT10hNYjUjS
 rLGJDt7duZlqcDUyILQdAHELxiev9CE7VStJTBz+Iw3UOZm8OcyvWJntl2TIinkdUPLt
 Od+SRWvoEeelSMTMGjp8urvH/SMAx3uIal2BAcR1CZiqpzBBXKGe1TAAueMPi2O4/e+t
 1sC7bPjmdkXJycEdaMvMOITHj7VZBN4NF33VdsmUPfUx9m41lZStxoUONsMz0IzuMuNO
 RelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qO0DEQsgPpTJ3W4/yS4w/C15HNNzg8b4HlcX8EpUruc=;
 b=nrCYTZKnCQbZcA1RXglG2aRYuTGcfI627UH1hkddCsGNKF35VhLVkj7geMEBuccqA1
 /bO9qyCqtcwGZfa79YWiJIA/G4ZPkrz9Qs/2dmDZyDOiYZ40B2gDjQ23gnua9N/Zc/vX
 CSCOVs/Uz8O76SEbOIrBmFDaBvSwtkisStib/QoPsL/NKtu7x/el2VeyP+ENOxupOoKp
 f3clVx1Dry2XYfW2LgoZlJ8415aEEJAQ5vaTGK+E8BzlERTSX3eBiDdWhtW+ASYpu25R
 y7J8aNVW/AAmmNLSgHj/pSIXnotOK2NS7jdAlsWmcHf6QeM3MhMxDWhcCohmdrJqITQf
 4i6Q==
X-Gm-Message-State: AOAM530903mSCtB7NpQ7YCz9GcIAd0fHoXK5lrNQjnT2JIetuUJoURXl
 tC2/1UGs0s4t2X1NIoGv+/lqVdB8hp1nGg==
X-Google-Smtp-Source: ABdhPJwvuMNjRlNLAqLGkh/rkKOrGl4INw95jA/HZYbCECL48A7X9o1M6xUCYK8++K5Sc/CFtHdwhA==
X-Received: by 2002:a1c:6344:: with SMTP id x65mr20647401wmb.51.1589811192092; 
 Mon, 18 May 2020 07:13:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l19sm17229075wmj.14.2020.05.18.07.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 07:13:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Allow user-mode code to write CPSR.E via MSR
Date: Mon, 18 May 2020 15:13:09 +0100
Message-Id: <20200518141309.11998-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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

In the first two cases not being able to update CPSR.E is a
bug, and in the third case it doesn't matter because CPSR.E
is always 0 there. So we can fix both bugs by adding CPSR_E
to CPSR_EXEC.

(The recommended way to change CPSR.E is to use the 'SETEND'
instruction, which we do correctly allow from usermode code.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Bug reported on IRC. Quick-and-dirty test case at:
 https://people.linaro.org/~peter.maydell/msr-setend.c

 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
 
-- 
2.20.1


