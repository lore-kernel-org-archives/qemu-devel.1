Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835D3CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C8C820867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F6+wjd6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8C820867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNu9k-0007Nt-0N
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWY-0003Km-KO
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWX-0007e8-AI
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:38 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:39837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtWX-0007dO-4c
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id r141so800628wme.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v2mAjqtuZOYE0ZtUDVZuiSZ00TgB6ibRdPm0eNtlQKI=;
 b=F6+wjd6MKAEFZdSJYbNPD9WS7D5r5oehojabF04cobSgTdb9eui3COyquhRFU8pZYL
 +0NxyRln6SYT31eN7hXYhdRnm7LFjtOsPNGGqtchjefnnVmxRqIRs8EqHoteCWx8teeM
 HV1INgZxJ66aSG7Wi/ikV4FTquufgCxW7xPuswZgQPGU/lNFyMDxj2fhhCx/KozuykBZ
 X1MsmrBfbWvfkull6RVw+bUtpRTkUg3/MlU24LcxHKMzorWQLXHVqI3HIXdj6sjdMC1R
 ZAHX1WHdL6Ueb8DtD8ys2stjbBSaSXASlbo9rEQ5iTELhz3ogZ7S421gNJOn2LAZpQQc
 3eUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v2mAjqtuZOYE0ZtUDVZuiSZ00TgB6ibRdPm0eNtlQKI=;
 b=JqrsKzyCHifZT65w8q2B+5jJew0FWm6AGnPIAh+vj8TsTVSoCsgrBN5w9acSKolF4W
 P0WsjCucrW5JuabviTPakwj2AQexxXp/T5rjhEahnzRDRJGRDMZQEabWYgP8Mrk4i9br
 d2n1ic01MplA5chZFMIdIrjMdNrWSG1/iQ7pdl1WuC+fHrqVVla03TyHQQl5YLJBsz6T
 XA5C5hJFW9hlxPt33cr1ttQNuUB40AzaO6R/S9tSz72y3DYVHij1HmRJVtF//auedSHv
 th/5yxZ/OM3mYDkNqK8txDpibJjhhJCnCpdGS+yMo03NnhSXD37mbI4LWi/YTCS7o/SG
 +aLw==
X-Gm-Message-State: APjAAAWqpBDzWQQIJpwqf2xhqC3oSoZ2uJvtPrJCb1XLNqgXV62vyBMz
 MSNu3FSy2QKfTiadc/SJHaREmQ==
X-Google-Smtp-Source: APXvYqwrmubbXisqQPKh0Wt9HZoWthKHc8peXtHfD07mT0lhgwACnWbol9V7yoHf7DiNoDZTCLCx6Q==
X-Received: by 2002:a05:600c:2295:: with SMTP id
 21mr1858740wmf.63.1571986595349; 
 Thu, 24 Oct 2019 23:56:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q6sm1250675wrx.30.2019.10.24.23.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:56:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1B2971FFC6;
 Fri, 25 Oct 2019 07:37:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 46/73] target/alpha: fetch code with translator_ld
Date: Fri, 25 Oct 2019 07:36:46 +0100
Message-Id: <20191025063713.23374-47-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index a69f58bf658..f7f1ed0f411 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2987,7 +2987,7 @@ static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUAlphaState *env = cpu->env_ptr;
-    uint32_t insn = cpu_ldl_code(env, ctx->base.pc_next);
+    uint32_t insn = translator_ldl(env, ctx->base.pc_next);
 
     ctx->base.pc_next += 4;
     ctx->base.is_jmp = translate_one(ctx, insn);
-- 
2.20.1


