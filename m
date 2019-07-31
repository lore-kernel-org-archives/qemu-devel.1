Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3E7C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46613206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fV8ff6+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46613206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrWE-0002pF-FM
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45251)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPp-00056y-H9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPo-0000Og-KW
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:25 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36355)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrPo-0000O3-EU
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:24 -0400
Received: by mail-wm1-x341.google.com with SMTP id g67so56286575wme.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V98Zmvzo/uFuI/92KeHfM/lcI3tBexjtRM2UXdiaujA=;
 b=fV8ff6+nfET7t8dH6zsmqcMQMxohhdTO03oI9PpGu5opcNDYTGB1J0E4XdxOgg0y/z
 8aSTH/vTHvk2W0rl1PFWctG6lBO6gvTtV1+vszoKl1oS42zXSlFmsbbuRhXcJ3EK6gea
 rFpd2EsMINoh8SECWeT275fd8NqmaF5r3MfQshfYZaJa2tL1N2e1HuEbH4i6PXcPDI/9
 9gZSs61TgD6zxupcStUfd9yBhRyjGnkuzPTr0SaXufxb6x7DM/0XpKFxwSX6oMHkBYnl
 IBoUmIv1QEq0KE8HYcChW8I6OEFczfWIISqHhyh++b3jdkBGw5v4AhrLZHxIhazaYSWh
 Oz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V98Zmvzo/uFuI/92KeHfM/lcI3tBexjtRM2UXdiaujA=;
 b=SrVaiA7T853+2AHYZO5yjQ10cXp5LuN23B3f8jON68RRRgIePHlLBK/L3ADy1r1FYm
 fjHq9ESQ+zVYbNL2kDCnbS5QNPHfaZmHHLxFOFtVwfM9R4v1XYiezKAuFirmsT6qaWNu
 V/dPJYXVEVwktqUjjhVjRdN/BJ99p6DEALvQYeTkGwE3sQ1j/Fznj6Ar2POk+CmAyCRi
 cuX6Q0Hg8wNba5/o/tcCUoDMkq1/BUvp7TItCelstKdCu2VmnQ6ug4nWSRE9Wm+FI0Vf
 L65ua6mDn/1bKC+2A2KVMa/ZWxC3XZm3UgoTn86Qd44gQFfWIaos+dfwRJhFAGjH6nPR
 Y9Qg==
X-Gm-Message-State: APjAAAVWummDsqNPOSjkIxXx7h77Rig98qx4j2i0sa+o5QcGkDkGcLMW
 tekUQGVcpePDTyeuKNVczCIp39bcqX8=
X-Google-Smtp-Source: APXvYqx/rm6cyft+eS11gvuutof+D3J7YWSWOa2ntiSmDVzeVbJNIQyHfMedP334S7YNYwk5wWABvg==
X-Received: by 2002:a7b:cbc6:: with SMTP id n6mr84155160wmi.14.1564590323303; 
 Wed, 31 Jul 2019 09:25:23 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f70sm91237836wme.22.2019.07.31.09.25.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:25:21 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EAF771FFBC;
 Wed, 31 Jul 2019 17:07:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:07:02 +0100
Message-Id: <20190731160719.11396-38-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v4 37/54] target/alpha: fetch code with
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 aaron@os.amperecomputing.com, cota@braap.org, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/alpha/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 2c9cccf6c1b..daf1e05cba6 100644
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


