Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8427CC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E0A206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QiNeEiMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E0A206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwUw0-0001JM-Gk
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 14:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwUuO-0008T4-Ap
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:16:32 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:52907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwUuL-0003Gj-2s
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:16:30 -0400
Received: by mail-pj1-x102b.google.com with SMTP id gc9so6924495pjb.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 11:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1xo/F7/aAE6h7nPyZHFzXrWII41wbW4AOQQ3nfWZDVk=;
 b=QiNeEiMGpGrZ6xkpRErjKyWf1u+hT0g/Ix+B3362CKVmQqfSAzX4t+JoSwiK7rt1GI
 PnQ/pVwJrurcQkw7qE6YUYJxkPGuYq6jUSOTO7BHN97KKsXLG6wtcvNtLIcOoEpUlpkD
 om1dg+givkjG5/F1y/pt/J5o+J0VF/7hi3JnGjAx335eNbKMo1BFWmXo7b+sDEy3TfBB
 03o05AQQsvklldqX5+hYmzYFkiJ2OlfP/3CiGnx6SWivmH3lYErloUydfvVUXGVoXUED
 oTliO4CGviN7kb0c0f92ZrxS0UzLzVph29PWK71gsYo+H1XLk3rxKOEYiUboQ3CUnbZw
 vT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1xo/F7/aAE6h7nPyZHFzXrWII41wbW4AOQQ3nfWZDVk=;
 b=Wot4jBr8gf0t4Sg+4a7Xa8Qxil0/Yc1Gv7XHSSsxa5zlplL24bQMViT+9+6Yn4XBkg
 8pnrAGWHp+Jnz52EMY3RgWTcvS9/DYt405s0Tf8OLLcNlLO8o2or5TjJJObR4af+gDLm
 3eOZn36/Fsgxi0FMu0rjYPzMRlpKnGjO+TTc5kWA/FiT0VOd0BXw44ncbhXjyZnO/BpF
 rDrAfs4M1LwsjCsF6LMosremSgqUio9HKr4f8lGfKjCXqaW3zfVYHZdunUuqCPVgJtAd
 eCNWYvyD/Iny2vUVj5TSujJKPFGv5x7e49dKcFFBoJRmoRyMTAjUj3a4Kv/PGBEaxoQQ
 JYgw==
X-Gm-Message-State: AOAM5327674h/nyZ8YUQ9IptIj3wziiOguWu8aBwmE+dU2UOtKb/i1dS
 2ZtvgBCENi5J6DcX7Px8tjq9XJIGg/k=
X-Google-Smtp-Source: ABdhPJzKu46eNv/fCzl+i1f6Wk3rhb0eFtTxgE2UWZp/MezB8M9HypcjdczVNGDn24j5Sc2hHo9tnQ==
X-Received: by 2002:a17:902:d392:: with SMTP id
 e18mr8347442pld.139.1595009786311; 
 Fri, 17 Jul 2020 11:16:26 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id r7sm8698578pgu.51.2020.07.17.11.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 11:16:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.1 1/3] tcg: Save/restore vecop_list around minmax fallback
Date: Fri, 17 Jul 2020 11:16:21 -0700
Message-Id: <20200717181623.2742758-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717181623.2742758-1-richard.henderson@linaro.org>
References: <20200717181623.2742758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Forgetting this asserts when tcg_gen_cmp_vec is called from
within tcg_gen_cmpsel_vec.

Fixes: 72b4c792c7a
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index f784517d84..ed6fb55fe1 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -657,7 +657,9 @@ static void do_minmax(unsigned vece, TCGv_vec r, TCGv_vec a,
                       TCGv_vec b, TCGOpcode opc, TCGCond cond)
 {
     if (!do_op3(vece, r, a, b, opc)) {
+        const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
         tcg_gen_cmpsel_vec(cond, vece, r, a, b, a, b);
+        tcg_swap_vecop_list(hold_list);
     }
 }
 
-- 
2.25.1


