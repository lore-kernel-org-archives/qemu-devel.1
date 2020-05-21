Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAA8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C919E20826
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+4Hjh5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C919E20826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboOY-0007PC-Ve
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboI9-000258-6g
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:33 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:38969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboI8-0006WK-87
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:32 -0400
Received: by mail-qk1-x742.google.com with SMTP id w3so2326442qkb.6
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p1mJfQgUSajpR9lU6ZTURQdWL9DblhFREsfOMzR9p54=;
 b=G+4Hjh5dHU44k3Vge8s7hwNhgmKXokOePkqdTPtL48+K/vVTjAEL6y82VbSToKpNNE
 +CSL+56UL7WLFmtnnRY19Fe27uhwgD82J+CvcG5nhCFZ54MKEiIfVPsskk62NmX/Vs8a
 Qw16zOpzbKM6722D08ldOTvFXU9Bz31xftGaI5d0RvayZZqpc6vYKS1Q62eeNdZs64NA
 ctkRHWL2CgHinSI8VBgcDouipdz4hJIL7tlhi+bT2NS5NW7NocZXYeAg7pc2H5QTrWdB
 vWSXH/Wpsj8Sr4OFa+tMD8PXKnGPsJJuqP92VXPP559eytNMMYTIM2UYVN8lzzGGPPev
 mKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p1mJfQgUSajpR9lU6ZTURQdWL9DblhFREsfOMzR9p54=;
 b=N9N9NX3o3GGdvHgcSOH/vEyLSrtyO71TWSU6R1goo/+xjmGhKeejf+fCYhSrBMSOkX
 lC7uaLQmjUKAzUCySzHht8ZBGO+PfcLMnp0vM0ISlcXaH4Jgiba1bqSOzyuokJ7mN0Eu
 RLhZWGfwRi+yK+QbKHn68kYy21kD1iwrUW1WkdKyjkzE/ZJNN4d/2J5XBvztUA8m6g32
 ufWND/zbyjWTH0HMof7jgQBUnP2pHnoeOK6BBTpP4cbU3DsvoT0gn+JxzRvNXfYg2iP1
 Q6yHnMlJXFhoC5qd1oSVAHLQIgf3Hi6nmR0hUG002mBKxSsROW4O9u+7WZ1OnKcd87zy
 T6ng==
X-Gm-Message-State: AOAM531MqieSlQS+4U6mGfZOcsHy9yZCxQ4a1DFADqS9mJdPc+dlO3FY
 AkyfHmGttWbgWVqhMmtpjdVrcKIK0qHUOA==
X-Google-Smtp-Source: ABdhPJzSYPw/mIcCG6YiyKkWhcoH5A2dsvRWdMJN5BSRBmUQ3z66h1xBQ/BslbS1y4rjvNMcq0RY9A==
X-Received: by 2002:a37:8a42:: with SMTP id m63mr10531000qkd.230.1590079411098; 
 Thu, 21 May 2020 09:43:31 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:30 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 12/74] m68k: convert to helper_cpu_halted_set
Date: Thu, 21 May 2020 12:39:09 -0400
Message-Id: <20200521164011.638-13-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x742.google.com
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
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
index 0f80888203..16a64e4776 100644
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


