Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC06C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B585205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BUFd5SAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B585205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFBj-0005fU-7V
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkl-0003lp-7Y
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:27 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkk-000608-8v
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:26 -0400
Received: by mail-wr1-x431.google.com with SMTP id j5so4395556wrq.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xDuxFNao6D3Yn37v7+E98cgNAOVS9Qj7cKtOdgTs7Cs=;
 b=BUFd5SAbB8JlyHlbSkmFJP/BhBPDcV9GA+Zp7Bq7+WT/1zcKezu1eqtAyrF8BtzFx8
 Ss3sivlon2BOz+hirPebtTtVaSG7vzMUbVb2S/4M6P1QyQHvdED0IPj6NWKvNPldBwpF
 u7TgSbeC8fvV7JS0Wi9sp20T6QFLhIiNzj7iX0RJKZ9vdpmrt3H5HEpsfNe2ax3xbdOx
 bLC4MvxeWTTZy6Dph+OidjD2jNDPu+rHlzphGi6cnqL3lQSW9CwN+yulBXS8EfiFvOps
 ZfcBxmnYyHR1cFT6p4WmyFzPJ8zpE391YAv8VxW0S7DDNhXp47gloCnzeqNg7RjcD323
 RSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xDuxFNao6D3Yn37v7+E98cgNAOVS9Qj7cKtOdgTs7Cs=;
 b=V+qU01EdFZ1qQN5ZsCA2y9RFsPyc3+RiBkfRwaR3jaQ28Tj0a3d4C30XAfRtJI0ds+
 6uM64crP0N3gL8NizouJ4yaOnZUDjUUJemNsUh6vHCyD379q5SJhtMSMsvXs6mOx+uHv
 ME47d5EzxN9cd9SLmwS8+PDQ/pw8T8ye4Nb0QfOUZEorh38cnklq9kQMVt8jLZrliWFD
 Araf9SAeWfje8P7q56bRYTlDjYUyIFDgUxAvpGmq3hB9ignerKbVXNNKm8UZ4HiLS9Xq
 hZ+5OwxbS4UcW6qkP8xXFK5FIls7+feBbO1iSMQuZkZV+Utc6k/8M4sjSTteoTFox5w4
 gGSg==
X-Gm-Message-State: AOAM530X7iIzmMjpl7gEenp72+Xr+hdeChKKRstQkazDW9cKRMioz0qo
 GjILG4JsIy4EaeECDmfH3Ije+MAUusE5EA==
X-Google-Smtp-Source: ABdhPJzp4TuIYI17vj/9qFiNobPoiXcAm6RztAwPPeHRjsLXNBNxGiVuvTkSuaJYgKDR8VDfb+voCg==
X-Received: by 2002:adf:b30f:: with SMTP id j15mr6179037wrd.394.1589466144226; 
 Thu, 14 May 2020 07:22:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/45] target/arm: Convert Neon VRHADD,
 VHSUB 3-reg-same insns to decodetree
Date: Thu, 14 May 2020 15:21:27 +0100
Message-Id: <20200514142138.20875-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon VRHADD and VHSUB 3-reg-same insns to decodetree.
(These are all the other insns in 3-reg-same which were using
GEN_NEON_INTEGER_OP() and which are not pairwise or
reversed-operands.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200512163904.10918-7-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       | 6 ++++++
 target/arm/translate-neon.inc.c | 4 ++++
 target/arm/translate.c          | 8 ++------
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 00a909a8884..4984a5d4e19 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -47,6 +47,9 @@ VHADD_U_3s       1111 001 1 0 . .. .... .... 0000 . . . 0 .... @3same
 VQADD_S_3s       1111 001 0 0 . .. .... .... 0000 . . . 1 .... @3same
 VQADD_U_3s       1111 001 1 0 . .. .... .... 0000 . . . 1 .... @3same
 
+VRHADD_S_3s      1111 001 0 0 . .. .... .... 0001 . . . 0 .... @3same
+VRHADD_U_3s      1111 001 1 0 . .. .... .... 0001 . . . 0 .... @3same
+
 @3same_logic     .... ... . . . .. .... .... .... . q:1 .. .... \
                  &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp size=0
 
@@ -59,6 +62,9 @@ VBSL_3s          1111 001 1 0 . 01 .... .... 0001 ... 1 .... @3same_logic
 VBIT_3s          1111 001 1 0 . 10 .... .... 0001 ... 1 .... @3same_logic
 VBIF_3s          1111 001 1 0 . 11 .... .... 0001 ... 1 .... @3same_logic
 
+VHSUB_S_3s       1111 001 0 0 . .. .... .... 0010 . . . 0 .... @3same
+VHSUB_U_3s       1111 001 1 0 . .. .... .... 0010 . . . 0 .... @3same
+
 VQSUB_S_3s       1111 001 0 0 . .. .... .... 0010 . . . 1 .... @3same
 VQSUB_U_3s       1111 001 1 0 . .. .... .... 0010 . . . 1 .... @3same
 
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 20f0f2c8d83..e9da47171c6 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -877,3 +877,7 @@ DO_3SAME_64_ENV(VQRSHL_U64, gen_helper_neon_qrshl_u64)
 
 DO_3SAME_32(VHADD_S, hadd_s)
 DO_3SAME_32(VHADD_U, hadd_u)
+DO_3SAME_32(VHSUB_S, hsub_s)
+DO_3SAME_32(VHSUB_U, hsub_u)
+DO_3SAME_32(VRHADD_S, rhadd_s)
+DO_3SAME_32(VRHADD_U, rhadd_u)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2c842df4451..ebb899d846e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5435,6 +5435,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VSHL:
         case NEON_3R_SHA:
         case NEON_3R_VHADD:
+        case NEON_3R_VRHADD:
+        case NEON_3R_VHSUB:
         case NEON_3R_VABD:
         case NEON_3R_VABA:
             /* Already handled by decodetree */
@@ -5517,12 +5519,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tmp2 = neon_load_reg(rm, pass);
         }
         switch (op) {
-        case NEON_3R_VRHADD:
-            GEN_NEON_INTEGER_OP(rhadd);
-            break;
-        case NEON_3R_VHSUB:
-            GEN_NEON_INTEGER_OP(hsub);
-            break;
         case NEON_3R_VQSHL:
             GEN_NEON_INTEGER_OP_ENV(qshl);
             break;
-- 
2.20.1


