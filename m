Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED0DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A04C2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RocHciQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A04C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmbh-0008MD-Gv
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKh-00054Z-9k
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:59 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:54420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKf-00062t-CF
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:58 -0400
Received: by mail-pj1-x102a.google.com with SMTP id mm21so23136pjb.4
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S6laip3Wpd4WZffve1nLJPULOpaH60wT+1ALfz+5yig=;
 b=RocHciQOFTL4iO2FsUlY0t5JlELO9T6i0w7zuyu8sTk+ekwxdeyueRzz8fTyHduTOP
 LC96IlkXEVZAvsEkFfOUw6pGhQrfeChWEG4GgH0OozUaAnfTuYnw8SvLuMeT0yQpHCAU
 tvkRpb2ytjpnvbQU3uJDQaeuGtWawREAri6TFULbwUOl3TDbv/5j5pBUZLg9H/nrQMDy
 70FYlxgq9EK5zGt2ApJRTqM5fPco1AFcknea6iUVH3uUsT8wP5bs8AnU4pka8ps06HST
 6ClrdtUc9GmC+HlYlngqis+aImIa2GPtkNUcDNOx4OtLDOgbVMbN281k6IjVDgvqxiSe
 VAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S6laip3Wpd4WZffve1nLJPULOpaH60wT+1ALfz+5yig=;
 b=Euk9untjHn+dBuqxBZenkhlGiRNrRFvQkHSBNTrnyVyxtQqgluCcQyIFuF8jEOdGGu
 zR8zOXoLXJRvUK1jKR1XO+TrM0jEOMBFx4PDISJk/Rh7RKmEjg+VqyEe2Qmd4lH9t5ih
 2MDIsWWrLjtQikjQKhAopqpdihf1PGXQdroWtvCJr8lHmqaYIAGQWpfYVPMW+RYQyJnX
 i9F2k5ZFAUJslTOmABTxwIQpvif/sQlTaMzFkCHAkMYdnbrFTOYlDT4JDvKdE20lIiNn
 pdcb0Big9H7bmiqg5ygO22ibuiFqKmkMI3b9nzYuYZ4c19wn8cxsb1GHqoCeWr7Ao88t
 T88A==
X-Gm-Message-State: AOAM531yzQQTgxviFpwxeTv5F/xf4bUho7xgAry3qOx/xK2dDOOshATe
 box9bqGztYNCtZHaVv/PXH2cz109lE3Ifw==
X-Google-Smtp-Source: ABdhPJxgt8dMr3Dpb/rc9mUJbAWrjIOocVL+S43a1bSimXkZdhZYjU5xz69yx5RKY4sw0cJnFCKoFQ==
X-Received: by 2002:a17:902:708c:: with SMTP id
 z12mr1543618plk.258.1598890015725; 
 Mon, 31 Aug 2020 09:06:55 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/76] target/microblaze: Implement cmp and cmpu inline
Date: Mon, 31 Aug 2020 09:05:23 -0700
Message-Id: <20200831160601.833692-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are simple enough operations; we do not need to
call an out-of-line helper.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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


