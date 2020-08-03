Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5452AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 13:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204B92076C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 13:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7aFV4F4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204B92076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2aWr-0006Tl-8D
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 09:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2aVq-0005Y5-FL
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 09:28:22 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2aVn-0004Rb-VP
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 09:28:22 -0400
Received: by mail-wm1-x344.google.com with SMTP id x5so14329698wmi.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AyFACLs1JXpjGZamPbhug492vRl8MO0LxHw3leLeOJY=;
 b=X7aFV4F42hecCsGW9+iHhpQSqD6Mjv1znBSbF1rrrUrbeqpid8cHtc/TEqca8L+nh2
 MG/7gwmmOFCQTPZY1X0+VIwvfkhTsuOAr5RernW6JBENEVls95NwFoXVqaEAbP1J8WMl
 nTLP2l0L+VjAb3bHiDba3vevzoYugfUue0vwEAx2Z6rWvMqzif9235fG1Geng1mLHjJU
 l6Z+w+eQBbC5l4iJniwlxlG1YEejc825+3IfnfMojxFqChJKKqcEt63xDKs47tE8jbuu
 xP5B+qDVVdsAyNzMbyGCkPcbEYcRZQ/unYkW1h90Cxq+SV65CY7MAD9h2zYIWcZ3gAGm
 Nb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AyFACLs1JXpjGZamPbhug492vRl8MO0LxHw3leLeOJY=;
 b=AIsgMzhexqmly4Nw24cAkaK4HPAdI10EtVjp8wWpaP6ZOFSwoe+HIt/b7qMBR38pyq
 ZTuvOMsEAxgAMyTCMCgiK0bxGflr+lpX5LOA7N6+9fQnmvoZXJxyHr+CuyPrwK2G3wR/
 NT4kH8vQvWeYVAMBXE5ztI6xy3uHiMa0pAGW7yW3wJf3UHQclKaz0pO8UQEakFkIhLOI
 mivEy2c8b6KNvKvSmdogsfeTU/BkC2qzUxvwGpfloxBAWpAhQVrVnYTx03yqJ3hEyPc7
 t+F2XIdTSKf1O4ygX6AKiMoi6wZ8YUKLe/1i/ho9wojS2hCEmDV+DRjoe5dIcko4WzJr
 nyzg==
X-Gm-Message-State: AOAM531w6xD/kQJDrRwz0DNKNLAVYTu3WHvKsdww/o7/dzOtZSE9mfik
 a/fGjQFa0LEdeJlYj60S4y0WiQ==
X-Google-Smtp-Source: ABdhPJypDnZ9XBzlIWTSF8JCykOKTgBtAywcwsDMh26hmcRVGIKea0nclVxOLJ0nHS1D0wtSi33XQw==
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr85393wmj.24.1596461297424;
 Mon, 03 Aug 2020 06:28:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l1sm26508028wrb.12.2020.08.03.06.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 06:28:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm/translate.c: Delete/amend incorrect comments
Date: Mon,  3 Aug 2020 14:28:15 +0100
Message-Id: <20200803132815.3861-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In arm_tr_init_disas_context() we have a FIXME comment that suggests
"cpu_M0 can probably be the same as cpu_V0".  This isn't in fact
possible: cpu_V0 is used as a temporary inside gen_iwmmxt_shift(),
and that function is called in various places where cpu_M0 contains a
live value (i.e.  between gen_op_iwmmxt_movq_M0_wRn() and
gen_op_iwmmxt_movq_wRn_M0() calls).  Remove the comment.

We also have a comment on the declarations of cpu_V0/V1/M0 which
claims they're "for efficiency".  This isn't true with modern TCG, so
replace this comment with one which notes that they're only used with
the iwmmxt decode.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
In an ideal world we would clean up the iwmmxt decode to remove
cpu_V0, cpu_v1 and cpu_M0 entirely -- they're only used as
temporaries, and in a modern coding style we would just create and
dispose of more carefully scoped TCG temps as we needed them.
---
 target/arm/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 27bf6cd8b51..87235db4640 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -59,8 +59,9 @@
 #define IS_USER(s) (s->user)
 #endif
 
-/* We reuse the same 64-bit temporaries for efficiency.  */
+/* These are TCG temporaries used only by the legacy iwMMXt decoder */
 static TCGv_i64 cpu_V0, cpu_V1, cpu_M0;
+/* These are TCG globals which alias CPUARMState fields */
 static TCGv_i32 cpu_R[16];
 TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
 TCGv_i64 cpu_exclusive_addr;
@@ -8552,7 +8553,6 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     cpu_V0 = tcg_temp_new_i64();
     cpu_V1 = tcg_temp_new_i64();
-    /* FIXME: cpu_M0 can probably be the same as cpu_V0.  */
     cpu_M0 = tcg_temp_new_i64();
 }
 
-- 
2.20.1


