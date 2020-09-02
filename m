Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E801C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8B8206E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RBhhD0Gz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8B8206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVlA-0001vT-Ap
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDVk0-0000AC-H0
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:36:09 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDVjw-00056A-IX
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:36:07 -0400
Received: by mail-pf1-x441.google.com with SMTP id u20so3155290pfn.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G2J6CIcPbcU0ITFMtY+NemRyzDVdwC9h+WBRXX8kbT8=;
 b=RBhhD0GzDRJDO89gSnkIchxmAUhjsfUSxuO3kZ0762cHfBNJwsQXnUqOgt1bzU1Ukl
 g3vS3JOVf/qEHfDXLZbRnp6Y2FVS7ZrQE8cni+AavyxnxbT87HbAoMxQ3x/zhliDvaTr
 0SHgGd1fzJAmy2Jwy2dOuYn2PDyJymOwQF3hyKPYng2cTjPUn8QrNHJ6zpa4eDi2cgT6
 ijCcniyAQpQG4k7NNQH04wqBVjKOwgr/KBrY658YAb3Nm8yrTc979X6+J18nJJElRKuL
 O1OR77wd2F2beanKJ9E/GbMAZfD9+mqbQDDFw+eEUXfpDwdmj1QZ1eV2r6cIHoD9iV4d
 NH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G2J6CIcPbcU0ITFMtY+NemRyzDVdwC9h+WBRXX8kbT8=;
 b=lVHR0uekZq1C2lVFbxi0RkuRPOl2wOiV363RNZTaVh+8PNs3Mp3sur9G79n7eY2EjO
 bKaAIk7IRIk4i3yq8w3UlbQwn93ph3nB9Z31xKANwW2cielBmRhzAmvG5lode4Aq1fBW
 41I1VMeGX9aGPoBG1ggOPSSACnqMr31PBJ+FB4T1VAmTMptA6SiaPULEnxLR21p4cXCz
 ZFs1nXG3EborEAroqyRmmeXfoTJ0iYjC+N6fCBiR5F49YzI17hrwL22OdBbN1V9u9t/P
 oST+qlgiXwv/uB1ymKGcqPiFh9deX8Ol77TErGj1GBXi2idc3BbaRZwMUMebjnfcACN0
 6Jcw==
X-Gm-Message-State: AOAM5309gR0npNo6OzzcsehZVo+BInEKxa6Yrk/1LxPnGfvNHRA85SRO
 4hdiggJGRhw/yoqP+9PBUsIOeNF9ZgW7Kg==
X-Google-Smtp-Source: ABdhPJy72QgCeR5uR3QcOaKEB6NoPsjOSeAc2TpybGZNVnFEJy4d7rgCyMGr3dvPEsoxoL2ZKPIecQ==
X-Received: by 2002:a63:1c4e:: with SMTP id c14mr2467964pgm.98.1599064562544; 
 Wed, 02 Sep 2020 09:36:02 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm4955441pjz.33.2020.09.02.09.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 09:36:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] target/microblaze: Rename DISAS_UPDATE to DISAS_EXIT
Date: Wed,  2 Sep 2020 09:35:53 -0700
Message-Id: <20200902163559.1077728-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902163559.1077728-1-richard.henderson@linaro.org>
References: <20200902163559.1077728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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

The name "update" suggests that something needs updating, but
this is not the case.  Use "exit" to emphasize that nothing
needs doing except to exit.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a377818b5e..03fc653ce2 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -37,7 +37,7 @@
 
 /* is_jmp field values */
 #define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
-#define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
+#define DISAS_EXIT    DISAS_TARGET_1 /* all cpu state modified dynamically */
 
 static TCGv_i32 cpu_R[32];
 static TCGv_i32 cpu_pc;
@@ -1161,7 +1161,7 @@ static bool trans_brk(DisasContext *dc, arg_typea_br *arg)
     tcg_gen_ori_i32(cpu_msr, cpu_msr, MSR_BIP);
     tcg_gen_movi_tl(cpu_res_addr, -1);
 
-    dc->base.is_jmp = DISAS_UPDATE;
+    dc->base.is_jmp = DISAS_EXIT;
     return true;
 }
 
@@ -1202,7 +1202,7 @@ static bool trans_brki(DisasContext *dc, arg_typeb_br *arg)
                          ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM));
     }
     tcg_gen_ori_i32(cpu_msr, cpu_msr, msr_to_set);
-    dc->base.is_jmp = DISAS_UPDATE;
+    dc->base.is_jmp = DISAS_EXIT;
 #endif
 
     return true;
@@ -1712,7 +1712,7 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 
     /* Force an exit if the per-tb cpu state has changed.  */
     if (dc->base.is_jmp == DISAS_NEXT && dc->cpustate_changed) {
-        dc->base.is_jmp = DISAS_UPDATE;
+        dc->base.is_jmp = DISAS_EXIT;
         tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
     }
 }
@@ -1733,7 +1733,7 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
         gen_goto_tb(dc, 0, dc->base.pc_next);
         return;
 
-    case DISAS_UPDATE:
+    case DISAS_EXIT:
         if (unlikely(cs->singlestep_enabled)) {
             gen_raise_exception(dc, EXCP_DEBUG);
         } else {
-- 
2.25.1


