Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BF1C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:25:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26532145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zFHxOBUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26532145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnvI-0001Bp-0H
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnL-0007qE-TS
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:03 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnK-0002Cg-7f
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:03 -0400
Received: by mail-pg1-x542.google.com with SMTP id e33so752995pgm.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=WANLQRCpycKiqrfSXuwWnjHW6iUlbU2o8NExmAhiBGo=;
 b=zFHxOBUA4THZW2VM6gUFeAzETtdF+vMSsfacwfh/LzcRiMNc29ttwk42Zr6h8l5NdI
 6ZcpPAd//DiOvCVR9KFR9P0A1i1kBNykb6sEDJrifpKPLUPx5SPkKCqFjyplQJkENL8Y
 hG0qp1MQRpynDkWfFTG0NlFEYiwkFwjtrplx/e7x6PArWQxvUSASrETx9UxGVkXtfrAO
 OY+0yFQYN7eQE/p3/Ft0lBkQgxu2fP7H5JCoWRLakpacRlgmbuSmBmW2TKwRWfWojZ4+
 Va5mJRnyjeOu4SJU6aInmE1QfiGF5WddstnhLdRLdWQKR+U2p40JYJ2YoFi6tvDZCATb
 x3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WANLQRCpycKiqrfSXuwWnjHW6iUlbU2o8NExmAhiBGo=;
 b=W4M1wugTtiKWhI/+jefe/epPat92dL3h8/WeQW/FEFBby5+zbYoUNd368nUw4zKpaB
 vebzxAsjoB54FHttU5tGfOwbMEIL/oYEs5Hygc+Vfy0UofDCAuQfjRHmBkpQkqCu6u2f
 Jc5tqxLNOea7SRcYzMMu9kh3tRGPQgaUkyWbOsI3lrdEEHWG8U1wToGWKJNTKDvnloGJ
 DKJcbhhbn3ZCntel5+Uk1dOdUrTSQsQmQ1grR5oFpJb027x/R/960eDqC9HG8rUpuRaH
 Pk9I45J9gMWg8EyVH2mVIx+Nz+0qsYAQvL2b7YuZelMqvQUwiCo2sXrn9u3PkhbRVitL
 svQA==
X-Gm-Message-State: AOAM533baiw65+ZKGJLCJ1eQzIOQlanNLwjTrUgLViyGQFOg4E+NkJ+k
 NVxDmnlnMPSKF2CUSdEEZt+rTzVgwH5m/w==
X-Google-Smtp-Source: ABdhPJwK6A/3aVSma696pWx4caAugaJxh5ee27IH6YTssqRh0bMfzbC2ciUmpGvxu9BG9y5pm+aQog==
X-Received: by 2002:a63:5d66:: with SMTP id o38mr949965pgm.366.1599610620688; 
 Tue, 08 Sep 2020 17:17:00 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.16.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/43] tcg/optimize: Fold dup2_vec
Date: Tue,  8 Sep 2020 17:16:13 -0700
Message-Id: <20200909001647.532249-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the two arguments are identical, this can be reduced to
dup_vec or to mov_vec from a tcg_constant_vec.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 53aa8e5329..220f4601d5 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1109,6 +1109,21 @@ void tcg_optimize(TCGContext *s)
             }
             goto do_default;
 
+        case INDEX_op_dup2_vec:
+            assert(TCG_TARGET_REG_BITS == 32);
+            if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
+                tmp = arg_info(op->args[1])->val;
+                if (tmp == arg_info(op->args[2])->val) {
+                    tcg_opt_gen_movi(s, op, op->args[0], tmp);
+                    break;
+                }
+            } else if (args_are_copies(op->args[1], op->args[2])) {
+                op->opc = INDEX_op_dup_vec;
+                TCGOP_VECE(op) = MO_32;
+                nb_iargs = 1;
+            }
+            goto do_default;
+
         CASE_OP_32_64(not):
         CASE_OP_32_64(neg):
         CASE_OP_32_64(ext8s):
-- 
2.25.1


