Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E713C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:50:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF8B20672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNkfUaNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF8B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsasc-0006KV-Gs
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 19:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaq7-0000tf-5z
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:47:59 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaq5-0000pj-HG
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:47:58 -0400
Received: by mail-pg1-x542.google.com with SMTP id w2so18317553pgg.10
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 16:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OxuARGdyDb7zyHOtMNspwtFCmEXAy7U1ZwwaIWB/blY=;
 b=pNkfUaNnMJrm59wBjCi5o++U/VanYUI7zIQAjxwrJFL1xOr2OvhKvXol0pWJT+c+9y
 sbT9aZHpVgmipXWOEQ4p5b8CL2a25R9/M1evJUQDRB+7632T0cS9NUuq7JeT6lFYbOnA
 SbO/hk5aJn5ABLKHHH0JAjvOZ4KuSk+NcT7cdIbIOqrIJQ4Ln95cFkrPB7fzvSCaoxeS
 xv6xnlw4cTVJ57oCuuZYbUTgwmXikr/r7t2i+EdneyLQiOpVhWQ2yIqIXCjwPSunT8Zu
 TZTfveAJUgvstyAAidgH358fqhjRLZ4aWNW0bfFKdoOutTQ7GTSNiK4OE8LQYQxYWo9I
 8E5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OxuARGdyDb7zyHOtMNspwtFCmEXAy7U1ZwwaIWB/blY=;
 b=qc+PfP8VZplsYtFlpP+c7vTTXrvqndlVwc8ohEb9Sp5OdFtUJ9IOKph/HqG7muxowm
 cZ5P9Q3P3BYl0dwMjXhf5ozSLgdz79uAc0lXUXUexYtBZ8yJtkE1NQL5MZSerRmOXx97
 REM3ePPw5VEhFphiNCbCWukdX0EmHblThxGbwyr3Bo7mOf3NpRulgGio2qOKKN1RLBXN
 CQFYL1FL9V0gvaNvEVCZxP4VT+YttAKZeYVuiQ1gaW0Idj2FUyneNCQRUfp8XWAYudOt
 e0rrW65MOA86peSKrGlLawK+V8acChlf31alkMy4+qO2ekC8kCJL1HJYaR5p4w0mnVWi
 pprw==
X-Gm-Message-State: AOAM5316r6BM8Xm580Te22Py3E3w1sgRula4YfHbd4WPv2Dkt2fnAIZY
 ySwHj5HuhUwpOeuLuhQ8qd2HRRyV
X-Google-Smtp-Source: ABdhPJxz6lD60sCPccd7AIY7obnCou1RKaeafDl74vlyuc8mTzfvI8836GFx1MCyHZ+Ml8G1UYL5kg==
X-Received: by 2002:a63:5509:: with SMTP id j9mr41698729pgb.195.1594079276102; 
 Mon, 06 Jul 2020 16:47:56 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id e15sm19647649pgt.17.2020.07.06.16.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 16:47:55 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/21] target/xtensa: support copying registers up to 64 bits
 wide
Date: Mon,  6 Jul 2020 16:47:21 -0700
Message-Id: <20200706234737.32378-6-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200706234737.32378-1-jcmvbkbc@gmail.com>
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

FLIX dependency breaking code assumes that all registers are 32 bit
wide. This may not always be correct.
Extract actual register width from the associated register file and use
it to create temporaries of correct width and generate correct data
movement instructions.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |  1 +
 target/xtensa/translate.c | 26 +++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 0409aa6189cf..960f6573447f 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -359,6 +359,7 @@ typedef struct opcode_arg {
     uint32_t raw_imm;
     void *in;
     void *out;
+    uint32_t num_bits;
 } OpcodeArg;
 
 typedef struct DisasContext DisasContext;
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 9838bf6b3ec5..bc01a720719d 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -943,10 +943,10 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
 
         for (opnd = vopnd = 0; opnd < opnds; ++opnd) {
             void **register_file = NULL;
+            xtensa_regfile rf;
 
             if (xtensa_operand_is_register(isa, opc, opnd)) {
-                xtensa_regfile rf = xtensa_operand_regfile(isa, opc, opnd);
-
+                rf = xtensa_operand_regfile(isa, opc, opnd);
                 register_file = dc->config->regfile[rf];
 
                 if (rf == dc->config->a_regfile) {
@@ -972,6 +972,9 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
                 if (register_file) {
                     arg[vopnd].in = register_file[v];
                     arg[vopnd].out = register_file[v];
+                    arg[vopnd].num_bits = xtensa_regfile_num_bits(isa, rf);
+                } else {
+                    arg[vopnd].num_bits = 32;
                 }
                 ++vopnd;
             }
@@ -1111,8 +1114,15 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         for (i = j = 0; i < n_arg_copy; ++i) {
             if (i == 0 || arg_copy[i].resource != resource) {
                 resource = arg_copy[i].resource;
-                temp = tcg_temp_local_new();
-                tcg_gen_mov_i32(temp, arg_copy[i].arg->in);
+                if (arg_copy[i].arg->num_bits <= 32) {
+                    temp = tcg_temp_local_new_i32();
+                    tcg_gen_mov_i32(temp, arg_copy[i].arg->in);
+                } else if (arg_copy[i].arg->num_bits <= 64) {
+                    temp = tcg_temp_local_new_i64();
+                    tcg_gen_mov_i64(temp, arg_copy[i].arg->in);
+                } else {
+                    g_assert_not_reached();
+                }
                 arg_copy[i].temp = temp;
 
                 if (i != j) {
@@ -1143,7 +1153,13 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
     }
 
     for (i = 0; i < n_arg_copy; ++i) {
-        tcg_temp_free(arg_copy[i].temp);
+        if (arg_copy[i].arg->num_bits <= 32) {
+            tcg_temp_free_i32(arg_copy[i].temp);
+        } else if (arg_copy[i].arg->num_bits <= 64) {
+            tcg_temp_free_i64(arg_copy[i].temp);
+        } else {
+            g_assert_not_reached();
+        }
     }
 
     if (dc->base.is_jmp == DISAS_NEXT) {
-- 
2.20.1


