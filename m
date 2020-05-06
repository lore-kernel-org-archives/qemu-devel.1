Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FE0C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:37:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D5420736
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAj6yL6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D5420736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWOv0-0004th-IY
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 14:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOoF-0004cE-9u
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:19 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:37780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOoE-00034I-9I
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:18 -0400
Received: by mail-pg1-x529.google.com with SMTP id r4so1491509pgg.4
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 11:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3YIgXvNnlKZZkRJjIa1yeZKpwFFnxkASkY1Nv08qCiQ=;
 b=CAj6yL6Rk2C3GDzJbBsrdQG4Hwbw0IPpTwMbBG0BMSRO1eTYLuF+8tTwm/ez4SEo48
 AYMrShKUoi1OkpsUwugvZtKDhX2yQnpeOt9qrJ1u6w50udVrbvzCneaIQwYPOp0ET8CA
 GMRxUcJYjXuvXXAvL8qJc4XLDVIrsh+bOaw1zwlpZryBIaYKQKyGqZpwLTfVBd92elBQ
 Hf2zwk+ftvEMIRRr6/9knY5PWCnSE7q/BBvIduQ3CMBZdZVVN8I/yNIoGH1Do5EaXcaw
 +LoJmiTQxgyzstYI6+F9GOXFgZZO+hhvJ8o8d8SvQ51TSv/P7cWrXvPgT+roOqO/w07b
 +Qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3YIgXvNnlKZZkRJjIa1yeZKpwFFnxkASkY1Nv08qCiQ=;
 b=BioVnH52ozPDBvfVkalHvXlF91Z0VTEbuGKv0wQpx1UW39kfTXhFBmqH12YyZVm9vQ
 viDsRkQ2s+Kk87cL1ID3st5PxRw+5+AwoYyAdOAhyMiKJw4mn6unS0uity793uYJe4Ip
 xoPIhJg2mEIR9PSTOZNMAQJoIPJE9lUkEEVH0SnDD8oSinkZE2ubeMyZIFE6D0VOLHYQ
 URpK7JPEJ7eB4eUO/ivgW0ceKk1N2OomrmIJmzDgUtvuJ2Ciu3JR3cit6azMxjb7A8hg
 9XQxhO2mg+NVkw3npMQd86o3njvWJD9jHIq/+rRv9xkduB+ABo9qjfIuiRcwGxoiIaVz
 KEmA==
X-Gm-Message-State: AGi0PuY/TsqTMXUckXaG3sJzkupV/AGLYtJdGnWRbTaVcN6kum+kHHul
 iPbiAaQIBwiMuRuNsEQa9VBpIwgHMuM=
X-Google-Smtp-Source: APiQypL75+hD/kSeLGUYUckLFYolK/nG+2qYS0u0htPJWlxMbNUldWKxokw8SMkNiTPAW0U+4x+AbQ==
X-Received: by 2002:a62:888a:: with SMTP id l132mr5424303pfd.125.1588789816525; 
 Wed, 06 May 2020 11:30:16 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w11sm2572589pfq.100.2020.05.06.11.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 11:30:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/10] tcg: Fix integral argument type to tcg_gen_rot[rl]i_i{32, 64}
Date: Wed,  6 May 2020 11:30:02 -0700
Message-Id: <20200506183002.3192-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506183002.3192-1-richard.henderson@linaro.org>
References: <20200506183002.3192-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For the benefit of compatibility of function pointer types,
we have standardized on int32_t and int64_t as the integral
argument to tcg expanders.

We converted most of them in 474b2e8f0f7, but missed the rotates.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op.h |  8 ++++----
 tcg/tcg-op.c         | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 230db6e022..e3399d6a5e 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -297,9 +297,9 @@ void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2);
+void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2);
+void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -493,9 +493,9 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2);
+void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2);
+void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e2e25ebf7d..e60b74fb82 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -540,9 +540,9 @@ void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
     }
 }
 
-void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2)
+void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
-    tcg_debug_assert(arg2 < 32);
+    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
@@ -580,9 +580,9 @@ void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
     }
 }
 
-void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, unsigned arg2)
+void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
-    tcg_debug_assert(arg2 < 32);
+    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
@@ -1962,9 +1962,9 @@ void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     }
 }
 
-void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2)
+void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
-    tcg_debug_assert(arg2 < 64);
+    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
@@ -2001,9 +2001,9 @@ void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     }
 }
 
-void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, unsigned arg2)
+void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
-    tcg_debug_assert(arg2 < 64);
+    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
-- 
2.20.1


