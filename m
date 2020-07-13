Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3D2C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187B92065F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sRAp3ov4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187B92065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzKp-0006iz-Bj
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB3-0005Y0-0c
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:30 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB1-0006er-AA
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:28 -0400
Received: by mail-wm1-x342.google.com with SMTP id o2so13317813wmh.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=MtbNrkAMGJhFhtpNvSaktDyVzUetinwB6fus5j2wvXs=;
 b=sRAp3ov4SdXgLtDoEEDcJ9fWs1Rvra4etIXSnJnXgFxHsGTkpg9JsmmZjklrits0n/
 +bTAdjGg+SMPc2oglmkcNdxuuPOaCessPCot7cYshRSJIWt4KsJ+vqq6bjtoB1MlYF21
 Kr6wMejEjX3501If5627+kYnKpZbp7xvW9b4is0VQPk42dv6Z/yhasAV+O8bW/eZS1Ay
 R9grv1I5leQO5zYrRdNVEx2whoFz+1LNRvdgPewhUPuJRXp7FmUFGajKxhY+viDbp5id
 Ez0nTaXZaxA6HQEj+dtOq3Ltljr150qtj/aRclmzzgJrwc+HsTdlt2zGJyLs9MIivrnz
 nqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MtbNrkAMGJhFhtpNvSaktDyVzUetinwB6fus5j2wvXs=;
 b=sZYS/ekeaDNjOt8JWgHP3rS4F8NXOIcG2WCHAJQMQNQ7TmzldOy/FAZNRS5D5vSbm7
 a4avicnUJouDrYG8yzQE3iDi0rC+UjpQ7BP/aIgL+A9rrSLi3juY8eru1DvUif6Us27M
 axpupRqS7a9ayvnW/4iLj2vVidn960nEFnf0TeJO4vTaIC/AbJfGCWgi4O3TrwD+tU+U
 GvnA3YTdXtnEpAOTYeAj0X76XIYH0CM46IacdeRea77JPV5bcdDYfzb2+SSfhoDDjODR
 X8/eY2fwMXQOWSWq/Za5WY4tisFInwztNLSIb0mDexiiIAB+56MXUGXGywk5yFn4cgDZ
 080w==
X-Gm-Message-State: AOAM532ILrvNee8+Ig5JfjJhewmwhJUvPpBXT4GtTmLlw1q6HbPux8Dn
 q7/Il0QhbTTtz0ggo5wYIxY57sh/4U259g==
X-Google-Smtp-Source: ABdhPJxofn1lsA/C4ph0noIBzJCWgj5gGY5ttE5GNH1Hkoq2BCiU6qawGlhQs68Owl+tKQ+COqaVSg==
X-Received: by 2002:a1c:ab84:: with SMTP id u126mr143817wme.43.1594649485699; 
 Mon, 13 Jul 2020 07:11:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/25] target/nios2: add DISAS_NORETURN case for nothing more
 to generate
Date: Mon, 13 Jul 2020 15:10:56 +0100
Message-Id: <20200713141104.5139-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wentong Wu <wentong.wu@intel.com>

Add DISAS_NORETURN case for nothing more to generate because at runtime
execution will never return from some helper call. And at the same time
replace DISAS_UPDATE in t_gen_helper_raise_exception and gen_exception
with the newly added DISAS_NORETURN.

Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Message-id: 20200710233433.19729-1-wentong.wu@intel.com
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/nios2/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 6c34cd31937..00b591cc298 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -149,7 +149,7 @@ static void t_gen_helper_raise_exception(DisasContext *dc,
     tcg_gen_movi_tl(dc->cpu_R[R_PC], dc->pc);
     gen_helper_raise_exception(dc->cpu_env, tmp);
     tcg_temp_free_i32(tmp);
-    dc->is_jmp = DISAS_UPDATE;
+    dc->is_jmp = DISAS_NORETURN;
 }
 
 static bool use_goto_tb(DisasContext *dc, uint32_t dest)
@@ -802,7 +802,7 @@ static void gen_exception(DisasContext *dc, uint32_t excp)
     tcg_gen_movi_tl(cpu_R[R_PC], dc->pc);
     gen_helper_raise_exception(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
-    dc->is_jmp = DISAS_UPDATE;
+    dc->is_jmp = DISAS_NORETURN;
 }
 
 /* generate intermediate code for basic block 'tb'.  */
@@ -877,6 +877,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
         tcg_gen_exit_tb(NULL, 0);
         break;
 
+    case DISAS_NORETURN:
     case DISAS_TB_JUMP:
         /* nothing more to generate */
         break;
-- 
2.20.1


