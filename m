Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8BEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B38D821582
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="abTi7xGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38D821582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfKV-0006oq-UP
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDu-0003BP-Jz
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:58 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:35143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDn-0008UC-NB
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:53 -0400
Received: by mail-qt1-x844.google.com with SMTP id z1so2776543qtn.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KjBP9WZwlnczZ3SxEnPdyurMaB67UgSlf8Umf0tpZgo=;
 b=abTi7xGxOycXHf+FavHb7RymYID+HTzoPXque5EuWixdD9rNu2Y9loUZ+YbY5TWjSF
 13h+mGlyuWYeGfFWN596I05f133hD2UBp76A5xL0XhIzCnqtardpZHtSJ6ijXKBDVHSW
 UHFWpW/FYkJI0S8/xzUJTTd92nKDj1dHsi12y42osj/AQahKmudEZSySmWnAm63Ny+Ie
 fBQgg9WTMpqtTEfRO2MdeL+kwd65McTsb+JIdReBEMtijNt3SsZ+glEzsl3hcOpBOwlt
 o3Wmi9SfhkZkGZTv/N1mUNlb227fQEf+dglSORWEwlS0ijxEcHrjnOUX58ivzRji9w+N
 a9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KjBP9WZwlnczZ3SxEnPdyurMaB67UgSlf8Umf0tpZgo=;
 b=sKZQ46kt6agPvB3LXmJiv5qyTPLXFyFpotA3yUCIVOJ3bGxdpCEuJjvjAzD00fbOO4
 E7hNGh+jhxwvKYWC3Jxlnm9awba9Rc/R4113WAbaIcWUE77Bp/TstML3zeVgQc7gwkkd
 gWwZcmMdKxxxynVtKk46w1FoCRwXtnkxP81gh81tUgpG08MPlYVGZ8GQiBxsSeKvCgRR
 ceAFsb9Njdkk4Wa5sin103Ruzr1xo9PThc2MCgQ/dBys0wJiKEJ5q0Y397TDBKbEg9Ua
 3SpVt+Zj/s/4ghUmn/89wT+J2BU6uUDhZjG8v0F7L7b/XGXkFxUFRzXMwLW2KDMGDawe
 YU7A==
X-Gm-Message-State: AOAM533FwFE7mhNHTsvLIRhv1kRMujH6GqN+1a/ueODjesVGzZge7THn
 6JO2TuS/Z7TUsxy3C5uE907mUQPMSvpRbA==
X-Google-Smtp-Source: ABdhPJyqwHpT6X+LkF9eljWkoUotyBmYvwY6SSUUqaAv+L5XkRwnN2X4uKqT9/qrwDs355OFATVl3A==
X-Received: by 2002:ac8:7303:: with SMTP id x3mr1144098qto.44.1592427826541;
 Wed, 17 Jun 2020 14:03:46 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:46 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 21/73] lm32: convert to cpu_halted
Date: Wed, 17 Jun 2020 17:01:39 -0400
Message-Id: <20200617210231.4393-22-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x844.google.com
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
Cc: peter.puhov@linaro.org, Michael Walle <michael@walle.cc>, cota@braap.org,
 alex.bennee@linaro.org, robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Michael Walle <michael@walle.cc>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/lm32/op_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
index e39fcd5647..8e0bd57b9d 100644
--- a/target/lm32/op_helper.c
+++ b/target/lm32/op_helper.c
@@ -32,7 +32,7 @@ void HELPER(hlt)(CPULM32State *env)
 {
     CPUState *cs = env_cpu(env);
 
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cs->exception_index = EXCP_HLT;
     cpu_loop_exit(cs);
 }
@@ -45,7 +45,7 @@ void HELPER(ill)(CPULM32State *env)
             "Connect a debugger or switch to the monitor console "
             "to find out more.\n");
     vm_stop(RUN_STATE_PAUSED);
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     raise_exception(env, EXCP_HALTED);
 #endif
 }
-- 
2.17.1


