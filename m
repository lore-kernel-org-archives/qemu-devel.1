Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F4FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A07C20738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQC+I+dV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A07C20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgJJ-0007TW-Fz
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3K-0007aY-Sj
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:22 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:33115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3J-0001iM-0r
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:22 -0400
Received: by mail-pf1-x430.google.com with SMTP id u20so8301534pfn.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=45kd/bFobWQBgRWzCCV4KKe4PH1pZqfnSM8e41v0zaE=;
 b=fQC+I+dVqBZkOSZqVTEus73xkI0RWQXNKuGEuw5dAu7m6H2/BXyGRObsk64q9Si+lO
 JtRtp/Ff7YcjMwwskMa4Igv5YArvsIa0atm8D9iOw5al8cVv3atKTVZkuwPxKZ86lZmp
 t61Qf2arxXEv13OgrQDjkVPoKp+lyYHBB0AgMzGJBLKHqU9NprmkJjkxysomlYYccyH8
 NX+XDmjJNvc0Obt0oVAm1Hlhi4vd1GIpY4q6KqMucq5wmNGYbY1h6fwt1QGR9eq9updI
 DcCl+7l0JuM7UhcVD3yvvdGUMGpXweCADkCFKLQfLpqJroxPv4uC7Vj9M3tJa174E6kW
 U4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=45kd/bFobWQBgRWzCCV4KKe4PH1pZqfnSM8e41v0zaE=;
 b=Lrsti+mOcyTCAX0w0QcXSjy6kX/b8l+7BG8yMBtLaHn+Prf5yVlhTYAVBl23MZlPfg
 Iloe9uKwEpiCuN0L/NxX++qLBAqNnT74FWJDajhq72WCEEeRUvl5xxiUNYX+S+YA2E8O
 ycMM8AgvyIOrS9c7IW/nlDH3M03oh7esgF18OqFgYyJ50LSSHNASnJTZABe/oYm5lUbP
 49mMCXTwb6vTsEEtthFxy5PNrcWNcdJd064c7wWS1sUAjui1J5cIq9Xxq4nxCM6FtYoa
 JE4xguGLelHjshBd/sPgmpl55hO5idUCcrq2xqHrZcDoGnAlYDHPI3L6K5k2yb/zYWPT
 hAMw==
X-Gm-Message-State: AOAM532OMBZUKYlgeYn34zqkCFy1xTbrzPDC+KL7oa4VA8Gct8Oyqc56
 bld0HgF/NW+e0k840IH9yjBFmR+DsEB1Cg==
X-Google-Smtp-Source: ABdhPJzNpdmDH1WpuYOkEQY0Pq89My8gHP4s9SR1joXicBTUxhJzthySZsFaQFdKqNRnKBe1AtUsSQ==
X-Received: by 2002:a05:6a00:2285:: with SMTP id
 f5mr9209826pfe.173.1598389219275; 
 Tue, 25 Aug 2020 14:00:19 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/77] target/microblaze: Mark raise_exception as noreturn
Date: Tue, 25 Aug 2020 13:58:54 -0700
Message-Id: <20200825205950.730499-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will allow tcg to remove any dead code that might
follow an exception.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 2f8bdea22b..820711366d 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -1,4 +1,4 @@
-DEF_HELPER_2(raise_exception, void, env, i32)
+DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
 DEF_HELPER_1(debug, void, env)
 DEF_HELPER_FLAGS_3(carry, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_2(cmp, i32, i32, i32)
-- 
2.25.1


