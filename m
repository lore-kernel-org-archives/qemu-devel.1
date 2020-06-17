Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1D7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21A32166E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ejmPWiR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21A32166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfS4-0003KX-QI
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEA-0003KX-BP
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:10 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:46910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfE5-0008Vr-4S
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:09 -0400
Received: by mail-qt1-x841.google.com with SMTP id g18so2723364qtu.13
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9A7y00FSGgamAX20OqsIrmd5Bhg8NgpNlEQx1G0undg=;
 b=ejmPWiR0v02UVxmZ398zLrIXxCek8QuDnCa6ZDQi298AcyuiOwoXb8UGDGN/LQ+kHN
 /k4Xcb/L3C+Fiq4BL7Z4/taW4VsO9qgjiGO4DfGYsOq4JBeMRg1WUlvXedRB8tPH1288
 KUFkh59Q8Tb1H/MvV/r3tlQSVCvmq5WKMXC/0mUMs8CgFAC5lheR/r+UvtsvofxabO8K
 6ORkMlYLMIKU/LNBA10Lh077jbH5Dr++2NR+7Bxvo3tbFimHnH5RZoK9RMU8ILwY2Gf7
 epJiVHKCo7+yw+/E+A1K/3G/B72xOG+wwXgjV2WXgoOlQyDxU8GqoB7uZuNn5N2JejuN
 /ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9A7y00FSGgamAX20OqsIrmd5Bhg8NgpNlEQx1G0undg=;
 b=GuFz01+La0Y/XUTeA6GiUn9zT0w1A3gyY6shEOZfeCAkr4B4jcREEENLj3XXXrOuR4
 jFPzUJSCioasTCvYQsx/lyvg928WJiYY/p653lXoqRsCSUWKY6WpMkM8jDBaU0EpfgP+
 bLlb339wPuQhBMsQWzTYUV7JvPRd0CxGsX9X5t6HiUjxavV9FUlaV1WloUuSGS6gHXI9
 EzSQnyI+sEi7QPchBSfoHjk+uCSJp9GqnOafxj7TwUMqCobNzm6oC9FJYGmdPbEcP7su
 Xuaa20aq9qkyFCc8re1fgHDIEknvC79dYjrvksawPKqKVtHMYhQEF8meoiH09vvrLPVZ
 ZEPA==
X-Gm-Message-State: AOAM532e4S+CISupnH5k/Zx5w4mgqceJebND2KZeUycmGMzrGL9KPOEa
 HzNG5Kk4rENyajdEgFee+F0AE772zNQ2Jw==
X-Google-Smtp-Source: ABdhPJwyu5JcTS5Tgzntf3Vg8FGyhu2oC9siLtvrpzvlhf+Jih/q83gvaId6kY7S2VmKxUcknkhE0w==
X-Received: by 2002:aed:3e5d:: with SMTP id m29mr1085289qtf.125.1592427843830; 
 Wed, 17 Jun 2020 14:04:03 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:03 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 33/73] ppc: use cpu_reset_interrupt
Date: Wed, 17 Jun 2020 17:01:51 -0400
Message-Id: <20200617210231.4393-34-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x841.google.com
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
Cc: robert.foley@linaro.org, cota@braap.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Cc: qemu-ppc@nongnu.org
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/ppc/excp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 507f64c9e7..bf9e1e27e9 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1060,7 +1060,7 @@ bool ppc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         ppc_hw_interrupt(env);
         if (env->pending_interrupts == 0) {
-            cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
         }
         return true;
     }
-- 
2.17.1


