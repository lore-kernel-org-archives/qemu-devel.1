Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE98AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FF220738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A857IRIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FF220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgSA-0000Vw-TV
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3g-00082t-J5
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:44 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3e-0001rJ-Kl
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:44 -0400
Received: by mail-pg1-x542.google.com with SMTP id o5so7679541pgb.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=028+vI/58nZnbjOmGLeS9QgMrm8aOm1Pu2VJuR4D8gY=;
 b=A857IRIF5+n8uvaxlKuvmwHYD8/DlykEw7qpdmXUw/ryNi+lKjYoCMYBZJDyVGTzFl
 YFAp/hC8DduUE2sffbfRP3gVKLEtK4inRGZ4RatA0HJXUigDbs6wB47P4ZSK6qx0G18I
 7Rq73sjcZOoYqtmtKNQxbbnKpmrUu7hmBMWXeNclgsthlXGMtSvxUY7IXXMaqUk1zvma
 THrK3KUsd0+0+RFmNs7Xz5kCLCHqgS4NjpugyttU0N5wsPZsxpo8jEmP9kYdjFH7gzvk
 SdB8W/7KjM9UMNSnI916kCrbUO0MoD4cXMNluYmqrZJ8sg0zcTrdVU4n0xRhf26YQVMQ
 x5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=028+vI/58nZnbjOmGLeS9QgMrm8aOm1Pu2VJuR4D8gY=;
 b=IhbAcGAwvR7tuZBUookBUHdNRz27glSFM0UYQGudAjevBZFWmgex6+piCoIqygdFnG
 iCi60sca5xq0HM6ilCiogHg8YnrNiWovtxFw8nxhK+kqfdxV1aziSluCqMgm78kn5eQV
 UlIwzKynxueOZwDcZTK0YUj9tmeTXxZDgDYVdk3jtXGYR/3dpeBtilrh1lNb8R3vH71G
 /mnoiY5ulAo2zsmP+yyLudhong+JfjVZ+y5xgi+RjNT2ucHOfZkz2upjzwbnpEp9YmEt
 gu2MI4B40h6iR+bYnUllCU19pC05xnzqEqmhW0r3cDoyP+gt8J20ItEMGGSgM4+wEqzZ
 r4sA==
X-Gm-Message-State: AOAM531muZxu2bigT4VW1q2qYV0b8CQNfgl00hx8Jyou71mknv0ticCX
 7X/rcUpsmKLiTwXuvQT3IYyaX+jZQc6L8A==
X-Google-Smtp-Source: ABdhPJy5waXekXkk/vfJY+MGcmTsUvs647KFVIh0RYDwI60R3F2LKcsK7kcPagVbLEUkW2Zpd34HCg==
X-Received: by 2002:a62:1d0:: with SMTP id 199mr9523009pfb.189.1598389240500; 
 Tue, 25 Aug 2020 14:00:40 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 38/77] target/microblaze: Implement cmp and cmpu inline
Date: Tue, 25 Aug 2020 13:59:11 -0700
Message-Id: <20200825205950.730499-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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

These are simple enough operations; we do not need to
call an out-of-line helper.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.h    |  2 --
 target/microblaze/op_helper.c | 20 --------------------
 target/microblaze/translate.c | 24 ++++++++++++++++++++++--
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 988abf7661..6f7f96421f 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -1,6 +1,4 @@
 DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
-DEF_HELPER_2(cmp, i32, i32, i32)
-DEF_HELPER_2(cmpu, i32, i32, i32)
 
 DEF_HELPER_3(divs, i32, env, i32, i32)
 DEF_HELPER_3(divu, i32, env, i32, i32)
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 9bb6a2ad76..f976d112eb 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -69,26 +69,6 @@ void helper_raise_exception(CPUMBState *env, uint32_t index)
     cpu_loop_exit(cs);
 }
 
-uint32_t helper_cmp(uint32_t a, uint32_t b)
-{
-    uint32_t t;
-
-    t = b + ~a + 1;
-    if ((b & 0x80000000) ^ (a & 0x80000000))
-        t = (t & 0x7fffffff) | (b & 0x80000000);
-    return t;
-}
-
-uint32_t helper_cmpu(uint32_t a, uint32_t b)
-{
-    uint32_t t;
-
-    t = b + ~a + 1;
-    if ((b & 0x80000000) ^ (a & 0x80000000))
-        t = (t & 0x7fffffff) | (a & 0x80000000);
-    return t;
-}
-
 static inline int div_prepare(CPUMBState *env, uint32_t a, uint32_t b)
 {
     MicroBlazeCPU *cpu = env_archcpu(env);
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 98050f64b7..ce91645f05 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -327,8 +327,28 @@ DO_TYPEBV(addic, true, gen_addc)
 DO_TYPEBI(addik, false, tcg_gen_addi_i32)
 DO_TYPEBV(addikc, true, gen_addkc)
 
-DO_TYPEA(cmp, false, gen_helper_cmp)
-DO_TYPEA(cmpu, false, gen_helper_cmpu)
+static void gen_cmp(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    TCGv_i32 lt = tcg_temp_new_i32();
+
+    tcg_gen_setcond_i32(TCG_COND_LT, lt, inb, ina);
+    tcg_gen_sub_i32(out, inb, ina);
+    tcg_gen_deposit_i32(out, out, lt, 31, 1);
+    tcg_temp_free_i32(lt);
+}
+
+static void gen_cmpu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    TCGv_i32 lt = tcg_temp_new_i32();
+
+    tcg_gen_setcond_i32(TCG_COND_LTU, lt, inb, ina);
+    tcg_gen_sub_i32(out, inb, ina);
+    tcg_gen_deposit_i32(out, out, lt, 31, 1);
+    tcg_temp_free_i32(lt);
+}
+
+DO_TYPEA(cmp, false, gen_cmp)
+DO_TYPEA(cmpu, false, gen_cmpu)
 
 /* No input carry, but output carry. */
 static void gen_rsub(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
-- 
2.25.1


