Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A8CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F394521841
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJq01Zl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F394521841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfMf-0003Iq-3U
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDe-0002mp-DX
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:38 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:39814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDc-0008RR-5t
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:38 -0400
Received: by mail-qv1-xf42.google.com with SMTP id r16so1760478qvm.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4iFy7dIAe5u1Ho2N3UqzjTBmrVGvnP56Md9pXka22/M=;
 b=GJq01Zl56emhpKBWqwD25by/f/y3PvwaKGnN0S0csqDXR/pc0jXiKAhmSkiFIrB7Va
 /DICE6EnNdLRrs7vSecpwhhTK/fOiWc96RqAkxcnTvNwZVTmTSjfqemkvlnsgr5IDuYM
 MUfHB6nlnV/2X+g8bKtSgyN3FNVJkj+jQCGkLRslQGywFb9C1x9O1A34RdUkz6y9x0U5
 3onK6H0WYJdS0iZOu99mqQa2aXMQT/KtXXhanb0gY5iTPtPLvTfs1URL0aJlyi/SCh+f
 O+QBcPiTKiR3lALzRugPM/2VK7rriaNlT+tWNGrsc4QU78uXLdUaMsUZAIyM46E8a1gX
 1dIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4iFy7dIAe5u1Ho2N3UqzjTBmrVGvnP56Md9pXka22/M=;
 b=KUubNBeD2hEy6jnY6t/TWmWrIUIeC7F8gpsW+nMsuV8U7Ha0+jKB1nJ8UlcEJpIaJV
 y1Pn2EwZ6Kdi2wIMO9mExmJ6QAgEO29Wu2/Idy8WGbs3GL6cQ47fUKd3BOsCyNPezQoX
 wi7yKeTSE1Y/TjessCn1us8NlYmclb2aAdBZDD1KVRCapv8UVaS2B4BQRagl66DW35nL
 ANCoDgwVIr8BXTLwXYtbJWqf2dzVY9h6HEqpDYfMc640eqk7UpJgpxoqCPGk2G77dCn2
 YWgUaB9XGY6oZ9TBiCcqCdDqsHA1Zrn/LK0Z0Yqv8h26O7Roo3unhh86OaNkmbUe1Vpx
 43nQ==
X-Gm-Message-State: AOAM530w7lWM+DolTJhBqBaw1XTiHMR4rLrQze5ESczHzY13HSqumOZa
 43RRLvc7h8YEdGMg0Gi04Jettkt44DMkrA==
X-Google-Smtp-Source: ABdhPJxYpORM5zaU5RZvNX3UNeLoLacc5aJJ+cG8bvG6HXdVmsJeVHOFtSXcF7i4wDArwGu+ykGhQA==
X-Received: by 2002:ad4:48c7:: with SMTP id v7mr559228qvx.190.1592427811804;
 Wed, 17 Jun 2020 14:03:31 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:31 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 11/73] m68k: convert to helper_cpu_halted_set
Date: Wed, 17 Jun 2020 17:01:29 -0400
Message-Id: <20200617210231.4393-12-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/m68k/translate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 3fc67aa452..35086ff449 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -44,7 +44,6 @@
 #undef DEFO32
 #undef DEFO64
 
-static TCGv_i32 cpu_halted;
 static TCGv_i32 cpu_exception_index;
 
 static char cpu_reg_names[2 * 8 * 3 + 5 * 4];
@@ -80,9 +79,6 @@ void m68k_tcg_init(void)
 #undef DEFO32
 #undef DEFO64
 
-    cpu_halted = tcg_global_mem_new_i32(cpu_env,
-                                        -offsetof(M68kCPU, env) +
-                                        offsetof(CPUState, halted), "HALTED");
     cpu_exception_index = tcg_global_mem_new_i32(cpu_env,
                                                  -offsetof(M68kCPU, env) +
                                                  offsetof(CPUState, exception_index),
@@ -4698,6 +4694,7 @@ DISAS_INSN(halt)
 DISAS_INSN(stop)
 {
     uint16_t ext;
+    TCGv_i32 tmp;
 
     if (IS_USER(s)) {
         gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
@@ -4707,7 +4704,9 @@ DISAS_INSN(stop)
     ext = read_im16(env, s);
 
     gen_set_sr_im(s, ext, 0);
-    tcg_gen_movi_i32(cpu_halted, 1);
+    tmp = tcg_const_i32(1);
+    gen_helper_cpu_halted_set(cpu_env, tmp);
+    tcg_temp_free_i32(tmp);
     gen_exception(s, s->pc, EXCP_HLT);
 }
 
-- 
2.17.1


