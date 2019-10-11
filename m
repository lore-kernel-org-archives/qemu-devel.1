Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723F6ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E8C20640
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AqkZODQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E8C20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvUs-0003dp-Rh
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJL-00063Y-3c
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJJ-00048A-VS
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:26 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:45958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvJJ-00047l-PZ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:25 -0400
Received: by mail-yw1-xc44.google.com with SMTP id x65so3483169ywf.12
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BzP/FFrDkoCzHDBfpSksVJlWN9Ryii7p6SjFwNyKnoU=;
 b=AqkZODQVhA9/WR2YJsfGrFlyLg4lQqOmCuQ0HC5OfNv23kCK2P6hgpaP6fUkiP4ikF
 hUWt8U+8jkxWhD0FKjp2nEcyGHZEJDCzyu7PLJbwMjJx4jQCbUgdQ8OIhdSpS4hDBibf
 T/LLCfpNIsbRh6Nv6KXLV2tjYAk6T94JD55f88+c6TZ/XhMcpq6Uyh03s3EZ+RKq9+JD
 9tX4zvU0OsWOVUOS0JvJWtmixKhiregKwL9Kn4zZrjyX73BelZArm9kMZXeMRT9PCxSw
 ormYGSJlrWJDOzGd/vaMaUPvr0KHyRLJvYzuf9HdKkBYnQL0buaJDnrmd+RmK1d4XEle
 vGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BzP/FFrDkoCzHDBfpSksVJlWN9Ryii7p6SjFwNyKnoU=;
 b=HbFFH0p4V4ykEaGPvvP7eC8+yZhe+N4/0xBVknveQXEEcENIpttl13IvfYhspD4K4d
 o6DNFBsi4K7oayOqDksXE9jOr6xcLph1BpOr/4+pwKtUKMiQ8h53wgB3P840jEyJDTUT
 Mxct5W6esOZ+QGitixcPZTUsWrqVNd0yf9p0PzEuXyxpLQQfHz7JEQJ2xIFAdLmbgd6a
 6dhxqoY81N+PvdaKHb40hpPj7tzakjNf5E1s1F/xeRyZ6pg+FbC9w9WCe0XhNongjjwm
 0NDZXxYlf1UxaEq/YGpL50Q3OISTcjnhbZ+5/mvJ7/YsAKodHf5Si2GNM4ljM4jBOOyJ
 5OZA==
X-Gm-Message-State: APjAAAW3XzahOXwCUob4nXLeCkUoOc/U93UtoaVbwW2jbVamo5HUtX9R
 IYHKVAjuWCAFScn3BvtetOdpLYVaMbo=
X-Google-Smtp-Source: APXvYqzXIsJKTuUounznFg70XZwLVyzgXpP/eRr9hOljkXesvA2/8QvkAXvlr0cA88GKphEdKZ7T2Q==
X-Received: by 2002:a81:3986:: with SMTP id g128mr2497798ywa.487.1570801824830; 
 Fri, 11 Oct 2019 06:50:24 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:50:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 17/22] target/arm: Set PSTATE.TCO on exception entry
Date: Fri, 11 Oct 2019 09:47:39 -0400
Message-Id: <20191011134744.2477-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

D1.10 specifies that exception handlers begin with tag checks overridden.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Only set if MTE feature present.
---
 target/arm/helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index eec9064d88..e988398fce 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8401,6 +8401,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     target_ulong addr = env->cp15.vbar_el[new_el];
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
     unsigned int cur_el = arm_current_el(env);
+    unsigned int new_pstate;
 
     /*
      * Note that new_el can never be 0.  If cur_el is 0, then
@@ -8494,7 +8495,11 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     qemu_log_mask(CPU_LOG_INT, "...with ELR 0x%" PRIx64 "\n",
                   env->elr_el[new_el]);
 
-    pstate_write(env, PSTATE_DAIF | new_mode);
+    new_pstate = new_mode | PSTATE_DAIF;
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        new_pstate |= PSTATE_TCO;
+    }
+    pstate_write(env, new_pstate);
     env->aarch64 = 1;
     aarch64_restore_sp(env, new_el);
 
-- 
2.17.1


