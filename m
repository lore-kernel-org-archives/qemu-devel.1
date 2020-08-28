Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8EEC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:36:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9530120757
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMD0vn7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9530120757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfUl-0007yc-Kh
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFF-0001gy-6S
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:45 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFC-0005L5-Bl
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:44 -0400
Received: by mail-pl1-x644.google.com with SMTP id v16so539343plo.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=50E0hW76gnTgLCYM21b2+hcWFagS0hoFg/XoJTnl9H8=;
 b=aMD0vn7YXNiI7oXmxipwC3oGnTBSwqApyOeZgc8vZfIwMEgqgpwlzMo3el4S3H2bdG
 F08uIXSUUsiNOhf12sZhzgvk967B5L476cJGA1Lhs/oEl9Of0RtcpTwiPdy+KyF0EWdS
 i+CaBvX+D5Iihfh3/6gDr15zBNp9Mvc255+rxeyVz3Lx11t4jYvWTqraIaO7urI1PmIr
 c7KCdaACYl64BqfkC3Rwklevw/+Yyz2bOayZ8n0OCfGP6bALyld9xqX83g4U/g5uh5Ow
 wwfeiofDBHhxYXub/4aOkYYFAyyvVYKjyVOsGisHbRJf1+70zsvaEZSpHOsu+SqkSiaC
 aMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=50E0hW76gnTgLCYM21b2+hcWFagS0hoFg/XoJTnl9H8=;
 b=h+wH/bwtRw7ymLex99KqbwCx9OZCqwQja2nqf3yAnzH1LlT+b2VTelnLnGvh7AkFpS
 1+Flm4cmEm1RKEL63kRDBRJxfYEm4zeTR412rWlAFmsa7HeI6N7Xh4vhUaYJinqUPCnl
 Pd2o509AP402Dhdvw1tE0X9ZKRjJsqWUofzWjqz6TT/SUdAewy3Lwj7lwbC0THve4aL8
 rJIRKgEa5c8wcJcTPOddRqrZb/fT/g+3DS8dwf0m4NbWgR3JBN0puMg/PaSX4JT4rqxN
 LrpfE6EkK6lE4Rf8xaOLGhAuuMECXoS+3DnK19iOPdQDdy2oOtumPJh4VdzsVtsVrhXL
 ngtg==
X-Gm-Message-State: AOAM5307r6AIn6SomtIVnRT1TBZF3OKGKXLUbC6X7+6XoK/sI/xCb1bo
 KD0e81S5rL8lLjchTVLhoii0XVA/Ik/3nA==
X-Google-Smtp-Source: ABdhPJzg/UvYBiWE0kgGZeVMu9WhAMTmKuuHNBP9waBURHSpNW+bau9VxBgiJXe4vioYPcEUtEniSQ==
X-Received: by 2002:a17:902:b60d:: with SMTP id
 b13mr1490296pls.48.1598624439819; 
 Fri, 28 Aug 2020 07:20:39 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 54/76] target/microblaze: Assert no overlap in flags making
 up tb_flags
Date: Fri, 28 Aug 2020 07:19:07 -0700
Message-Id: <20200828141929.77854-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
Cc: edgar.iglesias@xilinx.com
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


