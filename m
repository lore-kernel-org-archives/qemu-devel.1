Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBE2C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365392177B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UnEl1IVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365392177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFo1U-00078q-BM
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnn-0000TT-PW
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:31 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:39523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnm-0002JK-3b
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:31 -0400
Received: by mail-pg1-x52a.google.com with SMTP id v15so729826pgh.6
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+RAengYno9BTXIpaDVeX7bv8hOtDAoI5mtNi1wVDY20=;
 b=UnEl1IVKPnG+KGEbpnaQCRn8t7fiUythZU0D+eF6T7aSF7hShWWDTGNHUk4Dm0lNhN
 kVnRs/D/AzVVlqUf9nH/Ez80ttSX0NOAz4ZprqzTJgid/iPKU+Qp6iuC9Ahd6AFG+Tqi
 R2knmqIqFgKc6X6iHoqw8YJC6sSnTE2WX1fcDGWhzO7nkqgIiqCAY4Lc32341YXjnmXB
 HYQDq72D2oih2/KWPpN7VgTjzhY2r+mVltxuskVEoM2jCbtPNFvNE0XLa5HXpstK6VUq
 janeNRhrI0aXHJbk1XgDGh5nrw9hbMbw4TEVZoxqb7LmFQgFja4qGzsinV4qs27WHSD0
 /l2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+RAengYno9BTXIpaDVeX7bv8hOtDAoI5mtNi1wVDY20=;
 b=T5IxnBnZ5PC1g9Qsj/ryVMe3Fmc2CFFA+tucmi5NbjJPK8sMzvH8hUmu14D3SS3rWb
 /Ia0gXWJ+IayRpJiGoAeBuZLujx7+ELoPtdjHHfjlEqbvOwx/yH9TaSXGRNyaXpDAbTD
 Ynj52eQDzb59C5aAatp+vL+JkC1TyWWCcK2mobZeakMJ2LOOglrAKx/5IsZZ2jXJxXG1
 Gd0XY2hjTY2/KqL/OxlRZbdWF6V7voGI87+9q+vqAO4OsJ4jFPvrrGHmUDyxv/6hXDWv
 7PRhV6on0eENQqP1ABlqkgWfb86/dW2MinACQD1OyPUiuJu4I3NyQeg67OFaMuw73wjD
 gniQ==
X-Gm-Message-State: AOAM530zEno4ZEB62e1b1mo0qGA21eJjufRr8/s2OzlDkeaEemxYyq90
 XXEpVB1ctwrPoa1wVUVQ7KbKqjlvUOGYMg==
X-Google-Smtp-Source: ABdhPJzLghf5Knkqv1nSb+3IrM5M7WIpj9iKTWITIR8NHQec3lgIPYfWRbChqLPgoLnF6AyBnBpu3A==
X-Received: by 2002:aa7:9569:: with SMTP id x9mr1261905pfq.16.1599610648468;
 Tue, 08 Sep 2020 17:17:28 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 31/43] tcg: Remove tcg_gen_dup{8,16,32,64}i_vec
Date: Tue,  8 Sep 2020 17:16:35 -0700
Message-Id: <20200909001647.532249-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These interfaces have been replaced by tcg_gen_dupi_vec
and tcg_constant_vec.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op.h |  4 ----
 tcg/tcg-op-vec.c     | 20 --------------------
 2 files changed, 24 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index b4fba35e87..d0319692ec 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -959,10 +959,6 @@ void tcg_gen_mov_vec(TCGv_vec, TCGv_vec);
 void tcg_gen_dup_i32_vec(unsigned vece, TCGv_vec, TCGv_i32);
 void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec, TCGv_i64);
 void tcg_gen_dup_mem_vec(unsigned vece, TCGv_vec, TCGv_ptr, tcg_target_long);
-void tcg_gen_dup8i_vec(TCGv_vec, uint32_t);
-void tcg_gen_dup16i_vec(TCGv_vec, uint32_t);
-void tcg_gen_dup32i_vec(TCGv_vec, uint32_t);
-void tcg_gen_dup64i_vec(TCGv_vec, uint64_t);
 void tcg_gen_dupi_vec(unsigned vece, TCGv_vec, uint64_t);
 void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index ce0d2f6e0e..d19aa7373e 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -241,26 +241,6 @@ TCGv_vec tcg_const_ones_vec_matching(TCGv_vec m)
     return tcg_const_ones_vec(t->base_type);
 }
 
-void tcg_gen_dup64i_vec(TCGv_vec r, uint64_t a)
-{
-    tcg_gen_dupi_vec(MO_64, r, a);
-}
-
-void tcg_gen_dup32i_vec(TCGv_vec r, uint32_t a)
-{
-    tcg_gen_dupi_vec(MO_32, r, a);
-}
-
-void tcg_gen_dup16i_vec(TCGv_vec r, uint32_t a)
-{
-    tcg_gen_dupi_vec(MO_16, r, a);
-}
-
-void tcg_gen_dup8i_vec(TCGv_vec r, uint32_t a)
-{
-    tcg_gen_dupi_vec(MO_8, r, a);
-}
-
 void tcg_gen_dupi_vec(unsigned vece, TCGv_vec r, uint64_t a)
 {
     TCGTemp *rt = tcgv_vec_temp(r);
-- 
2.25.1


