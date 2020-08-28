Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF98C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135CD20757
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKjpcga4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135CD20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfcI-0007pl-CI
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEu-00015D-G4
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:24 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEr-0005EX-M9
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:24 -0400
Received: by mail-pg1-x542.google.com with SMTP id g29so534807pgl.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1/Hy6AwnddO7FgH8pQmMPkXmEttwqr8LltORKFA3Vts=;
 b=mKjpcga4kNQpWS9DBD8HwW1uQUEGbJ6wTgVRaXAmWo9lct7BiyVxHQ656wLnSBOXwi
 CfrTt0FgBo9gVp44hJyZaVWKhaYGZzoZ8aOl4Hw3xR1KkmqSq5q8YeqGhC6vRmWzZ5as
 W1Cbn9EGU/KYD/tYZCcOyqRijccMbADMFN12hKfUudoQF8i3mI69S5LrA3QI1qc4LVEc
 DAhzbeqMsap9dS/xFPXo/kRgsk1s1C1+htQIqoqk4hrMNmp+PciB4Ff2kOEHMYQxmXHZ
 zA96tZ0qnIfZUpISialJzYVInFbiWQjEd3apV3AD3Jzgp44KZ919fSQMJpUYAZ4+0aAY
 kutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1/Hy6AwnddO7FgH8pQmMPkXmEttwqr8LltORKFA3Vts=;
 b=pyFEJX97wpQA4w94FXolNo1rpewrudUTWAT8jUJAm0lo4/2FM21r6vvn/subW1Xw0F
 eWPFKyP+1NnrqFRL4pIAB13786ydahfBZJvdN2ZG4zp1+/xJ646vrsYi/e1Z0ZXkew4B
 cew0kq2TlaEoxhFFK76MH7ruqMqnDXvS/nyHh81/7AKauS4e0g7xVXJ6HTq55SIxY0ie
 zw9gWt4M/hswde3qftGTRFZBsNv512wurupSb/Jylw4ADh5ZASKg9irXMA3vn3hjEj46
 pv/GHMBvzJAno/qrF4wYftoK+I0FbZeTMpUN7KgRUFCfL1pWmR/YkFdkz3xfWBsg+a9M
 ZzFA==
X-Gm-Message-State: AOAM533gw29LMLkikStj7pu68yUa92we9Vc7ojYEpGJFr4kPeiEtTqLm
 RpY8wCZGiBpTach0NlBXIOF7p0mCVXU8KQ==
X-Google-Smtp-Source: ABdhPJz/JlkwVbzHMLYkPzZVH/TiAY2JLa3zyJvrelu+SOEGyY9G13QrvRkltk+Mz/PJCigPuGJjjQ==
X-Received: by 2002:a63:547:: with SMTP id 68mr1404422pgf.327.1598624419880;
 Fri, 28 Aug 2020 07:20:19 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 38/76] target/microblaze: Implement cmp and cmpu inline
Date: Fri, 28 Aug 2020 07:18:51 -0700
Message-Id: <20200828141929.77854-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
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
Cc: edgar.iglesias@xilinx.com
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
index 0e7d24ddca..8da477457d 100644
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


