Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1FEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44265208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFwdICJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44265208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKpS-0004GS-A1
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmKcL-0004vV-2L
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:15:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmKcJ-0005s3-6T
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:15:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id h5so10432903wrc.7
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cWBE60YDRt2ipaIUjY7lGwhDyWZ8nYNoAEL9KqLFAz4=;
 b=aFwdICJYC7NHfE9XAykfgh/re6iB6JMqXnPtaqf6etlqk6jtZo6tC2KdATJtTawV7C
 fzbGZPgj9u2+VaFaFqg+5bW4hrS6QvuzdWz1D0iiOW2dW2yDCnDROF1mLT78js0h2q4H
 B4tObXrN/XcVqo0NBUm0OaEJXulxqbmnjJSeqtS0cAfpwtboL7xkY8EFeJAUW20FV/ld
 9DJPSu7S40sVnbSxcAbmOQE7XJoJFf27hwWVQJmINr1YVA1REcFmCQLB3WL+7DZfIYvP
 lkNf0WyeavWpRiQn14z6qSO7GlNYo4EjU60Jm0ok3q2SXiFWKUlUxNTG1x9fVsByXo3f
 clKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cWBE60YDRt2ipaIUjY7lGwhDyWZ8nYNoAEL9KqLFAz4=;
 b=PNCEo8kggdyIb7R3eFd16cbKRjtdef7gABXvfvgOx59odO3b1c2T/fw/2GbKApI3PK
 HigWh7uvKvKJDKR+/yq6GF5+mNgAcJZATL6Y4dVFqjtBdQ6yLSu8NtvQtjt3xuEtvudq
 8bKpd+6Prw30uWCnFZok0h6Q/20dd39DTZUI8rSE0ujWNo6VNOv6QMjYVerzadC7x7ML
 Ys6tRoTR+QyhZLmLABWdUU77Q6XhsyU3n5SeyfxrXFuskq2aM3lZHzJxyVxxqbY/FK80
 n0DfQVLTIXn4v2qhOd/TgVXduHxGfBaWx8C9xzTpt4n46hDzQet2Ic0iQMSLcUwq2Alj
 GhdQ==
X-Gm-Message-State: AOAM531q9WCZLqt5kP5D6XMcNeXddhDewul8xQo9UnhH1NfrAa0kzn4Y
 IfPY7ZtfKrVoKmduDlyxpDZCbg==
X-Google-Smtp-Source: ABdhPJwvF2VcbXeFnZ3jCvc8Rl2CpSiDxlfXD4rWSuI0nDFgsB2h7NtWuYxTS919hHWMjXQpT1AxPA==
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr5528879wrt.29.1592586949692;
 Fri, 19 Jun 2020 10:15:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l17sm7083180wmi.3.2020.06.19.10.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 10:15:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Remove dead code relating to SABA and UABA
Date: Fri, 19 Jun 2020 18:15:47 +0100
Message-Id: <20200619171547.29780-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit cfdb2c0c95ae9205b0 ("target/arm: Vectorize SABA/UABA") we
replaced the old handling of SABA/UABA with a vectorized implementation
which returns early rather than falling into the loop-ever-elements
code. We forgot to delete the part of the old looping code that
did the accumulate step, and Coverity correctly warns (CID 1428955)
that this code is now dead. Delete it.

Fixes: cfdb2c0c95ae9205b0
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a0e72ad6942..01d59164d68 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11370,18 +11370,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genfn(tcg_res, tcg_op1, tcg_op2);
             }
 
-            if (opcode == 0xf) {
-                /* SABA, UABA: accumulating ops */
-                static NeonGenTwoOpFn * const fns[3] = {
-                    gen_helper_neon_add_u8,
-                    gen_helper_neon_add_u16,
-                    tcg_gen_add_i32,
-                };
-
-                read_vec_element_i32(s, tcg_op1, rd, pass, MO_32);
-                fns[size](tcg_res, tcg_op1, tcg_res);
-            }
-
             write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
 
             tcg_temp_free_i32(tcg_res);
-- 
2.20.1


