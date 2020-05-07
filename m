Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7551DC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BD420A8B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqKW8WgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BD420A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkGS-0003P1-Fo
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWkFb-0002W3-Mj
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:23:59 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWkFa-0005dG-T2
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:23:59 -0400
Received: by mail-pf1-x442.google.com with SMTP id x2so3318037pfx.7
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wGcdGtbwCbGXwbtVCD3Vnuhz/HniX9vTMEGKeKgan54=;
 b=lqKW8WgZNP99aKxgo/S7/hsixeEDjm0r0MZM60QQS4RTQTNUQeMtBDzi1m0KUJ3TBT
 LKIab1SFijxo7aE7vEufZ6/m8Ws/XpGxTphRcwWcPcMStV/nbNSpJQ3ZlqBNBkqbjIka
 /390Ee5sZvEXCYkoNFrY5yMpGCVaaIET8FkHiagTqX8lU500hCuuvFQxn8PUNy38Ivg/
 PIuBPalXZDOY7Ndavo1OnK0hMAGImD7kow52Bk+can4C57P9xBs8gpecHopupUCkgJ8L
 RpUc9SkXN1I/Yu6ELGWZ2SMED+BuHL/tBk0eH22tH9ebSml83+75fFU/bSq9L11PyYfA
 +yPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wGcdGtbwCbGXwbtVCD3Vnuhz/HniX9vTMEGKeKgan54=;
 b=uCEV80Bn76gw6Qo4oZP/5AEg8e/6nq7GfNOEL2jqXxT9ePGF66WQtOv0JXqXj8R35D
 RC78qnXk16J5Mdn0ZBGCKRmPQy9HYQplxeHvJ1DKYe/a2J5Zjloa3UiKNkaFrp5Mz4Jf
 qKRG6cQlDGJA9utget/PKPdwH02PDAOrZsf9eg4lic+WUSSF6vZspjM7AswFrGqhF5rX
 3E74uOVXVhVebqDFWaS6uN63R0ftlszaCRW+2m7vQ9GrczPLgjPalOc5jd3hrxJVAH3F
 mlHsgmLYxNtimiYe+AY5FsTNfzQ8uNJj8+0q1kuEp9WRQVOtvczHxKf+zAKWqLhph++w
 gMHQ==
X-Gm-Message-State: AGi0PuZXEH6YopGwl7ARtIU013C4rOFtZOiTL8LldacJRY3+kTCRbgdP
 TFryVs6kSSLpoTr9JZfayyGwu1eJBq0=
X-Google-Smtp-Source: APiQypLEK2ylXRRvkalQrw1psYFubyykTGEMD8CYDeBFUo9tFHqT5dfWm5+So97qcVcQUwH7tyzc7A==
X-Received: by 2002:a62:35c3:: with SMTP id
 c186mr14226637pfa.261.1588872237150; 
 Thu, 07 May 2020 10:23:57 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 19sm312228pjl.52.2020.05.07.10.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 10:23:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] target/arm: Use tcg_gen_gvec_mov for clear_vec_high
Date: Thu,  7 May 2020 10:23:50 -0700
Message-Id: <20200507172352.15418-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507172352.15418-1-richard.henderson@linaro.org>
References: <20200507172352.15418-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 8-byte store for the end a !is_q operation can be
merged with the other stores.  Use a no-op vector move
to trigger the expand_clr portion of tcg_gen_gvec_mov.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 62e5729904..b6feb2b9dc 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -496,14 +496,8 @@ static void clear_vec_high(DisasContext *s, bool is_q, int rd)
     unsigned ofs = fp_reg_offset(s, rd, MO_64);
     unsigned vsz = vec_full_reg_size(s);
 
-    if (!is_q) {
-        TCGv_i64 tcg_zero = tcg_const_i64(0);
-        tcg_gen_st_i64(tcg_zero, cpu_env, ofs + 8);
-        tcg_temp_free_i64(tcg_zero);
-    }
-    if (vsz > 16) {
-        tcg_gen_gvec_dup_imm(MO_64, ofs + 16, vsz - 16, vsz - 16, 0);
-    }
+    /* Nop move, with side effect of clearing the tail. */
+    tcg_gen_gvec_mov(MO_64, ofs, ofs, is_q ? 16 : 8, vsz);
 }
 
 void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v)
-- 
2.20.1


