Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF68EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83BC52145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ed5ei2Zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BC52145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnzt-0004Qp-Ec
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnq-0000Zt-4R
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:34 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:34384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnno-0002Jl-Bi
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:33 -0400
Received: by mail-pj1-x1044.google.com with SMTP id n3so471079pjq.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5oTHhTIpHsSvQvico3TP/px05iIcGlpWqa7T/U3dIqI=;
 b=ed5ei2Zu3tRgX6uO1MfYoHHYNYfXG566IYYOg4vagiST50dBZ8qJrA3Hhga3Iop7ws
 kwK+4fwXNuUtDDMleYZwbvRRVxf5dzKekwRi/7DLUDJ6unB4G1pqNS0OM2oqeiNJQuSO
 mlxhOEdWkdBcFT7LbjgPWdR700KUjdlQRPItvgUaNQYciXLIMxIQDD6aNb/FJ398vm6E
 YpdO3pk2g6Knlw7Cv1czagf5aSeZsUe4ooy4iwbSVxfj9Uwq3m06arQrr26AaYP8OX9y
 wfUjdAw81nLA3yOUHQzQ1Q6F2m2aIiTKhQkEBRVBITRLsnLzof4ciIGMc0jN8ToAVFiD
 M9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5oTHhTIpHsSvQvico3TP/px05iIcGlpWqa7T/U3dIqI=;
 b=sfx//6+s17dvSqtOO3IKTqCo42lWq8X2Ru9CDJ9DgcBibJS5TsCdcBPwc/xtFlDzmr
 Ia+QVXkKMS5Y7m13mj2rUxNy8K8vHjTZ5WkXe615uH8TihiOiwg1j7Ec4X48rQ7M6G+K
 0hE2w51nFe9bjSeCiK4YYd/JKji0hr3Bs4zYfR83FcEibitJGlURaVzjyeyj9NHxp7Fn
 7J7q+qb3Hg2bI9+V+V0Z5KELu3KSCliVm+ZdFhSeMzpFlzEXehJMdPoN8xOnMCFWWKww
 X0tTC4o1izqzxuvqfEPywT0TP7cf/Xjy+ZyeOxwHu9RInKFHk8QBYJod7vBqcFBX2mzl
 sw7w==
X-Gm-Message-State: AOAM530j39NhC39k/2kVg/whvmoTenm7wB+kpaV9sl1B+y8SpyB9e8AH
 1pPbdJfTc5K75OCRMsp4B/CDbz3aKT3suw==
X-Google-Smtp-Source: ABdhPJwO5Fd5TQdKQLTDtdF5LjI3jOEgj4cZcf19Kcr9ucmSqwvzEN2+w8inv6jGunfR1lowk7E6jg==
X-Received: by 2002:a17:90b:4c0f:: with SMTP id
 na15mr1160808pjb.119.1599610650603; 
 Tue, 08 Sep 2020 17:17:30 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 33/43] tcg/aarch64: Use tcg_constant_vec with tcg vec expanders
Date: Tue,  8 Sep 2020 17:16:37 -0700
Message-Id: <20200909001647.532249-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Improve rotrv_vec to reduce "t1 = -v2, t2 = t1 + c" to
"t1 = -v, t2 = c - v2".  This avoids a serial dependency
between t1 and t2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index fdc118391c..d9d397075a 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2511,7 +2511,7 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                        TCGArg a0, ...)
 {
     va_list va;
-    TCGv_vec v0, v1, v2, t1, t2;
+    TCGv_vec v0, v1, v2, t1, t2, c1;
     TCGArg a2;
 
     va_start(va, a0);
@@ -2543,8 +2543,8 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
 
     case INDEX_op_rotlv_vec:
         t1 = tcg_temp_new_vec(type);
-        tcg_gen_dupi_vec(vece, t1, 8 << vece);
-        tcg_gen_sub_vec(vece, t1, v2, t1);
+        c1 = tcg_constant_vec(type, vece, 8 << vece);
+        tcg_gen_sub_vec(vece, t1, v2, c1);
         /* Right shifts are negative left shifts for AArch64.  */
         vec_gen_3(INDEX_op_shlv_vec, type, vece, tcgv_vec_arg(t1),
                   tcgv_vec_arg(v1), tcgv_vec_arg(t1));
@@ -2557,9 +2557,9 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     case INDEX_op_rotrv_vec:
         t1 = tcg_temp_new_vec(type);
         t2 = tcg_temp_new_vec(type);
+        c1 = tcg_constant_vec(type, vece, 8 << vece);
         tcg_gen_neg_vec(vece, t1, v2);
-        tcg_gen_dupi_vec(vece, t2, 8 << vece);
-        tcg_gen_add_vec(vece, t2, t1, t2);
+        tcg_gen_sub_vec(vece, t2, c1, v2);
         /* Right shifts are negative left shifts for AArch64.  */
         vec_gen_3(INDEX_op_shlv_vec, type, vece, tcgv_vec_arg(t1),
                   tcgv_vec_arg(v1), tcgv_vec_arg(t1));
-- 
2.25.1


