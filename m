Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4FBC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:21:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526402075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQpzcyXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526402075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgNM-0006Ob-9d
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg40-00006c-Cp
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:04 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3y-0001zi-74
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:04 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mw10so125102pjb.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=50E0hW76gnTgLCYM21b2+hcWFagS0hoFg/XoJTnl9H8=;
 b=qQpzcyXPHl5M2j5TPXNFFdiSYbAEmQ3fn4o0rqJKPi2ReviyKR89mQP3kQC8ZmUse6
 6pWzET3aU3LrOT58ZejZZ//AqmjVl57MhjNpNzkBUSF2WWp60YlFzBtSmdYASTv1oD5O
 lRrWQXIP2qZzG6HUTHnoqFNd31uoW3nHCkK3zzl5Acyye7ZhUdX+7rsauxeyxHs3gTAf
 oYb4zQmYgMeBUtNcCMZ0qeLXn4QQ65Po3dniUrwTOFgKI2TpcKLijihXDQQMUHJb5eEi
 GHLFMVvpcx7v88HN9AtKj3spm4lnj5OcjAv7meCPAKBHmyTtvjr7UtlOSa41AQzvBdOE
 et0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=50E0hW76gnTgLCYM21b2+hcWFagS0hoFg/XoJTnl9H8=;
 b=ugJTGPKSeCQkGnmSGWQUf9rRto9dmg70cJ8SS6WYxaBiGg8F7SzcWwPO4mAfzpf/Je
 YZ4J9XL9k3OKPg8ff2RqQlDyqd6d+RxsJxAIRe9hnGL5+cxlBbdP+zusLawepMsAKzjc
 ZW4LcPxKyF98K/6wq0llLOD33WVglJGW3G9pO2qJKnHVoQ4zI7Ns8xAtDsu64BzPhORc
 URaVAbYKsAVp7ncFovTwhl1vP3x5cM2Dn+h4D55HYVoREK78NTRBWw1+ytK5fu+kt/9O
 +CY7pZyBPMZpXfPkRHlXrmTa+p3J6ueb5/UwcUxZSmhfF8FQH2XVVvpxtBx2+KifPVhI
 aQSg==
X-Gm-Message-State: AOAM533UNKC/EjxvmdN0Y5WQyjugTaehcv26N6qFvr4NjPhrehlKAL4J
 9Kwyen8+6ZzfhFfYQkitf5kWYoZxyaXrCA==
X-Google-Smtp-Source: ABdhPJyw8+AdkWYQCVGur+z4KFmsCkuFJrprta2T019tMcFqehLZttCj5o21jVn5WTi3JEeB4iXZIQ==
X-Received: by 2002:a17:90b:110a:: with SMTP id
 gi10mr3107685pjb.104.1598389259764; 
 Tue, 25 Aug 2020 14:00:59 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 54/77] target/microblaze: Assert no overlap in flags making up
 tb_flags
Date: Tue, 25 Aug 2020 13:59:27 -0700
Message-Id: <20200825205950.730499-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create MSR_TB_MASK.  Use it in cpu_get_tb_cpu_state, and check
that IFLAGS_TB_MASK does not overlap.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 594501e4e7..2fc7cf26f1 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -261,8 +261,11 @@ struct CPUMBState {
 #define DRTE_FLAG	(1 << 17)
 #define DRTB_FLAG	(1 << 18)
 #define D_FLAG		(1 << 19)  /* Bit in ESR.  */
+
 /* TB dependent CPUMBState.  */
 #define IFLAGS_TB_MASK  (D_FLAG | IMM_FLAG | DRTI_FLAG | DRTE_FLAG | DRTB_FLAG)
+#define MSR_TB_MASK     (MSR_UM | MSR_VM | MSR_EE)
+
     uint32_t iflags;
 
 #if !defined(CONFIG_USER_ONLY)
@@ -372,12 +375,14 @@ typedef MicroBlazeCPU ArchCPU;
 
 #include "exec/cpu-all.h"
 
+/* Ensure there is no overlap between the two masks. */
+QEMU_BUILD_BUG_ON(MSR_TB_MASK & IFLAGS_TB_MASK);
+
 static inline void cpu_get_tb_cpu_state(CPUMBState *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
 {
     *pc = env->pc;
-    *flags = (env->iflags & IFLAGS_TB_MASK) |
-             (env->msr & (MSR_UM | MSR_VM | MSR_EE));
+    *flags = (env->iflags & IFLAGS_TB_MASK) | (env->msr & MSR_TB_MASK);
     *cs_base = (*flags & IMM_FLAG ? env->imm : 0);
 }
 
-- 
2.25.1


