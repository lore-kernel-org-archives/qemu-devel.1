Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFE6C43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 22:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1EE21D7A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 22:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EuT7r8DG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1EE21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSSjw-0003bg-Ek
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 18:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSShs-0001n0-IK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 18:23:44 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSShl-0007At-JO
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 18:23:44 -0400
Received: by mail-pl1-x642.google.com with SMTP id c6so664810plr.9
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 15:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6SKuiliJpxT6R4FNF++vrVrvF/ZziJKI2oEeY+DT8e8=;
 b=EuT7r8DG7rE/PtmrmBFi0XR/bwskgPZrAnzDkMTBGqkdO3riqJ6wWjPjwZEqm5pSbM
 LGgofxWI7rZ9ghdxwSO1BoEhR45GX3x1au5fAK7IGMOJZLYDim3hO7DuxJ74vn/Kf05y
 s+ftQAQP0lyaQlgCp20eM77KZS2+7jI8Y3JgnAlRi+AW61ZAV49zMRHRxPmaTbnV1Cfv
 ZNmhkUrQYrBXmRlfOtYEC7JVw0VaYqoYmP/KnTTNWwQLBRE4gxgWG4d3aP+4fq6i76Ln
 Xy1urFogfU46soOP2/+rCrSu0TeMZHoY/00QQinrBXEhMk/li7IgF0w9Ik71GjbMluaG
 v0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6SKuiliJpxT6R4FNF++vrVrvF/ZziJKI2oEeY+DT8e8=;
 b=Pv2/msVDyuc/7+eIXXz4e7qWpmsheVpypYjfkn1MWoG+0784d5Q5N8+aniYj+MjBPf
 IaTFvdQm4WGin+8m+EN9BZp3a+td4ZFFo9lDrFfxITznt5/r3QMkfjg/6XUMtBQ1aFR+
 jgnxx335OOGC7MLXzr7i2g3XZWAIQaFEsYRCSkwyodxdB+jSIDwBLyf9Ohj++NhxOfl9
 DyvtzQmd63LPVZAuaW7AX2WIwrTN9hac/YMpauWR9kHuUdhfhagAB8rlb8Bu2uWgv6GN
 HXSoH6k8OlMcTdJRERsIqvsxUrl3+KY27gb+//UamqufdSS0Dra45YCNE4eStenrOXx5
 FR2Q==
X-Gm-Message-State: AOAM533Hr1rPH1roy0GF6iddXULNicOoB3wvPTThVVflrmg39HH02Iet
 LbTA9SRZxV5YhurBurlhuMfFZ3HLULoUeQ==
X-Google-Smtp-Source: ABdhPJzzS7z/fXGrBiksDZjpfGCTo4NdsloZzvnlsmQJucaRTzl+7n+0Ku6fBPEcrd5juLUDnS7QGA==
X-Received: by 2002:a17:90a:6f21:: with SMTP id
 d30mr447075pjk.165.1602627815400; 
 Tue, 13 Oct 2020 15:23:35 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id cu5sm239899pjb.49.2020.10.13.15.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 15:23:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] tcg/optimize: Flush data at labels not TCG_OPF_BB_END
Date: Tue, 13 Oct 2020 15:23:30 -0700
Message-Id: <20201013222330.173525-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201013222330.173525-1-richard.henderson@linaro.org>
References: <20201013222330.173525-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can easily propagate temp values through the entire extended
basic block (in this case, the set of blocks connected by fallthru),
simply by not discarding the register state at the branch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 220f4601d5..9952c28bdc 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1484,29 +1484,30 @@ void tcg_optimize(TCGContext *s)
                     }
                 }
             }
-            goto do_reset_output;
+            /* fall through */
 
         default:
         do_default:
-            /* Default case: we know nothing about operation (or were unable
-               to compute the operation result) so no propagation is done.
-               We trash everything if the operation is the end of a basic
-               block, otherwise we only trash the output args.  "mask" is
-               the non-zero bits mask for the first output arg.  */
-            if (def->flags & TCG_OPF_BB_END) {
-                bitmap_zero(temps_used.l, nb_temps);
-            } else {
-        do_reset_output:
-                for (i = 0; i < nb_oargs; i++) {
-                    reset_temp(op->args[i]);
-                    /* Save the corresponding known-zero bits mask for the
-                       first output argument (only one supported so far). */
-                    if (i == 0) {
-                        arg_info(op->args[i])->mask = mask;
-                    }
+            /*
+             * Default case: we know nothing about operation (or were unable
+             * to compute the operation result) so no propagation is done.
+             */
+            for (i = 0; i < nb_oargs; i++) {
+                reset_temp(op->args[i]);
+                /*
+                 * Save the corresponding known-zero bits mask for the
+                 * first output argument (only one supported so far).
+                 */
+                if (i == 0) {
+                    arg_info(op->args[i])->mask = mask;
                 }
             }
             break;
+
+        case INDEX_op_set_label:
+            /* Trash everything at the start of a new extended bb. */
+            bitmap_zero(temps_used.l, nb_temps);
+            break;
         }
 
         /* Eliminate duplicate and redundant fence instructions.  */
-- 
2.25.1


