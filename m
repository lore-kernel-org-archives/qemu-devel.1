Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAA3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:47:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E811D20724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L7fOpLLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E811D20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhOi-0000eT-4r
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGs-0002bq-H5
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:50941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGq-0003Bk-P0
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id l17so2683028wmj.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=E7h/ZKKdx5+TkX9rKVx9Je7du9LnXSOF20AgOzD56ZM=;
 b=L7fOpLLBLGJfQ7HeLwA4L0iAz7AfI8PXjNFo/QV4+I7dQvCZtx2Ocyd40fjnTL/3NG
 epyMLeePRPWZark/RVjX/l1L3dQeYN5SaGQH24Yp2myHdosk2h0fFCKHUY7T9GAiKKqx
 AmARc5Z3du3qu9FkTTtuteWf+judDp+zeazMTYdp3PlUo7rnmLZlDnKdONU71HczDul0
 0KEG2nHIWvY4gXPyVUDVEWgTR0BLQcDpxelKAHXFIAlocD79Z7gvf2xebR5Jo4nXnGci
 maxsPFEkO6Cgx66PZT7v9eT4ZuWHCy+NGoJg2dq0kiCx52b+DV7tbjTjnmNwgwVMYK7v
 xBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E7h/ZKKdx5+TkX9rKVx9Je7du9LnXSOF20AgOzD56ZM=;
 b=DrS+lrExfypitF/lr3zH+L2QMlmv8X/e6IDA74JTEPMByREdhqHORPZC/cAbMhi6a2
 vMUqapiTcG5OFLQcyG3XUVDk6Xt4mQqfWfaZQ+6Hup7pCshRQb0lWkTbf3pSzS9VxvO0
 tK3ddkHnt9e23o1tm2Zb0Oeeqj1wWLyuas8554rBX1DE1tAKnGSKvhnIl0vWr8ZPgJWP
 WtxVY7c9rD6cshCkGz3fwqetdoPXXd6CwD0bmf5B8KNljqOLMsjo+YCKjIpsFlGvI7b3
 BoP0hqY7nq3HODxiM1GTUVoHyuQ7eARaJdgOiyg8ChYgytIroZR+o6cAjIZVleaArRQW
 9y1A==
X-Gm-Message-State: AOAM532WLU9/1KNEVqTxx0lSeZKoJy2MQsaZKOrwsmAST1wUDjzjBytI
 JXyGaJuDUtIVlPUUH/aqnUxnEyPZ+ZotjA==
X-Google-Smtp-Source: ABdhPJwHllFlKnMS8cTbpRhrizJPcOvlClvyvFrqpDXHi6EcACDaJiRk8SiOTyBshRS4t8VjnlH7DA==
X-Received: by 2002:a1c:e910:: with SMTP id q16mr10370829wmc.188.1592912358986; 
 Tue, 23 Jun 2020 04:39:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/42] target/arm: Rename NeonGenOneOpFn to NeonGenOne64OpFn
Date: Tue, 23 Jun 2020 12:38:33 +0100
Message-Id: <20200623113904.28805-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NeonGenOneOpFn typedef breaks with the pattern of the other
NeonGen*Fn typedefs, because it is a TCGv_i64 -> TCGv_i64 operation
but it does not have '64' in its name. Rename it to NeonGenOne64OpFn,
so that the old name is available for a TCGv_i32 -> TCGv_i32 operation
(which we will need in a subsequent commit).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200616170844.13318-10-peter.maydell@linaro.org
---
 target/arm/translate.h     | 2 +-
 target/arm/translate-a64.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 62ed5c4780c..35218b3fdf1 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -374,7 +374,7 @@ typedef void NeonGenWidenFn(TCGv_i64, TCGv_i32);
 typedef void NeonGenTwoOpWidenFn(TCGv_i64, TCGv_i32, TCGv_i32);
 typedef void NeonGenTwoSingleOPFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
 typedef void NeonGenTwoDoubleOPFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
-typedef void NeonGenOneOpFn(TCGv_i64, TCGv_i64);
+typedef void NeonGenOne64OpFn(TCGv_i64, TCGv_i64);
 typedef void CryptoTwoOpFn(TCGv_ptr, TCGv_ptr);
 typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCGv_i32);
 typedef void CryptoThreeOpFn(TCGv_ptr, TCGv_ptr, TCGv_ptr);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a0e72ad6942..7cb5fbfba80 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11917,8 +11917,8 @@ static void handle_2misc_pairwise(DisasContext *s, int opcode, bool u,
     } else {
         for (pass = 0; pass < maxpass; pass++) {
             TCGv_i64 tcg_op = tcg_temp_new_i64();
-            NeonGenOneOpFn *genfn;
-            static NeonGenOneOpFn * const fns[2][2] = {
+            NeonGenOne64OpFn *genfn;
+            static NeonGenOne64OpFn * const fns[2][2] = {
                 { gen_helper_neon_addlp_s8,  gen_helper_neon_addlp_u8 },
                 { gen_helper_neon_addlp_s16,  gen_helper_neon_addlp_u16 },
             };
-- 
2.20.1


