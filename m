Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CEAC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:16:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB7862177E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Us/s25z0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7862177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54032 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqka-0007R7-0X
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58662)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpqj-0005b5-26
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpqf-0007Ax-Fx
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:47 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54186)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpqe-0006ck-H4
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:44 -0400
Received: by mail-wm1-x343.google.com with SMTP id x15so3130739wmj.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ITzNLkGufKFpiKfmJVh6vzZ3LsNbeBm40jej1S7JzUY=;
 b=Us/s25z0K5nigBSeUH+Yvy1688SNudchk+MgUS+New9ZmBtZ8RSKj8BzrNdDh+Hnp5
 pVpm7RcHgcAF5L9rCDfjCFvb1bWqMRUv4f0ITJIyRa+Zz/plQk9ipYPBJUegk8OuXl3X
 KjMBzMGCuLmjHGKSxavfp7bcfnejBihNrLZLjKklbexep2qA0/qzZjJukTmBFvh3ilzk
 bxE9nNtrExzMZq2oXjAZ5QxEvFjUjbEtBSCgxfJ6OozVVZuB4nHyZXkzMRjT7+oWfs1K
 M63+rYYj3Gish0qnUVzKfcqXB18B0yQDBcX1m/IFXkqMKLChV2RzTJ9+ov+WOE1sWLNU
 5+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ITzNLkGufKFpiKfmJVh6vzZ3LsNbeBm40jej1S7JzUY=;
 b=nHF9r/4afqMyuU560D+MgLxYsKFHYMLU5o0O7a/jwikDqQuQkuBcb8XO/jVBn9j0uX
 7F5Q07Lws7whBW0T1jOCjCihLchHBSPWQwYDu2m3o/Lr9x4TVsQoO87EO3JMYgU0aBfQ
 x41mlanRkSfsLnZVpoFX2J2q6/eDwficPVbIMKPcKUbGu+JJRxeykMF+vd1zEmmpn042
 5Ou6vTmD4O4D9YGLJeoudCstSfxhqMiz0Dtf+rof5nhtaKH3UB1NoQqgSFdR/1PtS5AX
 8aec1qnDf5u8UyBxG/FWJbn/elktS+gTTfQJk+OYbgAtW26+UvtMJOpBFASTSz8sCzaO
 bRtQ==
X-Gm-Message-State: APjAAAUUecKh4qoVJqS4pxcmkPJ7nGmwMMG6fy4r5FmgwBTYPcHjRudh
 RtEj73J3T8bmdyBfmBdp4TXwJA==
X-Google-Smtp-Source: APXvYqwscFUsmLzmfKBI+1R+Cp/VFQNmAmOY4wureejtvZptyFOqsTfE5uhagkzmItu0+I9n6W06Hw==
X-Received: by 2002:a1c:b684:: with SMTP id g126mr8632045wmf.176.1560532709061; 
 Fri, 14 Jun 2019 10:18:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 67sm4075045wmd.38.2019.06.14.10.18.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:18:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 558911FFB7;
 Fri, 14 Jun 2019 18:12:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:42 +0100
Message-Id: <20190614171200.21078-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v3 32/50] target/alpha: fetch code with
 translator_ld
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
Cc: "Emilio G. Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/alpha/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 2c9cccf6c1..daf1e05cba 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2989,7 +2989,7 @@ static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUAlphaState *env = cpu->env_ptr;
-    uint32_t insn = cpu_ldl_code(env, ctx->base.pc_next);
+    uint32_t insn = translator_ldl(env, ctx->base.pc_next);
 
     ctx->base.pc_next += 4;
     ctx->base.is_jmp = translate_one(ctx, insn);
-- 
2.20.1


