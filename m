Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A589C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8C820675
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMrYJVlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8C820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6JXI-0003Dp-Ju
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 16:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6JWS-0002Oc-Mb
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 16:08:24 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6JWR-0003da-54
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 16:08:24 -0400
Received: by mail-pl1-x642.google.com with SMTP id r4so3121680pls.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 13:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a9KU3BFjLPcvWd1ynHXjJMFI8AkA4Hb5hz2Tk+NCbVg=;
 b=WMrYJVlGhGObuqXg4p/j7BSxZFF8fQpAIGxwV6E1xqQLVqi/gpw8ko+r/v3rUBxYbI
 /s4Ox6IuWo1Dd5TuAnk8C9oJT6GpxC8jecbMoS6AJHPW7NL4IiIXTzYvwNFqlS37tily
 GVRIG1wFqBpu8mUJSSikGNFKBQKH7hs0HEmBddnTCRGJhIn/Du2ZjL386FvJPUB3U9O1
 MZaymyawwAtUSW6HF9N2Fr+SqF02g+tC1i8AgSjxFk+cc6G3ZSM8eLduqtWUOdc5F50J
 um9m+ADZ11Oz043tEmMTO5ZF6gH0wy61p6lCCsFIJ3hKSHj19N+6Iz9IJERfnKdBk166
 +Zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a9KU3BFjLPcvWd1ynHXjJMFI8AkA4Hb5hz2Tk+NCbVg=;
 b=VuHpk7FXnUxmLmcuJQnTeqHwAOd8ljtQ0BJJrhloAsAs4kOL8XK9SDPsH4pRCGNUWa
 n4iI44oKQpXKyvR6pqFqNKVK1lLIrcBZSD5GCkhlpG2pNuaSROTup+bprDkNIpYVFUPR
 jInR3W9QmNH6wpNE7pWhOhwk9rOMInYLmrhrdp/fOPxR7IYVgxJbaeLK5ziTV1QRTQi6
 GJLf9cVxGAxohSRfgazDawnPImDLIG9S2gi7/LdzLcg1q7cCkx5vtGjGJM4KH7C0QRxM
 JIq4cO7GtwcHq/Wd+rmK7lm0Wq84OiZmCQErYN0Zq8ZnpHkh7Q5ZbFz2CIs8ohSc4Mrn
 ns5g==
X-Gm-Message-State: AOAM5304O1BRBVtBMvX4hnW110rRehyOEnNrvd41rIkcjtAnp3eJYTtF
 XRI5477GVi8yogD397U9CscerRC1X+A=
X-Google-Smtp-Source: ABdhPJzlLM5EQU2ChY5Aqs/hAwTuajBfDa2O99yKBH2XXoAmZxwOEKk+mcLvcutyUvFp8XnDWdf//Q==
X-Received: by 2002:a17:90a:1682:: with SMTP id
 o2mr6943714pja.227.1597349301471; 
 Thu, 13 Aug 2020 13:08:21 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm6811642pfc.202.2020.08.13.13.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 13:08:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] target/arm: Fill in the WnR syndrome bit in
 mte_check_fail
Date: Thu, 13 Aug 2020 13:08:16 -0700
Message-Id: <20200813200816.3037186-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813200816.3037186-1-richard.henderson@linaro.org>
References: <20200813200816.3037186-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: andreyknvl@google.com, vincenzo.frascino@arm.com, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to AArch64.TagCheckFault, none of the other ISS values are
provided, so we do not need to go so far as merge_syn_data_abort.
But we were missing the WnR bit.

Tested-by: Andrey Konovalov <andreyknvl@google.com>
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/mte_helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index a40454588d..891306f5b0 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -519,7 +519,7 @@ static void mte_check_fail(CPUARMState *env, uint32_t desc,
 {
     int mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
     ARMMMUIdx arm_mmu_idx = core_to_aa64_mmu_idx(mmu_idx);
-    int el, reg_el, tcf, select;
+    int el, reg_el, tcf, select, is_write, syn;
     uint64_t sctlr;
 
     reg_el = regime_el(env, arm_mmu_idx);
@@ -547,9 +547,10 @@ static void mte_check_fail(CPUARMState *env, uint32_t desc,
          */
         cpu_restore_state(env_cpu(env), ra, true);
         env->exception.vaddress = dirty_ptr;
-        raise_exception(env, EXCP_DATA_ABORT,
-                        syn_data_abort_no_iss(el != 0, 0, 0, 0, 0, 0, 0x11),
-                        exception_target_el(env));
+
+        is_write = FIELD_EX32(desc, MTEDESC, WRITE);
+        syn = syn_data_abort_no_iss(el != 0, 0, 0, 0, 0, is_write, 0x11);
+        raise_exception(env, EXCP_DATA_ABORT, syn, exception_target_el(env));
         /* noreturn, but fall through to the assert anyway */
 
     case 0:
-- 
2.25.1


