Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282CBC388F2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E77D2072E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNT/2z+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E77D2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasfQ-0001Wz-Kk
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRi-00050n-Ov
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:50 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:42647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRh-0006yu-2q
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:50 -0500
Received: by mail-pf1-x436.google.com with SMTP id x13so35457pfa.9
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YKIoLTi5ySgzCVvhycZMdw7nP6Jv58IFUwkqltF23wU=;
 b=oNT/2z+vahNd8FRuo0RBTPK/El7HxwyZBAP/QdPYWEDCo48i9MCc34T3VnZUDAkYSN
 /AW2sDAOtpQNkuEwjaCX5laWW779KeUfq3iLJ/R2K5OjQUAN6HeyubhvZ5fYscyg6Pat
 nYZ4aGgm8OVPCcyh5N3f378pziIGlkLog9zcRQBwWMplOn+essc7xNKplg5bpDvSqTOu
 qZhemAh2ul83Mmeehuxkg15A2Xx+++/Gko3EBJBJGMNpWlpr4oee9O/QuLpmuioRvOno
 1l0y9zPy0lGudwdp2aQFr8I+iQH9g0yN6fdNPXPOLW0QisL0KqVORES1UwydahzEQvBu
 6WYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YKIoLTi5ySgzCVvhycZMdw7nP6Jv58IFUwkqltF23wU=;
 b=aJcoVeyByBUP0SSuKJf7nj1d6nxrG9J4cdB0Kawt2Tz6mOAcNWvClY8iFkJLKo9ojH
 jQI0SMzABffpzUYVCZr5rfjrMwFogTAbe21AwmGm3F46eSo4wdqvY0PUIonYhdw9o16l
 WhUtF8sksrYbWiSqXX7WcDl/lejTIt9D10MWdFpCuP34ujn6OxInRgWxo3QPJtBMNONK
 VEjuTJCmDRe5gaD/z1RWNnN2gAOR34d3bAIhF0MGmpH5+HJrhzOEK93Ot+Rx7ejoy6HH
 LxEZ+lZPFw9dkhPs1qpPSNPJCJEj5/HJJuKNwLeI4kuC/78PLxnCQ4ZKLsMRLe9FqO8g
 wa8g==
X-Gm-Message-State: AOAM532N9sHSR22d6nQmasD3O/qjLmMxAI7wZML6xK0opQo/FEtuNBDA
 2CNQVJbwQO7PUIXOTVopbEwUcTFX+Y1Xlw==
X-Google-Smtp-Source: ABdhPJyYAGBur9xl4xGo9nYXx4yOJpPKUvSLw2EMSNA8gIOzjcQvjMnZba5HHr1CjWhRxUnSRJbxcg==
X-Received: by 2002:a05:6a00:212b:b029:18b:ad77:1a27 with SMTP id
 n11-20020a056a00212bb029018bad771a27mr126668pfj.40.1604633387463; 
 Thu, 05 Nov 2020 19:29:47 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 19/41] tcg/aarch64: Use B not BL for tcg_out_goto_long
Date: Thu,  5 Nov 2020 19:28:59 -0800
Message-Id: <20201106032921.600200-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A typo generated a branch-and-link insn instead of plain branch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index fea784cf75..bd888bc66d 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1317,7 +1317,7 @@ static inline void tcg_out_goto_long(TCGContext *s, tcg_insn_unit *target)
 {
     ptrdiff_t offset = target - s->code_ptr;
     if (offset == sextract64(offset, 0, 26)) {
-        tcg_out_insn(s, 3206, BL, offset);
+        tcg_out_insn(s, 3206, B, offset);
     } else {
         tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP, (intptr_t)target);
         tcg_out_insn(s, 3207, BR, TCG_REG_TMP);
-- 
2.25.1


