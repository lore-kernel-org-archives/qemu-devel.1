Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C99C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C192098B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FywU01ug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C192098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfHE-0000UK-FT
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDm-00033R-2N
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:46 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:37431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDk-0008Tq-CF
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:45 -0400
Received: by mail-qk1-x741.google.com with SMTP id b27so3508836qka.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B03XAH5wL6d9wQMcetAjOEJJOmedJjFZih4s04YDqvs=;
 b=FywU01ugE/Po4A3CGfnl2o0/Ueb0CbiUSIbfHaG0Q+RawwrkEG/urfCMCbxEPZOV7b
 sfKbFfEHWjCsbfrff3TW717e/zE/rs3PamGHa9nPyVxq6wbDfFqyhTLE0j2NfkLGB+Bq
 Gc0+HDhi8d+5XjVNYT+2VygAi7bKxv2iTAXoTkbOz39lyExiVXNxyTlzuIItkH1Nb1l6
 AKzagW0eE0lvQcNZtD1yXc8qqNY+jIGw/gXUt734RBohaQ8E6vShWXimLD9Gq6GxxjZu
 o8ZfgmW+9cSelMiapXMoPyShmdt1vqlOputb9AfbJ1eYEJ/TKwqvz4SA6JgecrqYFKkE
 EUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B03XAH5wL6d9wQMcetAjOEJJOmedJjFZih4s04YDqvs=;
 b=X8vd2nWOfASF3c/TOUULKj/imyey6I7BIfiHL2jK6shQnEpPpTIes3pO/Zj2ocM9b5
 m267jNyvy5IGIn3xkQmbxlQ+fu8PyExCmlLBxPBnQbUQnBW2rlmlYJXttOIAdevM3yl+
 J3hBQ2X474Tk3jGWYyJNrW4WWyUfN/NfJphPeKCKif22Yury1ON+6yXDQ9+MV/KNsfbN
 q70jhe5dJay9R5+/rxuWH38bKE8AA8sHB2w61jHjYYegx4sBNzxxkfIokrnzQh47QPcE
 zJ+D67GNFR5T3GXmL+QqRyBIM30/L4IqEaqvagDgd+/WRI3dNZeciK/WphCfGPzkt7Eu
 gtTg==
X-Gm-Message-State: AOAM532v3H0kYHEyfKJ2eVZTD+pIdJjX7yBAlxhsJcmJUMk2rwxjbhlb
 L8QbtWY2gbrQCZ0cB/0V/o/0lMaIklWpoA==
X-Google-Smtp-Source: ABdhPJy5++27wdNslhJYjZREppFXV6/bN0A0fC6ucDwILRG60IkgCKLYz7nuwYqsGaeRLo9AOoq2GA==
X-Received: by 2002:a05:620a:14b8:: with SMTP id
 x24mr531887qkj.284.1592427823243; 
 Wed, 17 Jun 2020 14:03:43 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:42 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 19/73] sh4: convert to cpu_halted
Date: Wed, 17 Jun 2020 17:01:37 -0400
Message-Id: <20200617210231.4393-20-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x741.google.com
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
Cc: robert.foley@linaro.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 cota@braap.org, peter.puhov@linaro.org, alex.bennee@linaro.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/sh4/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 14c3db0f48..d338bbe871 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -90,7 +90,7 @@ void helper_sleep(CPUSH4State *env)
 {
     CPUState *cs = env_cpu(env);
 
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     env->in_sleep = 1;
     raise_exception(env, EXCP_HLT, 0);
 }
-- 
2.17.1


