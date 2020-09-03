Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC2EC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52832078E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d79wSgjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52832078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnKU-0004u2-BR
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDnIz-0002l4-4Z
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:21:25 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDnIx-0007aL-2y
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:21:24 -0400
Received: by mail-wm1-x344.google.com with SMTP id z9so2509178wmk.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cMROPLcTcDLsqz8ZyHuI3PmBlKUI5qkazLVoDFSt+zE=;
 b=d79wSgjguVjpuWwN2r//uARngSrrvXyXdYbHUNYzGcU6XL993iR2xOXCZf2TJ+w2SE
 F1k1N1xBkEGJ0xoHqyVSMeXVyKKmkmDUarqHJyBYy/UBcazuNnKenkugEMSvdwRSSGwx
 +sR4wYvyu3bCVvqa4ji2NNUR/9CV8fztKjq0FLRDU40Hq92piIjaoc3ZBM6IShJqOB6N
 hVJlx36qgB/Yfz8BCDXF5vdRwAb3Xfikz2f7aRBgyWYzVjFuJZaa81sJxPKy7aWFH7WS
 0ZEJILBEkYcbnAksQLqTLj1+EbFpl97HbpyKrl7+/1r7XrRFTE+kIQdM1iobmkHUzTwu
 e9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cMROPLcTcDLsqz8ZyHuI3PmBlKUI5qkazLVoDFSt+zE=;
 b=a4Mm0rn7UC0fqDANBLcjEEKdxqz1B6iUkHlTXJ2FdFpD9zIsH+TqaWwYKUbmTpqwU7
 jfDNVx32P8eaguSymW8Wgc7eVK3WB8Tkb6BQwjKXrxUBkQY7SC1DIOpsKGLGsYWvtl/V
 f/JU3xrBe85cnpkirwlg0naMlGZhzzA8+0vq/HJ0sAos/SF24eDxB1mk/EuEDq8fjJNR
 i/8uYc7orsep5S0pgMtfvpcVW6lrzIHck5tdSgaWg8hZFiIkoI76TSbRBYcD8MwoyzMa
 ixUZHcO5OXWnMubZPMaBfNFpN5ZPbh2M5zZVLxc0Ct4TuQgWE73NgpkSOWrLmtiWemE4
 IpNQ==
X-Gm-Message-State: AOAM530plcsXxW2QM1gYju/K/tjsc+JK2faWc0nUncJ8jCkcce08/pXL
 eDQdb80LvJowInAY76bZZcPoJw==
X-Google-Smtp-Source: ABdhPJzS2rPu1nqWNjT4Fo5FRInA6ZkmhMNohqh400p2NG7sw575nV29a8vKeIPMbX+5YckEn+fKmQ==
X-Received: by 2002:a1c:105:: with SMTP id 5mr2076404wmb.83.1599132081691;
 Thu, 03 Sep 2020 04:21:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c205sm3850668wmd.33.2020.09.03.04.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:21:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7253C1FF93;
 Thu,  3 Sep 2020 12:21:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 7/8] target/mips: simplify gen_compute_imm_branch logic
Date: Thu,  3 Sep 2020 12:21:06 +0100
Message-Id: <20200903112107.27367-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903112107.27367-1-alex.bennee@linaro.org>
References: <20200903112107.27367-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: fam@euphon.net, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One of the Travis builds was complaining about:

  qemu/include/tcg/tcg.h:437:12: error: ‘cond’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
       return (TCGCond)(c ^ 1);
  ../target/mips/translate.c:20031:13: note: ‘cond’ was declared here
       TCGCond cond;

Rather than figure out exactly which one was causing the complaint I
just defaulted to TCG_COND_ALWAYS and allowed that state to double up
for the now defunct bcond_compute variable.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/mips/translate.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 899b90ae0ff..398edf72898 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20028,8 +20028,7 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
 static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
                                    int rt, int32_t imm, int32_t offset)
 {
-    TCGCond cond;
-    int bcond_compute = 0;
+    TCGCond cond = TCG_COND_ALWAYS;
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
 
@@ -20046,7 +20045,6 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
             /* Treat as NOP */
             goto out;
         } else {
-            bcond_compute = 1;
             cond = TCG_COND_EQ;
         }
         break;
@@ -20065,7 +20063,6 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
             tcg_gen_shri_tl(t0, t0, imm);
             tcg_gen_andi_tl(t0, t0, 1);
             tcg_gen_movi_tl(t1, 0);
-            bcond_compute = 1;
             if (opc == NM_BBEQZC) {
                 cond = TCG_COND_EQ;
             } else {
@@ -20080,7 +20077,6 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
         } else if (rt == 0 && imm != 0) {
             /* Unconditional branch */
         } else {
-            bcond_compute = 1;
             cond = TCG_COND_NE;
         }
         break;
@@ -20088,24 +20084,20 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
         if (rt == 0 && imm == 0) {
             /* Unconditional branch */
         } else  {
-            bcond_compute = 1;
             cond = TCG_COND_GE;
         }
         break;
     case NM_BLTIC:
-        bcond_compute = 1;
         cond = TCG_COND_LT;
         break;
     case NM_BGEIUC:
         if (rt == 0 && imm == 0) {
             /* Unconditional branch */
         } else  {
-            bcond_compute = 1;
             cond = TCG_COND_GEU;
         }
         break;
     case NM_BLTIUC:
-        bcond_compute = 1;
         cond = TCG_COND_LTU;
         break;
     default:
@@ -20118,7 +20110,7 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
     clear_branch_hflags(ctx);
     ctx->base.is_jmp = DISAS_NORETURN;
 
-    if (bcond_compute == 0) {
+    if (cond == TCG_COND_ALWAYS) {
         /* Uncoditional compact branch */
         gen_goto_tb(ctx, 0, ctx->btarget);
     } else {
-- 
2.20.1


