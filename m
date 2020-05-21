Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4C5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCECB207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yOGgn9Bg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCECB207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboa0-0004EG-1z
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIu-00042h-74
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:20 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:42242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIt-0006d9-6x
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:19 -0400
Received: by mail-qk1-x742.google.com with SMTP id s1so7837515qkf.9
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SQwt3BlCMlkRrdpIoHWlR7VL+MoMENIbhHHtRYB6xLo=;
 b=yOGgn9BgznS/yS1LrJvqdJnaqQUv3Vd+eeNO8HyHHNLDVC3F/tIV+2EBndyiFxhUzj
 5+5AAik2xy0mLAimDWl5ECgK9p5NXiNwX8lqUMSVya+pxVxplE+KhndczpqjZ/pdqh6Y
 2vHUOC7B4KQsQifWJ+aJic+rA2yRGI11vEoyCnIM6R0QIBGrYaZ34b3s29zlFu2jUvrB
 yQKTRDVwp2pbmEO2/NoC0RztdQj1MIxQ9uAI5GpyyiWw5gt/u0J38OY/sPH+BwREzxm4
 O/TCLpxzGgd0WgM0YYFITRIrSmOOWWUZAtpllgqlCcVo6RyRMC6dLCjnZerGFVOWcSaU
 imZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SQwt3BlCMlkRrdpIoHWlR7VL+MoMENIbhHHtRYB6xLo=;
 b=Uyfcn6wqC8Ia8NoU0ptgFQif/EFOTlza+jGDtmF3/3C54/E99gEjKW/v9WcM2IZM4E
 c8l+gfcU680kK5NTGdNppjQHQTcJKwmoXsYR9bzeSrkquJbijhOguiAy8hczoCHdkuM0
 VW53Q4SEoAoWYedyLyZVZxwSZoNHhNpmrLrWizza4RVFbra0PPRz4VOjQYyVzpolR+6U
 PGG1r8zSeytcBnKrSqnhgbJy32v3KcLnDDNa7LrIzRGmGCPZGaZCSr7vXmR8tD75e8Oo
 8Gz+krw02hS6GRse+BgPg26oKmdXwiWzjJf1YbEoV3mclJglAAYy6zdAF0Zk0qKZPYCE
 GiMg==
X-Gm-Message-State: AOAM530cQHQfz/dOWWQ5MMDfGrsNo3tq+UJfSivbyoZBR2rM2dgsiIfX
 AGcMrbR+NKQguMfe0gMgeaGkBuTK+/t9xA==
X-Google-Smtp-Source: ABdhPJynGFq8Df6BbQkCk9y0uQHmLjSnNZXdVpOM8i/YmIf7kfEZTOhJ7Yy0mAUPRxi0840riiMMTQ==
X-Received: by 2002:a05:620a:a83:: with SMTP id
 v3mr10996261qkg.84.1590079458051; 
 Thu, 21 May 2020 09:44:18 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:17 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 47/74] cris: convert to cpu_interrupt_request
Date: Thu, 21 May 2020 12:39:44 -0400
Message-Id: <20200521164011.638-48-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x742.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org, cota@braap.org,
 peter.puhov@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/cris/cpu.c    | 2 +-
 target/cris/helper.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index cff6b9eabf..6d7e266042 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -37,7 +37,7 @@ static void cris_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool cris_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
+    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
 static void cris_cpu_reset(DeviceState *dev)
diff --git a/target/cris/helper.c b/target/cris/helper.c
index b5159b8357..67946d9246 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -131,7 +131,7 @@ void crisv10_cpu_do_interrupt(CPUState *cs)
 
     D_LOG("exception index=%d interrupt_req=%d\n",
           cs->exception_index,
-          cs->interrupt_request);
+          cpu_interrupt_request(cs));
 
     if (env->dslot) {
         /* CRISv10 never takes interrupts while in a delay-slot.  */
@@ -193,7 +193,7 @@ void cris_cpu_do_interrupt(CPUState *cs)
 
     D_LOG("exception index=%d interrupt_req=%d\n",
           cs->exception_index,
-          cs->interrupt_request);
+          cpu_interrupt_request(cs));
 
     switch (cs->exception_index) {
     case EXCP_BREAK:
-- 
2.17.1


